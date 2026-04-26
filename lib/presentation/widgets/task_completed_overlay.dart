import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════
//  TaskCompletedOverlay
//  Показывает выезжающую сверху карточку «Задание выполнено!»
//  с названием задачи и наградой (+XP, +🪙).
//  При передаче списка задач — показывает их последовательно.
//
//  Использование:
//    TaskCompletedOverlay.showAll(context, completedTasks);
// ═══════════════════════════════════════════════════════════════
class TaskCompletedOverlay {
  TaskCompletedOverlay._();

  // Показать одну карточку
  static Future<void> show(
    BuildContext context,
    Map<String, dynamic> task,
  ) async {
    final overlay = Overlay.maybeOf(context, rootOverlay: true);
    if (overlay == null) return;

    final entry = OverlayEntry(
      builder: (_) => _TaskCompletedBanner(task: task),
    );
    overlay.insert(entry);

    // live time: 0.4s in + 2.5s hold + 0.4s out
    await Future<void>.delayed(const Duration(milliseconds: 3300));
    entry.remove();
  }

  // Показать список задач по очереди
  static Future<void> showAll(
    BuildContext context,
    List<Map<String, dynamic>> tasks,
  ) async {
    for (final t in tasks) {
      if (!context.mounted) return;
      await show(context, t);
    }
  }
}

class _TaskCompletedBanner extends StatefulWidget {
  final Map<String, dynamic> task;
  const _TaskCompletedBanner({required this.task});

  @override
  State<_TaskCompletedBanner> createState() => _TaskCompletedBannerState();
}

class _TaskCompletedBannerState extends State<_TaskCompletedBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeOut);

    _play();
  }

  Future<void> _play() async {
    await _ctrl.forward();
    await Future<void>.delayed(const Duration(milliseconds: 2500));
    if (mounted) await _ctrl.reverse();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.task;
    final icon = t['task_icon'] as String? ?? '🎉';
    final title = t['task_title'] as String? ?? 'Задание выполнено';
    final xp = t['xp_reward'] as int? ?? 0;
    final coins = t['coin_reward'] as int? ?? 0;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0ABDB9), Color(0xFF078987)],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color:
                            const Color(0xFF0ABDB9).withValues(alpha: 0.35),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(icon,
                            style: const TextStyle(fontSize: 22)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              '🎉 Задание выполнено!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (xp > 0)
                            Text('+$xp XP',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                )),
                          if (coins > 0)
                            Text('+$coins 🪙',
                                style: const TextStyle(
                                  color: Color(0xFFFFE082),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
