import 'package:flutter/material.dart';
import '../../lesson/lesson_screen.dart';

class PathTab extends StatelessWidget {
  final String name;
  final bool isKids;
  const PathTab({super.key, required this.name, required this.isKids});

  @override
  Widget build(BuildContext context) {
    final modules = [
      {
        'title': 'Основы',
        'lessons': 5,
        'completed': 3,
        'locked': false,
        'emoji': '🌱',
        'color': const Color(0xFF0ABDB9),
      },
      {
        'title': 'Животные',
        'lessons': 8,
        'completed': 1,
        'locked': false,
        'emoji': '🐾',
        'color': const Color(0xFF9B59B6),
      },
      {
        'title': 'Еда и напитки',
        'lessons': 6,
        'completed': 0,
        'locked': false,
        'emoji': '🍎',
        'color': const Color(0xFF3498DB),
      },
      {
        'title': 'Числа и время',
        'lessons': 7,
        'completed': 0,
        'locked': true,
        'emoji': '🔢',
        'color': const Color(0xFFFF6B35),
      },
      {
        'title': 'Семья',
        'lessons': 5,
        'completed': 0,
        'locked': true,
        'emoji': '👨‍👩‍👧',
        'color': const Color(0xFFFFBB33),
      },
      {
        'title': 'Финальный тест',
        'lessons': 1,
        'completed': 0,
        'locked': true,
        'emoji': '🏆',
        'color': const Color(0xFFFFD700),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Шапка
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Привет, $name! 👋',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        )),
                    const SizedBox(height: 4),
                    const Text('Путь славы',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        )),
                    const SizedBox(height: 16),
                    // Кнопка продолжить
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonScreen(isKidsMode: isKids),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow_rounded,
                                color: Color(0xFF0ABDB9), size: 22),
                            SizedBox(width: 8),
                            Text('Продолжить обучение',
                                style: TextStyle(
                                  color: Color(0xFF0ABDB9),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Дерево уроков
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: modules.asMap().entries.map((entry) {
                    final i = entry.key;
                    final m = entry.value;
                    final isLocked = m['locked'] as bool;
                    final completed = m['completed'] as int;
                    final lessons = m['lessons'] as int;
                    final color = m['color'] as Color;
                    final progress = lessons > 0 ? completed / lessons : 0.0;

                    return Column(
                      children: [
                        // Соединитель
                        if (i > 0)
                          Container(
                            width: 2,
                            height: 24,
                            color: isLocked
                                ? const Color(0xFFE0F3F2)
                                : const Color(0xFF0ABDB9)
                                    .withValues(alpha: 0.3),
                          ),
                        // Модуль
                        Opacity(
                          opacity: isLocked ? 0.5 : 1,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isLocked
                                  ? const Color(0xFFF0F0F0)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isLocked
                                    ? const Color(0xFFE0E0E0)
                                    : color.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: isLocked
                                      ? const Color(0xFFE0E0E0)
                                      : color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: Text(
                                    isLocked ? '🔒' : m['emoji'] as String,
                                    style: const TextStyle(fontSize: 26),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(m['title'] as String,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: isLocked
                                              ? const Color(0xFF8EAEAC)
                                              : const Color(0xFF0F1F1E),
                                        )),
                                    Text(
                                      isLocked
                                          ? 'Заблокировано'
                                          : '$completed/$lessons уроков',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: isLocked
                                            ? const Color(0xFFB0B0B0)
                                            : const Color(0xFF8EAEAC),
                                      ),
                                    ),
                                    if (!isLocked) ...[
                                      const SizedBox(height: 8),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: LinearProgressIndicator(
                                          value: progress,
                                          backgroundColor:
                                              color.withValues(alpha: 0.15),
                                          valueColor:
                                              AlwaysStoppedAnimation(color),
                                          minHeight: 6,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (!isLocked)
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: color,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                            ]),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
