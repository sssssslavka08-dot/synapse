import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardTab extends StatefulWidget {
  final String name;
  const LeaderboardTab({super.key, required this.name});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  int _selectedLeague = 1;
  List<Map<String, dynamic>> _players = [];
  bool _loading = true;

  final List<String> _leagues = ['🥉 Бронза', '🥈 Серебро', '🥇 Золото'];
  final List<Color> _leagueColors = [
    const Color(0xFFCD7F32),
    const Color(0xFF9EA0A5),
    const Color(0xFFFFD700),
  ];

  static const _mockPlayers = [
    {'name': 'Айгерим К.', 'xp': 1250, 'streak': 14, 'avatar': '👩'},
    {'name': 'Данияр М.', 'xp': 1180, 'streak': 9, 'avatar': '👨'},
    {'name': 'Сабина Т.', 'xp': 980, 'streak': 21, 'avatar': '👩‍🦱'},
    {'name': 'Алишер Н.', 'xp': 870, 'streak': 5, 'avatar': '🧑'},
    {'name': 'Медина А.', 'xp': 820, 'streak': 12, 'avatar': '👩‍🦰'},
    {'name': 'Темирлан Б.', 'xp': 790, 'streak': 3, 'avatar': '👦'},
    {'name': 'Жансая О.', 'xp': 750, 'streak': 7, 'avatar': '👧'},
    {'name': 'Нурлан С.', 'xp': 600, 'streak': 2, 'avatar': '🧑‍💻'},
    {'name': 'Камила Р.', 'xp': 540, 'streak': 8, 'avatar': '👩‍💼'},
  ];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this, initialIndex: 1);
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final weekStart = _weekStart();

      final rows = await Supabase.instance.client
          .from('leaderboard')
          .select('weekly_xp, users(name, streak, age)')
          .eq('week_start', weekStart)
          .order('weekly_xp', ascending: false)
          .limit(20);

      if (!mounted) return;

      if (rows.isEmpty) {
        _applyMockPlayers();
        return;
      }

      final avatars = ['👩', '👨', '👩‍🦱', '🧑', '👩‍🦰', '👦', '👧', '🧑‍💻', '👩‍💼', '🧑‍🎓'];
      final built = <Map<String, dynamic>>[];
      bool hasMe = false;

      for (int i = 0; i < rows.length; i++) {
        final r = rows[i];
        final user = r['users'] as Map<String, dynamic>?;
        final name = user?['name'] as String? ?? 'Игрок';
        final streak = (user?['streak'] ?? 0) as int;
        final xp = (r['weekly_xp'] ?? 0) as int;
        final isMe = (r['user_id'] == uid) ||
            (uid != null && name == widget.name && !hasMe);
        if (isMe) hasMe = true;
        built.add({
          'name': name,
          'xp': xp,
          'streak': streak,
          'avatar': isMe ? '⭐' : avatars[i % avatars.length],
          if (isMe) 'isMe': true,
        });
      }

      // If current user not in top, append them from profile
      if (!hasMe && uid != null) {
        try {
          final me = await Supabase.instance.client
              .from('users')
              .select('name, streak, xp')
              .eq('id', uid)
              .maybeSingle();
          if (me != null) {
            built.add({
              'name': me['name'] ?? widget.name,
              'xp': me['xp'] ?? 0,
              'streak': me['streak'] ?? 0,
              'avatar': '⭐',
              'isMe': true,
            });
          }
        } catch (_) {}
      }

      setState(() {
        _players = built;
        _loading = false;
      });
    } catch (_) {
      if (mounted) _applyMockPlayers();
    }
  }

  void _applyMockPlayers() {
    final list = List<Map<String, dynamic>>.from(
      _mockPlayers.map((p) => Map<String, dynamic>.from(p)),
    );
    // Insert current user
    final meEntry = {
      'name': widget.name,
      'xp': 0,
      'streak': 0,
      'avatar': '⭐',
      'isMe': true,
    };
    list.insert(list.length ~/ 2, meEntry);
    setState(() {
      _players = list;
      _loading = false;
    });
  }

  String _weekStart() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    return '${monday.year}-${monday.month.toString().padLeft(2, '0')}-${monday.day.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Рейтинг',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F1F1E),
                      )),
                  const Text('Топ недели по XP',
                      style: TextStyle(color: Color(0xFF8EAEAC), fontSize: 13)),
                  const SizedBox(height: 16),

                  // Лиги
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FAFA),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: _leagues.asMap().entries.map((e) {
                        final isSelected = _selectedLeague == e.key;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _selectedLeague = e.key),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(e.value,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w400,
                                    color: isSelected
                                        ? _leagueColors[e.key]
                                        : const Color(0xFF8EAEAC),
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            // Топ 3 пьедестал
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: CircularProgressIndicator(color: Color(0xFF0ABDB9)),
                ),
              )
            else if (_players.length >= 3)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _PodiumItem(
                      place: 2,
                      player: _players[1],
                      height: 80,
                      color: const Color(0xFF9EA0A5)),
                  const SizedBox(width: 12),
                  _PodiumItem(
                      place: 1,
                      player: _players[0],
                      height: 110,
                      color: const Color(0xFFFFD700)),
                  const SizedBox(width: 12),
                  _PodiumItem(
                      place: 3,
                      player: _players[2],
                      height: 60,
                      color: const Color(0xFFCD7F32)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Список
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _players.length,
                itemBuilder: (context, i) {
                  final p = _players[i];
                  final isMe = p['isMe'] == true;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isMe
                          ? const Color(0xFF0ABDB9).withValues(alpha: 0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isMe
                            ? const Color(0xFF0ABDB9).withValues(alpha: 0.3)
                            : const Color(0xFFE0F3F2),
                        width: isMe ? 1.5 : 1,
                      ),
                    ),
                    child: Row(children: [
                      SizedBox(
                        width: 28,
                        child: Text('${i + 1}',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: i < 3
                                  ? [
                                      const Color(0xFFFFD700),
                                      const Color(0xFF9EA0A5),
                                      const Color(0xFFCD7F32),
                                    ][i]
                                  : const Color(0xFF8EAEAC),
                            )),
                      ),
                      Text(p['avatar'], style: const TextStyle(fontSize: 28)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isMe ? '${p['name']} (Ты)' : p['name'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isMe
                                    ? const Color(0xFF0ABDB9)
                                    : const Color(0xFF0F1F1E),
                              ),
                            ),
                            Text('🔥 ${p['streak']} дней',
                                style: const TextStyle(
                                    fontSize: 11, color: Color(0xFF8EAEAC))),
                          ],
                        ),
                      ),
                      Text('${p['xp']} XP',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0ABDB9),
                          )),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PodiumItem extends StatelessWidget {
  final int place;
  final Map<String, dynamic> player;
  final double height;
  final Color color;

  const _PodiumItem({
    required this.place,
    required this.player,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(player['avatar'], style: const TextStyle(fontSize: 32)),
        const SizedBox(height: 4),
        Text(player['name'].toString().split(' ')[0],
            style: const TextStyle(fontSize: 11, color: Color(0xFF4D6766))),
        Text('${player['xp']} XP',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0ABDB9))),
        const SizedBox(height: 6),
        Container(
          width: 80,
          height: height,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Text(
              place == 1
                  ? '🥇'
                  : place == 2
                      ? '🥈'
                      : '🥉',
              style: const TextStyle(fontSize: 28),
            ),
          ),
        ),
      ],
    );
  }
}
