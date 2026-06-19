import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/level_system.dart';
import '../../../services/supabase_service.dart';
import '../../../services/user_store.dart';
import '../../../services/words_service.dart';
import '../../../services/notification_service.dart';
import 'tabs/daily_tab.dart';
import 'tabs/leaderboard_tab.dart';
import 'tabs/path_tab.dart';
import '../shop/shop_screen.dart';
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
  int _currentIndex = 0;
  bool _showLevelUp = false;
  int _newLevel = 1;
  bool _showRobotGreeting = false;

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

  static const _navItems = <_NavData>[
    _NavData(Icons.auto_stories_rounded, 'Обучение'),
    _NavData(Icons.emoji_events_rounded, 'Рейтинг'),
    _NavData(Icons.task_alt_rounded, 'Задания'),
    _NavData(Icons.storefront_rounded, 'Магазин'),
    _NavData(Icons.person_rounded, 'Профиль'),
  ];

  @override
  void initState() {
    super.initState();
    _tabs = [
      PathTab(name: widget.name, isKids: widget.age <= 12, age: widget.age),
      LeaderboardTab(name: widget.name),
      DailyTab(name: widget.name, isKids: widget.age <= 12),
      const ShopScreen(),
      ProfileTab(name: widget.name, age: widget.age),
    ];

    _levelUpCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _levelUpScale = Tween<double>(begin: 0.5, end: 1.0).animate(
        CurvedAnimation(parent: _levelUpCtrl, curve: Curves.elasticOut));
    _levelUpFade = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _levelUpCtrl, curve: Curves.easeIn));

    _checkLevelUp();
    _checkRobotGreeting();
    SupabaseService.instance.ensureWelcomeCoins();
    UserStore.instance.refresh();
    _warmWordsAndNotifications();
    NotificationService.instance.onNotificationTap = (_) {
      final tab = NotificationService.instance.consumePendingTab();
      if (tab != null && mounted) setState(() => _currentIndex = tab);
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final tab = NotificationService.instance.consumePendingTab();
      if (tab != null && mounted) setState(() => _currentIndex = tab);
    });
  }

  Future<void> _warmWordsAndNotifications() async {
    NotificationService.instance.recordActivity();
    await NotificationService.instance.refreshEngagementSchedule();
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      if (uid == null) return;
      final row = await Supabase.instance.client
          .from('users')
          .select('selected_language')
          .eq('id', uid)
          .maybeSingle();
      final lang = row?['selected_language'] as String? ?? 'en';
      if (lang.isNotEmpty) {
        await WordsService.instance.warmCacheForLanguage(lang);
      }
    } catch (_) {}
  }

  Future<void> _checkRobotGreeting() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().split('T').first;
    final last = prefs.getString('robot_greeting_date') ?? '';
    if (last != today) {
      await prefs.setString('robot_greeting_date', today);
      if (!mounted) return;
      setState(() => _showRobotGreeting = true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _showRobotGreeting = false);
      });
    }
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

  void _onNav(int i) {
    setState(() => _currentIndex = i);
    UserStore.instance.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isWide = w >= 768;
    final accent = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: Stack(
        children: [
          // ── Layout: sidebar (web) vs bottom-nav (mobile) ──
          if (isWide)
            Row(
              children: [
                _Sidebar(
                  currentIndex: _currentIndex,
                  items: _navItems,
                  accent: accent,
                  onTap: _onNav,
                ),
                Expanded(
                  child: IndexedStack(index: _currentIndex, children: _tabs),
                ),
              ],
            )
          else
            IndexedStack(index: _currentIndex, children: _tabs),

          // ── Robot greeting overlay ──
          if (_showRobotGreeting)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => _showRobotGreeting = false),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  color: Colors.black.withValues(alpha: 0.65),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.darkCard,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: AppColors.tiffany.withValues(alpha: 0.3)),
                          ),
                          child: Text(
                            _greetings[DateTime.now().day % _greetings.length],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          'assets/images/robot.png',
                          width: 180,
                          height: 180,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Нажми, чтобы продолжить',
                          style: TextStyle(
                            color: AppColors.textSecondary.withValues(alpha: 0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ── Level up overlay ──
          if (_showLevelUp)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  _levelUpCtrl.reverse().then((_) {
                    if (mounted) setState(() => _showLevelUp = false);
                  });
                },
                child: Container(
                  color: Colors.black.withValues(alpha: 0.7),
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
      bottomNavigationBar: isWide
          ? null
          : _MobileBottomNav(
              currentIndex: _currentIndex,
              items: _navItems,
              accent: accent,
              onTap: _onNav,
            ),
    );
  }
}

// ─── Nav data ─────────────────────────────────────────────────────
class _NavData {
  final IconData icon;
  final String label;
  const _NavData(this.icon, this.label);
}

// ─── SIDEBAR (web / wide) ─────────────────────────────────────────
class _Sidebar extends StatelessWidget {
  final int currentIndex;
  final List<_NavData> items;
  final Color accent;
  final ValueChanged<int> onTap;
  const _Sidebar({
    required this.currentIndex,
    required this.items,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      decoration: const BoxDecoration(
        color: AppColors.darkNav,
        border: Border(right: BorderSide(color: AppColors.darkBorder, width: 1)),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // ── Logo ──
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 36,
                      height: 36,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'SYNAPSE',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            // ── Nav items ──
            ...List.generate(items.length, (i) {
              final item = items[i];
              final active = i == currentIndex;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                child: Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => onTap(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: active
                            ? accent.withValues(alpha: 0.12)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                        border: active
                            ? Border.all(color: accent.withValues(alpha: 0.25))
                            : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item.icon,
                            size: 22,
                            color: active ? accent : AppColors.textHint,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: active ? FontWeight.w800 : FontWeight.w600,
                              color: active ? AppColors.textPrimary : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            // ── Bottom logo ──
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'v1.0',
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── MOBILE BOTTOM NAV ───────────────────────────────────────────
class _MobileBottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavData> items;
  final Color accent;
  final ValueChanged<int> onTap;
  const _MobileBottomNav({
    required this.currentIndex,
    required this.items,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkNav,
        border: Border(top: BorderSide(color: AppColors.darkBorder, width: 1)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final item = items[i];
              final active = i == currentIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? accent.withValues(alpha: 0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item.icon,
                        size: 24,
                        color: active ? accent : AppColors.textHint,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                          color: active ? accent : AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
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
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
            color: AppColors.tiffany.withValues(alpha: 0.5), width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.tiffany.withValues(alpha: 0.25),
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
                  color: AppColors.tiffany,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2)),
          const SizedBox(height: 8),
          Text('Этаж $level',
              style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1)),
          Text(title,
              style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.tiffany,
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
