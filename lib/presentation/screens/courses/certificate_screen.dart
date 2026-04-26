import 'package:flutter/material.dart';
import '../../../data/courses/course_structure.dart';

class CertificateScreen extends StatelessWidget {
  final LanguageCourse course;
  final bool isKidsMode;
  final String? userName;

  const CertificateScreen({
    super.key,
    required this.course,
    this.isKidsMode = false,
    this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6EFF8),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18, color: Color(0xFF0F1F1E)),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    '🏆 Сертификат',
                    style: TextStyle(
                      color: Color(0xFF0F1F1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _CertificateCard(
                  course: course,
                  userName: userName ?? 'Студент',
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('📱 Функция сохранения скоро!'),
                            backgroundColor: const Color(0xFF0ABDB9),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.download_rounded),
                      label: const Text('Сохранить сертификат'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0ABDB9),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('📤 Функция публикации скоро!'),
                            backgroundColor: const Color(0xFF9B59B6),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share_rounded),
                      label: const Text('Поделиться'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF0ABDB9),
                        side: const BorderSide(color: Color(0xFF0ABDB9)),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  final LanguageCourse course;
  final String userName;

  const _CertificateCard({required this.course, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFD6EFF8),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFF0ABDB9), width: 3),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Фоновые декоративные круги
          Positioned(
            top: -20,
            left: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0ABDB9).withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0ABDB9).withValues(alpha: 0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Заголовок
                Column(
                  children: [
                    const Text(
                      'СЕРТИФИКАТ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0ABDB9),
                        letterSpacing: 4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'самому крутому',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF4D6766),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),

                // Имя пользователя
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  child: Text(
                    userName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0ABDB9),
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // Описание + логотип + робот в ряд
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Кубок слева
                    const Text('🏆', style: TextStyle(fontSize: 48)),
                    const SizedBox(width: 12),

                    // Текст по центру
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Сертификат выдан за прохождение курса по языку\n"${course.langName}" ${course.flag}\nгде он показал лучший результат',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF0F1F1E),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Флаги языков
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('🇬🇧', style: TextStyle(fontSize: 18)),
                              Text('🇩🇪', style: TextStyle(fontSize: 18)),
                              Text('🇫🇷', style: TextStyle(fontSize: 18)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0ABDB9),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'LEARN!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Робот справа
                    SizedBox(
                      width: 80,
                      height: 100,
                      child: Image.asset(
                        'assets/images/robot.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Text(
                          '🤖',
                          style: TextStyle(fontSize: 48),
                        ),
                      ),
                    ),
                  ],
                ),

                // Подпись
                const Divider(color: Color(0xFF0ABDB9), thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Лого
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        'assets/images/logo.png',
                        errorBuilder: (_, __, ___) => const Text('⚡'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'by.synapse',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF0ABDB9),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      _formatDate(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8EAEAC),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    final months = [
      '', 'января', 'февраля', 'марта', 'апреля', 'мая', 'июня',
      'июля', 'августа', 'сентября', 'октября', 'ноября', 'декабря',
    ];
    return '${d.day} ${months[d.month]} ${d.year}';
  }
}
