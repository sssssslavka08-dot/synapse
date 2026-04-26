import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../language_select_screen.dart';

// ═══════════════════════════════════════════════════════════
//  WelcomeScreen
//  Показывается один раз после первого входа в аккаунт.
//  Анимирует логотип и приветствие, затем ведёт на выбор языка.
// ═══════════════════════════════════════════════════════════
class WelcomeScreen extends StatefulWidget {
  final String name;
  final int age;

  const WelcomeScreen({super.key, required this.name, required this.age});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoCtrl;
  late AnimationController _textCtrl;
  late AnimationController _btnCtrl;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<Offset> _textSlide;
  late Animation<double> _btnFade;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _btnCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoCtrl, curve: const Interval(0, 0.5)),
    );
    _textFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut),
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textCtrl, curve: Curves.easeOut));
    _btnFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _btnCtrl, curve: Curves.easeOut),
    );

    // Cascade animations
    _logoCtrl.forward().then((_) async {
      await Future.delayed(const Duration(milliseconds: 200));
      _textCtrl.forward().then((_) async {
        await Future.delayed(const Duration(milliseconds: 300));
        _btnCtrl.forward();
      });
    });
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _textCtrl.dispose();
    _btnCtrl.dispose();
    super.dispose();
  }

  Future<void> _onStart() async {
    // Помечаем first_login = true
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid != null) {
        await Supabase.instance.client
            .from('users')
            .update({'first_login': true}).eq('id', uid);
      }
    } catch (_) {}

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => LanguageSelectScreen(
          name: widget.name,
          age: widget.age,
        ),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1F1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // ── Logo ────────────────────────────────────
              FadeTransition(
                opacity: _logoFade,
                child: ScaleTransition(
                  scale: _logoScale,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0ABDB9),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0ABDB9).withValues(alpha: 0.4),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 64,
                      height: 64,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ── Text ────────────────────────────────────
              FadeTransition(
                opacity: _textFade,
                child: SlideTransition(
                  position: _textSlide,
                  child: Column(
                    children: [
                      const Text(
                        'SYNAPSE',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(height: 16),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.35,
                          ),
                          children: [
                            const TextSpan(text: 'Добро пожаловать,\n'),
                            TextSpan(
                              text: widget.name,
                              style: const TextStyle(
                                color: Color(0xFF0ABDB9),
                              ),
                            ),
                            const TextSpan(text: '! 👋'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Text(
                        'Готов учить языки по науке?\nAI подберёт программу именно под тебя.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF8EAEAC),
                          height: 1.55,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // ── Features preview ────────────────────────
              FadeTransition(
                opacity: _btnFade,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _FeatureChip(emoji: '🧠', label: 'Алгоритм SM-2'),
                        const SizedBox(width: 10),
                        _FeatureChip(emoji: '🏆', label: 'Рейтинг'),
                        const SizedBox(width: 10),
                        _FeatureChip(emoji: '🔊', label: 'Произношение'),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // ── CTA Button ──────────────────────────
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: _onStart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0ABDB9),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: const Text(
                          'Начать обучение →',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Feature chip ─────────────────────────────────────────
class _FeatureChip extends StatelessWidget {
  final String emoji, label;
  const _FeatureChip({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3332),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: const Color(0xFF2A4A48)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 13)),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF8EAEAC),
            ),
          ),
        ],
      ),
    );
  }
}
