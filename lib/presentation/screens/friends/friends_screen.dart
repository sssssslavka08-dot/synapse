import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/level_system.dart';
import '../../../services/supabase_service.dart';

// ═══════════════════════════════════════════════════════════════
//  FriendsScreen — список друзей, запросы, поиск, прогресс
// ═══════════════════════════════════════════════════════════════
class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  List<Map<String, dynamic>> _friends = [];
  List<Map<String, dynamic>> _requests = [];
  List<Map<String, dynamic>> _searchResults = [];
  bool _loading = true;
  bool _searching = false;
  final _searchCtrl = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabs.dispose();
    _searchCtrl.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _loading = true);
    final friends = await SupabaseService.instance.getFriends();
    final requests = await SupabaseService.instance.getPendingRequests();
    if (!mounted) return;
    setState(() {
      _friends = friends;
      _requests = requests;
      _loading = false;
    });
  }

  void _onSearchChanged(String q) {
    _debounce?.cancel();
    if (q.trim().isEmpty) {
      setState(() => _searchResults = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      setState(() => _searching = true);
      final results = await SupabaseService.instance.searchUsers(q);
      if (!mounted) return;
      setState(() {
        _searchResults = results;
        _searching = false;
      });
    });
  }

  Future<void> _sendRequest(String friendId) async {
    await SupabaseService.instance.sendFriendRequest(friendId);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Запрос отправлен!'),
        backgroundColor: AppColors.tiffany,
        behavior: SnackBarBehavior.floating,
      ),
    );
    setState(() {
      _searchResults = _searchResults.map((u) {
        if (u['id'] == friendId) return {...u, '_sent': true};
        return u;
      }).toList();
    });
  }

  Future<void> _accept(String requesterId) async {
    await SupabaseService.instance.acceptFriendRequest(requesterId);
    await _loadData();
  }

  Future<void> _remove(String friendId) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: const Color(0xFF1A3332),
        title: const Text('Удалить друга?',
            style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Отмена',
                  style: TextStyle(color: AppColors.textSecondary))),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Удалить',
                  style: TextStyle(color: Color(0xFFFF6B6B)))),
        ],
      ),
    );
    if (ok == true) {
      await SupabaseService.instance.removeFriend(friendId);
      await _loadData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        foregroundColor: Colors.white,
        title: const Text('Друзья',
            style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 22,
                letterSpacing: -0.5)),
        actions: [
          if (_requests.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.notifications_rounded,
                      color: AppColors.tiffany),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('${_requests.length}',
                          style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
        ],
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: AppColors.tiffany,
          labelColor: AppColors.tiffany,
          unselectedLabelColor: const Color(0xFF5A7A78),
          labelStyle:
              const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
          tabs: [
            const Tab(text: 'Мои друзья'),
            Tab(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Запросы'),
                  if (_requests.isNotEmpty) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B35),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text('${_requests.length}',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ),
                  ],
                ],
              ),
            ),
            const Tab(text: 'Найти'),
          ],
        ),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.tiffany))
          : TabBarView(
              controller: _tabs,
              children: [
                _buildFriendsList(),
                _buildRequestsList(),
                _buildSearch(),
              ],
            ),
    );
  }

  // ── Список друзей ───────────────────────────────────────────
  Widget _buildFriendsList() {
    if (_friends.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('👥', style: TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            const Text('Пока нет друзей',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Найди друзей во вкладке «Найти»',
                style: TextStyle(color: Color(0xFF5A7A78), fontSize: 14)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppColors.tiffany,
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _friends.length,
        itemBuilder: (_, i) => _FriendCard(
          user: _friends[i],
          onRemove: () => _remove(_friends[i]['id'] as String),
        ),
      ),
    );
  }

  // ── Запросы дружбы ─────────────────────────────────────────
  Widget _buildRequestsList() {
    if (_requests.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('📭', style: TextStyle(fontSize: 56)),
            SizedBox(height: 16),
            Text('Нет входящих запросов',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _requests.length,
      itemBuilder: (_, i) {
        final u = _requests[i];
        final xp = (u['xp'] ?? 0) as int;
        final level = LevelSystem.levelFromXp(xp);
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A3332),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFF2A4A48)),
          ),
          child: Row(
            children: [
              _Avatar(emoji: LevelSystem.emojiForLevel(level), level: level),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u['name'] ?? '',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    Text(
                        'Этаж $level · ${LevelSystem.titleForLevel(level)}',
                        style: const TextStyle(
                            color: Color(0xFF5A7A78), fontSize: 12)),
                  ],
                ),
              ),
              Row(
                children: [
                  _ActionBtn(
                    icon: Icons.check_rounded,
                    color: AppColors.tiffany,
                    onTap: () => _accept(u['id'] as String),
                  ),
                  const SizedBox(width: 8),
                  _ActionBtn(
                    icon: Icons.close_rounded,
                    color: const Color(0xFF4D6766),
                    onTap: () =>
                        SupabaseService.instance.removeFriend(u['id'] as String)
                            .then((_) => _loadData()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Поиск ──────────────────────────────────────────────────
  Widget _buildSearch() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchCtrl,
            onChanged: _onSearchChanged,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Поиск по имени…',
              hintStyle: const TextStyle(color: Color(0xFF5A7A78)),
              prefixIcon:
                  const Icon(Icons.search_rounded, color: Color(0xFF5A7A78)),
              suffixIcon: _searching
                  ? const Padding(
                      padding: EdgeInsets.all(12),
                      child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.tiffany)),
                    )
                  : null,
              filled: true,
              fillColor: const Color(0xFF1A3332),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Expanded(
          child: _searchResults.isEmpty && _searchCtrl.text.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('🔍', style: TextStyle(fontSize: 48)),
                      SizedBox(height: 12),
                      Text('Введи имя друга для поиска',
                          style: TextStyle(
                              color: Color(0xFF5A7A78), fontSize: 14)),
                    ],
                  ),
                )
              : _searchResults.isEmpty && !_searching
                  ? const Center(
                      child: Text('Никого не найдено',
                          style: TextStyle(
                              color: Color(0xFF5A7A78), fontSize: 14)),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _searchResults.length,
                      itemBuilder: (_, i) {
                        final u = _searchResults[i];
                        final xp = (u['xp'] ?? 0) as int;
                        final level = LevelSystem.levelFromXp(xp);
                        final sent = u['_sent'] == true;
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3332),
                            borderRadius: BorderRadius.circular(16),
                            border:
                                Border.all(color: const Color(0xFF2A4A48)),
                          ),
                          child: Row(
                            children: [
                              _Avatar(
                                  emoji: LevelSystem.emojiForLevel(level),
                                  level: level),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(u['name'] ?? '',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14)),
                                    Text(
                                        'Этаж $level · $xp XP · 🔥${u['streak'] ?? 0}',
                                        style: const TextStyle(
                                            color: Color(0xFF5A7A78),
                                            fontSize: 12)),
                                  ],
                                ),
                              ),
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: sent
                                    ? const Icon(Icons.check_circle_rounded,
                                        color: AppColors.tiffany)
                                    : GestureDetector(
                                        onTap: () => _sendRequest(
                                            u['id'] as String),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: AppColors.tiffany,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Text('Добавить',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12)),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }
}

// ─── Карточка друга ────────────────────────────────────────────
class _FriendCard extends StatelessWidget {
  final Map<String, dynamic> user;
  final VoidCallback onRemove;
  const _FriendCard({required this.user, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final xp = (user['xp'] ?? 0) as int;
    final streak = (user['streak'] ?? 0) as int;
    final words = (user['words_learned'] ?? 0) as int;
    final level = LevelSystem.levelFromXp(xp);
    final progress = LevelSystem.progressInLevel(xp);
    final title = LevelSystem.titleForLevel(level);
    final emoji = LevelSystem.emojiForLevel(level);
    final lang = user['selected_language'] as String? ?? '';
    final langEmoji = const {
      'en': '🇬🇧', 'kz': '🇰🇿', 'ru': '🇷🇺',
      'de': '🇩🇪', 'fr': '🇫🇷', 'zh': '🇨🇳',
    }[lang] ?? '🌍';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A3332),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF2A4A48)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _Avatar(emoji: emoji, level: level),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(user['name'] ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 15)),
                        const SizedBox(width: 6),
                        Text(langEmoji,
                            style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                    Text('Этаж $level · $title',
                        style: const TextStyle(
                            color: AppColors.tiffany,
                            fontSize: 12,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.more_horiz_rounded,
                    color: Color(0xFF4D6766)),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Прогресс-бар уровня
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Прогресс этажа',
                      style: const TextStyle(
                          color: Color(0xFF5A7A78), fontSize: 11)),
                  Text('$xp XP',
                      style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: const Color(0xFF2A4A48),
                  valueColor: const AlwaysStoppedAnimation(AppColors.tiffany),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Статы
          Row(
            children: [
              _StatChip(label: '🔥 $streak дней', color: const Color(0xFFFF6B35)),
              const SizedBox(width: 8),
              _StatChip(label: '📖 $words слов', color: const Color(0xFF9B59B6)),
              const SizedBox(width: 8),
              _StatChip(label: '⭐ Этаж $level', color: const Color(0xFFFFD700)),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Вспомогательные виджеты ──────────────────────────────────
class _Avatar extends StatelessWidget {
  final String emoji;
  final int level;
  const _Avatar({required this.emoji, required this.level});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.tiffany.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(
                color: AppColors.tiffany.withValues(alpha: 0.4),
                width: 1.5),
          ),
          child: Center(
            child: Text(emoji, style: const TextStyle(fontSize: 22)),
          ),
        ),
        Positioned(
          bottom: -2,
          right: -2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              color: AppColors.darkBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.tiffany, width: 1),
            ),
            child: Text('$level',
                style: const TextStyle(
                    color: AppColors.tiffany,
                    fontSize: 9,
                    fontWeight: FontWeight.w900)),
          ),
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final Color color;
  const _StatChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(label,
          style: TextStyle(
              color: color, fontSize: 11, fontWeight: FontWeight.w600)),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionBtn(
      {required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Icon(icon, color: color, size: 18),
      ),
    );
  }
}
