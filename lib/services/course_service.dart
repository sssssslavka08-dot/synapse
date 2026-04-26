import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/courses/course_structure.dart';
import '../data/courses/all_courses.dart';

final _db = Supabase.instance.client;

class CourseService {
  CourseService._();
  static final instance = CourseService._();

  String? get _uid => _db.auth.currentUser?.id;

  // Получить прогресс по всем главам конкретного языка
  Future<Map<String, ChapterProgress>> getCourseProgress(String langCode) async {
    if (_uid == null) return {};

    try {
      final rows = await _db
          .from('course_progress')
          .select()
          .eq('user_id', _uid!)
          .eq('lang_code', langCode);

      final Map<String, ChapterProgress> result = {};
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

      // Первая глава всегда доступна
      final course = getCourseByLang(langCode);
      if (course != null && course.chapters.isNotEmpty) {
        final firstId = course.chapters.first.id;
        if (!result.containsKey(firstId)) {
          result[firstId] = const ChapterProgress(
            chapterId: '',
            status: ChapterStatus.available,
          );
        }
      }

      return result;
    } catch (_) {
      return _defaultProgress(langCode);
    }
  }

  Map<String, ChapterProgress> _defaultProgress(String langCode) {
    final course = getCourseByLang(langCode);
    if (course == null || course.chapters.isEmpty) return {};
    return {
      course.chapters.first.id: ChapterProgress(
        chapterId: course.chapters.first.id,
        status: ChapterStatus.available,
      ),
    };
  }

  // Отметить теорию как прочитанную
  Future<void> markTheoryDone(String langCode, String chapterId) async {
    if (_uid == null) return;
    await _upsertProgress(langCode, chapterId, {'theory_done': true, 'status': 'in_progress'});
  }

  // Отметить упражнения как выполненные
  Future<void> markExercisesDone(
      String langCode, String chapterId, int score) async {
    if (_uid == null) return;
    await _upsertProgress(langCode, chapterId, {
      'exercises_done': true,
      'score': score,
      'status': 'in_progress',
    });
  }

  // Завершить экзамен
  Future<void> completeExam({
    required String langCode,
    required String chapterId,
    required int score,
    required int coinsReward,
    required int xpReward,
    required String? nextChapterId,
  }) async {
    if (_uid == null) return;

    final passed = score >= 60;
    final now = DateTime.now().toIso8601String();

    await _upsertProgress(langCode, chapterId, {
      'exam_passed': passed,
      'score': score,
      'status': passed ? 'completed' : 'in_progress',
      'completed_at': passed ? now : null,
    });

    if (passed) {
      // Выдаём монеты и XP
      await _rewardPlayer(coinsReward: coinsReward, xpReward: xpReward);

      // Разблокируем следующую главу
      if (nextChapterId != null) {
        await _upsertProgress(langCode, nextChapterId, {
          'status': 'available',
          'theory_done': false,
          'exercises_done': false,
          'exam_passed': false,
          'score': 0,
        });
      }
    }
  }

  // Получить CEFR-уровень пользователя по языку
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

  // Обновить CEFR-уровень
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

  // Проверить, завершён ли весь курс (для выдачи сертификата)
  Future<bool> isCourseCompleted(String langCode) async {
    if (_uid == null) return false;
    final course = getCourseByLang(langCode);
    if (course == null) return false;
    final progress = await getCourseProgress(langCode);
    return course.chapters.every((ch) =>
        progress[ch.id]?.status == ChapterStatus.completed);
  }

  // Получить данные для сертификата
  Future<Map<String, dynamic>?> getCertificateData(String langCode) async {
    if (_uid == null) return null;
    final completed = await isCourseCompleted(langCode);
    if (!completed) return null;

    final profile = await _db
        .from('users')
        .select('name')
        .eq('id', _uid!)
        .maybeSingle();

    final course = getCourseByLang(langCode);
    if (course == null) return null;

    return {
      'user_name': profile?['name'] ?? 'Студент',
      'lang_name': course.langName,
      'lang_flag': course.flag,
      'level': 'B2',
      'completed_at': DateTime.now(),
      'course': course,
    };
  }

  Future<void> _upsertProgress(
      String langCode, String chapterId, Map<String, dynamic> data) async {
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

  Future<void> _rewardPlayer({
    required int coinsReward,
    required int xpReward,
  }) async {
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
}
