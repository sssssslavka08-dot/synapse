import 'package:supabase_flutter/supabase_flutter.dart';

// ═══════════════════════════════════════════════════════════════
//  WordsService — загрузка слов из Supabase с SM-2 приоритетами
// ═══════════════════════════════════════════════════════════════
class WordsService {
  WordsService._();
  static final WordsService instance = WordsService._();

  SupabaseClient get _db => Supabase.instance.client;
  String? get _uid => _db.auth.currentUser?.id;

  // ── Универсальная модель слова из Supabase ─────────────────
  static LessonWord fromRow(Map<String, dynamic> r) => LessonWord(
        id: r['id'] as String,
        word: r['word'] as String,
        translation: r['translation'] as String,
        transcription: r['transcription'] as String? ?? '',
        category: r['category'] as String? ?? '',
        difficulty: r['difficulty'] as int? ?? 1,
        language: r['language'] as String? ?? 'en',
      );

  // ── Просто слова по языку ──────────────────────────────────
  Future<List<LessonWord>> getWordsByLanguage({
    required String language,
    int limit = 20,
  }) async {
    final rows = await _db
        .from('words')
        .select()
        .eq('language', language)
        .order('difficulty')
        .limit(limit);
    return (rows as List).map((r) => fromRow(r)).toList();
  }

  // ── Умный подбор для урока (SM-2) ─────────────────────────
  // Приоритет: слова с просроченным next_review → новые слова
  Future<List<LessonWord>> getWordsForLesson({
    required String language,
    int count = 10,
  }) async {
    final uid = _uid;

    // 1. Просроченные слова (нужно повторить)
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
            .limit(count);

        due = (dueRows as List)
            .where((r) => r['words'] != null)
            .map((r) => fromRow(r['words'] as Map<String, dynamic>))
            .toList();
      } catch (_) {}
    }

    if (due.length >= count) return due.take(count).toList();

    // 2. Новые слова (которых ещё нет в progress)
    final needed = count - due.length;
    List<String> knownIds = due.map((w) => w.id).toList();

    if (uid != null) {
      try {
        final progressRows = await _db
            .from('progress')
            .select('word_id')
            .eq('user_id', uid);
        knownIds.addAll(
          (progressRows as List).map((r) => r['word_id'] as String),
        );
      } catch (_) {}
    }

    // Загружаем слова и фильтруем на клиенте
    final allRows = await _db
        .from('words')
        .select()
        .eq('language', language)
        .order('difficulty')
        .limit(count * 3); // берём с запасом для фильтрации

    final newWords = (allRows as List)
        .map((r) => fromRow(r))
        .where((w) => !knownIds.contains(w.id))
        .take(needed)
        .toList();

    return [...due, ...newWords];
  }

  // ── Все варианты ответов для карточки ─────────────────────
  // Возвращает [правильный + 3 случайных]
  Future<List<String>> getOptions({
    required String correctTranslation,
    required String language,
    required String excludeWordId,
  }) async {
    final rows = await _db
        .from('words')
        .select('translation')
        .eq('language', language)
        .neq('id', excludeWordId)
        .limit(20);

    final pool =
        (rows as List).map((r) => r['translation'] as String).toList();
    pool.shuffle();
    final wrong = pool.take(3).toList();
    final options = [correctTranslation, ...wrong]..shuffle();
    return options;
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

  // Эмодзи по категории
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
