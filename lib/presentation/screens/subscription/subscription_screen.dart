import 'dart:async';
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

class _SubscriptionScreenState extends State<SubscriptionScreen>
    with TickerProviderStateMixin {
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
        '2 темы из главы в день',
        '1 язык изучения',
        'Уроки без Нейрончика',
        'До 2 000 монет за курс',
      ],
      'missing': [
        'Мини-игры за монеты',
        'AI-аналитика прогресса',
        'Нейрончик-компаньон',
        'Офлайн-режим',
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
        '10 тем по степени прохождения',
        'Изучение 3 языков одновременно',
        'Мини-игры + монеты за победы',
        'AI-аналитика успеваемости',
        'Нейрончик-компаньон',
        'До 5 000 монет за курс',
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
      'color': 0xFF9B59B6,
      'accent': 0xFFF3E8FF,
      'features': [
        'Всё из PRO',
        'Офлайн-режим (синхронизация)',
        'Персональный AI-план изучения',
        'Приоритетная тех-поддержка',
        'До 10 000 монет за курс',
        '🟣 Рамка "Неон Фиолетовый" в подарок',
        '🟣 Префикс LEGENDA (фиолет. неон)',
      ],
      'missing': <String>[],
    },
  ];

  Future<void> _handlePurchase() async {
    if (_selected == 'free') {
      await SupabaseService.instance.updateSubscription('free');
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(name: widget.name, age: widget.age),
        ),
        (route) => false,
      );
      return;
    }

    setState(() => _isLoading = true);
    await _showPaymentDialog();
  }

  Future<void> _showPaymentDialog() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _PaymentLoadingDialog(),
    );

    // Имитация обработки платежа
    await Future.delayed(const Duration(milliseconds: 3500));

    try {
      await SupabaseService.instance.updateSubscription(_selected);
      if (_selected == 'legenda') {
        // Выдать фиолетовую неон рамку и префикс для легенды
        await SupabaseService.instance.grantLegendaRewards();
      }
    } catch (_) {}

    if (!mounted) return;
    Navigator.of(context).pop(); // Закрыть loading dialog

    await _showSuccessDialog();
  }

  Future<void> _showSuccessDialog() async {
    final plan = _plans.firstWhere((p) => p['id'] == _selected);
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => _PaymentSuccessDialog(
        planName: plan['name'] as String,
        planIcon: plan['icon'] as String,
        isLegenda: _selected == 'legenda',
        color: Color(plan['color'] as int),
      ),
    );

    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(name: widget.name, age: widget.age),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
              child: Column(
                children: [
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
                            border: Border.all(color: const Color(0xFFD6F5F4)),
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
                    style: TextStyle(fontSize: 14, color: Color(0xFF4D6766)),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

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
                            color: isSelected ? color : const Color(0xFFD6F5F4),
                            width: isSelected ? 2 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.15),
                                    blurRadius: 16,
                                    offset: const Offset(0, 6),
                                  )
                                ]
                              : null,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                                      child: Text(plan['icon'] as String,
                                          style:
                                              const TextStyle(fontSize: 22)),
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
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        plan['price'] as String,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800,
                                          color: color,
                                        ),
                                      ),
                                      if ((plan['period'] as String).isNotEmpty)
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
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

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handlePurchase,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selected == 'legenda'
                            ? const Color(0xFF9B59B6)
                            : const Color(0xFF0ABDB9),
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
                    style: TextStyle(fontSize: 11, color: Color(0xFF8EAEAC)),
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

// ── Диалог: имитация списания ────────────────────────────────────
class _PaymentLoadingDialog extends StatefulWidget {
  const _PaymentLoadingDialog();

  @override
  State<_PaymentLoadingDialog> createState() => _PaymentLoadingDialogState();
}

class _PaymentLoadingDialogState extends State<_PaymentLoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  int _step = 0;
  Timer? _timer;

  static const _steps = [
    '🔐 Подключение к платёжному шлюзу...',
    '💳 Проверка карты...',
    '🔄 Обработка транзакции...',
    '✅ Подтверждение оплаты...',
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    _timer = Timer.periodic(const Duration(milliseconds: 800), (t) {
      if (!mounted) return;
      if (_step < _steps.length - 1) {
        setState(() => _step++);
      } else {
        t.cancel();
      }
    });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RotationTransition(
              turns: _ctrl,
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0ABDB9), Color(0xFF9B59B6)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.payment_rounded,
                    color: Colors.white, size: 32),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Обработка платежа',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F1F1E),
              ),
            ),
            const SizedBox(height: 16),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                _steps[_step],
                key: ValueKey(_step),
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF4D6766),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            const LinearProgressIndicator(
              color: Color(0xFF0ABDB9),
              backgroundColor: Color(0xFFE0FAFA),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Диалог: успешная оплата ──────────────────────────────────────
class _PaymentSuccessDialog extends StatefulWidget {
  final String planName;
  final String planIcon;
  final bool isLegenda;
  final Color color;

  const _PaymentSuccessDialog({
    required this.planName,
    required this.planIcon,
    required this.isLegenda,
    required this.color,
  });

  @override
  State<_PaymentSuccessDialog> createState() => _PaymentSuccessDialogState();
}

class _PaymentSuccessDialogState extends State<_PaymentSuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut),
    );
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ScaleTransition(
              scale: _scale,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                      color: widget.color.withValues(alpha: 0.3), width: 2),
                ),
                child: Center(
                  child: Text(widget.planIcon,
                      style: const TextStyle(fontSize: 40)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Подписка ${widget.planName} активна!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: widget.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Оплата прошла успешно. Все функции разблокированы.',
              style: TextStyle(fontSize: 14, color: Color(0xFF4D6766)),
              textAlign: TextAlign.center,
            ),
            if (widget.isLegenda) ...[
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF9B59B6).withValues(alpha: 0.1),
                      const Color(0xFF0ABDB9).withValues(alpha: 0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: const Color(0xFF9B59B6).withValues(alpha: 0.3)),
                ),
                child: const Column(
                  children: [
                    Text('🎁 Подарки Legend',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF9B59B6),
                          fontSize: 14,
                        )),
                    SizedBox(height: 6),
                    Text(
                      '🟣 Рамка "Неон Фиолетовый" добавлена\n🟣 Префикс LEGENDA активирован',
                      style:
                          TextStyle(fontSize: 12, color: Color(0xFF4D6766)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: widget.color,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Начать обучение →',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
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
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                color: included
                    ? const Color(0xFF0F1F1E)
                    : const Color(0xFFCBD5E1),
                fontWeight: included ? FontWeight.w500 : FontWeight.w400,
                decoration: included ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
