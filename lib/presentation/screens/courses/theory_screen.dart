import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../core/constants/app_colors.dart';
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
    final accent = isKids ? const Color(0xFFFF6B35) : AppColors.tiffany;

    return Scaffold(
      backgroundColor: isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg,
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
                            color: AppColors.darkCard,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: AppColors.darkBorder),
                          ),
                          child: const Icon(Icons.close_rounded,
                              size: 20, color: AppColors.textSecondary),
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
                                color: AppColors.textPrimary,
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
                    itemBuilder: (_, i) => _TheoryPage(
                      section: _sections[i],
                      isKidsMode: isKids,
                      langCode: widget.langCode,
                    ),
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

class _TheoryPage extends StatefulWidget {
  final TheorySection section;
  final bool isKidsMode;
  final String langCode;

  const _TheoryPage({
    required this.section,
    required this.isKidsMode,
    required this.langCode,
  });

  @override
  State<_TheoryPage> createState() => _TheoryPageState();
}

class _TheoryPageState extends State<_TheoryPage> {
  final FlutterTts _tts = FlutterTts();
  bool _speaking = false;

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  Future<void> _speak() async {
    if (_speaking) {
      await _tts.stop();
      setState(() => _speaking = false);
      return;
    }
    final lang = _ttsLang(widget.langCode);
    await _tts.setLanguage(lang);
    await _tts.setSpeechRate(0.4);
    await _tts.setVolume(1.0);
    setState(() => _speaking = true);
    await _tts.speak(widget.section.content);
    if (mounted) setState(() => _speaking = false);
  }

  String _ttsLang(String code) {
    switch (code) {
      case 'en': return 'en-US';
      case 'de': return 'de-DE';
      case 'fr': return 'fr-FR';
      case 'es': return 'es-ES';
      case 'it': return 'it-IT';
      case 'tr': return 'tr-TR';
      case 'ru': return 'ru-RU';
      case 'kz': return 'kk-KZ';
      case 'zh': return 'zh-CN';
      case 'ja': return 'ja-JP';
      case 'ko': return 'ko-KR';
      case 'ar': return 'ar-SA';
      default: return 'en-US';
    }
  }

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
              color: AppColors.tiffany.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: AppColors.tiffany.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                const Icon(Icons.menu_book_rounded,
                    color: AppColors.tiffany, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    widget.section.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.tiffany,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _speak,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: _speaking
                          ? AppColors.tiffany
                          : AppColors.tiffany.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _speaking
                              ? Icons.stop_rounded
                              : Icons.volume_up_rounded,
                          color: _speaking
                              ? Colors.white
                              : AppColors.tiffany,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _speaking ? 'Стоп' : 'Слушать',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: _speaking
                                ? Colors.white
                                : AppColors.tiffany,
                          ),
                        ),
                      ],
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
              color: AppColors.darkCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.darkBorder),
            ),
            child: Text(
              widget.section.content,
              style: TextStyle(
                fontSize: widget.isKidsMode ? 15 : 14,
                height: 1.7,
                color: AppColors.textPrimary,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Таблицы
          if (widget.section.tables != null)
            ...widget.section.tables!.map((t) => _GrammarTableWidget(table: t)),

          // Примеры
          if (widget.section.examples.isNotEmpty) ...[
            const Text(
              '📝 Примеры',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.section.examples.map((ex) => Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.tiffany.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.tiffany.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    ex,
                    style: TextStyle(
                      fontSize: widget.isKidsMode ? 14 : 13,
                      color: AppColors.textPrimary,
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
        border: Border.all(color: AppColors.darkBorder),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: AppColors.tiffany,
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
                              color: AppColors.tiffany,
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
                                    color: AppColors.textPrimary),
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
