import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:confetti/confetti.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/courses/course_structure.dart';
import '../../../services/course_service.dart';
import '../../../services/daily_tasks_service.dart';
import '../../../presentation/widgets/neuronchik.dart';

class ExamScreen extends StatefulWidget {
  final CourseChapter chapter;
  final String langCode;
  final String? nextChapterId;
  final bool isKidsMode;

  const ExamScreen({
    super.key,
    required this.chapter,
    required this.langCode,
    this.nextChapterId,
    this.isKidsMode = false,
  });

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  final Map<int, int> _answers = {};
  bool _showResults = false;
  int _score = 0;
  bool _loading = false;
  late AnimationController _resultCtrl;
  late Animation<double> _resultAnim;
  late ConfettiController _confettiCtrl;

  List<ExamQuestion> get _questions => widget.chapter.exam;

  @override
  void initState() {
    super.initState();
    _resultCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _resultAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _resultCtrl, curve: Curves.elasticOut),
    );
    _confettiCtrl = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _resultCtrl.dispose();
    _confettiCtrl.dispose();
    super.dispose();
  }

  void _select(int idx) {
    if (_answers.containsKey(_current)) return;
    final isCorrect = idx == _questions[_current].correctIndex;
    if (isCorrect) {
      HapticFeedback.lightImpact();
    } else {
      HapticFeedback.heavyImpact();
    }
    setState(() => _answers[_current] = idx);
  }

  void _next() {
    if (_current < _questions.length - 1) {
      setState(() => _current++);
    } else {
      _finishExam();
    }
  }

  Future<void> _finishExam() async {
    int correct = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].correctIndex) correct++;
    }
    final score = (correct / _questions.length * 100).round();

    setState(() {
      _score = score;
      _showResults = true;
      _loading = true;
    });

    await CourseService.instance.completeExam(
      langCode: widget.langCode,
      chapterId: widget.chapter.id,
      score: score,
      coinsReward: widget.chapter.coinsReward,
      xpReward: widget.chapter.xpReward,
      nextChapterId: widget.nextChapterId,
    );

    if (score >= 60) {
      await DailyTasksService.updateProgress(
        taskType: 'complete_lesson',
        count: 1,
        perfect: score == 100,
      );
      await DailyTasksService.updateProgress(
        taskType: 'correct_answers',
        count: correct,
      );
    }

    if (mounted) {
      setState(() => _loading = false);
      _resultCtrl.forward();
      if (_score >= 60) {
        _confettiCtrl.play();
        HapticFeedback.lightImpact();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_showResults) return _buildResults(context);

    final isKids = widget.isKidsMode;
    final question = _questions[_current];
    final answered = _answers.containsKey(_current);

    return Scaffold(
      backgroundColor: isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Шапка экзамена
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                  decoration: const BoxDecoration(
                    color: AppColors.darkCard,
                    border: Border(
                        bottom: BorderSide(color: AppColors.darkBorder)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: AppColors.darkBg,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.darkBorder),
                              ),
                              child: const Icon(Icons.close_rounded,
                                  size: 20, color: AppColors.textSecondary),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFF9800)
                                            .withValues(alpha: 0.1),
                                        borderRadius:
                                            BorderRadius.circular(6),
                                      ),
                                      child: const Text(
                                        '📝 ЭКЗАМЕН',
                                        style: TextStyle(
                                          color: Color(0xFFFF9800),
                                          fontSize: 10,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '${widget.chapter.emoji} ${widget.chapter.title}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Вопрос ${_current + 1} из ${_questions.length}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: (_current + 1) / _questions.length,
                          backgroundColor:
                              const Color(0xFFFF9800).withValues(alpha: 0.12),
                          valueColor: const AlwaysStoppedAnimation(
                              Color(0xFFFF9800)),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  ),
                ),

                // Вопрос + ответы
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.darkCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: AppColors.darkBorder),
                          ),
                          child: Text(
                            question.question,
                            style: TextStyle(
                              fontSize: isKids ? 18 : 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Варианты ответа
                        ...question.options.asMap().entries.map(
                          (e) => _ExamOption(
                            label: e.value,
                            index: e.key,
                            selected: _answers[_current] == e.key,
                            answered: answered,
                            correct: e.key == question.correctIndex,
                            isKidsMode: isKids,
                            onTap: () => _select(e.key),
                          ),
                        ),

                        // Пояснение
                        if (answered) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  _answers[_current] == question.correctIndex
                                      ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
                                      : const Color(0xFFEF4444).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    _answers[_current] == question.correctIndex
                                        ? const Color(0xFF4CAF50)
                                        : const Color(0xFFEF4444),
                              ),
                            ),
                            child: Text(
                              question.explanation,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textPrimary,
                                  height: 1.4),
                            ),
                          ),
                        ],
                        const SizedBox(height: 100),
                      ],
                    ),
                  ),
                ),

                // Кнопка
                if (answered)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    child: SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                        ),
                        child: Text(
                          _current < _questions.length - 1
                              ? 'Следующий вопрос →'
                              : 'Завершить экзамен ✓',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
              ],
            ),

            if (isKids)
              Positioned(
                bottom: 100,
                right: 16,
                child: NeuronchikWidget(
                  mood: NeuronchikMood.thinking,
                  size: 60,
                  isKidsMode: true,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    final passed = _score >= 60;
    final isKids = widget.isKidsMode;

    return Scaffold(
      backgroundColor:
          isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiCtrl,
              blastDirectionality: BlastDirectionality.explosive,
              numberOfParticles: 30,
              gravity: 0.2,
              emissionFrequency: 0.05,
              colors: const [
                Color(0xFF4ECDC4), Color(0xFFFFD700),
                Color(0xFF4CAF50), Color(0xFFFF9800), Color(0xFFE91E63),
              ],
            ),
          ),
          SafeArea(
        child: _loading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Color(0xFFFF9800)),
                    SizedBox(height: 20),
                    Text('Сохраняем результаты...',
                        style: TextStyle(
                            color: AppColors.textSecondary, fontSize: 14)),
                  ],
                ),
              )
            : ScaleTransition(
                scale: _resultAnim,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        passed ? '🎉' : '😓',
                        style: const TextStyle(fontSize: 72),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        passed
                            ? isKids
                                ? 'Ты молодец! Глава пройдена!'
                                : 'Глава завершена!'
                            : 'Попробуй ещё раз',
                        style: TextStyle(
                          fontSize: isKids ? 26 : 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),

                      // Результат
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.darkCard,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: passed
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFEF4444),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$_score%',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.w900,
                                color: passed
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFEF4444),
                              ),
                            ),
                            Text(
                              passed
                                  ? 'Отличный результат!'
                                  : 'Нужно минимум 60%',
                              style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textSecondary),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                _ResultBadge(
                                    icon: '🪙',
                                    label:
                                        '+${widget.chapter.coinsReward}',
                                    active: passed),
                                const SizedBox(width: 16),
                                _ResultBadge(
                                    icon: '⚡',
                                    label:
                                        '+${widget.chapter.xpReward} XP',
                                    active: passed),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: passed
                                ? const Color(0xFF4CAF50)
                                : const Color(0xFFFF9800),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(16)),
                          ),
                          child: Text(
                            passed
                                ? 'К следующей главе →'
                                : 'Попробовать ещё раз',
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}

class _ExamOption extends StatelessWidget {
  final String label;
  final int index;
  final bool selected;
  final bool answered;
  final bool correct;
  final bool isKidsMode;
  final VoidCallback onTap;

  const _ExamOption({
    required this.label,
    required this.index,
    required this.selected,
    required this.answered,
    required this.correct,
    required this.isKidsMode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color bg = AppColors.darkCard;
    Color border = AppColors.darkBorder;

    if (answered) {
      if (correct) { bg = const Color(0xFF4CAF50).withValues(alpha: 0.15); border = const Color(0xFF4CAF50); }
      else if (selected) { bg = const Color(0xFFEF4444).withValues(alpha: 0.15); border = const Color(0xFFEF4444); }
    } else if (selected) {
      border = const Color(0xFFFF9800);
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 2),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: isKidsMode ? 15 : 14,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class _ResultBadge extends StatelessWidget {
  final String icon;
  final String label;
  final bool active;

  const _ResultBadge({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF4CAF50).withValues(alpha: 0.15)
            : AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active
              ? const Color(0xFF4CAF50)
              : AppColors.darkBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: active
                  ? const Color(0xFF4CAF50)
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
