import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/constants/app_colors.dart';

/// Центрированная карточка входа/регистрации для Flutter Web + декор.
class AuthWebShell extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const AuthWebShell({
    super.key,
    required this.child,
    this.maxWidth = 440,
  });

  /// 4 уникальных робота (main и tablet — один файл, используем только main).
  /// (asset, x, y, size, delayMs)
  static const _robots = [
    ('assets/images/splash/robot-happy.png', 0.04, 0.07, 118.0, 0),
    ('assets/images/splash/robot-thumbsup.png', 0.82, 0.05, 112.0, 180),
    ('assets/images/splash/robot-main.png', 0.03, 0.74, 108.0, 320),
    ('assets/images/splash/robot-serious.png', 0.83, 0.73, 112.0, 480),
  ];

  static const _emojis = [
    ('🧠', 0.20, 0.14, 0),
    ('✨', 0.68, 0.12, 120),
    ('🎯', 0.24, 0.48, 240),
    ('🚀', 0.72, 0.50, 360),
    ('💡', 0.14, 0.32, 80),
    ('🌟', 0.86, 0.28, 200),
    ('📚', 0.18, 0.62, 300),
    ('🔥', 0.78, 0.62, 420),
    ('💎', 0.50, 0.88, 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF0A1A19),
              Color(0xFF0D2423),
              Color(0xFF0A1F1E),
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 720;
              return Stack(
                fit: StackFit.expand,
                children: [
                  if (wide) ..._buildRobots(constraints),
                  if (wide) ..._buildEmojis(constraints),
                  Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(32, 28, 32, 32),
                          decoration: BoxDecoration(
                            color: AppColors.darkBg.withValues(alpha: 0.92),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(
                              color: AppColors.tiffany.withValues(alpha: 0.25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.tiffany.withValues(alpha: 0.08),
                                blurRadius: 48,
                                spreadRadius: 4,
                              ),
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 32,
                                offset: const Offset(0, 16),
                              ),
                            ],
                          ),
                          child: child,
                        ),
                      )
                          .animate()
                          .fadeIn(duration: 450.ms, curve: Curves.easeOut)
                          .slideY(
                            begin: 0.06,
                            end: 0,
                            duration: 500.ms,
                            curve: Curves.easeOutCubic,
                          ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildRobots(BoxConstraints constraints) {
    return _robots.map((r) {
      final (asset, fx, fy, size, delay) = r;
      return Positioned(
        left: fx * constraints.maxWidth,
        top: fy * constraints.maxHeight,
        child: Opacity(
          opacity: 0.9,
          child: Image.asset(
            asset,
            width: size,
            height: size,
            fit: BoxFit.contain,
          )
              .animate(
                onPlay: (c) => c.repeat(reverse: true),
                delay: delay.ms,
              )
              .moveY(
                begin: -8,
                end: 8,
                duration: (2200 + delay % 800).ms,
                curve: Curves.easeInOut,
              )
              .rotate(
                begin: -0.03,
                end: 0.03,
                duration: (2800 + delay % 600).ms,
                curve: Curves.easeInOut,
              ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildEmojis(BoxConstraints constraints) {
    return _emojis.map((e) {
      final (emoji, fx, fy, delay) = e;
      return Positioned(
        left: fx * constraints.maxWidth,
        top: fy * constraints.maxHeight,
        child: Text(emoji, style: const TextStyle(fontSize: 28))
            .animate(
              onPlay: (c) => c.repeat(reverse: true),
              delay: delay.ms,
            )
            .fadeIn(duration: 500.ms)
            .scale(
              begin: const Offset(0.88, 0.88),
              end: const Offset(1.12, 1.12),
              duration: (1600 + delay % 500).ms,
              curve: Curves.easeInOut,
            )
            .moveY(
              begin: 0,
              end: -14,
              duration: (2000 + delay % 700).ms,
              curve: Curves.easeInOut,
            ),
      );
    }).toList();
  }
}
