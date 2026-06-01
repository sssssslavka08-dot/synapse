import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/auth/session_guard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../services/auth_service.dart';
import '../language_select_screen.dart';
import '../home/home_screen.dart';

// ═══════════════════════════════════════════════════════════
//  GoogleSetupScreen
//  Показывается после первого входа через Google.
//  Отображает данные из Google аккаунта (имя, email, фото),
//  просит указать возраст и создать пароль,
//  чтобы можно было войти и через email.
// ═══════════════════════════════════════════════════════════
class GoogleSetupScreen extends StatefulWidget {
  final String googleName;
  final String googleEmail;
  final String? googlePhotoUrl;
  final bool isNewUser;

  const GoogleSetupScreen({
    super.key,
    required this.googleName,
    required this.googleEmail,
    this.googlePhotoUrl,
    required this.isNewUser,
  });

  @override
  State<GoogleSetupScreen> createState() => _GoogleSetupScreenState();
}

class _GoogleSetupScreenState extends State<GoogleSetupScreen>
    with SingleTickerProviderStateMixin {
  final _authService = AuthService();
  final _ageCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _obscurePass = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;
  int _age = 0;

  late AnimationController _fadeCtrl;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));

    // Если уже существующий пользователь — просто переходим на главную
    if (!widget.isNewUser) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goHome());
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _ensureValidSession());
  }

  Future<void> _ensureValidSession() async {
    if (await SessionGuard.validateSession()) return;
    if (!mounted) return;
    await SessionGuard.forceReauth(context);
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _ageCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _goHome() async {
    if (!await SessionGuard.validateSession()) {
      if (!mounted) return;
      await SessionGuard.forceReauth(context);
      return;
    }
    await _authService.saveGoogleProfile(
      name: widget.googleName,
      email: widget.googleEmail,
      age: _age > 0 ? _age : 13,
      photoUrl: widget.googlePhotoUrl,
    );
    final data = await _authService.getUserData();
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomeScreen(
          name: data?['name'] ?? widget.googleName,
          age: data?['age'] ?? 13,
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_age < 5 || _age > 100) {
      _showError('Укажи корректный возраст');
      return;
    }
    if (_passCtrl.text.length < 6) {
      _showError('Пароль минимум 6 символов');
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      _showError('Пароли не совпадают');
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (!await SessionGuard.validateSession()) {
        if (!mounted) return;
        await SessionGuard.forceReauth(context);
        return;
      }

      // Сначала профиль — пароль опционален для Google
      await _authService.saveGoogleProfile(
        name: widget.googleName,
        email: widget.googleEmail,
        age: _age,
        photoUrl: widget.googlePhotoUrl,
      );

      // Привязываем email/password (может быть недоступно на части провайдеров)
      try {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(password: _passCtrl.text),
        );
      } on AuthException catch (e) {
        if (!SessionGuard.isStaleSessionError(e)) {
          // Продолжаем без пароля — вход через Google остаётся
        } else {
          rethrow;
        }
      }

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LanguageSelectScreen(
            name: widget.googleName,
            age: _age,
          ),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } catch (e) {
      if (SessionGuard.isStaleSessionError(e)) {
        if (mounted) await SessionGuard.forceReauth(context);
      } else {
        _showError('Ошибка: ${e.toString().replaceAll('Exception: ', '')}');
      }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // ── Логотип ──────────────────────────────────
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 32),

                  // ── Заголовок ─────────────────────────────────
                  const Text('Почти готово!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        color: AppColors.textPrimary,
                      )),
                  const SizedBox(height: 8),
                  const Text('Мы получили твои данные из Google',
                      style:
                          TextStyle(color: Color(0xFF4D6766), fontSize: 15)),
                  const SizedBox(height: 28),

                  // ── Google профиль карточка ───────────────────
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.darkBorder),
                    ),
                    child: Row(
                      children: [
                        // Аватар из Google
                        _GoogleAvatar(
                          photoUrl: widget.googlePhotoUrl,
                          name: widget.googleName,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Icon(Icons.verified,
                                    color: AppColors.tiffany, size: 16),
                                const SizedBox(width: 5),
                                const Text('Google аккаунт',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.tiffany,
                                    )),
                              ]),
                              const SizedBox(height: 5),
                              Text(
                                widget.googleName,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 3),
                              Text(
                                widget.googleEmail,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textSecondary,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Разделитель ───────────────────────────────
                  const Row(children: [
                    Expanded(child: Divider(color: AppColors.darkBorder)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text('Укажи дополнительные данные',
                          style: TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                    ),
                    Expanded(child: Divider(color: AppColors.darkBorder)),
                  ]),
                  const SizedBox(height: 24),

                  // ── Возраст ───────────────────────────────────
                  TextField(
                    controller: _ageCtrl,
                    keyboardType: TextInputType.number,
                    onChanged: (v) =>
                        setState(() => _age = int.tryParse(v) ?? 0),
                    decoration: _inputDec(
                      'Твой возраст',
                      Icons.cake_outlined,
                      hint: 'Влияет на режим обучения',
                    ),
                  ),

                  // Подсказка режима
                  if (_age >= 5) ...[
                    const SizedBox(height: 10),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: (_age <= 12
                                ? AppColors.tiffany
                                : AppColors.textSecondary)
                            .withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (_age <= 12
                                  ? AppColors.tiffany
                                  : AppColors.darkBorder)
                              .withValues(alpha: 0.5),
                        ),
                      ),
                      child: Text(
                        _age <= 12
                            ? '👶 Детский режим: Нейрончик + мини-игры'
                            : '📊 Взрослый режим: граф знаний + статистика',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: _age <= 12
                              ? AppColors.tiffany
                              : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 14),

                  // ── Пароль ────────────────────────────────────
                  TextField(
                    controller: _passCtrl,
                    obscureText: _obscurePass,
                    decoration:
                        _inputDec('Создай пароль', Icons.lock_outline)
                            .copyWith(
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
                  const SizedBox(height: 14),

                  // ── Подтверждение пароля ──────────────────────
                  TextField(
                    controller: _confirmCtrl,
                    obscureText: _obscureConfirm,
                    decoration: _inputDec(
                            'Подтверди пароль', Icons.lock_outline)
                        .copyWith(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: AppColors.textSecondary,
                        ),
                        onPressed: () => setState(
                            () => _obscureConfirm = !_obscureConfirm),
                      ),
                      // Показываем галочку если пароли совпадают
                      suffixIconConstraints:
                          const BoxConstraints(minWidth: 48),
                    ),
                  ),

                  // Статус совпадения паролей
                  if (_confirmCtrl.text.isNotEmpty &&
                      _passCtrl.text.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(children: [
                      Icon(
                        _passCtrl.text == _confirmCtrl.text
                            ? Icons.check_circle_rounded
                            : Icons.cancel_rounded,
                        size: 16,
                        color: _passCtrl.text == _confirmCtrl.text
                            ? const Color(0xFF10B981)
                            : const Color(0xFFEF4444),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _passCtrl.text == _confirmCtrl.text
                            ? 'Пароли совпадают'
                            : 'Пароли не совпадают',
                        style: TextStyle(
                          fontSize: 13,
                          color: _passCtrl.text == _confirmCtrl.text
                              ? const Color(0xFF10B981)
                              : const Color(0xFFEF4444),
                        ),
                      ),
                    ]),
                  ],
                  const SizedBox(height: 28),

                  // Инфо-блок
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.darkCard,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info_outline_rounded,
                            color: AppColors.tiffany, size: 18),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'После этого ты сможешь войти как через Google, так и по email + пароль',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF4D6766),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Кнопка ────────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tiffany,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white)
                          : const Text('Продолжить →',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Пропустить создание пароля
                  Center(
                    child: TextButton(
                      onPressed: _isLoading ? null : _goHome,
                      child: const Text(
                        'Пропустить — войду только через Google',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Виджет аватара из Google ────────────────────────────────
class _GoogleAvatar extends StatelessWidget {
  final String? photoUrl;
  final String name;
  const _GoogleAvatar({required this.photoUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    if (photoUrl != null && photoUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Image.network(
          photoUrl!,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _initials(),
        ),
      );
    }
    return _initials();
  }

  Widget _initials() {
    final letters = name.trim().split(' ').take(2).map((w) =>
        w.isNotEmpty ? w[0].toUpperCase() : '').join();
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.tiffany,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Center(
        child: Text(
          letters.isNotEmpty ? letters : '?',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
