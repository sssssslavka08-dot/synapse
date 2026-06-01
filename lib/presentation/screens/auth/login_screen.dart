import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/auth/auth_router.dart';
import '../../../core/auth/oauth_recovery.dart';
import '../../../core/constants/app_colors.dart';
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
  StreamSubscription<AuthState>? _authSub;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _authSub = Supabase.instance.client.auth.onAuthStateChange.listen((state) {
        if (state.event == AuthChangeEvent.signedIn &&
            state.session != null &&
            mounted) {
          _navigateAfterOAuth();
        }
      });
      if (OAuthRecovery.hasCallback(Uri.base)) {
        Future.microtask(_navigateAfterOAuth);
      }
    }
  }

  Future<void> _navigateAfterOAuth() async {
    final session = await OAuthRecovery.waitForSession(
      timeout: const Duration(seconds: 5),
    );
    final user = session?.user;
    if (user == null || !mounted) return;

    final profile = await AuthRouter.loadOrCreateProfile(user);
    if (!mounted) return;

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => AuthRouter.destinationForUser(
          user: user,
          profile: profile,
        ),
      ),
      (_) => false,
    );
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

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
      prefixIcon: Icon(icon, color: AppColors.textSecondary),
      filled: true,
      fillColor: AppColors.darkCard,
      labelStyle: const TextStyle(color: AppColors.textSecondary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.tiffany, width: 2),
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
    } on AuthException catch (e) {
      _showError(_authErrorMessage(e));
    } catch (e) {
      final s = e.toString().toLowerCase();
      if (s.contains('network') || s.contains('socket') || s.contains('connection')) {
        _showError('Нет подключения к интернету');
      } else {
        _showError('Не удалось войти. Попробуй ещё раз или через Google.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _googleLogin() async {
    setState(() => _isLoading = true);
    try {
      final result = await _authService.signInWithGoogle();
      if (result == null && kIsWeb) {
        // Web: редирект на Google — не показываем ошибку
        return;
      }
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
      _showError(AuthService.googleSignInErrorMessage(e));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String _authErrorMessage(AuthException e) {
    final code = e.code ?? '';
    if (code == 'invalid_credentials' ||
        e.message.toLowerCase().contains('invalid login')) {
      return _method == LoginMethod.email
          ? 'Неверный email или пароль'
          : 'Неверный номер или пароль';
    }
    if (code == 'email_not_confirmed' ||
        e.message.toLowerCase().contains('email not confirmed')) {
      return 'Email не подтверждён. Проверь почту или зарегистрируйся заново.';
    }
    if (code == 'user_not_found') {
      return 'Аккаунт не найден. Зарегистрируйся заново.';
    }
    return e.message.isNotEmpty ? e.message : 'Ошибка входа ($code)';
  }

  Future<void> _resetPassword() async {
    final email = _method == LoginMethod.email
        ? _emailCtrl.text.trim()
        : '${_phoneCtrl.text.replaceAll(RegExp(r'[^0-9]'), '')}@synapse.kz';
    if (email.isEmpty || !email.contains('@')) {
      _showError('Сначала введи email (вкладка Email)');
      return;
    }
    setState(() => _isLoading = true);
    try {
      await _authService.resetPasswordForEmail(email);
      if (mounted) {
        _showMessage('Ссылка для сброса пароля отправлена на $email', success: true);
      }
    } on AuthException catch (e) {
      _showError(e.message);
    } catch (_) {
      _showError('Не удалось отправить письмо. Проверь email.');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor:
            success ? const Color(0xFF10B981) : const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showError(String msg) => _showMessage(msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
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
                    color: AppColors.tiffany,
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
                    color: AppColors.textPrimary,
                  )),
              const SizedBox(height: 8),
              const Text('Войди в свой аккаунт',
                  style: TextStyle(color: Color(0xFF4D6766), fontSize: 15)),
              const SizedBox(height: 28),

              // Переключатель телефон/email
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
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
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _isLoading ? null : _resetPassword,
                  child: const Text(
                    'Забыли пароль?',
                    style: TextStyle(color: AppColors.tiffany, fontSize: 13),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Кнопка войти
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tiffany,
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
                Expanded(child: Divider(color: AppColors.darkBorder)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('или',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ),
                Expanded(child: Divider(color: AppColors.darkBorder)),
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
                        color: AppColors.textPrimary,
                      )),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.darkBorder),
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
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: const Text('Зарегистрироваться',
                      style: TextStyle(
                        color: AppColors.tiffany,
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
                    ? AppColors.tiffany
                    : AppColors.textSecondary,
              )),
        ),
      ),
    );
  }
}
