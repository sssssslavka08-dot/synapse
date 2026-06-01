import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../services/auth_service.dart';
import '../../presentation/screens/auth/login_screen.dart';

/// Проверка JWT на сервере (после очистки БД старая сессия даёт user_not_found).
class SessionGuard {
  SessionGuard._();

  static bool isStaleSessionError(Object e) {
    if (e is AuthException) {
      return e.statusCode == 403 ||
          e.statusCode == 401 ||
          e.code == 'user_not_found';
    }
    final s = e.toString();
    return s.contains('user_not_found') ||
        s.contains('does not exist') ||
        s.contains('JWT');
  }

  /// true — сессия валидна на сервере Supabase Auth.
  static Future<bool> validateSession() async {
    final auth = Supabase.instance.client.auth;
    if (auth.currentSession == null) return false;
    try {
      final res = await auth.getUser();
      return res.user != null;
    } catch (e) {
      if (isStaleSessionError(e)) {
        await auth.signOut();
      }
      return false;
    }
  }

  static Future<void> forceReauth(
    BuildContext context, {
    String message =
        'Сессия устарела. Войди через Google или email ещё раз.',
  }) async {
    await AuthService().signOut();
    if (!context.mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFFEF4444),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
