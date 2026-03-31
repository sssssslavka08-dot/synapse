import 'package:flutter/material.dart';
import '../../../../core/utils/level_system.dart';
import '../../../../services/supabase_service.dart';
import '../../friends/friends_screen.dart';

class FeedTab extends StatefulWidget {
  FeedTab({super.key});

  @override
  State<FeedTab> createState() => _FeedTabState();
}

class _FeedTabState extends State<FeedTab> {
  List<Map<String, dynamic>> _friends = [];
  bool _friendsLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }

  Future<void> _loadFriends() async {
    final friends = await SupabaseService.instance.getFriends();
    if (mounted) setState(() { _friends = friends; _friendsLoading = false; });
  }

  static const List<Map<String, dynamic>> _posts = [
    {
      'type': 'word_of_day',
      'emoji': '✨',
      'title': 'Слово дня',
      'content': 'Синапс (Synapse) — место контакта между нейронами',
      'tag': 'Казахский',
      'time': '2 мин назад',
    },
    {
      'type': 'achievement',
      'emoji': '🏆',
      'title': 'Айгерим К. получила достижение!',
      'content': 'Перешла в Золотую лигу после 21 дня без пропусков',
      'tag': 'Достижение',
      'time': '15 мин назад',
    },
    {
      'type': 'tip',
      'emoji': '💡',
      'title': 'Лайфхак недели',
      'content':
          'Учи слова перед сном — мозг закрепляет их во время сна. Достаточно 10 минут!',
      'tag': 'Совет',
      'time': '1 час назад',
    },
    {
      'type': 'quiz',
      'emoji': '🎯',
      'title': 'Быстрый тест',
      'content': 'Как переводится слово "Достар" на русский?',
      'options': ['Друзья', 'Семья', 'Школа', 'Дом'],
      'correct': 0,
      'tag': 'Тест',
      'time': '2 часа назад',
    },
    {
      'type': 'news',
      'emoji': '📢',
      'title': 'Новый курс: Деловой казахский',
      'content':
          'Запускаем новый модуль для профессионального общения. Старт 1 апреля!',
      'tag': 'Новости',
      'time': '3 часа назад',
    },
    {
      'type': 'idiom',
      'emoji': '🗣',
      'title': 'Идиома недели',
      'content': '"Тіл табу" (Тіл табу) — найти общий язык с кем-либо',
      'tag': 'Казахский',
      'time': '5 часов назад',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Лента',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F1F1E),
                          )),
                      Text('Друзья и новости',
                          style: TextStyle(
                              color: Color(0xFF8EAEAC), fontSize: 13)),
                    ],
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE0F3F2)),
                    ),
                    child: const Icon(Icons.notifications_outlined,
                        color: Color(0xFF8EAEAC), size: 20),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Активность друзей
                  if (_friendsLoading)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: _FriendsActivitySkeleton(),
                    )
                  else if (_friends.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _FriendsActivityRow(
                        friends: _friends,
                        onSeeAll: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FriendsScreen(),
                          ),
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _AddFriendsBanner(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const FriendsScreen(),
                          ),
                        ),
                      ),
                    ),
                  // Основная лента
                  ..._posts.map((post) {
                    if (post['type'] == 'quiz') return _QuizCard(post: post);
                    return _FeedCard(post: post);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeedCard extends StatelessWidget {
  final Map<String, dynamic> post;
  const _FeedCard({required this.post});

  Color get _tagColor {
    switch (post['tag']) {
      case 'Достижение':
        return const Color(0xFFFFD700);
      case 'Совет':
        return const Color(0xFF3498DB);
      case 'Новости':
        return const Color(0xFF9B59B6);
      default:
        return const Color(0xFF0ABDB9);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0F3F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(post['emoji'], style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(post['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F1F1E),
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: _tagColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(post['tag'],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _tagColor,
                  )),
            ),
          ]),
          const SizedBox(height: 10),
          Text(post['content'],
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF4D6766),
                height: 1.5,
              )),
          const SizedBox(height: 8),
          Text(post['time'],
              style: const TextStyle(fontSize: 11, color: Color(0xFF8EAEAC))),
        ],
      ),
    );
  }
}

class _QuizCard extends StatefulWidget {
  final Map<String, dynamic> post;
  const _QuizCard({required this.post});

  @override
  State<_QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<_QuizCard> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    final options = widget.post['options'] as List;
    final correct = widget.post['correct'] as int;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0F3F2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Text(widget.post['emoji'], style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(widget.post['title'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F1F1E),
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF0ABDB9).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text('Тест',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0ABDB9),
                  )),
            ),
          ]),
          const SizedBox(height: 12),
          Text(widget.post['content'],
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F1F1E),
              )),
          const SizedBox(height: 12),
          ...options.asMap().entries.map((e) {
            final isSelected = _selected == e.key;
            final isCorrect = e.key == correct;
            Color bg = Colors.white;
            Color border = const Color(0xFFE0F3F2);
            if (_selected != null) {
              if (isCorrect) {
                bg = const Color(0xFF22C55E).withValues(alpha: 0.1);
                border = const Color(0xFF22C55E);
              } else if (isSelected) {
                bg = const Color(0xFFEF4444).withValues(alpha: 0.1);
                border = const Color(0xFFEF4444);
              }
            } else if (isSelected) {
              bg = const Color(0xFF0ABDB9).withValues(alpha: 0.1);
              border = const Color(0xFF0ABDB9);
            }
            return GestureDetector(
              onTap: () {
                if (_selected == null) setState(() => _selected = e.key);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: border),
                ),
                child: Text(e.value, style: const TextStyle(fontSize: 14)),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Горизонтальная лента активности друзей ───────────────────
class _FriendsActivityRow extends StatelessWidget {
  final List<Map<String, dynamic>> friends;
  final VoidCallback onSeeAll;
  const _FriendsActivityRow(
      {required this.friends, required this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Друзья онлайн',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F1F1E))),
            GestureDetector(
              onTap: onSeeAll,
              child: const Text('Все друзья',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF0ABDB9),
                      fontWeight: FontWeight.w600)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 96,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: friends.length,
            itemBuilder: (_, i) {
              final f = friends[i];
              final xp = (f['xp'] ?? 0) as int;
              final level = LevelSystem.levelFromXp(xp);
              final emoji = LevelSystem.emojiForLevel(level);
              final progress = LevelSystem.progressInLevel(xp);
              final name = (f['name'] as String? ?? '').split(' ').first;

              return Container(
                width: 76,
                margin: EdgeInsets.only(
                    right: i < friends.length - 1 ? 10 : 0),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border:
                      Border.all(color: const Color(0xFFE0F3F2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 38,
                          height: 38,
                          child: CircularProgressIndicator(
                            value: progress,
                            strokeWidth: 3,
                            backgroundColor:
                                const Color(0xFFD6F5F4),
                            valueColor: const AlwaysStoppedAnimation(
                                Color(0xFF0ABDB9)),
                          ),
                        ),
                        Text(emoji,
                            style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text(name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F1F1E))),
                    Text('Эт. $level',
                        style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xFF0ABDB9),
                            fontWeight: FontWeight.w600)),
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

// ─── Скелетон загрузки ─────────────────────────────────────────
class _FriendsActivitySkeleton extends StatelessWidget {
  const _FriendsActivitySkeleton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96,
      child: Row(
        children: List.generate(4, (i) => Container(
          width: 76,
          margin: EdgeInsets.only(right: i < 3 ? 10 : 0),
          decoration: BoxDecoration(
            color: const Color(0xFFE8FAFA),
            borderRadius: BorderRadius.circular(16),
          ),
        )),
      ),
    );
  }
}

// ─── Баннер «Добавь друзей» ────────────────────────────────────
class _AddFriendsBanner extends StatelessWidget {
  final VoidCallback onTap;
  const _AddFriendsBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            const Text('👥', style: TextStyle(fontSize: 32)),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Учи с друзьями!',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15)),
                  SizedBox(height: 3),
                  Text(
                      'Соревнуйся, следи за прогрессом и мотивируй друг друга',
                      style: TextStyle(
                          color: Colors.white70, fontSize: 12, height: 1.4)),
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text('Найти',
                  style: TextStyle(
                      color: Color(0xFF0ABDB9),
                      fontWeight: FontWeight.w800,
                      fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}
