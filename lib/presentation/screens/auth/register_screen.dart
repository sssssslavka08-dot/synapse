import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../language_select_screen.dart';
import '../home/home_screen.dart';
import 'login_screen.dart';
import 'google_setup_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

enum AuthMethod { phone, email }

class _RegisterScreenState extends State<RegisterScreen> {
  final _authService = AuthService();
  AuthMethod _method = AuthMethod.phone;
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;
  DateTime? _birthDate;

  int get _age {
    if (_birthDate == null) return 0;
    final now = DateTime.now();
    int age = now.year - _birthDate!.year;
    if (now.month < _birthDate!.month ||
        (now.month == _birthDate!.month && now.day < _birthDate!.day)) {
      age--;
    }
    return age;
  }

  String get _profileHint {
    if (_birthDate == null) return '';
    final age = _age;
    if (age < 13) return '🤖 Детский режим: Нейрончик + мини-игры + яркий UI';
    return '📊 Взрослый режим: граф знаний + детальная статистика';
  }

  Color get _profileColor =>
      _age < 13 ? const Color(0xFFFF6B35) : const Color(0xFF0ABDB9);

  Future<void> _pickBirthDate() async {
    final now = DateTime.now();
    final initial = _birthDate ?? DateTime(now.year - 10, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 100),
      lastDate: DateTime(now.year - 3),
      locale: const Locale('ru'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF0ABDB9),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF0F1F1E),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) setState(() => _birthDate = picked);
  }

  void _onPhoneChanged(String v) {
    final digits = v.replaceAll(RegExp(r'[^0-9]'), '');
    final d = digits.startsWith('7')
        ? digits
        : '7${digits.replaceAll(RegExp(r'^7'), '')}';

    String f = '';
    if (d.length >= 1) f = '+7';
    if (d.length >= 2) f += ' (${d.substring(1, d.length.clamp(1, 4))}';
    if (d.length >= 4) f += ') ${d.substring(4, d.length.clamp(4, 7))}';
    if (d.length >= 7) f += '-${d.substring(7, d.length.clamp(7, 9))}';
    if (d.length >= 9) f += '-${d.substring(9, d.length.clamp(9, 11))}';

    if (f != _phoneCtrl.text) {
      _phoneCtrl.value = TextEditingValue(
        text: f,
        selection: TextSelection.collapsed(offset: f.length),
      );
    }
  }

  InputDecoration _inputDec(String label, IconData icon, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: const Color(0xFF8EAEAC)),
      filled: true,
      fillColor: Colors.white,
      labelStyle: const TextStyle(color: Color(0xFF8EAEAC)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD6F5F4)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFD6F5F4)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF0ABDB9), width: 2),
      ),
    );
  }

  Future<void> _register() async {
    if (_nameCtrl.text.isEmpty || _birthDate == null) {
      _showError('Заполни все поля');
      return;
    }
    if (_method == AuthMethod.email && _emailCtrl.text.isEmpty) {
      _showError('Введи email');
      return;
    }
    if (_method == AuthMethod.phone && _phoneCtrl.text.isEmpty) {
      _showError('Введи номер телефона');
      return;
    }
    if (_passCtrl.text.length < 6) {
      _showError('Пароль минимум 6 символов');
      return;
    }

    setState(() => _isLoading = true);
    try {
      final email = _method == AuthMethod.email
          ? _emailCtrl.text.trim()
          : '${_phoneCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')}@synapse.kz';

      final age = _age;
      await _authService.registerWithEmail(
        email: email,
        password: _passCtrl.text,
        name: _nameCtrl.text.trim(),
        age: age,
        birthDate: _birthDate,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LanguageSelectScreen(
              name: _nameCtrl.text,
              age: age,
            ),
          ),
        );
      }
    } catch (e) {
      String msg = 'Ошибка регистрации';
      final err = e.toString().toLowerCase();
      if (err.contains('already registered') ||
          err.contains('already been registered')) {
        msg = 'Аккаунт уже существует. Попробуй войти.';
      } else if (err.contains('weak_password') || err.contains('password')) {
        msg = 'Пароль слишком простой (минимум 6 символов)';
      } else if (err.contains('invalid') && err.contains('email')) {
        msg = 'Неверный формат email';
      } else if (err.contains('network') || err.contains('connection')) {
        msg = 'Нет подключения к интернету';
      } else {
        msg = 'Ошибка: ${e.toString().replaceAll('AuthException: ', '')}';
      }
      _showError(msg);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _googleSignIn() async {
    setState(() => _isLoading = true);
    try {
      final result = await _authService.signInWithGoogle();
      if (result != null && mounted) {
        if (result.isNewUser) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => GoogleSetupScreen(
                googleName: result.name,
                googleEmail: result.email,
                googlePhotoUrl: result.photoUrl,
                isNewUser: true,
              ),
            ),
          );
        } else {
          final data = await _authService.getUserData();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => HomeScreen(
                name: data?['name'] ?? result.name,
                age: data?['age'] ?? 13,
              ),
            ),
          );
        }
      }
    } catch (e) {
      final msg =
          e.toString().contains('sign_in_canceled') ||
                  e.toString().contains('canceled')
              ? 'Вход через Google отменён'
              : 'Ошибка Google входа. Проверь интернет.';
      _showError(msg);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _nameCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              Row(children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0ABDB9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.hub_rounded,
                      color: Colors.white, size: 22),
                ),
                const SizedBox(width: 10),
                const Text('SYNAPSE',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 32),

              const Text('Создать аккаунт',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F1F1E),
                  )),
              const SizedBox(height: 8),
              const Text('AI настроит приложение под тебя',
                  style: TextStyle(color: Color(0xFF4D6766), fontSize: 15)),
              const SizedBox(height: 28),

              // Переключатель телефон/email
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8FAFA),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  _MethodTab(
                    label: '📱 Телефон',
                    selected: _method == AuthMethod.phone,
                    onTap: () => setState(() => _method = AuthMethod.phone),
                  ),
                  _MethodTab(
                    label: '✉️ Email',
                    selected: _method == AuthMethod.email,
                    onTap: () => setState(() => _method = AuthMethod.email),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              if (_method == AuthMethod.phone)
                TextField(
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                  onChanged: _onPhoneChanged,
                  decoration: _inputDec(
                    'Номер телефона',
                    Icons.phone_outlined,
                    hint: '+7 (___) ___-__-__',
                  ),
                )
              else
                TextField(
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _inputDec(
                      'Электронная почта', Icons.email_outlined),
                ),
              const SizedBox(height: 14),

              // Имя
              TextField(
                controller: _nameCtrl,
                decoration: _inputDec('Имя', Icons.person_outline),
              ),
              const SizedBox(height: 14),

              // Дата рождения — picker
              GestureDetector(
                onTap: _pickBirthDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: _birthDate != null
                          ? const Color(0xFF0ABDB9)
                          : const Color(0xFFD6F5F4),
                      width: _birthDate != null ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.cake_outlined,
                          color: _birthDate != null
                              ? const Color(0xFF0ABDB9)
                              : const Color(0xFF8EAEAC),
                          size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _birthDate != null
                              ? _formatDate(_birthDate!)
                              : 'Дата рождения',
                          style: TextStyle(
                            fontSize: 16,
                            color: _birthDate != null
                                ? const Color(0xFF0F1F1E)
                                : const Color(0xFF8EAEAC),
                          ),
                        ),
                      ),
                      if (_birthDate != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _profileColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${_age} лет',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: _profileColor,
                            ),
                          ),
                        )
                      else
                        const Icon(Icons.calendar_today_outlined,
                            color: Color(0xFF8EAEAC), size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Пароль
              TextField(
                controller: _passCtrl,
                obscureText: _obscurePass,
                decoration: _inputDec('Пароль', Icons.lock_outline).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: const Color(0xFF8EAEAC),
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
              ),

              // Превью режима
              if (_birthDate != null) ...[
                const SizedBox(height: 14),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: _profileColor.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: _profileColor.withValues(alpha: 0.25)),
                  ),
                  child: Text(_profileHint,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _profileColor,
                      )),
                ),
              ],
              const SizedBox(height: 28),

              // Кнопка регистрации
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
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
                      : const Text('Зарегистрироваться →',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 20),

              const Row(children: [
                Expanded(child: Divider(color: Color(0xFFD6F5F4))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('или войти через',
                      style: TextStyle(
                          color: Color(0xFF8EAEAC), fontSize: 13)),
                ),
                Expanded(child: Divider(color: Color(0xFFD6F5F4))),
              ]),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _googleSignIn,
                  icon: const Icon(Icons.g_mobiledata_rounded,
                      color: Color(0xFFEA4335), size: 26),
                  label: const Text('Войти через Google',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F1F1E),
                      )),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFD6F5F4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Уже есть аккаунт? ',
                    style: TextStyle(
                        color: Color(0xFF8EAEAC), fontSize: 14)),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const LoginScreen())),
                  child: const Text('Войти',
                      style: TextStyle(
                        color: Color(0xFF0ABDB9),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ]),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _MethodTab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _MethodTab(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    )
                  ]
                : null,
          ),
          child: Text(label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: selected
                    ? const Color(0xFF0ABDB9)
                    : const Color(0xFF8EAEAC),
              )),
        ),
      ),
    );
  }
}
