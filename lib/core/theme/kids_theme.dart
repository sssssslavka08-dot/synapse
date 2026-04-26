import 'package:flutter/material.dart';

// Цвета детского режима
class KidsColors {
  static const Color primary = Color(0xFFFF6B35);      // Оранжевый
  static const Color secondary = Color(0xFF4ECDC4);    // Мята
  static const Color accent = Color(0xFFFFE66D);       // Жёлтый
  static const Color purple = Color(0xFFA855F7);       // Фиолетовый
  static const Color pink = Color(0xFFFF6B9D);         // Розовый
  static const Color green = Color(0xFF6BCB77);        // Зелёный
  static const Color bg = Color(0xFFFFF9F0);           // Тёплый белый
  static const Color card = Colors.white;
  static const Color text = Color(0xFF1A1A2E);
  static const Color muted = Color(0xFF8EAEAC);

  static const List<Color> levelColors = [
    Color(0xFFFF6B35),
    Color(0xFF4ECDC4),
    Color(0xFFFFE66D),
    Color(0xFFA855F7),
    Color(0xFFFF6B9D),
    Color(0xFF6BCB77),
  ];

  static Color forIndex(int i) => levelColors[i % levelColors.length];
}

// Стили текста для детей
class KidsTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w900,
    color: KidsColors.text,
    letterSpacing: -0.5,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: KidsColors.muted,
  );

  static const TextStyle body = TextStyle(
    fontSize: 16,
    height: 1.5,
    color: KidsColors.text,
  );

  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );

  static const TextStyle badge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    color: Colors.white,
  );
}

// Виджеты для детского интерфейса
class KidsButton extends StatelessWidget {
  final String label;
  final String? emoji;
  final Color color;
  final VoidCallback onTap;
  final double? width;

  const KidsButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
    this.emoji,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (emoji != null) ...[
              Text(emoji!, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
            ],
            Text(label, style: KidsTextStyles.button),
          ],
        ),
      ),
    );
  }
}

// Карточка с анимацией для детей
class KidsCard extends StatefulWidget {
  final Widget child;
  final Color? borderColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double borderRadius;

  const KidsCard({
    super.key,
    required this.child,
    this.borderColor,
    this.backgroundColor,
    this.onTap,
    this.borderRadius = 20,
  });

  @override
  State<KidsCard> createState() => _KidsCardState();
}

class _KidsCardState extends State<KidsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? (_) => _ctrl.forward() : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _ctrl.reverse();
              widget.onTap!();
            }
          : null,
      onTapCancel: widget.onTap != null ? () => _ctrl.reverse() : null,
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? KidsColors.card,
            borderRadius:
                BorderRadius.circular(widget.borderRadius),
            border: widget.borderColor != null
                ? Border.all(
                    color: widget.borderColor!.withValues(alpha: 0.4),
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: (widget.borderColor ?? KidsColors.primary)
                    .withValues(alpha: 0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}

// Монетный счётчик для детей
class KidsCoinDisplay extends StatelessWidget {
  final int coins;
  final bool large;

  const KidsCoinDisplay({
    super.key,
    required this.coins,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 18 : 12,
        vertical: large ? 10 : 6,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
        ),
        borderRadius: BorderRadius.circular(large ? 20 : 14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFFD700).withValues(alpha: 0.4),
            blurRadius: large ? 12 : 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('🪙',
              style: TextStyle(fontSize: large ? 22 : 16)),
          const SizedBox(width: 6),
          Text(
            coins.toString(),
            style: TextStyle(
              fontSize: large ? 20 : 15,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// XP бейдж для детей
class KidsXpBadge extends StatelessWidget {
  final int xp;

  const KidsXpBadge({super.key, required this.xp});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4ECDC4), Color(0xFF0ABDB9)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('⚡', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            '$xp XP',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Стрик для детей
class KidsStreakBadge extends StatelessWidget {
  final int streak;

  const KidsStreakBadge({super.key, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF4500)],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withValues(alpha: 0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 4),
          Text(
            '$streak дней',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Декоративные звёздочки для фона (kids mode)
class KidsStarsBg extends StatelessWidget {
  final Widget child;

  const KidsStarsBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 20,
          right: 30,
          child: Text('⭐', style: TextStyle(fontSize: 20, color: Colors.amber.withValues(alpha: 0.4))),
        ),
        Positioned(
          top: 80,
          left: 20,
          child: Text('✨', style: TextStyle(fontSize: 16, color: Colors.blue.withValues(alpha: 0.3))),
        ),
        Positioned(
          top: 150,
          right: 50,
          child: Text('💫', style: TextStyle(fontSize: 14, color: Colors.purple.withValues(alpha: 0.3))),
        ),
        child,
      ],
    );
  }
}
