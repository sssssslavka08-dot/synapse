import 'package:flutter/material.dart';
import '../../../services/auth_service.dart';
import '../home/home_screen.dart';
import 'register_screen.dart';
import 'google_setup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum LoginMethod { phone, email }

class _LoginScreenState extends State<LoginScreen> {
  final _authService = AuthService();
  LoginMethod _method = LoginMethod.phone;
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _isLoading = false;

  // Маска телефона
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

  Future<void> _login() async {
    if (_passCtrl.text.isEmpty) {
      _showError('Введи пароль');
      return;
    }
    if (_method == LoginMethod.email && _emailCtrl.text.isEmpty) {
      _showError('Введи email');
      return;
    }
    if (_method == LoginMethod.phone && _phoneCtrl.text.isEmpty) {
      _showError('Введи номер телефона');
      return;
    }

    setState(() => _isLoading = true);
    try {
      // Формируем email так же как при регистрации
      final email = _method == LoginMethod.email
          ? _emailCtrl.text.trim()
          : '${_phoneCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')}@synapse.kz';

      await _authService.signInWithEmail(
        email: email,
        password: _passCtrl.text,
      );

      final data = await _authService.getUserData();
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(
              name: data?['name'] ?? 'Пользователь',
              age: data?['age'] ?? 13,
            ),
          ),
        );
      }
    } catch (e) {
      String msg = 'Неверный номер или пароль';
      if (e.toString().contains('invalid_credentials') ||
          e.toString().contains('Invalid login')) {
        msg = 'Неверный номер/email или пароль';
      } else if (e.toString().contains('Email not confirmed')) {
        msg = 'Аккаунт не подтверждён. Попроси администратора или пересоздай аккаунт.';
      }
      _showError(msg);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _googleLogin() async {
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
      final msg = e.toString().contains('sign_in_canceled') ||
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

  @override
  void dispose() {
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
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

              // Логотип
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
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 48),

              const Text('Добро пожаловать!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: Color(0xFF0F1F1E),
                  )),
              const SizedBox(height: 8),
              const Text('Войди в свой аккаунт',
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
                    selected: _method == LoginMethod.phone,
                    onTap: () => setState(() => _method = LoginMethod.phone),
                  ),
                  _MethodTab(
                    label: '✉️ Email',
                    selected: _method == LoginMethod.email,
                    onTap: () => setState(() => _method = LoginMethod.email),
                  ),
                ]),
              ),
              const SizedBox(height: 20),

              // Поле телефон или email
              if (_method == LoginMethod.phone)
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
                  decoration: _inputDec('Email', Icons.email_outlined),
                ),
              const SizedBox(height: 14),

              // Пароль
              TextField(
                controller: _passCtrl,
                obscureText: _obscurePass,
                decoration: _inputDec('Пароль', Icons.lock_outline).copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePass ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF8EAEAC),
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Кнопка войти
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
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
                      : const Text('Войти →',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 20),

              // Разделитель
              const Row(children: [
                Expanded(child: Divider(color: Color(0xFFD6F5F4))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('или',
                      style: TextStyle(color: Color(0xFF8EAEAC), fontSize: 13)),
                ),
                Expanded(child: Divider(color: Color(0xFFD6F5F4))),
              ]),
              const SizedBox(height: 20),

              // Google
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: _isLoading ? null : _googleLogin,
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
              const SizedBox(height: 32),

              // Нет аккаунта
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Нет аккаунта? ',
                    style: TextStyle(color: Color(0xFF8EAEAC), fontSize: 14)),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: const Text('Зарегистрироваться',
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
