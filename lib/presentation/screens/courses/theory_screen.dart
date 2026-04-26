import 'package:flutter/material.dart';
import '../../../data/courses/course_structure.dart';
import '../../../services/course_service.dart';
import '../../../presentation/widgets/neuronchik.dart';
import 'exercise_screen.dart';

class TheoryScreen extends StatefulWidget {
  final CourseChapter chapter;
  final String langCode;
  final bool isKidsMode;

  const TheoryScreen({
    super.key,
    required this.chapter,
    required this.langCode,
    this.isKidsMode = false,
  });

  @override
  State<TheoryScreen> createState() => _TheoryScreenState();
}

class _TheoryScreenState extends State<TheoryScreen> {
  final PageController _pageCtrl = PageController();
  int _currentPage = 0;
  bool _completed = false;

  List<TheorySection> get _sections => widget.chapter.theory;
  int get _totalPages => _sections.length;

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageCtrl.nextPage(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    await CourseService.instance
        .markTheoryDone(widget.langCode, widget.chapter.id);
    if (!mounted) return;
    setState(() => _completed = true);
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;
    // Переходим к упражнениям, не возвращаясь назад
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseScreen(
          chapter: widget.chapter,
          langCode: widget.langCode,
          isKidsMode: widget.isKidsMode,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isKids = widget.isKidsMode;
    final accent = isKids ? const Color(0xFFFF6B35) : const Color(0xFF0ABDB9);

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
                            border:
                                Border.all(color: const Color(0xFFD6F5F4)),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 20, color: Color(0xFF4D6766)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.chapter.emoji} ${widget.chapter.title}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F1F1E),
                              ),
                            ),
                            Text(
                              'Теория · ${_currentPage + 1} из $_totalPages',
                              style: TextStyle(
                                  fontSize: 12, color: accent),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Прогресс-бар
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (_currentPage + 1) / _totalPages,
                      backgroundColor: accent.withValues(alpha: 0.12),
                      valueColor: AlwaysStoppedAnimation(accent),
                      minHeight: 5,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Контент
                Expanded(
                  child: PageView.builder(
                    controller: _pageCtrl,
                    onPageChanged: (i) =>
                        setState(() => _currentPage = i),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _totalPages,
                    itemBuilder: (_, i) =>
                        _TheoryPage(section: _sections[i], isKidsMode: isKids),
                  ),
                ),

                // Кнопка Далее
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
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
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text(
                        _currentPage < _totalPages - 1
                            ? 'Далее →'
                            : 'Перейти к упражнениям →',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Нейрончик
            if (isKids)
              Positioned(
                bottom: 100,
                right: 16,
                child: NeuronchikWidget(
                  mood: NeuronchikMood.thinking,
                  size: 64,
                  isKidsMode: true,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TheoryPage extends StatelessWidget {
  final TheorySection section;
  final bool isKidsMode;

  const _TheoryPage({required this.section, required this.isKidsMode});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок секции
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF0ABDB9).withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: const Color(0xFF0ABDB9).withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book_rounded,
                    color: Color(0xFF0ABDB9), size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    section.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0ABDB9),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Основной текст
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0F0FF)),
            ),
            child: Text(
              section.content,
              style: TextStyle(
                fontSize: isKidsMode ? 15 : 14,
                height: 1.7,
                color: const Color(0xFF0F1F1E),
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Таблицы
          if (section.tables != null)
            ...section.tables!.map((t) => _GrammarTableWidget(table: t)),

          // Примеры
          if (section.examples.isNotEmpty) ...[
            const Text(
              '📝 Примеры',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F1F1E),
              ),
            ),
            const SizedBox(height: 8),
            ...section.examples.map((ex) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8FDF9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFA8E6E3)),
                  ),
                  child: Text(
                    ex,
                    style: TextStyle(
                      fontSize: isKidsMode ? 14 : 13,
                      color: const Color(0xFF0F3D3B),
                      height: 1.5,
                    ),
                  ),
                )),
          ],
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _GrammarTableWidget extends StatelessWidget {
  final GrammarTable table;
  const _GrammarTableWidget({required this.table});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD6F5F4)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color(0xFF0ABDB9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(11)),
            ),
            child: Row(
              children: [
                const Icon(Icons.table_chart_rounded,
                    color: Colors.white, size: 16),
                const SizedBox(width: 6),
                Text(
                  table.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Заголовки
          Container(
            color: const Color(0xFFE0FAFA),
            child: Row(
              children: table.headers
                  .map((h) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            h,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0ABDB9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Строки
          ...table.rows.asMap().entries.map((entry) => Container(
                color: entry.key.isEven
                    ? Colors.white
                    : const Color(0xFFF8FFFE),
                child: Row(
                  children: entry.value
                      .map((cell) => Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                cell,
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF0F1F1E)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ))
                      .toList(),
                ),
              )),
        ],
      ),
    );
  }
}
