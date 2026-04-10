import 'package:supabase_flutter/supabase_flutter.dart';

class DailyTasksService {
  static final _db = Supabase.instance.client;

  static const _templates = [
    {'type': 'complete_lesson',         'title': 'Пройти 1 урок',              'icon': '🎯', 'target': 1,  'xp': 30, 'coins': 10},
    {'type': 'complete_lesson',         'title': 'Пройти 3 урока подряд',      'icon': '📚', 'target': 3,  'xp': 80, 'coins': 25},
    {'type': 'learn_words',             'title': 'Выучить 10 слов',            'icon': '💡', 'target': 10, 'xp': 40, 'coins': 15},
    {'type': 'learn_words',             'title': 'Выучить 20 слов',            'icon': '🧠', 'target': 20, 'xp': 70, 'coins': 22},
    {'type': 'play_game',               'title': 'Сыграть в мини-игру',        'icon': '🎮', 'target': 1,  'xp': 25, 'coins': 8},
    {'type': 'correct_answers',         'title': 'Ответить верно 15 раз',      'icon': '✅', 'target': 15, 'xp': 35, 'coins': 12},
    {'type': 'correct_answers',         'title': 'Ответить верно 30 раз',      'icon': '🎯', 'target': 30, 'xp': 60, 'coins': 20},
    {'type': 'complete_lesson_perfect', 'title': 'Пройти урок без ошибок',     'icon': '🏆', 'target': 1,  'xp': 60, 'coins': 20},
    {'type': 'play_game',               'title': 'Сыграть в 2 мини-игры',      'icon': '🕹️', 'target': 2,  'xp': 45, 'coins': 15},
    {'type': 'complete_lesson',         'title': 'Пройти 5 уроков',            'icon': '🌟', 'target': 5,  'xp': 120,'coins': 40},
  ];

  // ── Получить или сгенерировать задания на сегодня ────────────
  static Future<List<Map<String, dynamic>>> getTodayTasks() async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return [];

    final now = DateTime.now().toUtc();

    // Ищем незакончившиеся задания
    final existing = await _db
        .from('daily_tasks')
        .select()
        .eq('user_id', uid)
        .gte('expires_at', now.toIso8601String())
        .order('created_at');

    if ((existing as List).isNotEmpty) {
      return List<Map<String, dynamic>>.from(existing);
    }

    // Удаляем старые
    await _db.from('daily_tasks').delete().eq('user_id', uid).lt('expires_at', now.toIso8601String());

    // Генерируем 5 новых заданий
    final todayLocal = DateTime.now();
    final tomorrow = DateTime(todayLocal.year, todayLocal.month, todayLocal.day + 1).toUtc();
    final templates = List.from(_templates)..shuffle();
    final selected = templates.take(5).toList();

    final rows = selected.map((t) => {
      'user_id': uid,
      'task_type': t['type'],
      'task_title': t['title'],
      'task_icon': t['icon'],
      'target_count': t['target'],
      'current_count': 0,
      'xp_reward': t['xp'],
      'coin_reward': t['coins'],
      'is_completed': false,
      'expires_at': tomorrow.toIso8601String(),
    }).toList();

    final result = await _db.from('daily_tasks').insert(rows).select();
    return List<Map<String, dynamic>>.from(result);
  }

  // ── Обновить прогресс после урока/игры ───────────────────────
  // Возвращает список завершённых заданий (для показа уведомления)
  static Future<List<Map<String, dynamic>>> updateProgress({
    required String taskType,
    int count = 1,
    bool perfect = false,
  }) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return [];

    final now = DateTime.now().toUtc();
    final completed = <Map<String, dynamic>>[];

    // Типы которые нужно обновить
    final types = [taskType];
    if (taskType == 'complete_lesson' && perfect) {
      types.add('complete_lesson_perfect');
    }

    final tasks = await _db
        .from('daily_tasks')
        .select()
        .eq('user_id', uid)
        .eq('is_completed', false)
        .gte('expires_at', now.toIso8601String())
        .inFilter('task_type', types);

    for (final task in (tasks as List)) {
      final type = task['task_type'] as String;
      if (type == 'complete_lesson_perfect' && !perfect) continue;

      final newCount = (task['current_count'] as int? ?? 0) + count;
      final target = task['target_count'] as int;
      final isDone = newCount >= target;

      await _db.from('daily_tasks').update({
        'current_count': newCount > target ? target : newCount,
        if (isDone) ...{
          'is_completed': true,
          'completed_at': now.toIso8601String(),
        },
      }).eq('id', task['id']);

      if (isDone) {
        completed.add(Map<String, dynamic>.from(task));
        await _rewardUser(
          xp: task['xp_reward'] as int? ?? 0,
          coins: task['coin_reward'] as int? ?? 0,
        );
      }
    }

    return completed;
  }

  // ── Начислить награду ────────────────────────────────────────
  static Future<void> _rewardUser({required int xp, required int coins}) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return;
    try {
      final user = await _db.from('users').select('xp, coins').eq('id', uid).single();
      await _db.from('users').update({
        'xp': (user['xp'] as int? ?? 0) + xp,
        'coins': (user['coins'] as int? ?? 0) + coins,
      }).eq('id', uid);
    } catch (_) {}
  }

  // ── Время до следующего обновления ──────────────────────────
  static String timeUntilReset() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final diff = tomorrow.difference(now);
    final h = diff.inHours;
    final m = diff.inMinutes % 60;
    return '${h}ч ${m}м';
  }
}
