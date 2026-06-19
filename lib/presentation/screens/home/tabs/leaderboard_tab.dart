import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';

class LeaderboardTab extends StatefulWidget {
  final String name;
  const LeaderboardTab({super.key, required this.name});

  @override
  State<LeaderboardTab> createState() => _LeaderboardTabState();
}

class _LeaderboardTabState extends State<LeaderboardTab> {
  List<Map<String, dynamic>> _players = [];
  bool _loading = true;

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
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;

      final rows = await Supabase.instance.client
          .from('users')
          .select('id, name, xp, streak')
          .order('xp', ascending: false)
          .limit(20);

      if (!mounted) return;
      if (rows.isEmpty) { _applyMockPlayers(); return; }

      final avatars = ['👩', '👨', '👩‍🦱', '🧑', '👩‍🦰', '👦', '👧', '🧑‍💻', '👩‍💼', '🧑‍🎓'];
      final built = <Map<String, dynamic>>[];
      bool hasMe = false;

      for (int i = 0; i < rows.length; i++) {
        final r = rows[i];
        final isMe = r['id'] == uid;
        if (isMe) hasMe = true;
        built.add({
          'name': r['name'] ?? 'Игрок',
          'xp': (r['xp'] ?? 0) as int,
          'streak': (r['streak'] ?? 0) as int,
          'avatar': isMe ? '⭐' : avatars[i % avatars.length],
          if (isMe) 'isMe': true,
        });
      }

      if (!hasMe && uid != null) {
        built.add({
          'name': widget.name,
          'xp': 0,
          'streak': 0,
          'avatar': '⭐',
          'isMe': true,
        });
      }

      setState(() { _players = built; _loading = false; });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
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
                        color: AppColors.textPrimary,
                      )),
                  const Text('Топ недели по XP',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            ),

            // Топ 3 пьедестал
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.tiffany),
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
                          ? AppColors.tiffany.withValues(alpha: 0.08)
                          : AppColors.darkCard,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: isMe
                            ? AppColors.tiffany.withValues(alpha: 0.3)
                            : AppColors.darkBorder,
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
                                  : AppColors.textHint,
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
                                    ? AppColors.tiffany
                                    : AppColors.textPrimary,
                              ),
                            ),
                            Text('🔥 ${p['streak']} дней',
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.textSecondary)),
                          ],
                        ),
                      ),
                      Text('${p['xp']} XP',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppColors.tiffany,
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
            style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        Text('${player['xp']} XP',
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.tiffany)),
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
