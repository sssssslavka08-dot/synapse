import 'package:flutter/material.dart';
import '../../../services/supabase_service.dart';
import '../home/home_screen.dart';

class SubscriptionScreen extends StatefulWidget {
  final String name;
  final int age;

  const SubscriptionScreen({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  String _selected = 'pro';
  bool _isLoading = false;

  static const _plans = [
    {
      'id': 'free',
      'icon': '🌱',
      'name': 'FREE',
      'label': 'Бесплатный',
      'price': '0 ₸',
      'period': '',
      'color': 0xFF64748B,
      'accent': 0xFFE2E8F0,
      'features': [
        '20 слов в день',
        'Базовые игры',
        'Рейтинг',
        'Реклама',
      ],
      'missing': [
        'AI-анализ прогресса',
        'Голосовые тренировки',
        'Без рекламы',
      ],
    },
    {
      'id': 'pro',
      'icon': '⚡',
      'name': 'PRO',
      'label': 'Про',
      'price': '1 490 ₸',
      'period': '/ месяц',
      'color': 0xFF0ABDB9,
      'accent': 0xFFE0FAFA,
      'popular': true,
      'features': [
        'Безлимитные слова',
        'Все игры и режимы',
        'Без рекламы',
        'AI-анализ прогресса',
        'Голосовые тренировки',
        'Приоритет в рейтинге',
      ],
      'missing': <String>[],
    },
    {
      'id': 'legenda',
      'icon': '👑',
      'name': 'LEGENDA',
      'label': 'Легенда',
      'price': '3 990 ₸',
      'period': '/ месяц',
      'color': 0xFFD97706,
      'accent': 0xFFFEF3C7,
      'features': [
        'Всё из PRO',
        'Персональный AI-тьютор',
        'Ранний доступ к функциям',
        'Эксклюзивные бейджи',
        'Офлайн режим',
        'VIP поддержка',
      ],
      'missing': <String>[],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                children: [
                  // Кнопка назад или закрыть
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(color: const Color(0xFFD6F5F4)),
                          ),
                          child: const Icon(Icons.close,
                              size: 20, color: Color(0xFF4D6766)),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0ABDB9).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Text('7 дней бесплатно',
                            style: TextStyle(
                              color: Color(0xFF0ABDB9),
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Выбери свой план',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F1F1E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Открой все возможности SYNAPSE',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF4D6766),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Карточки планов
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _plans.length,
                itemBuilder: (context, i) {
                  final plan = _plans[i];
                  final isSelected = _selected == plan['id'];
                  final color = Color(plan['color'] as int);
                  final accent = Color(plan['accent'] as int);
                  final isPopular = plan['popular'] == true;
                  final features = plan['features'] as List;
                  final missing = plan['missing'] as List;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selected = plan['id'] as String),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: isSelected ? accent : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? color
                                : const Color(0xFFD6F5F4),
                            width: isSelected ? 2 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.12),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  )
                                ]
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Шапка карточки
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Center(
                                      child: Text(
                                        plan['icon'] as String,
                                        style:
                                            const TextStyle(fontSize: 22),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              plan['name'] as String,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w800,
                                                color: color,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                            if (isPopular) ...[
                                              const SizedBox(width: 8),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 3),
                                                decoration: BoxDecoration(
                                                  color: color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: const Text(
                                                  'Популярный',
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        Text(
                                          plan['label'] as String,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF8EAEAC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        plan['price'] as String,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: color,
                                        ),
                                      ),
                                      if ((plan['period'] as String)
                                          .isNotEmpty)
                                        Text(
                                          plan['period'] as String,
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

                            // Фичи
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18, 14, 18, 18),
                              child: Column(
                                children: [
                                  ...features.map((f) => _FeatureRow(
                                        text: f as String,
                                        included: true,
                                        color: color,
                                      )),
                                  ...missing.map((f) => _FeatureRow(
                                        text: f as String,
                                        included: false,
                                        color: color,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Кнопка выбора
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() => _isLoading = true);
                              try {
                                await SupabaseService.instance
                                    .updateSubscription(_selected);
                              } catch (_) {}
                              if (!mounted) return;
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomeScreen(
                                    name: widget.name,
                                    age: widget.age,
                                  ),
                                ),
                                (route) => false,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0ABDB9),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              _selected == 'free'
                                  ? 'Продолжить бесплатно'
                                  : 'Попробовать 7 дней бесплатно →',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Отмена в любое время · Без скрытых платежей',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF8EAEAC),
                    ),
                    textAlign: TextAlign.center,
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

class _FeatureRow extends StatelessWidget {
  final String text;
  final bool included;
  final Color color;

  const _FeatureRow({
    required this.text,
    required this.included,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            included ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 16,
            color: included ? color : const Color(0xFFCBD5E1),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: included
                  ? const Color(0xFF0F1F1E)
                  : const Color(0xFFCBD5E1),
              fontWeight:
                  included ? FontWeight.w500 : FontWeight.w400,
              decoration: included ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
