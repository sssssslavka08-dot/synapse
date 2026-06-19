import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../core/constants/app_colors.dart';
import '../../../services/daily_tasks_service.dart';
import '../../../services/supabase_service.dart';
import '../../../services/words_service.dart';
import '../../widgets/task_completed_overlay.dart';

/// Детская игра: истребитель Нейрончика + быстрый перевод слов (3 ❤️).
class NeuronJetScreen extends StatefulWidget {
  final String language;
  const NeuronJetScreen({super.key, this.language = 'en'});

  @override
  State<NeuronJetScreen> createState() => _NeuronJetScreenState();
}

class _JetEnemy {
  double x;
  double y;
  final double speed;
  final bool isBoss;
  bool alive;

  _JetEnemy({
    required this.x,
    required this.y,
    required this.speed,
    this.isBoss = false,
  }) : alive = true;
}

class _JetBullet {
  double x;
  double y;
  _JetBullet(this.x, this.y);
}

class _NeuronJetScreenState extends State<NeuronJetScreen>
    with TickerProviderStateMixin {
  static const _ttsLocales = {
    'en': 'en-US',
    'kz': 'kk-KZ',
    'ru': 'ru-RU',
    'de': 'de-DE',
    'fr': 'fr-FR',
    'zh': 'zh-CN',
    'es': 'es-ES',
    'ja': 'ja-JP',
    'tr': 'tr-TR',
    'it': 'it-IT',
    'ko': 'ko-KR',
    'ar': 'ar-SA',
  };

  final _rng = Random();
  final _enemies = <_JetEnemy>[];
  final _bullets = <_JetBullet>[];

  List<LessonWord> _wordPool = [];
  LessonWord? _activeWord;
  List<String> _wordOptions = [];

  bool _loading = true;
  bool _started = false;
  bool _gameOver = false;
  bool _wordPhase = false;
  int _lives = 3;
  int _score = 0;
  int _xp = 0;
  int _kills = 0;
  String? _selected;
  bool _wordAnswered = false;

  double _jetX = 0.5;
  double _fieldW = 1;

  Timer? _loop;
  Timer? _spawnTimer;
  Timer? _shootTimer;
  Timer? _wordTimer;
  late FlutterTts _tts;

  @override
  void initState() {
    super.initState();
    _initTts();
    _loadWords();
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    await _tts.setLanguage(_ttsLocales[widget.language] ?? 'en-US');
    await _tts.setSpeechRate(0.45);
  }

  Future<void> _loadWords() async {
    final words = await WordsService.instance.getWordsForLesson(
      language: widget.language,
      count: 24,
    );
    words.shuffle();
    setState(() {
      _wordPool = words;
      _loading = false;
    });
  }

  void _startGame() {
    setState(() {
      _started = true;
      _gameOver = false;
      _lives = 3;
      _score = 0;
      _xp = 0;
      _kills = 0;
      _enemies.clear();
      _bullets.clear();
      _jetX = 0.5;
    });
    _spawnTimer = Timer.periodic(const Duration(milliseconds: 900), (_) {
      if (!mounted || _gameOver || _wordPhase) return;
      _spawnEnemy();
    });
    _shootTimer = Timer.periodic(const Duration(milliseconds: 280), (_) {
      if (!mounted || _gameOver || _wordPhase) return;
      _fire();
    });
    _loop = Timer.periodic(const Duration(milliseconds: 33), (_) => _tick());
    _scheduleWordPhase();
  }

  void _scheduleWordPhase() {
    _wordTimer?.cancel();
    _wordTimer = Timer(const Duration(seconds: 12), () {
      if (!mounted || _gameOver || _wordPhase) return;
      _beginWordPhase();
    });
  }

  void _spawnEnemy() {
    if (_fieldW <= 0) return;
    setState(() {
      _enemies.add(_JetEnemy(
        x: 0.08 + _rng.nextDouble() * 0.84,
        y: -0.08,
        speed: 0.004 + _rng.nextDouble() * 0.004,
        isBoss: _kills > 0 && _kills % 7 == 0,
      ));
    });
  }

  void _fire() {
    setState(() {
      _bullets.add(_JetBullet(_jetX, 0.88));
    });
  }

  void _tick() {
    if (!mounted || _gameOver || _wordPhase) return;
    setState(() {
      for (final b in _bullets) {
        b.y -= 0.018;
      }
      _bullets.removeWhere((b) => b.y < -0.05);

      for (final e in _enemies) {
        if (!e.alive) continue;
        e.y += e.speed;
        if (e.y > 0.92) {
          e.alive = false;
          _lives--;
          if (_lives <= 0) _endGame();
        }
      }

      for (final b in _bullets) {
        for (final e in _enemies) {
          if (!e.alive) continue;
          if ((b.x - e.x).abs() < 0.06 && (b.y - e.y).abs() < 0.06) {
            e.alive = false;
            _kills++;
            _score += e.isBoss ? 25 : 10;
            if (_kills % 5 == 0) {
              Future.microtask(_beginWordPhase);
            }
          }
        }
      }
      _enemies.removeWhere((e) => !e.alive);
    });
  }

  Future<void> _beginWordPhase() async {
    if (_wordPool.isEmpty || _gameOver) return;
    _wordTimer?.cancel();
    setState(() {
      _wordPhase = true;
      _wordAnswered = false;
      _selected = null;
      _activeWord = _wordPool[_kills % _wordPool.length];
    });
    final w = _activeWord!;
    final opts = await WordsService.instance.getOptions(
      correctTranslation: w.translation,
      language: widget.language,
      excludeWordId: w.id,
    );
    if (!mounted) return;
    setState(() => _wordOptions = opts);
    _tts.speak(w.word);
  }

  void _onWordPick(String option) {
    if (_wordAnswered || _activeWord == null) return;
    final correct = option == _activeWord!.translation;
    setState(() {
      _wordAnswered = true;
      _selected = option;
    });

    if (correct) {
      HapticFeedback.lightImpact();
      _score += 30;
      _xp += 8;
      SupabaseService.instance.reviewWord(
        wordId: _activeWord!.id,
        quality: 5,
      );
      Future.delayed(const Duration(milliseconds: 700), _endWordPhase);
    } else {
      HapticFeedback.heavyImpact();
      setState(() => _lives--);
      SupabaseService.instance.reviewWord(
        wordId: _activeWord!.id,
        quality: 1,
      );
      if (_lives <= 0) {
        Future.delayed(const Duration(milliseconds: 800), _endGame);
      } else {
        Future.delayed(const Duration(milliseconds: 900), _endWordPhase);
      }
    }
  }

  void _endWordPhase() {
    if (!mounted || _gameOver) return;
    setState(() {
      _wordPhase = false;
      _activeWord = null;
      _wordOptions = [];
      _selected = null;
      _wordAnswered = false;
    });
    _scheduleWordPhase();
  }

  Future<void> _endGame() async {
    _loop?.cancel();
    _spawnTimer?.cancel();
    _shootTimer?.cancel();
    _wordTimer?.cancel();
    if (_xp > 0) {
      SupabaseService.instance.addWeeklyXp(_xp);
    }
    if (!mounted) return;
    setState(() => _gameOver = true);
    _trackDailyTasks();
  }

  Future<void> _trackDailyTasks() async {
    final completedPlay = await DailyTasksService.updateProgress(
      taskType: 'play_game',
      count: 1,
    );
    List<Map<String, dynamic>> completedAnswers = [];
    if (_score > 0) {
      completedAnswers = await DailyTasksService.updateProgress(
        taskType: 'correct_answers',
        count: _score.clamp(0, 30),
      );
    }
    if (!mounted) return;
    final all = [...completedPlay, ...completedAnswers];
    if (all.isNotEmpty) {
      TaskCompletedOverlay.showAll(context, all);
    }
  }

  @override
  void dispose() {
    _loop?.cancel();
    _spawnTimer?.cancel();
    _shootTimer?.cancel();
    _wordTimer?.cancel();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF061214),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.tiffany),
              )
            : _gameOver
                ? _buildGameOver()
                : !_started
                    ? _buildStart()
                    : _buildGame(),
      ),
    );
  }

  Widget _buildStart() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white70),
            ),
          ),
          const Spacer(),
          Image.asset('assets/images/robot.png', height: 120),
          const SizedBox(height: 16),
          const Text(
            'Нейро-истребитель',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Сбивай врагов и быстро переводи слова!\n3 сердечка · ошибка = −1 ❤️',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF8EAEAC),
              fontSize: 15,
              height: 1.5,
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.tiffany,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: _startGame,
              child: const Text(
                'Взлёт! 🚀',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameOver() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('💥', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 12),
            const Text(
              'Миссия завершена!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Очки: $_score · XP: +$_xp',
              style: const TextStyle(color: Color(0xFF8EAEAC), fontSize: 16),
            ),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Выход'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.tiffany,
                    ),
                    onPressed: () => setState(() {
                      _started = false;
                      _gameOver = false;
                    }),
                    child: const Text('Ещё раз'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGame() {
    return LayoutBuilder(
      builder: (context, c) {
        _fieldW = c.maxWidth;
        return Stack(
          children: [
            // Поле боя
            GestureDetector(
              onHorizontalDragUpdate: (d) {
                setState(() {
                  _jetX = (_jetX + d.delta.dx / _fieldW).clamp(0.08, 0.92);
                });
              },
              child: CustomPaint(
                size: Size(c.maxWidth, c.maxHeight),
                painter: _JetPainter(
                  jetX: _jetX,
                  enemies: _enemies,
                  bullets: _bullets,
                ),
              ),
            ),
            // HUD
            Positioned(
              top: 8,
              left: 12,
              right: 12,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _loop?.cancel();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  ),
                  const Spacer(),
                  Text(
                    '⭐ $_score',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    '❤️' * _lives.clamp(0, 3),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            if (_wordPhase && _activeWord != null) _buildWordOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildWordOverlay() {
    final w = _activeWord!;
    return Container(
      color: Colors.black.withValues(alpha: 0.72),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.tiffany.withValues(alpha: 0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '⚡ Переведи быстро!',
                style: TextStyle(
                  color: AppColors.tiffany,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                w.word,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                ),
              ),
              if (w.transcription.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  w.transcription,
                  style: const TextStyle(color: Color(0xFF8EAEAC)),
                ),
              ],
              const SizedBox(height: 18),
              ..._wordOptions.map((opt) {
                final sel = _selected == opt;
                final showResult = _wordAnswered;
                final isCorrect = opt == w.translation;
                Color? bg;
                if (showResult && sel) {
                  bg = isCorrect
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444);
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: bg ?? AppColors.darkSurface,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: BorderSide(
                            color: AppColors.darkBorder.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                      onPressed:
                          _wordAnswered ? null : () => _onWordPick(opt),
                      child: Text(
                        opt,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class _JetPainter extends CustomPainter {
  final double jetX;
  final List<_JetEnemy> enemies;
  final List<_JetBullet> bullets;

  _JetPainter({
    required this.jetX,
    required this.enemies,
    required this.bullets,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Звёзды
    final star = Paint()..color = Colors.white.withValues(alpha: 0.15);
    for (var i = 0; i < 40; i++) {
      final x = (i * 47.0) % size.width;
      final y = (i * 83.0) % size.height;
      canvas.drawCircle(Offset(x, y), 1.2, star);
    }

    // Враги
    for (final e in enemies) {
      if (!e.alive) continue;
      final cx = e.x * size.width;
      final cy = e.y * size.height;
      final r = e.isBoss ? 22.0 : 16.0;
      canvas.drawCircle(
        Offset(cx, cy),
        r,
        Paint()..color = e.isBoss ? const Color(0xFFFF6B6B) : const Color(0xFF7C3AED),
      );
      final eye = Paint()..color = Colors.white;
      canvas.drawCircle(Offset(cx - 5, cy - 3), 3, eye);
      canvas.drawCircle(Offset(cx + 5, cy - 3), 3, eye);
    }

    // Пули
    final bulletPaint = Paint()..color = AppColors.tiffany;
    for (final b in bullets) {
      canvas.drawCircle(
        Offset(b.x * size.width, b.y * size.height),
        4,
        bulletPaint,
      );
    }

    // Истребитель
    final jx = jetX * size.width;
    final jy = size.height * 0.9;
    final jetPath = Path()
      ..moveTo(jx, jy - 28)
      ..lineTo(jx - 22, jy + 14)
      ..lineTo(jx, jy + 6)
      ..lineTo(jx + 22, jy + 14)
      ..close();
    canvas.drawPath(jetPath, Paint()..color = AppColors.tiffany);
    canvas.drawPath(
      jetPath,
      Paint()
        ..color = Colors.white.withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawCircle(
      Offset(jx, jy - 8),
      7,
      Paint()..color = const Color(0xFF0ABDB9),
    );
  }

  @override
  bool shouldRepaint(covariant _JetPainter old) => true;
}
