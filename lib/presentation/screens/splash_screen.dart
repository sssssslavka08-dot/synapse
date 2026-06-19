import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/auth/auth_router.dart';
import '../../core/auth/oauth_recovery.dart';
import '../../core/auth/session_guard.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/splash_assets.dart';
import 'auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const _maxTotal = Duration(seconds: 8);
  static const _animDuration = Duration(milliseconds: 2800);

  late final String _robotAsset;
  late AnimationController _ctrl;
  late Animation<double> _robotOpacity;
  late Animation<double> _robotScale;
  late Animation<double> _titleOpacity;

  bool _navigating = false;

  @override
  void initState() {
    super.initState();
    _robotAsset = SplashAssets.randomPath();

    _ctrl = AnimationController(vsync: this, duration: _animDuration);

    _robotOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 12),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 38),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 18,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(0), weight: 32),
    ]).animate(_ctrl);

    _robotScale = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.55, end: 1)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 12,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(1), weight: 38),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0)
            .chain(CurveTween(curve: Curves.easeInCubic)),
        weight: 18,
      ),
      TweenSequenceItem(tween: ConstantTween<double>(0), weight: 32),
    ]).animate(_ctrl);

    _titleOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _ctrl,
        curve: const Interval(0.68, 1, curve: Curves.easeOut),
      ),
    );

    unawaited(_runSplash());
  }

  Future<void> _runSplash() async {
    final started = DateTime.now();
    final authFuture = _resolveDestination();
    unawaited(_ctrl.forward());

    Widget destination;
    try {
      destination = await authFuture.timeout(
        _maxTotal,
        onTimeout: () => const LoginScreen(),
      );
    } catch (_) {
      destination = const LoginScreen();
    }

    if (!mounted) return;

    final elapsed = DateTime.now().difference(started);
    final timeLeft = _maxTotal - elapsed;

    if (!_ctrl.isCompleted && timeLeft > Duration.zero) {
      try {
        await _ctrl.forward(from: _ctrl.value).timeout(timeLeft);
      } catch (_) {
        _ctrl.value = 1;
      }
    } else if (!_ctrl.isCompleted) {
      _ctrl.value = 1;
    }

    final afterAnim = DateTime.now().difference(started);
    final pauseLeft = _maxTotal - afterAnim;
    if (pauseLeft > Duration.zero) {
      final pause = pauseLeft > const Duration(milliseconds: 350)
          ? const Duration(milliseconds: 350)
          : pauseLeft;
      await Future.delayed(pause);
    }

    if (!mounted) return;
    _navigate(destination);
  }

  Future<Widget> _resolveDestination() async {
    try {
      final session = await OAuthRecovery.waitForSession()
          .timeout(const Duration(seconds: 5));
      final user = session?.user ?? Supabase.instance.client.auth.currentUser;

      if (user != null && session != null && !session.isExpired) {
        if (!await SessionGuard.validateSession()
            .timeout(const Duration(seconds: 3))) {
          return const LoginScreen();
        }
        final profile = await AuthRouter.loadOrCreateProfile(user)
            .timeout(const Duration(seconds: 4));
        return AuthRouter.destinationForUser(user: user, profile: profile);
      }
    } catch (_) {}

    return const LoginScreen();
  }

  void _navigate(Widget destination) {
    if (_navigating) return;
    _navigating = true;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Center(
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final showRobot = _robotOpacity.value > 0.01;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 280,
                  child: Center(
                    child: showRobot
                        ? Opacity(
                            opacity: _robotOpacity.value,
                            child: Transform.scale(
                              scale: _robotScale.value,
                              child: Image.asset(
                                _robotAsset,
                                width: 260,
                                height: 260,
                                fit: BoxFit.contain,
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ),
                Opacity(
                  opacity: _titleOpacity.value,
                  child: const Text(
                    'SYNAPSE',
                    style: TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -1.5,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
