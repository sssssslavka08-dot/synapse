import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../services/words_service.dart';
import '../../../services/supabase_service.dart';
import '../../../services/daily_tasks_service.dart';
import '../../widgets/task_completed_overlay.dart';

// ═══════════════════════════════════════════════════════════════
//  FeedNeuronScreen — Детская мини-игра (возраст ≤ 12)
//  Большой эмодзи + 4 варианта. Персонаж Нейрончик реагирует.
// ═══════════════════════════════════════════════════════════════
class FeedNeuronScreen extends StatefulWidget {
  final String language;
  const FeedNeuronScreen({super.key, this.language = 'en'});

  @override
  State<FeedNeuronScreen> createState() => _FeedNeuronScreenState();
}

class _FeedNeuronScreenState extends State<FeedNeuronScreen>
    with TickerProviderStateMixin {
  List<LessonWord> _words = [];
  List<String> _options = [];
  bool _loading = true;
  int _index = 0;
  int _score = 0;
  int _xp = 0;
  String? _selected;
  bool _answered = false;
  bool _isSpeaking = false;

  // Нейрончик: 😴 → 😊 → 🤩 → 🥳
  String _neuron = '🤖';
  String _neuronMsg = 'Привет! Я Нейрончик!';

  late AnimationController _bounceCtrl;
  late AnimationController _xpCtrl;
  late Animation<double> _bounceAnim;
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
    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _bounceAnim = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut),
    );
    _xpCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _initTts();
    _loadWords();
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    await _tts.setLanguage(_ttsLocales[widget.language] ?? 'en-US');
    await _tts.setSpeechRate(0.4);
    _tts.setStartHandler(() => setState(() => _isSpeaking = true));
    _tts.setCompletionHandler(() => setState(() => _isSpeaking = false));
  }

  Future<void> _loadWords() async {
    final words = await WordsService.instance.getWordsForLesson(
      language: widget.language,
      count: 8,
    );
    if (words.isEmpty) {
      setState(() => _loading = false);
      return;
    }
    final opts = await WordsService.instance.getOptions(
      correctTranslation: words[0].translation,
      language: widget.language,
      excludeWordId: words[0].id,
    );
    setState(() {
      _words = words;
      _options = opts.length >= 4 ? opts : _localOptions(words[0], words);
      _loading = false;
    });
    await Future.delayed(const Duration(milliseconds: 400));
    _speakWord();
  }

  List<String> _localOptions(LessonWord correct, List<LessonWord> pool) {
    final others = pool
        .where((w) => w.id != correct.id)
        .map((w) => w.translation)
        .toList()
      ..shuffle();
    return [correct.translation, ...others.take(3)]..shuffle();
  }

  Future<void> _speakWord() async {
    if (_words.isEmpty) return;
    await _tts.stop();
    await _tts.speak(_words[_index].word);
  }

  LessonWord get _current => _words[_index];

  void _answer(String option) async {
    if (_answered) return;
    final isCorrect = option == _current.translation;
    setState(() {
      _selected = option;
      _answered = true;
    });

    // Обновляем Нейрончика
    if (isCorrect) {
      _score++;
      _xp += 15;
      setState(() {
        _neuron = _score >= 6 ? '🥳' : _score >= 3 ? '🤩' : '😊';
        _neuronMsg = ['Отлично! 🎉', 'Супер! ⚡', 'Молодец! 🌟', 'Ура! 🎊']
            [_score % 4];
      });
      _bounceCtrl.forward().then((_) => _bounceCtrl.reverse());
      _xpCtrl.forward(from: 0);

      // SM-2
      SupabaseService.instance
          .reviewWord(wordId: _current.id, quality: 4);
    } else {
      setState(() {
        _neuron = '😅';
        _neuronMsg = 'Попробуй ещё раз!';
      });
      SupabaseService.instance
          .reviewWord(wordId: _current.id, quality: 1);
    }

    await Future.delayed(const Duration(milliseconds: 1300));
    if (!mounted) return;

    if (_index < _words.length - 1) {
      final nextIdx = _index + 1;
      final opts = await WordsService.instance.getOptions(
        correctTranslation: _words[nextIdx].translation,
        language: widget.language,
        excludeWordId: _words[nextIdx].id,
      );
      setState(() {
        _index = nextIdx;
        _options = opts.length >= 4 ? opts : _localOptions(_words[nextIdx], _words);
        _selected = null;
        _answered = false;
      });
      _speakWord();
    } else {
      _showResult();
    }
  }

  void _showResult() async {
    // Трекинг ежедневных заданий
    final completedPlay = await DailyTasksService.updateProgress(
      taskType: 'play_game',
      count: 1,
    );
    List<Map<String, dynamic>> completedAnswers = [];
    if (_score > 0) {
      completedAnswers = await DailyTasksService.updateProgress(
        taskType: 'correct_answers',
        count: _score,
      );
    }
    if (!mounted) return;
    final all = [...completedPlay, ...completedAnswers];
    if (all.isNotEmpty) {
      // Не ждём — анимация на фоне, пока показываем диалог
      TaskCompletedOverlay.showAll(context, all);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🥳', style: TextStyle(fontSize: 60)),
              const SizedBox(height: 12),
              const Text('Урок завершён!',
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              Text('Правильно: $_score / ${_words.length}',
                  style: const TextStyle(
                      color: Color(0xFF4D6766), fontSize: 15)),
              const SizedBox(height: 4),
              Text('+$_xp XP заработано ⚡',
                  style: const TextStyle(
                      color: AppColors.tiffany,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tiffany,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('На главную',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bounceCtrl.dispose();
    _xpCtrl.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: _loading
            ? const Center(
                child:
                    CircularProgressIndicator(color: AppColors.tiffany))
            : _words.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('😕',
                            style: TextStyle(fontSize: 48)),
                        const SizedBox(height: 12),
                        const Text('Нет слов для игры',
                            style: TextStyle(color: AppColors.textSecondary)),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.tiffany,
                              foregroundColor: Colors.white),
                          child: const Text('Назад'),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // ── Шапка ──────────────────────────
                        Row(children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.darkBorder),
                              ),
                              child: const Icon(Icons.close,
                                  size: 20, color: Color(0xFF4D6766)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (_index + 1) / _words.length,
                                backgroundColor: AppColors.darkBorder,
                                valueColor: const AlwaysStoppedAnimation(
                                    AppColors.tiffany),
                                minHeight: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.tiffany
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text('⚡ $_xp XP',
                                style: const TextStyle(
                                  color: AppColors.tiffany,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13,
                                )),
                          ),
                        ]),

                        const SizedBox(height: 20),

                        // ── Нейрончик ──────────────────────
                        AnimatedBuilder(
                          animation: _bounceCtrl,
                          builder: (_, __) => Transform.scale(
                            scale: _bounceAnim.value,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: AppColors.darkBorder),
                              ),
                              child: Row(children: [
                                Text(_neuron,
                                    style: const TextStyle(fontSize: 32)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(_neuronMsg,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      )),
                                ),
                              ]),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ── Карточка со словом ──────────────
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.tiffany,
                                AppColors.tiffanyMid
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.tiffany
                                    .withValues(alpha: 0.3),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              )
                            ],
                          ),
                          child: Column(children: [
                            Text(_current.emoji,
                                style: const TextStyle(fontSize: 64)),
                            const SizedBox(height: 12),
                            Text(_current.word,
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                )),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: _speakWord,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 7),
                                decoration: BoxDecoration(
                                  color: Colors.white
                                      .withValues(alpha: _isSpeaking ? 0.35 : 0.2),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _isSpeaking
                                          ? Icons.volume_up_rounded
                                          : Icons.volume_up_outlined,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    const Text('🔊 Послушать',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),

                        const SizedBox(height: 20),

                        // ── Варианты ответов ────────────────
                        Expanded(
                          child: GridView.count(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.2,
                            physics: const NeverScrollableScrollPhysics(),
                            children: _options.map((opt) {
                              Color bg = AppColors.darkCard;
                              Color border = AppColors.darkBorder;
                              Color text = AppColors.textPrimary;

                              if (_answered &&
                                  opt == _current.translation) {
                                bg = const Color(0xFF22C55E)
                                    .withValues(alpha: 0.12);
                                border = const Color(0xFF22C55E);
                                text = const Color(0xFF22C55E);
                              } else if (_answered &&
                                  opt == _selected) {
                                bg = const Color(0xFFEF4444)
                                    .withValues(alpha: 0.12);
                                border = const Color(0xFFEF4444);
                                text = const Color(0xFFEF4444);
                              }

                              return GestureDetector(
                                onTap: () => _answer(opt),
                                child: AnimatedContainer(
                                  duration:
                                      const Duration(milliseconds: 200),
                                  decoration: BoxDecoration(
                                    color: bg,
                                    borderRadius:
                                        BorderRadius.circular(16),
                                    border: Border.all(
                                        color: border, width: 1.5),
                                  ),
                                  child: Center(
                                    child: Text(opt,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: text,
                                        )),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
