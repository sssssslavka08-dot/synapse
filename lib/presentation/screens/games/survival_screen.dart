import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../services/words_service.dart';
import '../../../services/supabase_service.dart';

// ═══════════════════════════════════════════════════════════════
//  SurvivalScreen — Режим выживания (возраст > 12)
//  60 сек · 3 жизни · 3 сек на ответ · +5 XP за слово
// ═══════════════════════════════════════════════════════════════
class SurvivalScreen extends StatefulWidget {
  final String language;
  const SurvivalScreen({super.key, this.language = 'en'});

  @override
  State<SurvivalScreen> createState() => _SurvivalScreenState();
}

class _SurvivalScreenState extends State<SurvivalScreen>
    with TickerProviderStateMixin {
  List<LessonWord> _pool = [];
  bool _loading = true;
  bool _started = false;
  bool _gameOver = false;

  int _lives = 3;
  int _score = 0;
  int _xp = 0;
  int _timeLeft = 60; // секунды
  int _wordTimer = 3; // секунды на ответ
  int _poolIndex = 0;
  List<String> _options = [];
  String? _selected;
  bool _answered = false;

  Timer? _gameTimer;
  Timer? _wordCountdown;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;
  late AnimationController _wrongCtrl;
  late Animation<double> _wrongAnim;
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
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _wrongCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _wrongAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _wrongCtrl, curve: Curves.elasticIn),
    );
    _initTts();
    _loadWords();
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    await _tts.setLanguage(_ttsLocales[widget.language] ?? 'en-US');
    await _tts.setSpeechRate(0.5);
  }

  Future<void> _loadWords() async {
    final words = await WordsService.instance.getWordsByLanguage(
      language: widget.language,
      limit: 50,
    );
    words.shuffle();
    setState(() {
      _pool = words;
      _loading = false;
    });
  }

  void _startGame() {
    setState(() => _started = true);
    _setupNextWord();
    _startGameTimer();
  }

  void _startGameTimer() {
    _gameTimer?.cancel();
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() => _timeLeft--);
      if (_timeLeft <= 0) _endGame(reason: 'time');
    });
  }

  void _startWordTimer() {
    _wordCountdown?.cancel();
    setState(() => _wordTimer = 3);
    _wordCountdown = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _answered) return;
      setState(() => _wordTimer--);
      if (_wordTimer <= 0) {
        _wordCountdown?.cancel();
        _onWrong(null); // время вышло
      }
    });
  }

  void _setupNextWord() async {
    if (_poolIndex >= _pool.length) {
      _pool.shuffle();
      _poolIndex = 0;
    }
    final word = _pool[_poolIndex];
    final opts = await WordsService.instance.getOptions(
      correctTranslation: word.translation,
      language: widget.language,
      excludeWordId: word.id,
    );
    if (!mounted) return;
    setState(() {
      _options =
          opts.length >= 4 ? opts : _makeOptions(word.translation);
      _selected = null;
      _answered = false;
    });
    _tts.speak(word.word);
    _startWordTimer();
  }

  List<String> _makeOptions(String correct) {
    final others = _pool
        .where((w) => w.translation != correct)
        .map((w) => w.translation)
        .take(3)
        .toList();
    return [correct, ...others]..shuffle();
  }

  LessonWord get _current => _pool[_poolIndex];

  void _answer(String option) {
    if (_answered || _gameOver) return;
    _wordCountdown?.cancel();

    final isCorrect = option == _current.translation;
    setState(() {
      _selected = option;
      _answered = true;
    });

    if (isCorrect) {
      _onCorrect();
    } else {
      _onWrong(option);
    }
  }

  void _onCorrect() {
    setState(() {
      _score++;
      _xp += 5;
    });
    SupabaseService.instance.reviewWord(wordId: _current.id, quality: 4);
    _poolIndex++;
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted || _gameOver) return;
      _setupNextWord();
    });
  }

  void _onWrong(String? selected) {
    setState(() {
      _selected = selected;
      _answered = true;
      _lives--;
    });
    _wrongCtrl.forward(from: 0).then((_) => _wrongCtrl.reverse());
    if (selected != null) {
      SupabaseService.instance.reviewWord(wordId: _current.id, quality: 1);
    }
    if (_lives <= 0) {
      _endGame(reason: 'lives');
      return;
    }
    _poolIndex++;
    Future.delayed(const Duration(milliseconds: 900), () {
      if (!mounted || _gameOver) return;
      _setupNextWord();
    });
  }

  void _endGame({required String reason}) {
    _gameTimer?.cancel();
    _wordCountdown?.cancel();
    setState(() => _gameOver = true);

    // Сохраняем XP
    if (_xp > 0) {
      SupabaseService.instance.addWeeklyXp(_xp);
    }
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    _wordCountdown?.cancel();
    _pulseCtrl.dispose();
    _wrongCtrl.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F1E),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF0ABDB9)))
            : _pool.isEmpty
                ? _buildEmpty()
                : !_started
                    ? _buildStart()
                    : _gameOver
                        ? _buildResult()
                        : _buildGame(),
      ),
    );
  }

  Widget _buildEmpty() => Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('😕', style: TextStyle(fontSize: 48)),
          const SizedBox(height: 12),
          const Text('Нет слов для игры',
              style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0ABDB9),
                foregroundColor: Colors.white),
            child: const Text('Назад'),
          ),
        ]),
      );

  Widget _buildStart() => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('⚔️', style: TextStyle(fontSize: 72)),
            const SizedBox(height: 20),
            const Text('Режим Выживания',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: -0.5,
                )),
            const SizedBox(height: 12),
            const Text(
              '60 секунд · 3 жизни\n3 секунды на ответ · +5 XP за слово',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, fontSize: 15, height: 1.6),
            ),
            const SizedBox(height: 40),
            _InfoRow(icon: '⏱', text: '60 секунд всего'),
            const SizedBox(height: 10),
            _InfoRow(icon: '❤️', text: '3 жизни'),
            const SizedBox(height: 10),
            _InfoRow(icon: '⚡', text: '+5 XP за каждый правильный ответ'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _startGame,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0ABDB9),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                ),
                child: const Text('Начать! ⚔️',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Назад',
                  style: TextStyle(color: Colors.white38, fontSize: 14)),
            ),
          ],
        ),
      );

  Widget _buildGame() => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ── Статус-бар ─────────────────────────────────
            Row(
              children: [
                // Жизни
                Row(
                  children: List.generate(
                    3,
                    (i) => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        i < _lives ? '❤️' : '🖤',
                        style: const TextStyle(fontSize: 22),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Таймер
                AnimatedBuilder(
                  animation: _pulseCtrl,
                  builder: (_, __) => Transform.scale(
                    scale: _timeLeft <= 10 ? _pulseAnim.value : 1.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: _timeLeft <= 10
                            ? const Color(0xFFEF4444).withValues(alpha: 0.2)
                            : Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _timeLeft <= 10
                              ? const Color(0xFFEF4444)
                              : Colors.white24,
                        ),
                      ),
                      child: Text(
                        '⏱ $_timeLeft с',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: _timeLeft <= 10
                              ? const Color(0xFFEF4444)
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                // Счёт
                Text('⚡ $_xp XP',
                    style: const TextStyle(
                      color: Color(0xFF0ABDB9),
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    )),
              ],
            ),

            const SizedBox(height: 24),

            // ── Таймер слова ────────────────────────────────
            Row(
              children: List.generate(
                3,
                (i) => Expanded(
                  child: Container(
                    height: 6,
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    decoration: BoxDecoration(
                      color: i < _wordTimer
                          ? const Color(0xFF0ABDB9)
                          : Colors.white12,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 28),

            // ── Карточка слова ──────────────────────────────
            AnimatedBuilder(
              animation: _wrongCtrl,
              builder: (_, child) {
                final offset =
                    _wrongAnim.value * 10 * (0.5 - _wrongAnim.value).sign;
                return Transform.translate(
                  offset: Offset(offset, 0),
                  child: child,
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    vertical: 36, horizontal: 24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0ABDB9), Color(0xFF078987)],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0ABDB9).withValues(alpha: 0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: Column(children: [
                  Text(
                    _current.word,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  if (_current.transcription.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    Text(
                      '[${_current.transcription}]',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.7),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ]),
              ),
            ),

            const SizedBox(height: 28),

            // ── Варианты ───────────────────────────────────
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.0,
                physics: const NeverScrollableScrollPhysics(),
                children: _options.map((opt) {
                  Color bg = Colors.white.withValues(alpha: 0.08);
                  Color border = Colors.white24;
                  Color text = Colors.white;

                  if (_answered && opt == _current.translation) {
                    bg = const Color(0xFF22C55E).withValues(alpha: 0.2);
                    border = const Color(0xFF22C55E);
                    text = const Color(0xFF22C55E);
                  } else if (_answered && opt == _selected) {
                    bg = const Color(0xFFEF4444).withValues(alpha: 0.2);
                    border = const Color(0xFFEF4444);
                    text = const Color(0xFFEF4444);
                  }

                  return GestureDetector(
                    onTap: () => _answer(opt),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      decoration: BoxDecoration(
                        color: bg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: border, width: 1.5),
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

            // Слов переведено
            const SizedBox(height: 12),
            Text('Переведено: $_score слов',
                style: const TextStyle(
                    color: Colors.white54, fontSize: 13)),
          ],
        ),
      );

  Widget _buildResult() => Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_score >= 15 ? '🏆' : _score >= 8 ? '⭐' : '💪',
                style: const TextStyle(fontSize: 72)),
            const SizedBox(height: 16),
            Text(
              _score >= 15
                  ? 'Легендарный результат!'
                  : _score >= 8
                      ? 'Отличный результат!'
                      : 'Хороший старт!',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.white),
            ),
            const SizedBox(height: 24),
            _ResultRow(label: 'Слов переведено', value: '$_score'),
            const SizedBox(height: 8),
            _ResultRow(label: 'XP заработано', value: '+$_xp ⚡'),
            const SizedBox(height: 8),
            _ResultRow(
                label: 'Жизни осталось',
                value: List.generate(
                        _lives.clamp(0, 3), (_) => '❤️')
                    .join()),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _lives = 3;
                    _score = 0;
                    _xp = 0;
                    _timeLeft = 60;
                    _poolIndex = 0;
                    _started = false;
                    _gameOver = false;
                    _pool.shuffle();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0ABDB9),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Сыграть снова',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('На главную',
                  style: TextStyle(color: Colors.white38, fontSize: 14)),
            ),
          ],
        ),
      );
}

class _InfoRow extends StatelessWidget {
  final String icon, text;
  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(text,
              style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      );
}

class _ResultRow extends StatelessWidget {
  final String label, value;
  const _ResultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white60, fontSize: 15)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700)),
        ],
      );
}
