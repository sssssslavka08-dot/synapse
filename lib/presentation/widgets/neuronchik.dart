import 'dart:math';
import 'package:flutter/material.dart';

enum NeuronchikMood { happy, excited, thinking, sleeping, cheering, sad, love }

class NeuronchikWidget extends StatefulWidget {
  final String? message;
  final NeuronchikMood mood;
  final double size;
  final bool isKidsMode;

  const NeuronchikWidget({
    super.key,
    this.message,
    this.mood = NeuronchikMood.happy,
    this.size = 64,
    this.isKidsMode = true,
  });

  @override
  State<NeuronchikWidget> createState() => _NeuronchikWidgetState();
}

class _NeuronchikWidgetState extends State<NeuronchikWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late AnimationController _bounceCtrl;
  late AnimationController _blinkCtrl;
  late AnimationController _waveCtrl;
  late Animation<double> _floatAnim;
  late Animation<double> _bounceAnim;
  late Animation<double> _blinkAnim;
  late Animation<double> _waveAnim;

  bool _showBubble = false;
  bool _minimized = false;
  bool _eyeOpen = true;
  String _currentMessage = '';

  static const _messages = {
    NeuronchikMood.happy: [
      'Привет! Ты молодец! 💪',
      'Каждый урок делает тебя умнее! 🧠',
      'Отличный прогресс! ⚡',
      'Так держать, дружище! 🌟',
    ],
    NeuronchikMood.excited: [
      'ВАУ! Ты просто супер! 🌟',
      'Невероятно! Так держать! 🏆',
      'Ты на верном пути! 🚀',
      'Я в тебя верю! 💥',
    ],
    NeuronchikMood.thinking: [
      'Думай внимательно... 🤔',
      'Вспомни — ты это знаешь! 💡',
      'Не торопись, подумай! ⏳',
      'Ответ где-то рядом... 🔍',
    ],
    NeuronchikMood.sleeping: [
      'Zzz... Разбуди меня уроком! 😴',
      'Соскучился по занятиям! 💤',
      'Эй, я здесь! 👀',
    ],
    NeuronchikMood.cheering: [
      'УРА! Задание выполнено! 🎉',
      'Получил монеты! 🪙',
      'Новое достижение! 🏅',
      'Ты чемпион! 🥇',
    ],
    NeuronchikMood.sad: [
      'Не расстраивайся! 🤗',
      'Попробуй ещё раз! 💪',
      'Ошибки — это нормально! ❤️',
    ],
    NeuronchikMood.love: [
      'Ты мой любимый ученик! ❤️',
      'Обожаю учиться вместе! 🥰',
      'До встречи завтра! 👋',
    ],
  };

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _blinkCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );

    _waveCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _floatAnim = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    _bounceAnim = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut),
    );

    _blinkAnim = Tween<double>(begin: 1.0, end: 0.05).animate(
      CurvedAnimation(parent: _blinkCtrl, curve: Curves.easeInOut),
    );

    _waveAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _waveCtrl, curve: Curves.easeInOut),
    );

    // Приветствие через 1.2 секунды
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _showMessage();
    });

    // Мигание каждые 3-5 секунд
    _scheduleBlink();
  }

  void _scheduleBlink() {
    final delay = 3000 + Random().nextInt(2000);
    Future.delayed(Duration(milliseconds: delay), () {
      if (!mounted) return;
      _blinkCtrl.forward().then((_) {
        _blinkCtrl.reverse().then((_) {
          if (mounted) _scheduleBlink();
        });
      });
    });
  }

  void _showMessage() {
    final msgs = _messages[widget.mood] ?? _messages[NeuronchikMood.happy]!;
    final msg = widget.message ?? msgs[Random().nextInt(msgs.length)];
    if (!mounted) return;
    setState(() {
      _currentMessage = msg;
      _showBubble = true;
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showBubble = false);
    });
  }

  void _onTap() {
    if (_minimized) {
      setState(() => _minimized = false);
      return;
    }
    _bounceCtrl.forward().then((_) => _bounceCtrl.reverse());
    _waveCtrl.forward().then((_) => _waveCtrl.reverse());
    _showMessage();
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _bounceCtrl.dispose();
    _blinkCtrl.dispose();
    _waveCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation:
          Listenable.merge([_floatAnim, _bounceAnim, _blinkAnim, _waveAnim]),
      builder: (_, __) => Transform.translate(
        offset: Offset(0, -_floatAnim.value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Пузырь с сообщением
            AnimatedOpacity(
              opacity: _showBubble && !_minimized ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8, right: 4),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                constraints: const BoxConstraints(maxWidth: 200),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(4),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0ABDB9).withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ],
                  border: Border.all(color: const Color(0xFFD6F5F4), width: 1.5),
                ),
                child: Text(
                  _currentMessage,
                  style: TextStyle(
                    fontSize: widget.isKidsMode ? 13 : 12,
                    color: const Color(0xFF0F1F1E),
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // Нейрончик — мультяшный робот
            GestureDetector(
              onTap: _onTap,
              onLongPress: () => setState(() => _minimized = !_minimized),
              child: Transform.scale(
                scale: _bounceAnim.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _minimized ? 44 : widget.size,
                  height: _minimized ? 44 : widget.size,
                  child: _minimized
                      ? _MinimizedBot(size: 44)
                      : CustomPaint(
                          painter: _NeuronchikPainter(
                            mood: widget.mood,
                            blinkScale: _blinkAnim.value,
                            waveProgress: _waveAnim.value,
                            isKidsMode: widget.isKidsMode,
                          ),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Мини-версия нейрончика ──────────────────────────────────────
class _MinimizedBot extends StatelessWidget {
  final double size;
  const _MinimizedBot({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: const Color(0xFF0ABDB9),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: const Center(
        child: Text('🤖', style: TextStyle(fontSize: 22)),
      ),
    );
  }
}

// ── CustomPainter — рисует мультяшного робота ───────────────────
class _NeuronchikPainter extends CustomPainter {
  final NeuronchikMood mood;
  final double blinkScale;
  final double waveProgress;
  final bool isKidsMode;

  const _NeuronchikPainter({
    required this.mood,
    required this.blinkScale,
    required this.waveProgress,
    required this.isKidsMode,
  });

  // Основной цвет в зависимости от настроения
  Color get _bodyColor {
    switch (mood) {
      case NeuronchikMood.excited:
      case NeuronchikMood.cheering:
        return const Color(0xFF0ABDB9);
      case NeuronchikMood.sleeping:
        return const Color(0xFF8EAEAC);
      case NeuronchikMood.sad:
        return const Color(0xFF64748B);
      case NeuronchikMood.love:
        return const Color(0xFFE91E8C);
      default:
        return const Color(0xFF0ABDB9);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final cx = w / 2;
    final cy = h / 2;

    // ── Тень ────────────────────────────────────────────────────
    final shadowPaint = Paint()
      ..color = _bodyColor.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, h * 0.9), width: w * 0.6, height: h * 0.12),
      shadowPaint,
    );

    // ── Антенна ──────────────────────────────────────────────────
    final antennaPaint = Paint()
      ..color = _bodyColor
      ..strokeWidth = w * 0.05
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(cx, h * 0.08),
      Offset(cx, h * 0.22),
      antennaPaint,
    );

    // Шарик антенны
    final antBallPaint = Paint()
      ..color = mood == NeuronchikMood.excited || mood == NeuronchikMood.cheering
          ? const Color(0xFFFFD700)
          : Colors.white
      ..style = PaintingStyle.fill;
    final antBallBorderPaint = Paint()
      ..color = _bodyColor
      ..strokeWidth = w * 0.04
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(cx, h * 0.07), w * 0.065, antBallPaint);
    canvas.drawCircle(Offset(cx, h * 0.07), w * 0.065, antBallBorderPaint);

    // ── Тело (голова) ────────────────────────────────────────────
    final bodyPaint = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;
    final bodyRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.1, h * 0.2, w * 0.8, h * 0.65),
      Radius.circular(w * 0.22),
    );
    canvas.drawRRect(bodyRect, bodyPaint);

    // Внутренний экран (лицо)
    final screenPaint = Paint()
      ..color = const Color(0xFF0F2827)
      ..style = PaintingStyle.fill;
    final screenRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.18, h * 0.28, w * 0.64, h * 0.45),
      Radius.circular(w * 0.14),
    );
    canvas.drawRRect(screenRect, screenPaint);

    // ── Глаза ───────────────────────────────────────────────────
    _drawEyes(canvas, w, h, cx);

    // ── Рот ─────────────────────────────────────────────────────
    _drawMouth(canvas, w, h, cx);

    // ── Щёки (kids mode) ─────────────────────────────────────────
    if (isKidsMode &&
        (mood == NeuronchikMood.happy ||
            mood == NeuronchikMood.excited ||
            mood == NeuronchikMood.cheering ||
            mood == NeuronchikMood.love)) {
      final cheekPaint = Paint()
        ..color = const Color(0xFFFF9DB5).withValues(alpha: 0.5)
        ..style = PaintingStyle.fill;
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.24, h * 0.57), width: w * 0.14, height: h * 0.09),
        cheekPaint,
      );
      canvas.drawOval(
        Rect.fromCenter(
            center: Offset(w * 0.76, h * 0.57), width: w * 0.14, height: h * 0.09),
        cheekPaint,
      );
    }

    // ── Маленькие ушки-болты ─────────────────────────────────────
    final boltPaint = Paint()
      ..color = _bodyColor.withValues(alpha: 0.7)
      ..style = PaintingStyle.fill;
    // Левый болт
    canvas.drawCircle(Offset(w * 0.07, h * 0.44), w * 0.06, boltPaint);
    canvas.drawCircle(
        Offset(w * 0.07, h * 0.44),
        w * 0.04,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill);
    // Правый болт
    canvas.drawCircle(Offset(w * 0.93, h * 0.44), w * 0.06, boltPaint);
    canvas.drawCircle(
        Offset(w * 0.93, h * 0.44),
        w * 0.04,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.3)
          ..style = PaintingStyle.fill);

    // ── Размахивающая рука (при тапе) ────────────────────────────
    if (waveProgress > 0) {
      final armAngle = -pi / 6 - (pi / 4) * sin(waveProgress * pi);
      final armPaint = Paint()
        ..color = _bodyColor
        ..strokeWidth = w * 0.09
        ..strokeCap = StrokeCap.round
        ..style = PaintingStyle.stroke;
      final armStart = Offset(w * 0.88, h * 0.44);
      final armEnd = Offset(
        armStart.dx + cos(armAngle) * w * 0.3,
        armStart.dy + sin(armAngle) * h * 0.3,
      );
      canvas.drawLine(armStart, armEnd, armPaint);
    }

    // ── Звёздочки вокруг (при excited/cheering) ──────────────────
    if (mood == NeuronchikMood.excited || mood == NeuronchikMood.cheering) {
      _drawSparkles(canvas, w, h);
    }
  }

  void _drawEyes(Canvas canvas, double w, double h, double cx) {
    final eyeWhitePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final eyePupilPaint = Paint()
      ..color = const Color(0xFF0F2827)
      ..style = PaintingStyle.fill;

    final eyeGlowPaint = Paint()
      ..color = _bodyColor
      ..style = PaintingStyle.fill;

    // Позиции глаз
    final leftEyeCenter = Offset(cx - w * 0.17, h * 0.47);
    final rightEyeCenter = Offset(cx + w * 0.17, h * 0.47);
    final eyeRadius = w * 0.11;

    for (final center in [leftEyeCenter, rightEyeCenter]) {
      if (mood == NeuronchikMood.sleeping) {
        // Закрытые глаза — линия
        final closedPaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.7)
          ..strokeWidth = w * 0.04
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke;
        canvas.drawArc(
          Rect.fromCenter(center: center, width: eyeRadius * 2, height: eyeRadius),
          0,
          pi,
          false,
          closedPaint,
        );
      } else if (mood == NeuronchikMood.thinking) {
        // Один глаз прищурен
        final isLeft = center == leftEyeCenter;
        if (isLeft) {
          // Прищуренный
          final squintPaint = Paint()
            ..color = Colors.white.withValues(alpha: 0.8)
            ..strokeWidth = w * 0.04
            ..strokeCap = StrokeCap.round
            ..style = PaintingStyle.stroke;
          canvas.drawLine(
            Offset(center.dx - eyeRadius * 0.7, center.dy),
            Offset(center.dx + eyeRadius * 0.7, center.dy),
            squintPaint,
          );
        } else {
          _drawNormalEye(canvas, center, eyeRadius, eyeWhitePaint,
              eyePupilPaint, eyeGlowPaint);
        }
      } else {
        // Нормальный глаз с морганием
        canvas.save();
        canvas.translate(center.dx, center.dy);
        canvas.scale(1.0, blinkScale.clamp(0.05, 1.0));
        canvas.translate(-center.dx, -center.dy);
        _drawNormalEye(canvas, center, eyeRadius, eyeWhitePaint,
            eyePupilPaint, eyeGlowPaint);
        canvas.restore();
      }
    }
  }

  void _drawNormalEye(
    Canvas canvas,
    Offset center,
    double radius,
    Paint white,
    Paint pupil,
    Paint glow,
  ) {
    canvas.drawCircle(center, radius, white);
    canvas.drawCircle(center, radius * 0.55, pupil);
    // Блик
    canvas.drawCircle(
      Offset(center.dx + radius * 0.25, center.dy - radius * 0.25),
      radius * 0.2,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill,
    );
    // Цветное кольцо
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = glow.color.withValues(alpha: 0.3)
        ..strokeWidth = 1.5
        ..style = PaintingStyle.stroke,
    );
  }

  void _drawMouth(Canvas canvas, double w, double h, double cx) {
    final mouthPaint = Paint()
      ..strokeWidth = w * 0.045
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final mouthY = h * 0.62;
    final mouthW = w * 0.22;

    switch (mood) {
      case NeuronchikMood.happy:
      case NeuronchikMood.excited:
      case NeuronchikMood.cheering:
      case NeuronchikMood.love:
        // Большая улыбка
        mouthPaint.color = const Color(0xFF4CFFDB);
        final path = Path();
        path.moveTo(cx - mouthW, mouthY);
        path.quadraticBezierTo(cx, mouthY + h * 0.1, cx + mouthW, mouthY);
        canvas.drawPath(path, mouthPaint);
        // Зубы/блеск
        if (mood == NeuronchikMood.excited || mood == NeuronchikMood.cheering) {
          canvas.drawCircle(
              Offset(cx, mouthY + h * 0.04),
              w * 0.04,
              Paint()
                ..color = Colors.white.withValues(alpha: 0.6)
                ..style = PaintingStyle.fill);
        }
        break;

      case NeuronchikMood.sad:
        // Грустная мордочка
        mouthPaint.color = Colors.white.withValues(alpha: 0.5);
        final sadPath = Path();
        sadPath.moveTo(cx - mouthW, mouthY + h * 0.04);
        sadPath.quadraticBezierTo(cx, mouthY, cx + mouthW, mouthY + h * 0.04);
        canvas.drawPath(sadPath, mouthPaint);
        break;

      case NeuronchikMood.sleeping:
        // Ровная линия рта
        mouthPaint.color = Colors.white.withValues(alpha: 0.4);
        canvas.drawLine(
          Offset(cx - mouthW * 0.6, mouthY),
          Offset(cx + mouthW * 0.6, mouthY),
          mouthPaint,
        );
        // ZZZ
        final zzPaint = Paint()
          ..color = Colors.white.withValues(alpha: 0.6)
          ..style = PaintingStyle.fill;
        final textPainter = TextPainter(
          text: TextSpan(
            text: 'z',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: w * 0.12,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: TextDirection.ltr,
        )..layout();
        textPainter.paint(canvas, Offset(cx + w * 0.15, h * 0.25));
        break;

      case NeuronchikMood.thinking:
        // Точка-мысль
        mouthPaint.color = Colors.white.withValues(alpha: 0.5);
        canvas.drawLine(
          Offset(cx - mouthW * 0.3, mouthY),
          Offset(cx + mouthW * 0.3, mouthY),
          mouthPaint,
        );
        break;
    }
  }

  void _drawSparkles(Canvas canvas, double w, double h) {
    final sparklePaint = Paint()
      ..color = const Color(0xFFFFD700)
      ..style = PaintingStyle.fill;

    final positions = [
      Offset(w * 0.05, h * 0.15),
      Offset(w * 0.92, h * 0.2),
      Offset(w * 0.12, h * 0.8),
      Offset(w * 0.88, h * 0.78),
    ];

    for (final pos in positions) {
      _drawStar(canvas, pos, w * 0.04, sparklePaint);
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 5; i++) {
      final angle = (i * 2 * pi / 5) - pi / 2;
      final outerX = center.dx + radius * cos(angle);
      final outerY = center.dy + radius * sin(angle);
      final innerAngle = angle + pi / 5;
      final innerX = center.dx + (radius * 0.4) * cos(innerAngle);
      final innerY = center.dy + (radius * 0.4) * sin(innerAngle);
      if (i == 0) {
        path.moveTo(outerX, outerY);
      } else {
        path.lineTo(outerX, outerY);
      }
      path.lineTo(innerX, innerY);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_NeuronchikPainter old) =>
      old.mood != mood ||
      old.blinkScale != blinkScale ||
      old.waveProgress != waveProgress;
}

// ── Обёртка для экрана с Нейрончиком ─────────────────────────────
class WithNeuronchik extends StatelessWidget {
  final Widget child;
  final NeuronchikMood mood;
  final String? message;
  final bool show;
  final bool isKidsMode;
  final double size;

  const WithNeuronchik({
    super.key,
    required this.child,
    this.mood = NeuronchikMood.happy,
    this.message,
    this.show = true,
    this.isKidsMode = true,
    this.size = 72,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return child;
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 100,
          right: 16,
          child: NeuronchikWidget(
            mood: mood,
            message: message,
            size: size,
            isKidsMode: isKidsMode,
          ),
        ),
      ],
    );
  }
}

// ── Большой Нейрончик для kids экранов (центрированный) ──────────
class NeuronchikBig extends StatelessWidget {
  final NeuronchikMood mood;
  final String? message;
  final double size;

  const NeuronchikBig({
    super.key,
    this.mood = NeuronchikMood.happy,
    this.message,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    return NeuronchikWidget(
      mood: mood,
      message: message,
      size: size,
      isKidsMode: true,
    );
  }
}
