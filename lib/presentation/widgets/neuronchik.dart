import 'dart:math';
import 'package:flutter/material.dart';

class NeuronchikWidget extends StatefulWidget {
  final String? message;
  final NeuronchikMood mood;

  const NeuronchikWidget({
    super.key,
    this.message,
    this.mood = NeuronchikMood.happy,
  });

  @override
  State<NeuronchikWidget> createState() => _NeuronchikWidgetState();
}

enum NeuronchikMood { happy, excited, thinking, sleeping, cheering }

class _NeuronchikWidgetState extends State<NeuronchikWidget>
    with TickerProviderStateMixin {
  late AnimationController _floatCtrl;
  late AnimationController _bounceCtrl;
  late Animation<double> _floatAnim;
  late Animation<double> _bounceAnim;

  bool _showBubble = false;
  bool _minimized = false;
  String _currentMessage = '';

  static const _messages = {
    NeuronchikMood.happy: [
      'Ты молодец! Продолжай! 💪',
      'Каждый урок делает тебя умнее! 🧠',
      'Отличный прогресс! ⚡',
    ],
    NeuronchikMood.excited: [
      'ВАУ! Ты просто супер! 🌟',
      'Невероятно! Так держать! 🏆',
      'Ты на верном пути! 🚀',
    ],
    NeuronchikMood.thinking: [
      'Думай внимательно... 🤔',
      'Вспомни — ты это знаешь! 💡',
      'Не торопись, подумай! ⏳',
    ],
    NeuronchikMood.sleeping: [
      'Zzz... Разбуди меня уроком! 😴',
      'Соскучился по занятиям! 💤',
    ],
    NeuronchikMood.cheering: [
      'УРА! Задание выполнено! 🎉',
      'Получил монеты! 🪙',
      'Новое достижение! 🏅',
    ],
  };

  String get _moodEmoji {
    switch (widget.mood) {
      case NeuronchikMood.happy:     return '🤖';
      case NeuronchikMood.excited:   return '🤩';
      case NeuronchikMood.thinking:  return '🧐';
      case NeuronchikMood.sleeping:  return '😴';
      case NeuronchikMood.cheering:  return '🥳';
    }
  }

  @override
  void initState() {
    super.initState();

    _floatCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _bounceCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _floatAnim = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut),
    );

    _bounceAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _bounceCtrl, curve: Curves.elasticOut),
    );

    // Показываем приветствие через 1 секунду
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) _showMessage();
    });
  }

  void _showMessage() {
    final msgs = _messages[widget.mood] ?? _messages[NeuronchikMood.happy]!;
    final msg = widget.message ?? msgs[Random().nextInt(msgs.length)];
    setState(() { _currentMessage = msg; _showBubble = true; });
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
    _showMessage();
  }

  @override
  void dispose() {
    _floatCtrl.dispose();
    _bounceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_floatAnim, _bounceAnim]),
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
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                constraints: const BoxConstraints(maxWidth: 180),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14),
                    bottomLeft: Radius.circular(14),
                    bottomRight: Radius.circular(4),
                  ),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2))],
                  border: Border.all(color: const Color(0xFFD6F5F4)),
                ),
                child: Text(
                  _currentMessage,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF0F1F1E), height: 1.4),
                ),
              ),
            ),

            // Нейрончик
            GestureDetector(
              onTap: _onTap,
              onLongPress: () => setState(() => _minimized = !_minimized),
              child: Transform.scale(
                scale: _bounceAnim.value,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _minimized ? 36 : 52,
                  height: _minimized ? 36 : 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0ABDB9),
                    borderRadius: BorderRadius.circular(_minimized ? 18 : 16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0ABDB9).withValues(alpha: 0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _minimized ? '🤖' : _moodEmoji,
                      style: TextStyle(fontSize: _minimized ? 18 : 28),
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

// ── Обёртка для экрана с Нейрончиком ─────────────────────────
class WithNeuronchik extends StatelessWidget {
  final Widget child;
  final NeuronchikMood mood;
  final String? message;
  final bool show;

  const WithNeuronchik({
    super.key,
    required this.child,
    this.mood = NeuronchikMood.happy,
    this.message,
    this.show = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!show) return child;
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 90,
          right: 16,
          child: NeuronchikWidget(mood: mood, message: message),
        ),
      ],
    );
  }
}
