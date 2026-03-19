import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home/home_screen.dart';

// ═══════════════════════════════════════════════════════════════
//  LevelTestScreen — 3 вопроса после выбора языка
//  Результат → устанавливает difficulty в профиле Supabase
// ═══════════════════════════════════════════════════════════════
class LevelTestScreen extends StatefulWidget {
  final String name;
  final int age;
  final String language;

  const LevelTestScreen({
    super.key,
    required this.name,
    required this.age,
    required this.language,
  });

  @override
  State<LevelTestScreen> createState() => _LevelTestScreenState();
}

class _LevelTestScreenState extends State<LevelTestScreen>
    with SingleTickerProviderStateMixin {
  int _step = 0;
  int _score = 0; // 0–3
  bool _answered = false;
  String? _selected;
  bool _saving = false;

  late AnimationController _slideCtrl;
  late Animation<Offset> _slideAnim;

  // Вопрос 1: уровень знания языка
  static const _q1Options = ['Нет, совсем с нуля', 'Немного знаю', 'Знаю хорошо'];

  // Вопрос 2: простое слово
  static const _q2Word = 'Cat';
  static const _q2Correct = 'Кошка';
  static const _q2Options = ['Кошка', 'Собака', 'Дом', 'Яблоко'];

  // Вопрос 3: цель
  static const _q3Options = ['10 мин в день', '20 мин в день', '30 мин+'];

  @override
  void initState() {
    super.initState();
    _slideCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideCtrl, curve: Curves.easeOutCubic));
    _slideCtrl.forward();
  }

  @override
  void dispose() {
    _slideCtrl.dispose();
    super.dispose();
  }

  void _nextStep(String answer) async {
    if (_answered) return;
    setState(() {
      _selected = answer;
      _answered = true;
    });

    // Считаем очки
    if (_step == 1 && answer == _q2Correct) _score++;
    if (_step == 0 && answer == 'Знаю хорошо') _score++;
    if (_step == 2) {
      if (answer == '20 мин в день') _score++;
      if (answer == '30 мин+') _score += 2;
    }

    await Future.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;

    if (_step < 2) {
      setState(() {
        _step++;
        _answered = false;
        _selected = null;
      });
      _slideCtrl.forward(from: 0);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    setState(() => _saving = true);

    // difficulty: 1 = новичок, 2 = средний, 3 = продвинутый
    final difficulty = _score <= 1 ? 1 : _score <= 3 ? 2 : 3;

    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid != null) {
        await Supabase.instance.client.from('users').update({
          'difficulty': difficulty,
        }).eq('id', uid);
      }
    } catch (_) {}

    if (!mounted) return;
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) =>
            HomeScreen(name: widget.name, age: widget.age),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: _saving
            ? const Center(
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(color: Color(0xFF0ABDB9)),
                SizedBox(height: 16),
                Text('Настраиваем программу...',
                    style: TextStyle(color: Color(0xFF8EAEAC))),
              ]))
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Прогресс ────────────────────────────
                    Row(children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0ABDB9),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: const Icon(Icons.hub_rounded,
                            color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 10),
                      const Text('SYNAPSE',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      const Spacer(),
                      Text('${_step + 1} / 3',
                          style: const TextStyle(
                              color: Color(0xFF8EAEAC), fontSize: 13)),
                    ]),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: (_step + 1) / 3,
                        backgroundColor: const Color(0xFFD6F5F4),
                        valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF0ABDB9)),
                        minHeight: 6,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // ── Вопрос ──────────────────────────────
                    SlideTransition(
                      position: _slideAnim,
                      child: _buildQuestion(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildQuestion() {
    switch (_step) {
      case 0:
        return _QuestionCard(
          emoji: '🤔',
          question:
              'Как хорошо ты знаешь\n${_langName(widget.language)}?',
          options: _q1Options,
          selected: _selected,
          onTap: _nextStep,
        );
      case 1:
        return _QuestionCard(
          emoji: '🐱',
          question: 'Что значит слово\n"$_q2Word"?',
          options: _q2Options,
          selected: _selected,
          correct: _q2Correct,
          onTap: _nextStep,
        );
      case 2:
        return _QuestionCard(
          emoji: '🎯',
          question: 'Сколько времени готов\nучиться каждый день?',
          options: _q3Options,
          selected: _selected,
          onTap: _nextStep,
        );
      default:
        return const SizedBox();
    }
  }

  String _langName(String code) {
    const names = {
      'en': 'английский',
      'kz': 'казахский',
      'ru': 'русский',
      'de': 'немецкий',
      'fr': 'французский',
      'zh': 'китайский',
    };
    return names[code] ?? code;
  }
}

// ─── Карточка вопроса ──────────────────────────────────────────
class _QuestionCard extends StatelessWidget {
  final String emoji;
  final String question;
  final List<String> options;
  final String? selected;
  final String? correct;
  final void Function(String) onTap;

  const _QuestionCard({
    required this.emoji,
    required this.question,
    required this.options,
    required this.selected,
    required this.onTap,
    this.correct,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 48)),
        const SizedBox(height: 16),
        Text(
          question,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F1F1E),
            letterSpacing: -0.5,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 32),
        ...options.map((opt) {
          Color bg = Colors.white;
          Color border = const Color(0xFFD6F5F4);
          Color text = const Color(0xFF0F1F1E);
          IconData? icon;

          if (selected != null) {
            final isCorrect = correct == null || opt == correct;
            if (opt == selected && correct != null && opt != correct) {
              bg = const Color(0xFFEF4444).withValues(alpha: 0.08);
              border = const Color(0xFFEF4444);
              text = const Color(0xFFEF4444);
              icon = Icons.cancel_rounded;
            } else if (opt == correct && selected != null) {
              bg = const Color(0xFF22C55E).withValues(alpha: 0.08);
              border = const Color(0xFF22C55E);
              text = const Color(0xFF22C55E);
              icon = Icons.check_circle_rounded;
            } else if (opt == selected && correct == null) {
              bg = const Color(0xFF0ABDB9).withValues(alpha: 0.08);
              border = const Color(0xFF0ABDB9);
              text = const Color(0xFF0ABDB9);
              icon = Icons.check_circle_rounded;
            }
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: () => onTap(opt),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: border, width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(opt,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: text,
                          )),
                    ),
                    if (icon != null)
                      Icon(icon, color: text, size: 20),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
