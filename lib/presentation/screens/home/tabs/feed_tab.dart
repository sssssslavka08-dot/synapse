import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  FeedTab({super.key});

  final List<Map<String, dynamic>> _posts = [
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
                      Text('Новости и контент',
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
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _posts.length,
                itemBuilder: (context, i) {
                  final post = _posts[i];
                  if (post['type'] == 'quiz') {
                    return _QuizCard(post: post);
                  }
                  return _FeedCard(post: post);
                },
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
