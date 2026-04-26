import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/utils/level_system.dart';
import '../../widgets/neuronchik.dart';
import 'tabs/daily_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/path_tab.dart';
import 'tabs/feed_tab.dart';
import 'tabs/profile_tab.dart';

class HomeScreen extends StatefulWidget {
  final String name;
  final int age;
  const HomeScreen({super.key, required this.name, required this.age});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 2;
  int _pendingTasks = 3;
  bool _showLevelUp = false;
  int _newLevel = 1;

  // Neuronchik greeting (kids only)
  bool _showGreeting = false;
  bool _greetingToCorner = false;

  late AnimationController _levelUpCtrl;
  late Animation<double> _levelUpScale;
  late Animation<double> _levelUpFade;

  late final List<Widget> _tabs;

  static const _greetings = [
    'Привет! Я рад тебя видеть! 🎉',
    'О, ты вернулся! Учимся? 🚀',
    'Ура! Снова вместе! ⭐',
    'Привет-привет! Погнали учить! 🧠',
  ];

  @override
  void initState() {
    super.initState();
    _tabs = [
      DailyTab(name: widget.name, isKids: widget.age <= 12),
      LeaderboardTab(name: widget.name),
      PathTab(name: widget.name, isKids: widget.age <= 12, age: widget.age),
      FeedTab(),
      ProfileTab(name: widget.name, age: widget.age),
    ];

    _levelUpCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _levelUpScale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _levelUpCtrl, curve: Curves.elasticOut));
    _levelUpFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _levelUpCtrl, curve: Curves.easeIn));

    _checkLevelUp();
    if (widget.age <= 12) _checkNeuronchikGreeting();
  }

  Future<void> _checkNeuronchikGreeting() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final last = prefs.getString('neuronchik_greeting_date') ?? '';
    if (last != today) {
      await prefs.setString('neuronchik_greeting_date', today);
      if (!mounted) return;
      setState(() => _showGreeting = true);
      // через 2.5с начинаем двигать в угол
      Future.delayed(const Duration(milliseconds: 2500), () {
        if (mounted) setState(() => _greetingToCorner = true);
      });
      // через 3.8с убираем оверлей — обычный угловой Нейрончик берёт управление
      Future.delayed(const Duration(milliseconds: 3800), () {
        if (mounted) setState(() => _showGreeting = false);
      });
    }
  }

  void _dismissGreeting() {
    if (!_showGreeting) return;
    setState(() => _greetingToCorner = true);
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => _showGreeting = false);
    });
  }

  @override
  void dispose() {
    _levelUpCtrl.dispose();
    super.dispose();
  }

  Future<void> _checkLevelUp() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) return;
    try {
      final data = await Supabase.instance.client
          .from('users')
          .select('xp')
          .eq('id', uid)
          .maybeSingle();
      if (!mounted || data == null) return;
      final xp = (data['xp'] ?? 0) as int;
      final level = LevelSystem.levelFromXp(xp);
      final prefs = await SharedPreferences.getInstance();
      final lastLevel = prefs.getInt('last_known_level_$uid') ?? 1;
      if (level > lastLevel) {
        await prefs.setInt('last_known_level_$uid', level);
        if (!mounted) return;
        setState(() { _showLevelUp = true; _newLevel = level; });
        _levelUpCtrl.forward();
        Future.delayed(const Duration(seconds: 4), () {
          if (mounted) {
            _levelUpCtrl.reverse().then((_) {
              if (mounted) setState(() => _showLevelUp = false);
            });
          }
        });
      } else {
        await prefs.setInt('last_known_level_$uid', level);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: _tabs,
          ),
          // Нейрончик в углу (скрыт пока показывается приветствие)
          if (!_showGreeting)
            Positioned(
              bottom: 90,
              right: 16,
              child: NeuronchikWidget(
                mood: _currentIndex == 0
                    ? NeuronchikMood.cheering
                    : NeuronchikMood.happy,
              ),
            ),

          // Greeting анимация (только для детей, раз в день)
          if (_showGreeting)
            Positioned.fill(
              child: GestureDetector(
                onTap: _dismissGreeting,
                behavior: HitTestBehavior.translucent,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  color: _greetingToCorner
                      ? Colors.transparent
                      : Colors.black.withValues(alpha: 0.45),
                  child: Stack(
                    children: [
                      // Greeting bubble (исчезает при движении в угол)
                      if (!_greetingToCorner)
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.1),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  _greetings[DateTime.now().day % _greetings.length],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F1F1E),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              NeuronchikWidget(
                                mood: NeuronchikMood.excited,
                                size: 180,
                                isKidsMode: true,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Нажми, чтобы продолжить',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Нейрончик движется в угол
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.easeInOut,
                        bottom: _greetingToCorner ? 90 : null,
                        right: _greetingToCorner ? 16 : null,
                        top: _greetingToCorner ? null : 0,
                        left: _greetingToCorner ? null : 0,
                        child: _greetingToCorner
                            ? NeuronchikWidget(
                                mood: NeuronchikMood.happy,
                                size: 64,
                                isKidsMode: true,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (_showLevelUp)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _levelUpCtrl.reverse().then((_) {
                    if (mounted) setState(() => _showLevelUp = false);
                  });
                },
                child: Container(
                  color: Colors.black.withValues(alpha: 0.6),
                  child: Center(
                    child: FadeTransition(
                      opacity: _levelUpFade,
                      child: ScaleTransition(
                        scale: _levelUpScale,
                        child: _LevelUpCard(level: _newLevel),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        pendingTasks: _pendingTasks,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
            if (i == 0) _pendingTasks = 0;
          });
        },
      ),
    );
  }
}

// ─── Карточка повышения уровня ─────────────────────────────────
class _LevelUpCard extends StatelessWidget {
  final int level;
  const _LevelUpCard({required this.level});

  @override
  Widget build(BuildContext context) {
    final emoji = LevelSystem.emojiForLevel(level);
    final title = LevelSystem.titleForLevel(level);
    return Container(
      width: 280,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1F1E),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.6), width: 2),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.3),
            blurRadius: 40,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 56)),
          const SizedBox(height: 12),
          const Text('НОВЫЙ ЭТАЖ!',
              style: TextStyle(
                  color: Color(0xFF0ABDB9),
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2)),
          const SizedBox(height: 8),
          Text('Этаж $level',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1)),
          Text(title,
              style: const TextStyle(
                  color: Color(0xFF8EAEAC),
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF0ABDB9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text('🎉 Продолжай учиться!',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final int pendingTasks;
  final ValueChanged<int> onTap;
  const _BottomNav({
    required this.currentIndex,
    required this.pendingTasks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE8F7F7), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                index: 0,
                current: currentIndex,
                icon: Icons.task_alt_rounded,
                label: 'Задания',
                badge: pendingTasks,
                onTap: onTap,
              ),
              _NavItem(
                index: 1,
                current: currentIndex,
                icon: Icons.emoji_events_rounded,
                label: 'Рейтинг',
                onTap: onTap,
              ),
              // Центральная кнопка — большая
              _CenterNavItem(
                isActive: currentIndex == 2,
                onTap: () => onTap(2),
              ),
              _NavItem(
                index: 3,
                current: currentIndex,
                icon: Icons.feed_rounded,
                label: 'Лента',
                onTap: onTap,
              ),
              _NavItem(
                index: 4,
                current: currentIndex,
                icon: Icons.person_rounded,
                label: 'Профиль',
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index, current;
  final IconData icon;
  final String label;
  final int badge;
  final ValueChanged<int> onTap;

  const _NavItem({
    required this.index,
    required this.current,
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge = 0,
  });

  bool get isActive => index == current;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? const Color(0xFF0ABDB9).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: isActive
                      ? const Color(0xFF0ABDB9)
                      : const Color(0xFF8EAEAC),
                ),
                if (badge > 0)
                  Positioned(
                    top: -4,
                    right: -6,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          badge > 9 ? '9+' : '$badge',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive
                    ? const Color(0xFF0ABDB9)
                    : const Color(0xFF8EAEAC),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CenterNavItem extends StatelessWidget {
  final bool isActive;
  final VoidCallback onTap;
  const _CenterNavItem({required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color:
                  isActive ? const Color(0xFF078987) : const Color(0xFF0ABDB9),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0ABDB9).withValues(alpha: 0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.auto_stories_rounded,
              color: Colors.white,
              size: 26,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Путь',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color:
                  isActive ? const Color(0xFF0ABDB9) : const Color(0xFF8EAEAC),
            ),
          ),
        ],
      ),
    );
  }
}
