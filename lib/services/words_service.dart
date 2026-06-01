import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/bundled_words.dart';

// ═══════════════════════════════════════════════════════════════
//  WordsService — Supabase + офлайн-кэш + встроенные слова по языку
// ═══════════════════════════════════════════════════════════════
class WordsService {
  WordsService._();
  static final WordsService instance = WordsService._();

  static const _cacheVersion = 'v2';
  static const _cacheMaxAge = Duration(days: 14);

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  String _cacheKey(String language) => 'words_cache_${_cacheVersion}_$language';
  String _offsetKey(String language) => 'words_offset_${_cacheVersion}_$language';
  String _cacheTimeKey(String language) =>
      'words_cache_time_${_cacheVersion}_$language';

  static LessonWord fromRow(Map<String, dynamic> r) => LessonWord(
        id: r['id'] as String,
        word: r['word'] as String,
        translation: r['translation'] as String,
        transcription: r['transcription'] as String? ?? '',
        category: r['category'] as String? ?? '',
        difficulty: r['difficulty'] as int? ?? 1,
        language: r['language'] as String? ?? 'en',
      );

  LessonWord _fromBundled(Map<String, dynamic> m, String language) =>
      LessonWord(
        id: m['id'] as String,
        word: m['word'] as String,
        translation: m['translation'] as String,
        transcription: m['transcription'] as String? ?? '',
        category: m['category'] as String? ?? '',
        difficulty: m['difficulty'] as int? ?? 1,
        language: language,
      );

  Future<int> _nextOffset(String language, int batchSize) async {
    final prefs = await SharedPreferences.getInstance();
    final key = _offsetKey(language);
    final current = prefs.getInt(key) ?? 0;
    final next = current + batchSize;
    await prefs.setInt(key, next);
    return current;
  }

  Future<List<LessonWord>?> _readCache(String language) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ts = prefs.getInt(_cacheTimeKey(language));
      if (ts == null) return null;
      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (age > _cacheMaxAge.inMilliseconds) return null;

      final raw = prefs.getString(_cacheKey(language));
      if (raw == null || raw.isEmpty) return null;
      final list = jsonDecode(raw) as List;
      return list
          .map((e) => fromRow(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return null;
    }
  }

  Future<void> _writeCache(String language, List<LessonWord> words) async {
    if (words.isEmpty) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(words
          .map((w) => {
                'id': w.id,
                'word': w.word,
                'translation': w.translation,
                'transcription': w.transcription,
                'category': w.category,
                'difficulty': w.difficulty,
                'language': w.language,
              })
          .toList());
      await prefs.setString(_cacheKey(language), encoded);
      await prefs.setInt(
          _cacheTimeKey(language), DateTime.now().millisecondsSinceEpoch);
    } catch (_) {}
  }

  List<LessonWord> _bundledLesson(String language, int count, int offset) {
    final slice = BundledWords.slice(language, offset: offset, count: count);
    return slice.map((m) => _fromBundled(m, language)).toList();
  }

  List<LessonWord> _pickRotated(List<LessonWord> pool, int count, int offset) {
    if (pool.isEmpty) return [];
    final start = offset % pool.length;
    final out = <LessonWord>[];
    for (var i = 0; i < count; i++) {
      out.add(pool[(start + i) % pool.length]);
    }
    return out;
  }

  // ── Просто слова по языку ──────────────────────────────────
  Future<List<LessonWord>> getWordsByLanguage({
    required String language,
    int limit = 20,
  }) async {
    final offset = await _nextOffset(language, 0);
    try {
      final rows = await _db
          .from('words')
          .select()
          .eq('language', language)
          .order('difficulty')
          .limit(limit)
          .timeout(const Duration(seconds: 5));
      final list =
          (rows as List).map((r) => fromRow(r as Map<String, dynamic>)).toList();
      if (list.isNotEmpty) {
        await _writeCache(language, list);
        return _pickRotated(list, limit, offset);
      }
    } catch (_) {}

    final cached = await _readCache(language);
    if (cached != null && cached.isNotEmpty) {
      return _pickRotated(cached, limit, offset);
    }
    return _bundledLesson(language, limit, offset);
  }

  // ── Умный подбор для урока (SM-2 + ротация + офлайн) ───────
  Future<List<LessonWord>> getWordsForLesson({
    required String language,
    int count = 10,
  }) async {
    final lang = language.isEmpty ? 'en' : language;
    final offset = await _nextOffset(lang, count);

    try {
      final uid = _uid;
      List<LessonWord> due = [];

      if (uid != null) {
        try {
          final now = DateTime.now().toIso8601String();
          final dueRows = await _db
              .from('progress')
              .select('word_id, words(*)')
              .eq('user_id', uid)
              .lte('next_review', now)
              .order('next_review')
              .limit(count)
              .timeout(const Duration(seconds: 5));

          due = (dueRows as List)
              .where((r) => r['words'] != null)
              .map((r) => fromRow(r['words'] as Map<String, dynamic>))
              .where((w) => w.language == lang)
              .toList();
        } catch (_) {}
      }

      if (due.length >= count) {
        return due.take(count).toList();
      }

      final needed = count - due.length;
      List<String> knownIds = due.map((w) => w.id).toList();

      if (uid != null) {
        try {
          final progressRows = await _db
              .from('progress')
              .select('word_id')
              .eq('user_id', uid)
              .timeout(const Duration(seconds: 5));
          knownIds.addAll(
            (progressRows as List).map((r) => r['word_id'] as String),
          );
        } catch (_) {}
      }

      List<LessonWord> remote = [];
      try {
        final allRows = await _db
            .from('words')
            .select()
            .eq('language', lang)
            .order('difficulty')
            .limit(count * 4)
            .timeout(const Duration(seconds: 5));

        remote = (allRows as List)
            .map((r) => fromRow(r as Map<String, dynamic>))
            .where((w) => !knownIds.contains(w.id))
            .toList();
      } catch (_) {}

      if (remote.isNotEmpty) {
        await _writeCache(lang, remote);
        final picked = _pickRotated(remote, needed, offset);
        return [...due, ...picked].take(count).toList();
      }

      final cached = await _readCache(lang);
      if (cached != null && cached.isNotEmpty) {
        final fresh = cached.where((w) => !knownIds.contains(w.id)).toList();
        final pool = fresh.isNotEmpty ? fresh : cached;
        final picked = _pickRotated(pool, needed, offset);
        return [...due, ...picked].take(count).toList();
      }
    } catch (_) {}

    final bundled = _bundledLesson(lang, count, offset);
    return bundled;
  }

  // ── Варианты ответов ─────────────────────────────────────
  Future<List<String>> getOptions({
    required String correctTranslation,
    required String language,
    required String excludeWordId,
  }) async {
    final lang = language.isEmpty ? 'en' : language;
    try {
      final rows = await _db
          .from('words')
          .select('translation')
          .eq('language', lang)
          .neq('id', excludeWordId)
          .limit(24)
          .timeout(const Duration(seconds: 4));

      final pool =
          (rows as List).map((r) => r['translation'] as String).toList();
      pool.shuffle();
      final wrong = pool.where((t) => t != correctTranslation).take(3).toList();
      if (wrong.length >= 3) {
        final options = [correctTranslation, ...wrong]..shuffle();
        return options;
      }
    } catch (_) {}

    final bundled = BundledWords.translationsFor(lang, limit: 40)..shuffle();
    final wrong =
        bundled.where((t) => t != correctTranslation).take(3).toList();
    while (wrong.length < 3) {
      wrong.add('—');
    }
    final options = [correctTranslation, ...wrong.take(3)]..shuffle();
    return options;
  }

  /// Прогрев кэша для изучаемого языка (вызов при входе в Home).
  Future<void> warmCacheForLanguage(String language) async {
    final lang = language.isEmpty ? 'en' : language;
    final cached = await _readCache(lang);
    if (cached != null && cached.length >= 12) return;
    try {
      final rows = await _db
          .from('words')
          .select()
          .eq('language', lang)
          .order('difficulty')
          .limit(48)
          .timeout(const Duration(seconds: 6));
      final list =
          (rows as List).map((r) => fromRow(r as Map<String, dynamic>)).toList();
      if (list.isNotEmpty) await _writeCache(lang, list);
    } catch (_) {
      await _writeCache(lang, _bundledLesson(lang, 24, 0));
    }
  }
}

// ─── Модель слова для урока ────────────────────────────────────
class LessonWord {
  final String id;
  final String word;
  final String translation;
  final String transcription;
  final String category;
  final int difficulty;
  final String language;

  const LessonWord({
    required this.id,
    required this.word,
    required this.translation,
    required this.transcription,
    required this.category,
    required this.difficulty,
    required this.language,
  });

  String get emoji {
    const map = {
      'animals': '🐾',
      'food': '🍎',
      'home': '🏠',
      'nature': '🌿',
      'education': '📚',
      'people': '👥',
      'technology': '💻',
      'transport': '🚗',
      'emotions': '❤️',
      'finance': '💰',
      'places': '🏙️',
      'life': '🌟',
      'abstract': '💭',
      'phrases': '💬',
    };
    return map[category] ?? '📖';
  }
}
