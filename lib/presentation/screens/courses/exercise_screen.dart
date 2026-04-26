import 'package:flutter/material.dart';
import '../../../data/courses/course_structure.dart';
import '../../../services/course_service.dart';
import '../../../presentation/widgets/neuronchik.dart';
import 'exam_screen.dart';

class ExerciseScreen extends StatefulWidget {
  final CourseChapter chapter;
  final String langCode;
  final bool isKidsMode;

  const ExerciseScreen({
    super.key,
    required this.chapter,
    required this.langCode,
    this.isKidsMode = false,
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  int? _selected;
  bool _answered = false;
  int _correct = 0;
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;
  NeuronchikMood _mood = NeuronchikMood.happy;

  List<CourseExercise> get _exercises => widget.chapter.exercises;

  @override
  void initState() {
    super.initState();
    _shakeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _shakeAnim = Tween<double>(begin: 0, end: 12).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
  }

  @override
  void dispose() {
    _shakeCtrl.dispose();
    super.dispose();
  }

  void _select(int idx) {
    if (_answered) return;
    setState(() {
      _selected = idx;
      _answered = true;
    });

    final isCorrect =
        idx == _exercises[_current].correctIndex;

    if (isCorrect) {
      _correct++;
      setState(() => _mood = NeuronchikMood.excited);
    } else {
      setState(() => _mood = NeuronchikMood.sad);
      _shakeCtrl.forward().then((_) => _shakeCtrl.reset());
    }
  }

  void _next() {
    if (_current < _exercises.length - 1) {
      setState(() {
        _current++;
        _selected = null;
        _answered = false;
        _mood = NeuronchikMood.thinking;
      });
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    final score = (_correct / _exercises.length * 100).round();
    await CourseService.instance.markExercisesDone(
        widget.langCode, widget.chapter.id, score);
    if (!mounted) return;
    // Переходим к экзамену если он есть
    if (widget.chapter.exam.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ExamScreen(
            chapter: widget.chapter,
            langCode: widget.langCode,
            isKidsMode: widget.isKidsMode,
          ),
        ),
      );
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKids = widget.isKidsMode;
    final accent = isKids ? const Color(0xFFFF6B35) : const Color(0xFF0ABDB9);
    final exercise = _exercises[_current];

    return Scaffold(
      backgroundColor: isKids ? const Color(0xFFFFF9F0) : const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Шапка
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: const Color(0xFFD6F5F4)),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 20,
                              color: Color(0xFF4D6766)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value:
                                (_current + 1) / _exercises.length,
                            backgroundColor:
                                accent.withValues(alpha: 0.12),
                            valueColor: AlwaysStoppedAnimation(accent),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${_current + 1}/${_exercises.length}',
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Тип упражнения
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: accent.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _exerciseTypeLabel(exercise.type),
                            style: TextStyle(
                              color: accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Вопрос
                        AnimatedBuilder(
                          animation: _shakeAnim,
                          builder: (_, child) => Transform.translate(
                            offset: Offset(
                                _shakeAnim.value *
                                    (_answered &&
                                            _selected !=
                                                exercise.correctIndex
                                        ? 1
                                        : 0),
                                0),
                            child: child,
                          ),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color:
                                      const Color(0xFFE0F0FF)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            child: Text(
                              exercise.question,
                              style: TextStyle(
                                fontSize: isKids ? 18 : 16,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF0F1F1E),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Варианты ответов
                        ...exercise.options.asMap().entries.map(
                          (entry) => _OptionTile(
                            label: entry.value,
                            index: entry.key,
                            selected: _selected == entry.key,
                            answered: _answered,
                            correct: entry.key == exercise.correctIndex,
                            isKidsMode: isKids,
                            accent: accent,
                            onTap: () => _select(entry.key),
                          ),
                        ),

                        // Пояснение после ответа
                        if (_answered) ...[
                          const SizedBox(height: 16),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: _selected ==
                                      exercise.correctIndex
                                  ? const Color(0xFFE8FDF5)
                                  : const Color(0xFFFFF3F3),
                              borderRadius:
                                  BorderRadius.circular(14),
                              border: Border.all(
                                color: _selected ==
                                        exercise.correctIndex
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFEF4444),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _selected ==
                                          exercise.correctIndex
                                      ? '✅'
                                      : '❌',
                                  style:
                                      const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    exercise.explanation,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF0F1F1E),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),

                // Кнопка Далее
                if (_answered)
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: accent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(16)),
                        ),
                        child: Text(
                          _current < _exercises.length - 1
                              ? 'Следующий вопрос →'
                              : 'Перейти к экзамену →',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            // Нейрончик
            Positioned(
              bottom: 100,
              right: 16,
              child: NeuronchikWidget(
                mood: _mood,
                size: 64,
                isKidsMode: isKids,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _exerciseTypeLabel(ExerciseType t) {
    switch (t) {
      case ExerciseType.multipleChoice: return '📝 Выбери правильный ответ';
      case ExerciseType.fillBlank: return '✏️ Заполни пропуск';
      case ExerciseType.translation: return '🔄 Перевод';
      case ExerciseType.matching: return '🔗 Сопоставь';
      case ExerciseType.trueOrFalse: return '✅ Верно или Неверно';
    }
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final int index;
  final bool selected;
  final bool answered;
  final bool correct;
  final bool isKidsMode;
  final Color accent;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.index,
    required this.selected,
    required this.answered,
    required this.correct,
    required this.isKidsMode,
    required this.accent,
    required this.onTap,
  });

  Color get _bgColor {
    if (!answered) return Colors.white;
    if (correct) return const Color(0xFFE8FDF5);
    if (selected) return const Color(0xFFFFF3F3);
    return Colors.white;
  }

  Color get _borderColor {
    if (!answered) return const Color(0xFFE0F0FF);
    if (correct) return const Color(0xFF4CAF50);
    if (selected) return const Color(0xFFEF4444);
    return const Color(0xFFE0F0FF);
  }

  @override
  Widget build(BuildContext context) {
    final letters = ['A', 'B', 'C', 'D'];

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _borderColor, width: 2),
          boxShadow: selected && !answered
              ? [
                  BoxShadow(
                    color: accent.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: answered
                    ? (correct
                        ? const Color(0xFF4CAF50)
                        : selected
                            ? const Color(0xFFEF4444)
                            : const Color(0xFFE2E8F0))
                    : (selected
                        ? accent
                        : const Color(0xFFE2E8F0)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: answered
                    ? Icon(
                        correct
                            ? Icons.check_rounded
                            : (selected
                                ? Icons.close_rounded
                                : null),
                        size: 16,
                        color: Colors.white,
                      )
                    : Text(
                        letters[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF64748B),
                        ),
                      ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: isKidsMode ? 15 : 14,
                  fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                  color: const Color(0xFF0F1F1E),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
