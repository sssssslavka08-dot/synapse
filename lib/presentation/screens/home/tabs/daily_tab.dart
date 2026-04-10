import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../services/daily_tasks_service.dart';

class DailyTab extends StatefulWidget {
  final String name;
  final bool isKids;
  const DailyTab({super.key, required this.name, required this.isKids});

  @override
  State<DailyTab> createState() => _DailyTabState();
}

class _DailyTabState extends State<DailyTab> {
  List<Map<String, dynamic>> _tasks = [];
  int _streak = 0;
  int _coins = 0;
  bool _loading = true;

  int get _completedCount => _tasks.where((t) => t['is_completed'] == true).length;
  int get _totalXp => _tasks.where((t) => t['is_completed'] == true)
      .fold(0, (s, t) => s + (t['xp_reward'] as int? ?? 0));

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final tasks = await DailyTasksService.getTodayTasks();

      int streak = 0, coins = 0;
      if (uid != null) {
        final data = await Supabase.instance.client
            .from('users').select('streak, coins').eq('id', uid).maybeSingle();
        streak = data?['streak'] as int? ?? 0;
        coins  = data?['coins']  as int? ?? 0;
      }

      if (mounted) setState(() { _tasks = tasks; _streak = streak; _coins = coins; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _load,
          color: const Color(0xFF0ABDB9),
          child: _loading
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF0ABDB9)))
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Шапка ─────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            const Text('Ежедневные задания',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0F1F1E))),
                            Text('Обновление через ${DailyTasksService.timeUntilReset()}',
                                style: const TextStyle(color: Color(0xFF8EAEAC), fontSize: 12)),
                          ]),
                          _StatBadge(emoji: '🔥', value: '$_streak', label: 'дней'),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // ── Монеты + прогресс ─────────────────
                      Row(children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)]),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                const Text('Прогресс дня', style: TextStyle(color: Colors.white70, fontSize: 13)),
                                Text('+$_totalXp XP', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                              ]),
                              const SizedBox(height: 10),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: LinearProgressIndicator(
                                  value: _tasks.isEmpty ? 0 : _completedCount / _tasks.length,
                                  backgroundColor: Colors.white30,
                                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                                  minHeight: 8,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _completedCount == _tasks.length && _tasks.isNotEmpty
                                    ? '🎉 Все задания выполнены!'
                                    : '$_completedCount/${_tasks.length} выполнено',
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ]),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF8E1),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: const Color(0xFFFFD54F).withValues(alpha: 0.5)),
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            const Text('🪙', style: TextStyle(fontSize: 28)),
                            const SizedBox(height: 4),
                            Text('$_coins', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFFF59E0B))),
                            const Text('монет', style: TextStyle(fontSize: 10, color: Color(0xFF8EAEAC))),
                          ]),
                        ),
                      ]),
                      const SizedBox(height: 24),

                      // ── Список заданий ────────────────────
                      const Text('Задания на сегодня',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0F1F1E))),
                      const SizedBox(height: 12),

                      if (_tasks.isEmpty)
                        _EmptyState(onRetry: _load)
                      else
                        ..._tasks.map((task) => _TaskCard(task: task)),

                      const SizedBox(height: 20),

                      // ── Заморозка ────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: const Color(0xFFE0F3F2)),
                        ),
                        child: Row(children: [
                          const Text('🧊', style: TextStyle(fontSize: 28)),
                          const SizedBox(width: 14),
                          const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Заморозить streak', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF0F1F1E))),
                            Text('Пропусти день без потери прогресса', style: TextStyle(fontSize: 12, color: Color(0xFF8EAEAC))),
                          ])),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3498DB).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text('10 🪙', style: TextStyle(color: Color(0xFF3498DB), fontWeight: FontWeight.w700, fontSize: 13)),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

// ── Карточка задания ──────────────────────────────────────────
class _TaskCard extends StatelessWidget {
  final Map<String, dynamic> task;
  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final done = task['is_completed'] == true;
    final current = task['current_count'] as int? ?? 0;
    final target = task['target_count'] as int? ?? 1;
    final progress = (current / target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: done ? const Color(0xFF0ABDB9).withValues(alpha: 0.07) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: done ? const Color(0xFF0ABDB9).withValues(alpha: 0.3) : const Color(0xFFE0F3F2),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text(task['task_icon'] as String? ?? '📌', style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                task['task_title'] as String? ?? '',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: done ? const Color(0xFF8EAEAC) : const Color(0xFF0F1F1E),
                  decoration: done ? TextDecoration.lineThrough : null,
                ),
              ),
              const SizedBox(height: 2),
              Row(children: [
                Text('+${task['xp_reward']} XP', style: const TextStyle(fontSize: 12, color: Color(0xFF0ABDB9), fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Text('+${task['coin_reward']} 🪙', style: const TextStyle(fontSize: 12, color: Color(0xFFF59E0B), fontWeight: FontWeight.w500)),
              ]),
            ])),
            if (done)
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: const Color(0xFF0ABDB9), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 18),
              )
            else
              Text('$current/$target', style: const TextStyle(fontSize: 13, color: Color(0xFF8EAEAC), fontWeight: FontWeight.w600)),
          ]),
          if (!done && target > 1) ...[
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: const Color(0xFFE0F3F2),
                valueColor: const AlwaysStoppedAnimation(Color(0xFF0ABDB9)),
                minHeight: 5,
              ),
            ),
          ],
        ]),
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String emoji, value, label;
  const _StatBadge({required this.emoji, required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFFFF6B35).withValues(alpha: 0.3)),
    ),
    child: Row(children: [
      Text(emoji, style: const TextStyle(fontSize: 20)),
      const SizedBox(width: 6),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFFFF6B35))),
        Text(label, style: const TextStyle(fontSize: 10, color: Color(0xFF8EAEAC))),
      ]),
    ]),
  );
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onRetry;
  const _EmptyState({required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(children: [
        const Text('📋', style: TextStyle(fontSize: 48)),
        const SizedBox(height: 12),
        const Text('Задания загружаются...', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF4D6766))),
        const SizedBox(height: 8),
        const Text('Убедись что SQL таблица создана в Supabase', textAlign: TextAlign.center, style: TextStyle(fontSize: 13, color: Color(0xFF8EAEAC))),
        const SizedBox(height: 16),
        TextButton(onPressed: onRetry, child: const Text('Попробовать снова')),
      ]),
    ),
  );
}
