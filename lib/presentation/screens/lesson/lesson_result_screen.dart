import 'package:flutter/material.dart';
import '../../../../services/daily_tasks_service.dart';
import '../home/home_screen.dart';
import 'lesson_screen.dart';

class LessonResultScreen extends StatefulWidget {
  final int correct;
  final int wrong;
  final int total;
  final bool isKidsMode;
  final String name;
  final int age;
  final String language;

  const LessonResultScreen({
    super.key,
    required this.correct,
    required this.wrong,
    required this.total,
    this.isKidsMode = false,
    this.name = 'Пользователь',
    this.age = 13,
    this.language = 'en',
  });

  @override
  State<LessonResultScreen> createState() => _LessonResultScreenState();
}

class _LessonResultScreenState extends State<LessonResultScreen> {
  List<Map<String, dynamic>> _completedTasks = [];

  int get xpEarned => widget.correct * 10;
  double get accuracy => widget.correct / widget.total;
  bool get isPerfect => widget.wrong == 0;

  String get _emoji {
    if (accuracy >= 0.8) return '🏆';
    if (accuracy >= 0.6) return '⭐';
    return '💪';
  }

  String get _title {
    if (accuracy >= 0.8) return 'Отлично!';
    if (accuracy >= 0.6) return 'Хорошо!';
    return 'Продолжай стараться!';
  }

  @override
  void initState() {
    super.initState();
    _updateTasks();
  }

  Future<void> _updateTasks() async {
    // Обновляем прогресс заданий
    final completedLesson = await DailyTasksService.updateProgress(
      taskType: 'complete_lesson',
      count: 1,
      perfect: isPerfect,
    );
    final completedWords = await DailyTasksService.updateProgress(
      taskType: 'learn_words',
      count: widget.correct,
    );
    final completedAnswers = await DailyTasksService.updateProgress(
      taskType: 'correct_answers',
      count: widget.correct,
    );

    final all = [...completedLesson, ...completedWords, ...completedAnswers];
    if (all.isNotEmpty && mounted) {
      setState(() => _completedTasks = all);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // Результат
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: const Color(0xFFD6F5F4)),
                ),
                child: Column(
                  children: [
                    Text(_emoji, style: const TextStyle(fontSize: 72)),
                    const SizedBox(height: 16),
                    Text(_title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F1F1E),
                          letterSpacing: -0.5,
                        )),
                    const SizedBox(height: 24),

                    Row(children: [
                      _StatBox(label: 'Верно',  value: '${widget.correct}', color: const Color(0xFF22C55E)),
                      const SizedBox(width: 12),
                      _StatBox(label: 'Ошибки', value: '${widget.wrong}',   color: const Color(0xFFEF4444)),
                      const SizedBox(width: 12),
                      _StatBox(label: 'XP',     value: '+$xpEarned',        color: const Color(0xFF0ABDB9)),
                    ]),
                    const SizedBox(height: 24),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Точность', style: TextStyle(fontSize: 14, color: Color(0xFF8EAEAC))),
                            Text('${(accuracy * 100).round()}%',
                                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF0ABDB9))),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: accuracy,
                            backgroundColor: const Color(0xFFD6F5F4),
                            valueColor: const AlwaysStoppedAnimation(Color(0xFF0ABDB9)),
                            minHeight: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Выполненные задания
              if (_completedTasks.isNotEmpty) ...[
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF8E1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFFFD54F).withValues(alpha: 0.5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🎉 Задания выполнены!',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFFF59E0B))),
                      const SizedBox(height: 8),
                      ..._completedTasks.map((t) => Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(children: [
                          Text(t['task_icon'] as String? ?? '✅', style: const TextStyle(fontSize: 16)),
                          const SizedBox(width: 8),
                          Expanded(child: Text(t['task_title'] as String? ?? '',
                              style: const TextStyle(fontSize: 13, color: Color(0xFF4D6766)))),
                          Text('+${t['xp_reward']} XP  +${t['coin_reward']}🪙',
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFF59E0B))),
                        ]),
                      )),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomeScreen(name: widget.name, age: widget.age)),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0ABDB9),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('На главную →', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton(
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LessonScreen(
                      isKidsMode: widget.isKidsMode,
                      language: widget.language,
                      name: widget.name,
                      age: widget.age,
                    )),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD6F5F4)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text('Повторить урок',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF4D6766))),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(children: [
          Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF8EAEAC))),
        ]),
      ),
    );
  }
}
