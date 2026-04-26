import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import 'home/home_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final String name;
  final int age;

  const LanguageSelectionScreen({
    super.key,
    required this.name,
    required this.age,
  });

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  final _authService = AuthService();
  String? _selectedLang;
  bool _isLoading = false;

  static const _languages = [
    {
      'code': 'en',
      'flag': '🇬🇧',
      'name': 'Английский',
      'subtitle': 'English · Система Александра',
      'color': 0xFF1A56DB,
    },
    {
      'code': 'kz',
      'flag': '🇰🇿',
      'name': 'Казахский',
      'subtitle': 'Қазақша · Разговорный',
      'color': 0xFF059669,
    },
    {
      'code': 'ru',
      'flag': '🇷🇺',
      'name': 'Русский',
      'subtitle': 'Русский · Для иностранцев',
      'color': 0xFFDC2626,
    },
    {
      'code': 'de',
      'flag': '🇩🇪',
      'name': 'Немецкий',
      'subtitle': 'Deutsch · Schritt für Schritt',
      'color': 0xFF92400E,
    },
    {
      'code': 'fr',
      'flag': '🇫🇷',
      'name': 'Французский',
      'subtitle': 'Français · Méthode française',
      'color': 0xFF1D4ED8,
    },
    {
      'code': 'zh',
      'flag': '🇨🇳',
      'name': 'Китайский',
      'subtitle': '中文 · 汉语入门',
      'color': 0xFFB91C1C,
    },
  ];

  Future<void> _confirm() async {
    if (_selectedLang == null) return;
    setState(() => _isLoading = true);
    try {
      await _authService.updateSelectedLanguage(_selectedLang!);
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => HomeScreen(
              name: widget.name,
              age: widget.age,
            ),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ABDB9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset('assets/images/logo.png', width: 26, height: 26),
                    ),
                    const SizedBox(width: 10),
                    const Text('SYNAPSE',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 28),
                  Text(
                    'Привет, ${widget.name}! 👋',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F1F1E),
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Какой язык хочешь изучать?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4D6766),
                    ),
                  ),
                ],
              ),
            ),

            // Список языков
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: _languages.length,
                itemBuilder: (context, i) {
                  final lang = _languages[i];
                  final isSelected = _selectedLang == lang['code'];
                  final color = Color(lang['color'] as int);

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedLang = lang['code'] as String),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.06)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isSelected ? color : const Color(0xFFD6F5F4),
                            width: isSelected ? 2 : 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Флаг
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Center(
                                child: Text(
                                  lang['flag'] as String,
                                  style: const TextStyle(fontSize: 28),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lang['name'] as String,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? color
                                          : const Color(0xFF0F1F1E),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    lang['subtitle'] as String,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? color.withValues(alpha: 0.7)
                                          : const Color(0xFF8EAEAC),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    isSelected ? color : Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? color
                                      : const Color(0xFFD6F5F4),
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? const Icon(Icons.check,
                                      size: 14, color: Colors.white)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            // Кнопка подтверждения
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: (_selectedLang != null && !_isLoading)
                      ? _confirm
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0ABDB9),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: const Color(0xFFD6F5F4),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Начать обучение →',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
