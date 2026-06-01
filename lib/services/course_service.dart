import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/courses/course_structure.dart';
import '../data/courses/all_courses.dart';
import 'user_store.dart';

final _db = Supabase.instance.client;

class _CachedProgress {
  final Map<String, ChapterProgress> data;
  final DateTime at;
  _CachedProgress(this.data, this.at);
}

class CourseService {
  CourseService._();
  static final instance = CourseService._();

  String? get _uid => _db.auth.currentUser?.id;
  final Map<String, _CachedProgress> _progressCache = {};
  static const _cacheTtl = Duration(seconds: 25);

  // ── Ключ для локального хранения ─────────────────────────────
  String _localKey(String langCode) {
    final uid = _uid ?? 'anon';
    return 'course_progress_${uid}_$langCode';
  }
  // Fallback ключ без uid — на случай если uid пришёл позже
  String _localKeyAnon(String langCode) => 'course_progress_anon_$langCode';

  void invalidateProgress(String langCode) {
    _progressCache.remove(langCode);
  }

  /// Главы уровня в порядке `order` (в файле курса они могут быть перемешаны с другими уровнями).
  List<CourseChapter> levelChaptersSorted(
    LanguageCourse course,
    LanguageLevel level,
  ) {
    return course.chapters.where((c) => c.level == level).toList()
      ..sort((a, b) => a.order.compareTo(b.order));
  }

  String? getNextChapterId(String langCode, String chapterId) =>
      _nextChapterId(langCode, chapterId);

  /// UI-статус главы: цепочка внутри уровня A1→A2→…, не порядок в массиве файла.
  ChapterStatus resolveChapterStatus(
    LanguageCourse course,
    CourseChapter chapter,
    Map<String, ChapterProgress> progress,
  ) {
    if (!_canAccessLevel(course, chapter.level, progress)) {
      return ChapterStatus.locked;
    }

    final levelList = levelChaptersSorted(course, chapter.level);
    final idx = levelList.indexWhere((c) => c.id == chapter.id);
    if (idx < 0) return ChapterStatus.locked;

    final stored = progress[chapter.id];
    if (stored != null && isChapterFinished(stored)) {
      return ChapterStatus.completed;
    }

    if (idx == 0) {
      if (stored == null || stored.status == ChapterStatus.locked) {
        return ChapterStatus.available;
      }
      return stored.status;
    }

    final prev = progress[levelList[idx - 1].id];
    if (!isChapterFinished(prev)) return ChapterStatus.locked;

    if (stored == null || stored.status == ChapterStatus.locked) {
      return ChapterStatus.available;
    }
    return stored.status;
  }

  bool _canAccessLevel(
    LanguageCourse course,
    LanguageLevel level,
    Map<String, ChapterProgress> progress,
  ) {
    if (level == LanguageLevel.a1) return true;
    final prevLevel = _previousLevel(level);
    if (prevLevel == null) return true;
    final prevChapters = levelChaptersSorted(course, prevLevel);
    if (prevChapters.isEmpty) return true;
    return prevChapters.every((c) => isChapterFinished(progress[c.id]));
  }

  LanguageLevel? _previousLevel(LanguageLevel level) {
    switch (level) {
      case LanguageLevel.a1:
        return null;
      case LanguageLevel.a2:
        return LanguageLevel.a1;
      case LanguageLevel.b1:
        return LanguageLevel.a2;
      case LanguageLevel.b2:
        return LanguageLevel.b1;
    }
  }

  bool isChapterFinished(ChapterProgress? p) => _isChapterFinished(p);

  // ── Получить прогресс (быстро: локально + кэш; Supabase — в фоне) ──
  Future<Map<String, ChapterProgress>> getCourseProgress(
    String langCode, {
    bool force = false,
  }) async {
    if (!force) {
      final cached = _progressCache[langCode];
      if (cached != null &&
          DateTime.now().difference(cached.at) < _cacheTtl) {
        return Map<String, ChapterProgress>.from(cached.data);
      }
    }

    var local = await _loadLocal(langCode);

    if (_uid != null) {
      final anonData = await _loadLocalWithKey(_localKeyAnon(langCode));
      if (anonData.isNotEmpty) {
        local = _merge(local, anonData);
        try {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove(_localKeyAnon(langCode));
        } catch (_) {}
      }
    }

    final merged = _applyUnlockRules(langCode, local);
    _progressCache[langCode] =
        _CachedProgress(Map<String, ChapterProgress>.from(merged), DateTime.now());

    if (_uid != null) {
      _pullRemoteProgress(langCode);
    }

    return merged;
  }

  Map<String, ChapterProgress> _applyUnlockRules(
    String langCode,
    Map<String, ChapterProgress> source,
  ) {
    final merged = Map<String, ChapterProgress>.from(source);
    final course = getCourseByLang(langCode);
    if (course == null || course.chapters.isEmpty) return merged;

    for (final level in LanguageLevel.values) {
      final list = levelChaptersSorted(course, level);
      if (list.isEmpty || !_canAccessLevel(course, level, merged)) continue;

      if (merged[list.first.id] == null ||
          merged[list.first.id]!.status == ChapterStatus.locked) {
        merged[list.first.id] = ChapterProgress(
          chapterId: list.first.id,
          status: ChapterStatus.available,
        );
      }

      for (int i = 1; i < list.length; i++) {
        final chId = list[i].id;
        final prevId = list[i - 1].id;
        if (!_isChapterFinished(merged[prevId])) continue;

        final cur = merged[chId];
        if (cur == null || cur.status == ChapterStatus.locked) {
          merged[chId] = ChapterProgress(
            chapterId: chId,
            status: ChapterStatus.available,
          );
        }
      }
    }
    return merged;
  }

  Future<void> _pullRemoteProgress(String langCode) async {
    try {
      final remote = await _loadRemote(langCode);
      if (remote.isEmpty) return;

      var local = await _loadLocal(langCode);
      final before = Map<String, ChapterProgress>.from(local);
      local = _merge(local, remote);

      for (final entry in local.entries) {
        final prev = before[entry.key];
        if (prev == null || _progressDiffers(prev, entry.value)) {
          await _saveLocal(langCode, entry.key, _progressToMap(entry.value));
        }
      }

      final merged = _applyUnlockRules(langCode, local);
      _progressCache[langCode] = _CachedProgress(
        Map<String, ChapterProgress>.from(merged),
        DateTime.now(),
      );

      final course = getCourseByLang(langCode);
      if (course == null) return;
      for (final level in LanguageLevel.values) {
        final list = levelChaptersSorted(course, level);
        for (int i = 1; i < list.length; i++) {
          final chId = list[i].id;
          final prevId = list[i - 1].id;
          if (!_isChapterFinished(merged[prevId])) continue;
          if (merged[chId]?.status == ChapterStatus.available) {
            _syncToRemote(langCode, chId, {
              'status': 'available',
              'theory_done': false,
              'exercises_done': false,
              'exam_passed': false,
              'score': 0,
            });
          }
        }
      }
    } catch (_) {}
  }

  // ── Отметить теорию как прочитанную ──────────────────────────
  Future<void> markTheoryDone(
    String langCode,
    String chapterId, {
    int coinsReward = 8,
    int xpReward = 5,
  }) async {
    final progress = await getCourseProgress(langCode);
    final wasDone = progress[chapterId]?.theoryDone ?? false;

    await _saveProgress(langCode, chapterId, {
      'theory_done': true,
      'status': _preserveStatus(progress[chapterId], fallback: 'in_progress'),
    });

    if (!wasDone) {
      await _rewardPlayer(coinsReward: coinsReward, xpReward: xpReward);
    }
  }

  // ── Отметить упражнения как выполненные ──────────────────────
  Future<void> markExercisesDone(
    String langCode,
    String chapterId,
    int score, {
    int coinsReward = 20,
    int xpReward = 15,
  }) async {
    final progress = await getCourseProgress(langCode);
    final wasDone = progress[chapterId]?.exercisesDone ?? false;

    final course = getCourseByLang(langCode);
    CourseChapter? chapter;
    if (course != null) {
      for (final c in course.chapters) {
        if (c.id == chapterId) {
          chapter = c;
          break;
        }
      }
    }
    final hasExam = chapter != null && chapter.exam.isNotEmpty;

    await _saveProgress(langCode, chapterId, {
      'exercises_done': true,
      'score': score,
      'status': hasExam
          ? _preserveStatus(progress[chapterId], fallback: 'in_progress')
          : 'completed',
      if (!hasExam) 'exam_passed': true,
      if (!hasExam) 'completed_at': DateTime.now().toIso8601String(),
    });

    if (!wasDone) {
      final coins =
          ((coinsReward * score) / 100).round().clamp(5, coinsReward);
      final xp = ((xpReward * score) / 100).round().clamp(3, xpReward);
      await _rewardPlayer(coinsReward: coins, xpReward: xp);
    }

    if (!hasExam) {
      await _unlockNextChapter(langCode, chapterId);
    }
  }

  // ── Завершить экзамен ────────────────────────────────────────
  Future<void> completeExam({
    required String langCode,
    required String chapterId,
    required int score,
    required int coinsReward,
    required int xpReward,
    required String? nextChapterId,
  }) async {
    final passed = score >= 60;
    final now = DateTime.now().toIso8601String();

    await _saveProgress(langCode, chapterId, {
      'exam_passed': passed,
      'score': score,
      'status': passed ? 'completed' : 'in_progress',
      'completed_at': passed ? now : null,
    });

    if (passed) {
      await _rewardPlayer(coinsReward: coinsReward, xpReward: xpReward);
      await _unlockNextChapter(
        langCode,
        chapterId,
        explicitNextId: nextChapterId,
      );
    }
  }

  // ── Получить CEFR-уровень пользователя по языку ──────────────
  Future<String> getUserLevel(String langCode) async {
    if (_uid == null) return 'A1';
    try {
      final row = await _db
          .from('user_language_levels')
          .select('level')
          .eq('user_id', _uid!)
          .eq('lang_code', langCode)
          .maybeSingle();
      return (row?['level'] as String?) ?? 'A1';
    } catch (_) {
      return 'A1';
    }
  }

  // ── Обновить CEFR-уровень ────────────────────────────────────
  Future<void> updateCefrLevel(String langCode, String level) async {
    if (_uid == null) return;
    try {
      await _db.from('user_language_levels').upsert({
        'user_id': _uid,
        'lang_code': langCode,
        'level': level,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {}
  }

  // ── Проверить, завершён ли весь курс ─────────────────────────
  Future<bool> isCourseCompleted(String langCode) async {
    final course = getCourseByLang(langCode);
    if (course == null) return false;
    final progress = await getCourseProgress(langCode);
    return course.chapters.every((ch) =>
        progress[ch.id]?.status == ChapterStatus.completed);
  }

  // ── Получить данные для сертификата ──────────────────────────
  Future<Map<String, dynamic>?> getCertificateData(String langCode) async {
    final completed = await isCourseCompleted(langCode);
    if (!completed) return null;

    String userName = 'Студент';
    try {
      if (_uid != null) {
        final profile = await _db
            .from('users')
            .select('name')
            .eq('id', _uid!)
            .maybeSingle();
        userName = profile?['name'] as String? ?? 'Студент';
      }
    } catch (_) {}

    final course = getCourseByLang(langCode);
    if (course == null) return null;

    return {
      'user_name': userName,
      'lang_name': course.langName,
      'lang_flag': course.flag,
      'level': 'B2',
      'completed_at': DateTime.now(),
      'course': course,
    };
  }

  // ═══════════════════════════════════════════════════════════════
  //  ЛОКАЛЬНОЕ ХРАНЕНИЕ (SharedPreferences) — основное
  // ═══════════════════════════════════════════════════════════════

  Future<Map<String, ChapterProgress>> _loadLocal(String langCode) async {
    return _loadLocalWithKey(_localKey(langCode));
  }

  Future<Map<String, ChapterProgress>> _loadLocalWithKey(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(key);
      if (raw == null) return {};
      final decoded = jsonDecode(raw);
      if (decoded is! Map) return {};
      final result = <String, ChapterProgress>{};
      for (final entry in (decoded as Map<String, dynamic>).entries) {
        if (entry.value is! Map) continue;
        final d = Map<String, dynamic>.from(entry.value as Map);
        result[entry.key] = ChapterProgress(
          chapterId: entry.key,
          status: _statusFromString(d['status'] as String? ?? 'locked'),
          score: (d['score'] ?? 0) as int,
          completedAt: d['completed_at'] != null
              ? DateTime.tryParse(d['completed_at'].toString())
              : null,
          theoryDone: (d['theory_done'] ?? false) as bool,
          exercisesDone: (d['exercises_done'] ?? false) as bool,
          examPassed: (d['exam_passed'] ?? false) as bool,
        );
      }
      return result;
    } catch (_) {
      return {};
    }
  }

  Future<void> _saveLocal(String langCode, String chapterId, Map<String, dynamic> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = _localKey(langCode);
      final raw = prefs.getString(key);
      final Map<String, dynamic> all = raw != null
          ? Map<String, dynamic>.from(jsonDecode(raw) as Map)
          : {};

      // Мёржим с существующими данными главы
      final prev = all[chapterId];
      final existing = prev is Map ? Map<String, dynamic>.from(prev) : <String, dynamic>{};
      existing.addAll(data);
      all[chapterId] = existing;

      await prefs.setString(key, jsonEncode(all));
    } catch (e) {
      debugPrint('[CourseService] _saveLocal error: $e');
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  SUPABASE — опциональный бэкап
  // ═══════════════════════════════════════════════════════════════

  Future<Map<String, ChapterProgress>> _loadRemote(String langCode) async {
    if (_uid == null) return {};
    try {
      final rows = await _db
          .from('course_progress')
          .select()
          .eq('user_id', _uid!)
          .eq('lang_code', langCode)
          .timeout(const Duration(seconds: 4));

      final result = <String, ChapterProgress>{};
      for (final row in rows as List) {
        final chapterId = row['chapter_id'] as String;
        result[chapterId] = ChapterProgress(
          chapterId: chapterId,
          status: _statusFromString(row['status'] as String? ?? 'locked'),
          score: (row['score'] ?? 0) as int,
          completedAt: row['completed_at'] != null
              ? DateTime.tryParse(row['completed_at'] as String)
              : null,
          theoryDone: (row['theory_done'] ?? false) as bool,
          exercisesDone: (row['exercises_done'] ?? false) as bool,
          examPassed: (row['exam_passed'] ?? false) as bool,
        );
      }
      return result;
    } catch (_) {
      return {};
    }
  }

  Future<void> _syncToRemote(String langCode, String chapterId, Map<String, dynamic> data) async {
    if (_uid == null) return;
    try {
      await _db.from('course_progress').upsert({
        'user_id': _uid,
        'lang_code': langCode,
        'chapter_id': chapterId,
        ...data,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {}
  }

  // ═══════════════════════════════════════════════════════════════
  //  ОБЩИЕ ХЕЛПЕРЫ
  // ═══════════════════════════════════════════════════════════════

  // Сохранить прогресс: локально (гарантированно) + Supabase (fire-and-forget)
  Future<void> _saveProgress(String langCode, String chapterId, Map<String, dynamic> data) async {
    invalidateProgress(langCode);
    await _saveLocal(langCode, chapterId, data);
    _syncToRemote(langCode, chapterId, data);
    final local = await _loadLocal(langCode);
    _progressCache[langCode] = _CachedProgress(
      _applyUnlockRules(langCode, local),
      DateTime.now(),
    );
  }

  // Мёрж: объединяем флаги и берём максимальный статус
  Map<String, ChapterProgress> _merge(
    Map<String, ChapterProgress> local,
    Map<String, ChapterProgress> remote,
  ) {
    final result = Map<String, ChapterProgress>.from(local);
    for (final entry in remote.entries) {
      final existing = result[entry.key];
      if (existing == null) {
        result[entry.key] = entry.value;
      } else {
        result[entry.key] = _mergeChapter(existing, entry.value);
      }
    }
    return result;
  }

  ChapterProgress _mergeChapter(ChapterProgress a, ChapterProgress b) {
    final status =
        _statusRank(a.status) >= _statusRank(b.status) ? a.status : b.status;
    final score = a.score > b.score ? a.score : b.score;
    final completedAt = a.completedAt != null
        ? (b.completedAt != null && b.completedAt!.isAfter(a.completedAt!)
            ? b.completedAt
            : a.completedAt)
        : b.completedAt;
    return ChapterProgress(
      chapterId: a.chapterId,
      status: status,
      score: score,
      completedAt: completedAt,
      theoryDone: a.theoryDone || b.theoryDone,
      exercisesDone: a.exercisesDone || b.exercisesDone,
      examPassed: a.examPassed || b.examPassed,
    );
  }

  bool _isChapterFinished(ChapterProgress? p) {
    if (p == null) return false;
    if (p.status == ChapterStatus.completed) return true;
    if (p.examPassed) return true;
    return p.theoryDone && p.exercisesDone && p.examPassed;
  }

  String _preserveStatus(ChapterProgress? p, {required String fallback}) {
    if (p == null) return fallback;
    if (p.status == ChapterStatus.completed || p.examPassed) {
      return 'completed';
    }
    return fallback;
  }

  String? _nextChapterId(String langCode, String chapterId) {
    final course = getCourseByLang(langCode);
    if (course == null) return null;
    CourseChapter? ch;
    for (final c in course.chapters) {
      if (c.id == chapterId) {
        ch = c;
        break;
      }
    }
    if (ch == null) return null;
    final list = levelChaptersSorted(course, ch.level);
    final idx = list.indexWhere((c) => c.id == chapterId);
    if (idx < 0 || idx + 1 >= list.length) return null;
    return list[idx + 1].id;
  }

  Future<void> _unlockNextChapter(
    String langCode,
    String chapterId, {
    String? explicitNextId,
  }) async {
    final nextId = explicitNextId ?? _nextChapterId(langCode, chapterId);
    if (nextId == null) return;
    final unlockData = {
      'status': 'available',
      'theory_done': false,
      'exercises_done': false,
      'exam_passed': false,
      'score': 0,
    };
    await _saveProgress(langCode, nextId, unlockData);
  }

  int _statusRank(ChapterStatus s) {
    switch (s) {
      case ChapterStatus.locked: return 0;
      case ChapterStatus.available: return 1;
      case ChapterStatus.inProgress: return 2;
      case ChapterStatus.completed: return 3;
    }
  }

  Future<void> _rewardPlayer({
    required int coinsReward,
    required int xpReward,
  }) async {
    if (_uid == null) return;
    try {
      final profile = await _db
          .from('users')
          .select('coins, xp')
          .eq('id', _uid!)
          .maybeSingle();
      if (profile == null) return;

      await _db.from('users').update({
        'coins': ((profile['coins'] ?? 0) as int) + coinsReward,
        'xp': ((profile['xp'] ?? 0) as int) + xpReward,
      }).eq('id', _uid!);
      UserStore.instance.applyDelta(
        coinsDelta: coinsReward,
        xpDelta: xpReward,
      );
    } catch (_) {}
  }

  ChapterStatus _statusFromString(String s) {
    switch (s) {
      case 'available':   return ChapterStatus.available;
      case 'in_progress': return ChapterStatus.inProgress;
      case 'completed':   return ChapterStatus.completed;
      default:            return ChapterStatus.locked;
    }
  }

  String _statusToString(ChapterStatus s) {
    switch (s) {
      case ChapterStatus.available:   return 'available';
      case ChapterStatus.inProgress: return 'in_progress';
      case ChapterStatus.completed:   return 'completed';
      case ChapterStatus.locked:      return 'locked';
    }
  }

  Map<String, dynamic> _progressToMap(ChapterProgress p) => {
        'status': _statusToString(p.status),
        'score': p.score,
        'theory_done': p.theoryDone,
        'exercises_done': p.exercisesDone,
        'exam_passed': p.examPassed,
        if (p.completedAt != null)
          'completed_at': p.completedAt!.toIso8601String(),
      };

  bool _progressDiffers(ChapterProgress a, ChapterProgress b) =>
      _statusRank(a.status) != _statusRank(b.status) ||
      a.score != b.score ||
      a.theoryDone != b.theoryDone ||
      a.exercisesDone != b.exercisesDone ||
      a.examPassed != b.examPassed;
}
