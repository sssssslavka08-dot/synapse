import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/level_system.dart';
import '../../../../core/theme/theme_notifier.dart';
import '../../auth/login_screen.dart';
import '../../subscription/subscription_screen.dart';
import '../../language_select_screen.dart';
import '../../friends/friends_screen.dart';

class ProfileTab extends StatefulWidget {
  final String name;
  final int age;
  const ProfileTab({super.key, required this.name, required this.age});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  Map<String, dynamic>? _userData;
  Map<String, int> _weekActivity = {}; // день → XP
  String _weakCategory = '—';
  int _totalDays = 0;
  bool _loadingStats = true;

  static const _langNames = {
    'en': '🇬🇧 Английский',
    'kz': '🇰🇿 Казахский',
    'ru': '🇷🇺 Русский',
    'de': '🇩🇪 Немецкий',
    'fr': '🇫🇷 Французский',
    'zh': '🇨🇳 Китайский',
    'es': '🇪🇸 Испанский',
    'ja': '🇯🇵 Японский',
    'tr': '🇹🇷 Турецкий',
    'it': '🇮🇹 Итальянский',
    'ko': '🇰🇷 Корейский',
    'ar': '🇸🇦 Арабский',
  };

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) {
      setState(() => _loadingStats = false);
      return;
    }

    try {
      // Данные профиля
      final user = await Supabase.instance.client
          .from('users')
          .select()
          .eq('id', uid)
          .maybeSingle();

      // Прогресс
      final progress = await Supabase.instance.client
          .from('progress')
          .select('wrong_count, correct_count, next_review, words(category)')
          .eq('user_id', uid);

      // Считаем слабую категорию
      final catErrors = <String, int>{};
      for (final row in (progress as List)) {
        final cat = (row['words'] as Map?)?['category'] as String? ?? 'other';
        final wrong = row['wrong_count'] as int? ?? 0;
        catErrors[cat] = (catErrors[cat] ?? 0) + wrong;
      }
      if (catErrors.isNotEmpty) {
        _weakCategory = catErrors.entries
            .reduce((a, b) => a.value > b.value ? a : b)
            .key;
      }

      // Активность по дням (заглушка на основе streak)
      final streak = user?['streak'] as int? ?? 0;
      final activity = <String, int>{};
      final days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
      final today = DateTime.now().weekday - 1;
      for (int i = 0; i < 7; i++) {
        final daysAgo = (today - i + 7) % 7;
        activity[days[daysAgo]] = i < streak
            ? 20 + (i * 15 % 80)
            : 0;
      }

      // Дней с регистрации
      if (user?['created_at'] != null) {
        final created = DateTime.tryParse(user!['created_at'] as String);
        if (created != null) {
          _totalDays = DateTime.now().difference(created).inDays + 1;
        }
      }

      setState(() {
        _userData = user;
        _weekActivity = activity;
        _loadingStats = false;
      });
    } catch (_) {
      setState(() => _loadingStats = false);
    }
  }

  void _showThemePicker(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => ListenableBuilder(
        listenable: appTheme,
        builder: (_, __) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Цветовая тема', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.4,
                ),
                itemCount: AppThemeNotifier.themes.length,
                itemBuilder: (_, i) {
                  final t = AppThemeNotifier.themes[i];
                  final selected = appTheme.current.name == t.name;
                  return GestureDetector(
                    onTap: () { appTheme.setTheme(i); Navigator.pop(ctx); },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: t.bg,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: selected ? t.primary : t.light,
                          width: selected ? 2.5 : 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 28, height: 28,
                            decoration: BoxDecoration(color: t.primary, shape: BoxShape.circle),
                            child: selected ? const Icon(Icons.check_rounded, color: Colors.white, size: 16) : null,
                          ),
                          const SizedBox(height: 6),
                          Text(t.name, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: t.primary)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditProfile(BuildContext ctx) {
    final nameCtrl = TextEditingController(text: widget.name);
    final ageCtrl = TextEditingController(text: widget.age.toString());
    bool saving = false;

    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetCtx) => StatefulBuilder(
        builder: (_, setS) => Padding(
          padding: EdgeInsets.fromLTRB(24, 20, 24, MediaQuery.of(sheetCtx).viewInsets.bottom + 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Редактировать профиль', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 20),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Имя',
                  prefixIcon: const Icon(Icons.person_outline),
                  filled: true, fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD6F5F4))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: appTheme.primary, width: 2)),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: ageCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Возраст',
                  prefixIcon: const Icon(Icons.cake_outlined),
                  filled: true, fillColor: Colors.white,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: const BorderSide(color: Color(0xFFD6F5F4))),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide(color: appTheme.primary, width: 2)),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity, height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: appTheme.primary, foregroundColor: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))),
                  onPressed: saving ? null : () async {
                    setS(() => saving = true);
                    final uid = Supabase.instance.client.auth.currentUser?.id;
                    if (uid != null) {
                      try {
                        await Supabase.instance.client.from('users').update({
                          'name': nameCtrl.text.trim(),
                          'age': int.tryParse(ageCtrl.text) ?? widget.age,
                        }).eq('id', uid);
                      } catch (_) {}
                    }
                    if (ctx.mounted) { Navigator.pop(sheetCtx); _loadStats(); }
                  },
                  child: saving
                      ? const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                      : const Text('Сохранить', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final name = widget.name;
    final xp = _userData?['xp'] as int? ?? 0;
    final coins = _userData?['coins'] as int? ?? 0;
    final streak = _userData?['streak'] as int? ?? 0;
    final plan = _userData?['subscription_type'] as String? ?? 'free';
    final level = LevelSystem.levelFromXp(xp);
    final levelTitle = LevelSystem.titleForLevel(level);
    final levelEmoji = LevelSystem.emojiForLevel(level);
    final levelProgress = LevelSystem.progressInLevel(xp);

    final badges = [
      {'emoji': '🔥', 'title': '7 дней подряд'},
      {'emoji': '📚', 'title': '50 слов'},
      {'emoji': '⚡', 'title': 'Первый урок'},
      {'emoji': '🌟', 'title': 'Топ-10'},
      {'emoji': '🎯', 'title': 'Меткий стрелок'},
      {'emoji': '🏆', 'title': 'Чемпион'},
    ];

    final stats = [
      {'label': 'Всего XP', 'value': '$xp', 'icon': '⚡'},
      {'label': 'Дней подряд', 'value': '$streak', 'icon': '🔥'},
      {'label': 'Дней учусь', 'value': '$_totalDays', 'icon': '📅'},
      {'label': 'Тариф', 'value': plan.toUpperCase(), 'icon': '👑'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadStats,
          color: const Color(0xFF0ABDB9),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                // ── Шапка профиля ──────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF0F1F1E), Color(0xFF1E3332)],
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 88,
                        height: 88,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0ABDB9),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                              color: const Color(0xFF3FCFCC), width: 3),
                        ),
                        child: Center(
                          child: Text(
                            name.isNotEmpty ? name[0].toUpperCase() : '?',
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              )),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => _showEditProfile(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.edit_rounded, color: Colors.white70, size: 16),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Значок уровня
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0ABDB9)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color(0xFF0ABDB9)
                                      .withValues(alpha: 0.4)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(levelEmoji,
                                    style: const TextStyle(fontSize: 14)),
                                const SizedBox(width: 6),
                                Text(
                                  'Этаж $level · $levelTitle',
                                  style: const TextStyle(
                                    color: Color(0xFF3FCFCC),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0ABDB9)
                                  .withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: const Color(0xFF0ABDB9)
                                      .withValues(alpha: 0.25)),
                            ),
                            child: Text(
                              plan == 'legenda'
                                  ? '👑 LEGENDA'
                                  : plan == 'pro'
                                      ? '⚡ PRO'
                                      : '🌱 FREE',
                              style: const TextStyle(
                                color: Color(0xFF8EAEAC),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // XP прогресс к следующему этажу
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('$xp XP',
                                    style: const TextStyle(
                                        color: Color(0xFF5A7A78),
                                        fontSize: 11)),
                                if (level < LevelSystem.maxLevel)
                                  Text(
                                    'до этажа ${level + 1}: ${LevelSystem.xpToNextLevel(xp)} XP',
                                    style: const TextStyle(
                                        color: Color(0xFF5A7A78),
                                        fontSize: 11))
                                else
                                  const Text('MAX',
                                      style: TextStyle(
                                          color: Color(0xFFFFD700),
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700)),
                              ],
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: LinearProgressIndicator(
                                value: levelProgress,
                                minHeight: 5,
                                backgroundColor: const Color(0xFF1A3332),
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF0ABDB9)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Статистика ──────────────────────
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.6,
                        children: stats
                            .map((s) => Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                        color: const Color(0xFFE0F3F2)),
                                  ),
                                  child: Row(children: [
                                    Text(s['icon']!,
                                        style: const TextStyle(
                                            fontSize: 24)),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(s['value']!,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF0ABDB9),
                                            )),
                                        Text(s['label']!,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF8EAEAC),
                                            )),
                                      ],
                                    ),
                                  ]),
                                ))
                            .toList(),
                      ),

                      const SizedBox(height: 24),

                      // ── AI-аналитика ─────────────────────
                      const Text('Моя статистика',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F1F1E),
                          )),
                      const SizedBox(height: 14),

                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFE0F3F2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // График активности
                            const Text('Активность за 7 дней',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF0F1F1E),
                                )),
                            const SizedBox(height: 14),
                            _loadingStats
                                ? const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xFF0ABDB9)),
                                    ),
                                  )
                                : _WeekChart(activity: _weekActivity),

                            const SizedBox(height: 18),
                            const Divider(color: Color(0xFFE0F3F2)),
                            const SizedBox(height: 14),

                            // Инсайты
                            _InsightRow(
                              icon: '🎯',
                              text: 'Слабая тема: ${_weakCategory == '—' ? 'нет данных' : _weakCategory}',
                            ),
                            const SizedBox(height: 10),
                            _InsightRow(
                              icon: '🔥',
                              text: 'Лучшая серия: $streak дней подряд',
                            ),
                            const SizedBox(height: 10),
                            _InsightRow(
                              icon: '📅',
                              text: 'Ты учишься $_totalDays ${_daysLabel(_totalDays)}',
                            ),
                            const SizedBox(height: 10),
                            _InsightRow(
                              icon: '⚡',
                              text: 'Всего заработано: $xp XP',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Достижения ──────────────────────
                      const Text('Достижения',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F1F1E),
                          )),
                      const SizedBox(height: 12),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.9,
                        children: badges
                            .map((b) => Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: const Color(0xFFE0F3F2)),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      Text(b['emoji']!,
                                          style: const TextStyle(
                                              fontSize: 28)),
                                      const SizedBox(height: 4),
                                      Text(b['title']!,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            color: Color(0xFF8EAEAC),
                                          )),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 24),

                      // ── Настройки ───────────────────────
                      const Text('Настройки',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F1F1E),
                          )),
                      const SizedBox(height: 12),

                      _SettingItem(
                        icon: Icons.language_rounded,
                        title: 'Язык обучения',
                        value: _langNames[_userData?['selected_language'] as String? ?? ''] ?? 'Не выбран',
                        onTap: () async {
                          // ignore: use_build_context_synchronously
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => LanguageSelectScreen(
                                name: widget.name,
                                age: widget.age,
                              ),
                            ),
                          );
                          _loadStats(); // обновить после смены языка
                        },
                      ),
                      _SettingItem(
                        icon: Icons.people_rounded,
                        title: 'Друзья',
                        value: 'Соревнуйся с друзьями',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FriendsScreen(),
                          ),
                        ),
                      ),
                      _SettingItem(
                        icon: Icons.notifications_outlined,
                        title: 'Уведомления',
                        value: 'Включены',
                        onTap: () {},
                      ),
                      _SettingItem(
                        icon: Icons.storefront_outlined,
                        title: 'Магазин',
                        value: '$coins 🪙',
                        onTap: () {},
                      ),
                      _SettingItem(
                        icon: Icons.palette_outlined,
                        title: 'Цветовая тема',
                        value: appTheme.current.name,
                        onTap: () => _showThemePicker(context),
                      ),
                      const SizedBox(height: 8),
                      _SettingItem(
                        icon: Icons.workspace_premium_rounded,
                        title: 'Подписка',
                        value: plan.toUpperCase(),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SubscriptionScreen(
                              name: widget.name,
                              age: widget.age,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Выход
                      GestureDetector(
                        onTap: () async {
                          await Supabase.instance.client.auth.signOut();
                          if (!mounted) return;
                          // ignore: use_build_context_synchronously
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEF4444)
                                .withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: const Color(0xFFEF4444)
                                    .withValues(alpha: 0.2)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout_rounded,
                                  color: Color(0xFFEF4444), size: 20),
                              SizedBox(width: 8),
                              Text('Выйти из аккаунта',
                                  style: TextStyle(
                                    color: Color(0xFFEF4444),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _daysLabel(int n) {
    if (n % 10 == 1 && n % 100 != 11) return 'день';
    if ([2, 3, 4].contains(n % 10) && ![12, 13, 14].contains(n % 100)) {
      return 'дня';
    }
    return 'дней';
  }
}

// ─── График активности ─────────────────────────────────────────
class _WeekChart extends StatelessWidget {
  final Map<String, int> activity;
  const _WeekChart({required this.activity});

  @override
  Widget build(BuildContext context) {
    final days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
    final maxVal =
        activity.values.fold<int>(1, (a, b) => a > b ? a : b);

    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: days.map((day) {
          final val = activity[day] ?? 0;
          final ratio = maxVal > 0 ? val / maxVal : 0.0;
          final active = val > 0;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 28,
                height: 52 * ratio + 4,
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF0ABDB9)
                      : const Color(0xFFE0F3F2),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              const SizedBox(height: 4),
              Text(day,
                  style: TextStyle(
                    fontSize: 10,
                    color: active
                        ? const Color(0xFF0ABDB9)
                        : const Color(0xFF8EAEAC),
                    fontWeight: active
                        ? FontWeight.w700
                        : FontWeight.w400,
                  )),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// ─── Строка инсайта ────────────────────────────────────────────
class _InsightRow extends StatelessWidget {
  final String icon, text;
  const _InsightRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => Row(children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF4D6766),
              )),
        ),
      ]);
}

// ─── Элемент настроек ──────────────────────────────────────────
class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String title, value;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE0F3F2)),
        ),
        child: Row(children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFF0ABDB9).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF0ABDB9), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0F1F1E),
                )),
          ),
          Text(value,
              style: const TextStyle(
                  fontSize: 13, color: Color(0xFF8EAEAC))),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded,
              color: Color(0xFF8EAEAC), size: 18),
        ]),
      ),
    );
  }
}
