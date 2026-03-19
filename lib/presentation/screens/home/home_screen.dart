import 'package:flutter/material.dart';
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

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 2; // Стартуем на "Путь"
  int _pendingTasks = 3; // Невыполненные задания (из Supabase)

  late final List<Widget> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      DailyTab(name: widget.name, isKids: widget.age <= 12),
      LeaderboardTab(name: widget.name),
      PathTab(name: widget.name, isKids: widget.age <= 12),
      FeedTab(),
      ProfileTab(name: widget.name, age: widget.age),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        pendingTasks: _pendingTasks,
        onTap: (i) {
          setState(() {
            _currentIndex = i;
            if (i == 0) _pendingTasks = 0; // сбрасываем badge при открытии
          });
        },
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
