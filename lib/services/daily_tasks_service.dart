import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'user_store.dart';

class DailyTasksService {
  static final _db = Supabase.instance.client;

  static final ValueNotifier<int> tasksUpdatedNotifier = ValueNotifier<int>(0);

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

  static String _localKey(String uid) {
    final day = DateTime.now().toIso8601String().split('T').first;
    return 'daily_tasks_${uid}_$day';
  }

  static List<Map<String, dynamic>> _buildLocalTasks(String uid) {
    final templates = List<Map<String, dynamic>>.from(_templates)..shuffle();
    final selected = templates.take(5).toList();
    final now = DateTime.now().toUtc();
    final tomorrow = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day + 1,
    ).toUtc();

    return selected.asMap().entries.map((e) {
      final t = e.value;
      return {
        'id': 'local_${uid}_${e.key}',
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
        'created_at': now.toIso8601String(),
      };
    }).toList();
  }

  static Future<List<Map<String, dynamic>>> _loadLocal(String uid) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_localKey(uid));
      if (raw != null) {
        final list = jsonDecode(raw);
        if (list is List && list.isNotEmpty) {
          return List<Map<String, dynamic>>.from(list);
        }
      }
      final tasks = _buildLocalTasks(uid);
      await prefs.setString(_localKey(uid), jsonEncode(tasks));
      return tasks;
    } catch (_) {
      return _buildLocalTasks(uid);
    }
  }

  static Future<void> _saveLocal(String uid, List<Map<String, dynamic>> tasks) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_localKey(uid), jsonEncode(tasks));
    } catch (_) {}
  }

  static Future<List<Map<String, dynamic>>> getTodayTasks() async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return [];

    try {
      final now = DateTime.now().toUtc();

      final existing = await _db
          .from('daily_tasks')
          .select()
          .eq('user_id', uid)
          .gte('expires_at', now.toIso8601String())
          .order('created_at')
          .timeout(const Duration(seconds: 5));

      if ((existing as List).isNotEmpty) {
        return List<Map<String, dynamic>>.from(existing);
      }

      await _db
          .from('daily_tasks')
          .delete()
          .eq('user_id', uid)
          .lt('expires_at', now.toIso8601String());

      final tomorrow = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day + 1,
      ).toUtc();
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

      final result =
          await _db.from('daily_tasks').insert(rows).select().timeout(
                const Duration(seconds: 5),
              );
      return List<Map<String, dynamic>>.from(result);
    } catch (_) {
      return _loadLocal(uid);
    }
  }

  static Future<List<Map<String, dynamic>>> updateProgress({
    required String taskType,
    int count = 1,
    bool perfect = false,
  }) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return [];

    final types = [taskType];
    if (taskType == 'complete_lesson' && perfect) {
      types.add('complete_lesson_perfect');
    }

    try {
      final now = DateTime.now().toUtc();
      final completed = <Map<String, dynamic>>[];

      final tasks = await _db
          .from('daily_tasks')
          .select()
          .eq('user_id', uid)
          .eq('is_completed', false)
          .gte('expires_at', now.toIso8601String())
          .inFilter('task_type', types)
          .timeout(const Duration(seconds: 5));

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

      if (tasks.isNotEmpty) tasksUpdatedNotifier.value++;
      return completed;
    } catch (_) {
      return _updateLocalProgress(uid, types, count, perfect);
    }
  }

  static Future<List<Map<String, dynamic>>> _updateLocalProgress(
    String uid,
    List<String> types,
    int count,
    bool perfect,
  ) async {
    final tasks = await _loadLocal(uid);
    final completed = <Map<String, dynamic>>[];
    var changed = false;

    for (var i = 0; i < tasks.length; i++) {
      final task = tasks[i];
      if (task['is_completed'] == true) continue;
      final type = task['task_type'] as String;
      if (!types.contains(type)) continue;
      if (type == 'complete_lesson_perfect' && !perfect) continue;

      final newCount = (task['current_count'] as int? ?? 0) + count;
      final target = task['target_count'] as int;
      final isDone = newCount >= target;

      tasks[i] = {
        ...task,
        'current_count': newCount > target ? target : newCount,
        if (isDone) 'is_completed': true,
      };

      if (isDone) {
        completed.add(tasks[i]);
        await _rewardUser(
          xp: task['xp_reward'] as int? ?? 0,
          coins: task['coin_reward'] as int? ?? 0,
        );
      }
      changed = true;
    }

    if (changed) {
      await _saveLocal(uid, tasks);
      tasksUpdatedNotifier.value++;
    }
    return completed;
  }

  static Future<void> _rewardUser({required int xp, required int coins}) async {
    final uid = _db.auth.currentUser?.id;
    if (uid == null) return;
    try {
      final user =
          await _db.from('users').select('xp, coins').eq('id', uid).single();
      await _db.from('users').update({
        'xp': (user['xp'] as int? ?? 0) + xp,
        'coins': (user['coins'] as int? ?? 0) + coins,
      }).eq('id', uid);
      UserStore.instance.applyDelta(coinsDelta: coins, xpDelta: xp);
    } catch (_) {}
  }

  static String timeUntilReset() {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final diff = tomorrow.difference(now);
    final h = diff.inHours;
    final m = diff.inMinutes % 60;
    return '${h}ч ${m}м';
  }
}
