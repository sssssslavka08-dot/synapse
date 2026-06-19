import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../services/auth_service.dart';
import '../../widgets/auth_web_shell.dart';
import '../language_select_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/auth/auth_router.dart';
import 'login_screen.dart';

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
  bool _acceptPolicy = false;
  int? _selectedAge;
  final _captchaCtrl = TextEditingController();
  late final int _captchaA;
  late final int _captchaB;

  static const _ageOptions = <(String, int)>[
    ('5–8 лет', 7),
    ('9–12 лет', 11),
    ('13–17 лет', 15),
    ('18+ лет', 25),
  ];

  @override
  void initState() {
    super.initState();
    _captchaA = 2 + DateTime.now().millisecond % 7;
    _captchaB = 1 + DateTime.now().second % 5;
  }

  String get _profileHint {
    if (_selectedAge == null) return '';
    if (_selectedAge! < 13) {
      return 'Детский режим: Нейрончик, игры и упрощённый интерфейс';
    }
    return 'Взрослый режим: статистика, курсы и рейтинг';
  }

  Color get _profileColor =>
      (_selectedAge ?? 18) < 13 ? const Color(0xFFFF6B35) : AppColors.tiffany;

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

  Future<void> _register() async {
    if (_nameCtrl.text.isEmpty || _selectedAge == null) {
      _showError('Заполни все поля');
      return;
    }
    if (!_acceptPolicy) {
      _showError('Примите политику конфиденциальности');
      return;
    }
    final captcha = int.tryParse(_captchaCtrl.text.trim());
    if (captcha != _captchaA + _captchaB) {
      _showError('Неверный ответ на проверку');
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

      final age = _selectedAge!;
      await _authService.registerWithEmail(
        email: email,
        password: _passCtrl.text,
        name: _nameCtrl.text.trim(),
        age: age,
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
      if (result == null && kIsWeb) return;
      if (result != null && mounted) {
        final user = Supabase.instance.client.auth.currentUser;
        if (user != null) {
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
      }
    } catch (e) {
      final msg =
          e.toString().contains('sign_in_canceled') ||
                  e.toString().contains('canceled')
              ? 'Вход через Google отменён'
              : AuthService.googleSignInErrorMessage(e);
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
    _nameCtrl.dispose();
    _passCtrl.dispose();
    _captchaCtrl.dispose();
    super.dispose();
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              Center(
                child: Text(
                  'SYNAPSE',
                  style: TextStyle(
                    fontSize: kIsWeb ? 22 : 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: kIsWeb ? 2 : 0,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: kIsWeb ? 24 : 32),

              const Text('Создать аккаунт',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: AppColors.textPrimary,
                  )),
              const SizedBox(height: 8),
              const Text('AI настроит приложение под тебя',
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

              DropdownButtonFormField<int>(
                value: _selectedAge,
                decoration: _inputDec('Возраст', Icons.person_outline),
                dropdownColor: AppColors.darkCard,
                items: _ageOptions
                    .map((e) => DropdownMenuItem(
                          value: e.$2,
                          child: Text(e.$1),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _selectedAge = v),
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
                      color: AppColors.textSecondary,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePass = !_obscurePass),
                  ),
                ),
              ),

              if (_selectedAge != null) ...[
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
              const SizedBox(height: 16),
              TextField(
                controller: _captchaCtrl,
                keyboardType: TextInputType.number,
                decoration: _inputDec(
                  'Сколько будет $_captchaA + $_captchaB?',
                  Icons.verified_outlined,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: _acceptPolicy,
                    activeColor: AppColors.tiffany,
                    onChanged: (v) => setState(() => _acceptPolicy = v ?? false),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _acceptPolicy = !_acceptPolicy),
                      child: Text.rich(
                        TextSpan(
                          text: 'Я принимаю ',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 13,
                          ),
                          children: const [
                            TextSpan(
                              text: 'политику конфиденциальности',
                              style: TextStyle(
                                color: AppColors.tiffany,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(text: ' и условия использования'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Кнопка регистрации
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _register,
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
                      : const Text('Зарегистрироваться →',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 20),

              const Row(children: [
                Expanded(child: Divider(color: AppColors.darkBorder)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('или войти через',
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 13)),
                ),
                Expanded(child: Divider(color: AppColors.darkBorder)),
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
              const SizedBox(height: 24),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Уже есть аккаунт? ',
                    style: TextStyle(
                        color: AppColors.textSecondary, fontSize: 14)),
                GestureDetector(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(
                          builder: (_) => const LoginScreen())),
                  child: const Text('Войти',
                      style: TextStyle(
                        color: AppColors.tiffany,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      )),
                ),
              ]),
              const SizedBox(height: 16),
            ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final form = _buildForm();
    if (kIsWeb) {
      return AuthWebShell(child: form);
    }
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: form,
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
