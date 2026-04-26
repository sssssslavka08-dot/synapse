import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';
import 'level_test_screen.dart';

// ═══════════════════════════════════════════════════════════
//  LanguageSelectScreen
//  Показывается после регистрации — пользователь выбирает
//  язык для изучения. Выбор сохраняется в Supabase.
// ═══════════════════════════════════════════════════════════
class LanguageSelectScreen extends StatefulWidget {
  final String name;
  final int age;

  const LanguageSelectScreen({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  State<LanguageSelectScreen> createState() => _LanguageSelectScreenState();
}

class _LanguageSelectScreenState extends State<LanguageSelectScreen>
    with SingleTickerProviderStateMixin {
  int _step = 1; // 1 = native lang, 2 = learning lang
  String? _nativeLang;
  String? _selected;
  bool _isLoading = false;
  late AnimationController _listController;

  static const _langs = [
    _Lang(
      code: 'en',
      flag: '🇬🇧',
      name: 'Английский',
      native: 'English',
      method: 'Система Александра «с нуля»',
      color: Color(0xFF1A56DB),
      bg: Color(0xFFEFF6FF),
    ),
    _Lang(
      code: 'kz',
      flag: '🇰🇿',
      name: 'Казахский',
      native: 'Қазақша',
      method: 'Казахский разговорный',
      color: Color(0xFF059669),
      bg: Color(0xFFECFDF5),
    ),
    _Lang(
      code: 'ru',
      flag: '🇷🇺',
      name: 'Русский',
      native: 'Русский',
      method: 'Для иностранцев · Кириллица',
      color: Color(0xFFDC2626),
      bg: Color(0xFFFEF2F2),
    ),
    _Lang(
      code: 'de',
      flag: '🇩🇪',
      name: 'Немецкий',
      native: 'Deutsch',
      method: 'Deutsche Schritt für Schritt',
      color: Color(0xFF92400E),
      bg: Color(0xFFFFFBEB),
    ),
    _Lang(
      code: 'fr',
      flag: '🇫🇷',
      name: 'Французский',
      native: 'Français',
      method: 'Méthode française',
      color: Color(0xFF1D4ED8),
      bg: Color(0xFFEFF6FF),
    ),
    _Lang(
      code: 'zh',
      flag: '🇨🇳',
      name: 'Китайский',
      native: '中文',
      method: '汉语入门 · Пиньинь → Иероглифы',
      color: Color(0xFFB91C1C),
      bg: Color(0xFFFFF1F2),
    ),
    _Lang(
      code: 'es',
      flag: '🇪🇸',
      name: 'Испанский',
      native: 'Español',
      method: 'Español desde cero · DELE',
      color: Color(0xFFC2410C),
      bg: Color(0xFFFFF7ED),
    ),
    _Lang(
      code: 'ja',
      flag: '🇯🇵',
      name: 'Японский',
      native: '日本語',
      method: 'Хирагана → Катакана → Кандзи',
      color: Color(0xFFBE123C),
      bg: Color(0xFFFFF1F2),
    ),
    _Lang(
      code: 'tr',
      flag: '🇹🇷',
      name: 'Турецкий',
      native: 'Türkçe',
      method: 'Türkçe sıfırdan · разговорный',
      color: Color(0xFFD97706),
      bg: Color(0xFFFFFBEB),
    ),
    _Lang(
      code: 'it',
      flag: '🇮🇹',
      name: 'Итальянский',
      native: 'Italiano',
      method: 'Italiano base · A1–B2',
      color: Color(0xFF15803D),
      bg: Color(0xFFF0FDF4),
    ),
    _Lang(
      code: 'ko',
      flag: '🇰🇷',
      name: 'Корейский',
      native: '한국어',
      method: 'Хангыль + разговорный K-culture',
      color: Color(0xFF1D4ED8),
      bg: Color(0xFFEFF6FF),
    ),
    _Lang(
      code: 'ar',
      flag: '🇸🇦',
      name: 'Арабский',
      native: 'العربية',
      method: 'Арабский алфавит + MSA',
      color: Color(0xFF065F46),
      bg: Color(0xFFECFDF5),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _listController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  Future<void> _confirm() async {
    if (_isLoading) return;

    if (_step == 1) {
      if (_nativeLang == null) return;
      setState(() {
        _step = 2;
        _listController.forward(from: 0);
      });
      return;
    }

    // Step 2 — save both languages and navigate
    if (_selected == null) return;
    setState(() => _isLoading = true);
    try {
      await SupabaseService.instance.updateNativeLanguage(_nativeLang!);
      await SupabaseService.instance.updateLanguage(_selected!);
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LevelTestScreen(
            name: widget.name,
            age: widget.age,
            language: _selected!,
          ),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ошибка: $e'),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isStep1 = _step == 1;
    final currentSelected = isStep1 ? _nativeLang : _selected;
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            // ── Шапка ──────────────────────────────────────
            _Header(
              name: widget.name,
              step: _step,
              onBack: isStep1 ? null : () => setState(() { _step = 1; _listController.forward(from: 0); }),
            ),

            // ── Список языков ───────────────────────────────
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                itemCount: _langs.length,
                itemBuilder: (ctx, i) {
                  final delay = i * 0.06;
                  return AnimatedBuilder(
                    animation: _listController,
                    builder: (_, child) {
                      final t = Curves.easeOutCubic.transform(
                        ((_listController.value - delay) / (1 - delay))
                            .clamp(0.0, 1.0),
                      );
                      return Opacity(
                        opacity: t,
                        child: Transform.translate(
                          offset: Offset(0, 24 * (1 - t)),
                          child: child,
                        ),
                      );
                    },
                    child: _LangCard(
                      lang: _langs[i],
                      isSelected: currentSelected == _langs[i].code,
                      onTap: () {
                        if (isStep1) {
                          setState(() => _nativeLang = _langs[i].code);
                        } else {
                          setState(() => _selected = _langs[i].code);
                        }
                      },
                    ),
                  );
                },
              ),
            ),

            // ── Кнопка подтверждения ────────────────────────
            _BottomButton(
              enabled: currentSelected != null,
              isLoading: _isLoading,
              onTap: _confirm,
              label: isStep1 ? 'Далее →' : 'Начать обучение →',
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Data class ─────────────────────────────────────────────
class _Lang {
  final String code, flag, name, native, method;
  final Color color, bg;
  const _Lang({
    required this.code,
    required this.flag,
    required this.name,
    required this.native,
    required this.method,
    required this.color,
    required this.bg,
  });
}

// ─── Шапка ──────────────────────────────────────────────────
class _Header extends StatelessWidget {
  final String name;
  final int step;
  final VoidCallback? onBack;
  const _Header({required this.name, required this.step, this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Логотип + back
          Row(children: [
            if (onBack != null) ...[
              GestureDetector(
                onTap: onBack,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8FAFA),
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF0ABDB9), size: 16),
                ),
              ),
              const SizedBox(width: 10),
            ],
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF0ABDB9),
                borderRadius: BorderRadius.circular(11),
              ),
              child: const Icon(Icons.hub_rounded,
                  color: Colors.white, size: 20),
            ),
            const SizedBox(width: 9),
            const Text('SYNAPSE',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            const Spacer(),
            // Step indicator
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0ABDB9).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$step / 2',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0ABDB9),
                ),
              ),
            ),
          ]),
          const SizedBox(height: 24),

          // Приветствие
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0F1F1E),
                letterSpacing: -0.5,
                height: 1.2,
              ),
              children: step == 1
                  ? [
                      TextSpan(text: 'Привет, $name!\n'),
                      const TextSpan(
                        text: 'Родной язык? ',
                        style: TextStyle(color: Color(0xFF0ABDB9)),
                      ),
                      const TextSpan(text: '🌍'),
                    ]
                  : [
                      const TextSpan(text: 'Отлично!\n'),
                      const TextSpan(
                        text: 'Что учим? ',
                        style: TextStyle(color: Color(0xFF0ABDB9)),
                      ),
                      const TextSpan(text: '👇'),
                    ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            step == 1
                ? 'AI адаптирует объяснения под твой язык'
                : 'Выбери язык — AI настроит программу под тебя',
            style: const TextStyle(fontSize: 14, color: Color(0xFF4D6766)),
          ),
        ],
      ),
    );
  }
}

// ─── Карточка языка ──────────────────────────────────────────
class _LangCard extends StatelessWidget {
  final _Lang lang;
  final bool isSelected;
  final VoidCallback onTap;
  const _LangCard(
      {required this.lang, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? lang.bg : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isSelected ? lang.color : const Color(0xFFD6F5F4),
              width: isSelected ? 2 : 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: lang.color.withValues(alpha: 0.12),
                      blurRadius: 14,
                      offset: const Offset(0, 5),
                    )
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Флаг в круглом контейнере
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: isSelected
                      ? lang.color.withValues(alpha: 0.12)
                      : const Color(0xFFF0FAFA),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child:
                      Text(lang.flag, style: const TextStyle(fontSize: 28)),
                ),
              ),
              const SizedBox(width: 14),

              // Текст
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? lang.color : const Color(0xFF0F1F1E),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      lang.native,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? lang.color.withValues(alpha: 0.65)
                            : const Color(0xFF8EAEAC),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      lang.method,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF8EAEAC),
                      ),
                    ),
                  ],
                ),
              ),

              // Чекбокс
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? lang.color : Colors.transparent,
                  border: Border.all(
                    color: isSelected ? lang.color : const Color(0xFFCBD5E1),
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(Icons.check_rounded,
                        size: 15, color: Colors.white)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Кнопка внизу ────────────────────────────────────────────
class _BottomButton extends StatelessWidget {
  final bool enabled;
  final bool isLoading;
  final VoidCallback onTap;
  final String label;
  const _BottomButton({
    required this.enabled,
    required this.isLoading,
    required this.onTap,
    this.label = 'Начать обучение →',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: enabled ? 1.0 : 0.45,
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: enabled ? onTap : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0ABDB9),
              foregroundColor: Colors.white,
              disabledBackgroundColor: const Color(0xFFD6F5F4),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.5, color: Colors.white),
                  )
                : Text(
                    label,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
          ),
        ),
      ),
    );
  }
}
