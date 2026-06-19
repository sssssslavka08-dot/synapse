import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../presentation/screens/home/home_screen.dart';
import '../../presentation/screens/language_select_screen.dart';
import '../../presentation/screens/onboarding/welcome_screen.dart';

/// Куда направить пользователя после успешной авторизации.
class AuthRouter {
  AuthRouter._();

  static bool isGoogleUser(User user) {
    final identities = user.identities;
    if (identities != null && identities.isNotEmpty) {
      if (identities.any((i) => i.provider == 'google')) return true;
    }
    final provider = user.appMetadata['provider'] as String?;
    if (provider == 'google') return true;
    return false;
  }

  static bool needsLanguage(Map<String, dynamic>? data) {
    final lang = data?['selected_language'] as String?;
    return lang == null || lang.trim().isEmpty;
  }

  static Future<Map<String, dynamic>?> loadOrCreateProfile(User user) async {
    final client = Supabase.instance.client;
    try {
      var data = await client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle()
          .timeout(const Duration(seconds: 8));

      if (data != null) return data;

      final name = user.userMetadata?['name'] as String? ??
          user.userMetadata?['full_name'] as String? ??
          user.email?.split('@').first ??
          'Пользователь';

      await client.from('users').upsert({
        'id': user.id,
        'name': name,
        'email': user.email,
        'age': 13,
        'coins': 500,
        'streak': 1,
        'xp': 0,
        'subscription_type': 'free',
        'selected_language': '',
        'first_login': false,
        'created_at': DateTime.now().toIso8601String(),
        'last_active_at': DateTime.now().toIso8601String(),
      });

      return await client
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();
    } catch (_) {
      return null;
    }
  }

  static Widget destinationForUser({
    required User user,
    required Map<String, dynamic>? profile,
  }) {
    final name = profile?['name'] as String? ??
        user.userMetadata?['name'] as String? ??
        user.userMetadata?['full_name'] as String? ??
        user.email?.split('@').first ??
        'Пользователь';
    final age = profile?['age'] as int? ?? 13;
    final effectiveAge = age >= 5 ? age : 13;

    if (needsLanguage(profile)) {
      return LanguageSelectScreen(name: name, age: effectiveAge);
    }

    if (!isGoogleUser(user) && (profile?['first_login'] as bool? ?? true)) {
      return WelcomeScreen(name: name, age: effectiveAge);
    }

    return HomeScreen(name: name, age: effectiveAge);
  }
}
