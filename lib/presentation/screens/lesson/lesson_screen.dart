import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../services/words_service.dart';
import '../../../services/supabase_service.dart';
import 'lesson_result_screen.dart';

class LessonScreen extends StatefulWidget {
  final bool isKidsMode;
  final String language; // 'en', 'kz', 'ru', 'de', 'fr', 'zh'
  final String name;
  final int age;
  const LessonScreen({
    super.key,
    this.isKidsMode = false,
    this.language = 'en',
    this.name = 'Пользователь',
    this.age = 13,
  });

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  List<LessonWord> _words = [];
  List<List<String>> _optionsCache = [];
  bool _loading = true;

  int _currentIndex = 0;
  int _correctCount = 0;
  int _wrongCount = 0;
  String? _selectedAnswer;
  bool _answered = false;
  bool _isSpeaking = false;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnim;
  late FlutterTts _tts;

  static const _ttsLocales = {
    'en': 'en-US',
    'kz': 'kk-KZ',
    'ru': 'ru-RU',
    'de': 'de-DE',
    'fr': 'fr-FR',
    'zh': 'zh-CN',
  };

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
    _initTts();
    _loadWords();
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    final locale = _ttsLocales[widget.language] ?? 'en-US';
    await _tts.setLanguage(locale);
    await _tts.setSpeechRate(0.45);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1.0);
    _tts.setStartHandler(() => setState(() => _isSpeaking = true));
    _tts.setCompletionHandler(() => setState(() => _isSpeaking = false));
    _tts.setErrorHandler((_) => setState(() => _isSpeaking = false));
  }

  Future<void> _loadWords() async {
    setState(() => _loading = true);
    try {
      final words = await WordsService.instance.getWordsForLesson(
        language: widget.language,
        count: 10,
      );

      if (words.isEmpty) {
        // Нет слов в Supabase — используем заглушку
        setState(() {
          _words = _fallbackWords(widget.language);
          _loading = false;
        });
      } else {
        // Загружаем варианты ответов для каждого слова
        final opts = <List<String>>[];
        for (final w in words) {
          final options = await WordsService.instance.getOptions(
            correctTranslation: w.translation,
            language: widget.language,
            excludeWordId: w.id,
          );
          // Если вариантов не хватает — fallback
          if (options.length < 4) {
            opts.add(_makeOptions(w.translation, words));
          } else {
            opts.add(options);
          }
        }
        setState(() {
          _words = words;
          _optionsCache = opts;
          _loading = false;
        });
      }

      await Future.delayed(const Duration(milliseconds: 500));
      _speakCurrentWord();
    } catch (e) {
      setState(() {
        _words = _fallbackWords(widget.language);
        _loading = false;
      });
    }
  }

  // Fallback если Supabase недоступен
  List<LessonWord> _fallbackWords(String lang) => [
        LessonWord(id: 'f1', word: 'Apple', translation: 'Яблоко', transcription: 'ˈæp.əl', category: 'food', difficulty: 1, language: lang),
        LessonWord(id: 'f2', word: 'Cat', translation: 'Кошка', transcription: 'kæt', category: 'animals', difficulty: 1, language: lang),
        LessonWord(id: 'f3', word: 'House', translation: 'Дом', transcription: 'haʊs', category: 'home', difficulty: 1, language: lang),
        LessonWord(id: 'f4', word: 'Water', translation: 'Вода', transcription: 'ˈwɔː.tər', category: 'nature', difficulty: 1, language: lang),
        LessonWord(id: 'f5', word: 'Book', translation: 'Книга', transcription: 'bʊk', category: 'education', difficulty: 1, language: lang),
      ];

  // Генерация 4 вариантов из списка слов урока
  List<String> _makeOptions(String correct, List<LessonWord> pool) {
    final others = pool
        .where((w) => w.translation != correct)
        .map((w) => w.translation)
        .toList()
      ..shuffle();
    final result = [correct, ...others.take(3)]..shuffle();
    return result;
  }

  Future<void> _speakCurrentWord() async {
    if (_words.isEmpty) return;
    final word = _words[_currentIndex].word;
    await _tts.stop();
    await _tts.speak(word);
  }

  LessonWord get _currentWord => _words[_currentIndex];

  List<String> get _currentOptions {
    if (_optionsCache.length > _currentIndex) {
      return _optionsCache[_currentIndex];
    }
    return _makeOptions(_currentWord.translation, _words);
  }

  void _selectAnswer(String answer) {
    if (_answered || _words.isEmpty) return;
    final isCorrect = answer == _currentWord.translation;

    setState(() {
      _selectedAnswer = answer;
      _answered = true;
      if (isCorrect) {
        _correctCount++;
      } else {
        _wrongCount++;
        _shakeController.forward().then((_) => _shakeController.reset());
      }
    });

    // Сохраняем в Supabase (SM-2)
    SupabaseService.instance.reviewWord(
      wordId: _currentWord.id,
      quality: isCorrect ? 4 : 1,
    );

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      if (_currentIndex < _words.length - 1) {
        setState(() {
          _currentIndex++;
          _selectedAnswer = null;
          _answered = false;
        });
        _speakCurrentWord();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LessonResultScreen(
              correct: _correctCount,
              wrong: _wrongCount,
              total: _words.length,
              isKidsMode: widget.isKidsMode,
              language: widget.language,
              name: widget.name,
              age: widget.age,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4FEFE),
        body: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: Color(0xFF0ABDB9)),
              SizedBox(height: 16),
              Text('Подбираем слова для тебя...',
                  style: TextStyle(color: Color(0xFF8EAEAC))),
            ],
          ),
        ),
      );
    }

    if (_words.isEmpty) {
      return Scaffold(
        backgroundColor: const Color(0xFFF4FEFE),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('😕', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 16),
              const Text('Слова не найдены.\nДобавь слова в Supabase.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF8EAEAC))),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0ABDB9),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Назад'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            // ── Шапка с прогрессом ──────────────────────────
            Padding(
              padding: const EdgeInsets.all(20),
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
                        border: Border.all(color: const Color(0xFFD6F5F4)),
                      ),
                      child: const Icon(Icons.close,
                          size: 20, color: Color(0xFF4D6766)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_currentIndex + 1} / ${_words.length}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF8EAEAC),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Row(children: [
                              const Text('✅ ', style: TextStyle(fontSize: 13)),
                              Text('$_correctCount',
                                  style: const TextStyle(
                                      color: Color(0xFF22C55E),
                                      fontWeight: FontWeight.w700)),
                              const SizedBox(width: 8),
                              const Text('❌ ', style: TextStyle(fontSize: 13)),
                              Text('$_wrongCount',
                                  style: const TextStyle(
                                      color: Color(0xFFEF4444),
                                      fontWeight: FontWeight.w700)),
                            ]),
                          ],
                        ),
                        const SizedBox(height: 6),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: (_currentIndex + 1) / _words.length,
                            backgroundColor: const Color(0xFFD6F5F4),
                            valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF0ABDB9)),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // ── Карточка слова ──────────────────────
                    AnimatedBuilder(
                      animation: _shakeAnim,
                      builder: (_, child) {
                        final offset =
                            _shakeAnim.value * 12 * (0.5 - _shakeAnim.value).sign;
                        return Transform.translate(
                          offset: Offset(offset, 0),
                          child: child,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(28),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
                          ),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF0ABDB9).withValues(alpha: 0.3),
                              blurRadius: 24,
                              offset: const Offset(0, 12),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Эмодзи для детей
                            if (widget.isKidsMode) ...[
                              Text(_currentWord.emoji,
                                  style: const TextStyle(fontSize: 52)),
                              const SizedBox(height: 10),
                            ],
                            Text(
                              _currentWord.word,
                              style: const TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -1,
                              ),
                            ),
                            // Транскрипция
                            if (_currentWord.transcription.isNotEmpty) ...[
                              const SizedBox(height: 6),
                              Text(
                                '[${_currentWord.transcription}]',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.75),
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                            const SizedBox(height: 14),

                            // Кнопка 🔊
                            GestureDetector(
                              onTap: _speakCurrentWord,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: _isSpeaking
                                      ? Colors.white.withValues(alpha: 0.35)
                                      : Colors.white.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                    color: Colors.white.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isSpeaking
                                          ? Icons.volume_up_rounded
                                          : Icons.volume_up_outlined,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text('Произношение',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.18),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: const Text('Что это значит?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ── Варианты ответов ────────────────────
                    ..._currentOptions.map((option) {
                      Color bg = Colors.white;
                      Color border = const Color(0xFFD6F5F4);
                      Color text = const Color(0xFF0F1F1E);
                      IconData? icon;

                      if (_answered && option == _currentWord.translation) {
                        bg = const Color(0xFF22C55E).withValues(alpha: 0.1);
                        border = const Color(0xFF22C55E);
                        text = const Color(0xFF22C55E);
                        icon = Icons.check_circle_rounded;
                      } else if (_answered && option == _selectedAnswer) {
                        bg = const Color(0xFFEF4444).withValues(alpha: 0.1);
                        border = const Color(0xFFEF4444);
                        text = const Color(0xFFEF4444);
                        icon = Icons.cancel_rounded;
                      }

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () => _selectAnswer(option),
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(option,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: text,
                                      )),
                                ),
                                if (icon != null)
                                  Icon(icon, color: text, size: 22),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
