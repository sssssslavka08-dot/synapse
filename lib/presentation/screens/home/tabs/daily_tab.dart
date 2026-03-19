import 'package:flutter/material.dart';

class DailyTab extends StatefulWidget {
  final String name;
  final bool isKids;
  const DailyTab({super.key, required this.name, required this.isKids});

  @override
  State<DailyTab> createState() => _DailyTabState();
}

class _DailyTabState extends State<DailyTab> {
  final List<Map<String, dynamic>> _quests = [
    {'title': 'Выучить 5 слов', 'xp': 20, 'done': false, 'icon': '📚'},
    {'title': 'Пройти 1 урок', 'xp': 30, 'done': false, 'icon': '🎯'},
    {'title': 'Прослушать диалог', 'xp': 15, 'done': false, 'icon': '🎧'},
    {'title': 'Повторить слова', 'xp': 10, 'done': false, 'icon': '🔄'},
    {'title': 'Сыграть в мини-игру', 'xp': 25, 'done': false, 'icon': '🎮'},
  ];

  bool _frozen = false;
  int _streak = 7;

  int get _completedCount => _quests.where((q) => q['done'] == true).length;

  int get _totalXp => _quests
      .where((q) => q['done'] == true)
      .fold(0, (sum, q) => sum + (q['xp'] as int));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Шапка
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Ежедневные задания',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F1F1E),
                            )),
                        Text('${_completedCount}/${_quests.length} выполнено',
                            style: const TextStyle(
                                color: Color(0xFF8EAEAC), fontSize: 13)),
                      ]),
                  // Streak badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF6B35).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color:
                              const Color(0xFFFF6B35).withValues(alpha: 0.3)),
                    ),
                    child: Row(children: [
                      const Text('🔥', style: TextStyle(fontSize: 20)),
                      const SizedBox(width: 6),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$_streak',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Color(0xFFFF6B35),
                                )),
                            const Text('дней',
                                style: TextStyle(
                                    fontSize: 10, color: Color(0xFF8EAEAC))),
                          ]),
                    ]),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Прогресс дня
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Прогресс дня',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 13)),
                        Text('+$_totalXp XP заработано',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                            )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: _completedCount / _quests.length,
                        backgroundColor: Colors.white30,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _completedCount == _quests.length
                          ? '🎉 Все задания выполнены!'
                          : 'Осталось ${_quests.length - _completedCount} задания',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Список заданий
              const Text('Задания на сегодня',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F1F1E),
                  )),
              const SizedBox(height: 12),

              ..._quests.asMap().entries.map((entry) {
                final i = entry.key;
                final q = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () =>
                        setState(() => _quests[i]['done'] = !q['done']),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: q['done']
                            ? const Color(0xFF0ABDB9).withValues(alpha: 0.08)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: q['done']
                              ? const Color(0xFF0ABDB9).withValues(alpha: 0.3)
                              : const Color(0xFFE0F3F2),
                        ),
                      ),
                      child: Row(children: [
                        Text(q['icon'], style: const TextStyle(fontSize: 24)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(q['title'],
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: q['done']
                                        ? const Color(0xFF8EAEAC)
                                        : const Color(0xFF0F1F1E),
                                    decoration: q['done']
                                        ? TextDecoration.lineThrough
                                        : null,
                                  )),
                              Text('+${q['xp']} XP',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF0ABDB9),
                                    fontWeight: FontWeight.w500,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: q['done']
                                ? const Color(0xFF0ABDB9)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: q['done']
                                  ? const Color(0xFF0ABDB9)
                                  : const Color(0xFFD6F5F4),
                              width: 2,
                            ),
                          ),
                          child: q['done']
                              ? const Icon(Icons.check_rounded,
                                  color: Colors.white, size: 16)
                              : null,
                        ),
                      ]),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),

              // Кнопка заморозки
              GestureDetector(
                onTap: () => setState(() => _frozen = !_frozen),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _frozen
                        ? const Color(0xFF3498DB).withValues(alpha: 0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _frozen
                          ? const Color(0xFF3498DB)
                          : const Color(0xFFE0F3F2),
                    ),
                  ),
                  child: Row(children: [
                    const Text('🧊', style: TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _frozen ? 'Заморозка активна ✓' : 'Заморозить streak',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: _frozen
                                ? const Color(0xFF3498DB)
                                : const Color(0xFF0F1F1E),
                          ),
                        ),
                        const Text(
                          'Пропусти день без потери прогресса',
                          style:
                              TextStyle(fontSize: 12, color: Color(0xFF8EAEAC)),
                        ),
                      ],
                    )),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
