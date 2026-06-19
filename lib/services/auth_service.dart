import 'config/secrets.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final supabase = Supabase.instance.client;

// Web client «SYNAPSE Web» — Supabase Google provider + serverClientId (Android)
const String _googleServerClientId = googleWebClientId;

/// Deep link для Google OAuth на Android (без SHA-1 нативного клиента).
const String _androidOAuthRedirect = 'synapse://login-callback';

/// URL возврата после Google OAuth (web).
String get _oauthRedirectUrl {
  if (kIsWeb) {
    final uri = Uri.base;
    final path = uri.path.endsWith('/') ? uri.path : '${uri.path}/';
    return '${uri.origin}$path';
  }
  return 'https://synapse-nine-brown.vercel.app/flutter/';
}

bool get _useMobileOAuth =>
    !kIsWeb && defaultTargetPlatform == TargetPlatform.android;

class GoogleSignInResult {
  final bool isNewUser;
  final String name;
  final String email;
  final String? photoUrl;

  GoogleSignInResult({
    required this.isNewUser,
    required this.name,
    required this.email,
    this.photoUrl,
  });
}

class AuthService {
  // Текущий пользователь
  User? get currentUser => supabase.auth.currentUser;
  Stream<AuthState> get authStateChanges => supabase.auth.onAuthStateChange;

  // ── РЕГИСТРАЦИЯ ПО EMAIL ──────────────────────
  Future<AuthResponse> registerWithEmail({
    required String email,
    required String password,
    required String name,
    required int age,
    DateTime? birthDate,
  }) async {
    AuthResponse result;

    try {
      result = await supabase.auth.signUp(
        email: email,
        password: password,
        data: {'name': name, 'age': age},
      );

      // Если сессии нет — пробуем войти (подтверждение отключено, но пользователь уже существует)
      if (result.session == null) {
        result = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      }
    } on AuthException catch (e) {
      // Пользователь уже есть — просто логинимся
      if (e.message.contains('already registered') ||
          e.message.contains('already been registered') ||
          e.statusCode == '422') {
        result = await supabase.auth.signInWithPassword(
          email: email,
          password: password,
        );
      } else {
        rethrow;
      }
    }

    final uid = result.user?.id;
    if (uid != null) {
      await _saveUserProfile(
          uid: uid, name: name, age: age, email: email, birthDate: birthDate);
    }
    return result;
  }

  // ── ВХОД ПО EMAIL ────────────────────────────
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> resetPasswordForEmail(String email) async {
    await supabase.auth.resetPasswordForEmail(
      email.trim(),
      redirectTo: _oauthRedirectUrl,
    );
  }

  // ── ВХОД ЧЕРЕЗ GOOGLE ────────────────────────
  Future<GoogleSignInResult?> signInWithGoogle() async {
    if (kIsWeb || _useMobileOAuth) {
      // Web и Android: OAuth через браузер (Android — deep link, без SHA-1 в GCP).
      await supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: kIsWeb ? _oauthRedirectUrl : _androidOAuthRedirect,
        authScreenLaunchMode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
      );
      if (kIsWeb) return null;
      final user = supabase.auth.currentUser;
      if (user == null) return null;
      return _resultFromAuthUser(user);
    }

    // iOS: нативный Google Sign-In
    final googleSignIn = GoogleSignIn(
      serverClientId: _googleServerClientId,
    );
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final idToken = googleAuth.idToken;
    if (idToken == null) {
      throw Exception(
        'Google: не удалось получить idToken. Проверь serverClientId и настройки OAuth.',
      );
    }

    final response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: googleAuth.accessToken,
    );

    if (response.user == null) return null;

    final existing = await supabase
        .from('users')
        .select()
        .eq('id', response.user!.id)
        .maybeSingle();

    return GoogleSignInResult(
      isNewUser: existing == null,
      name: googleUser.displayName ?? existing?['name'] ?? 'Пользователь',
      email: googleUser.email,
      photoUrl: googleUser.photoUrl,
    );
  }

  Future<GoogleSignInResult> _resultFromAuthUser(User user) async {
    final existing = await supabase
        .from('users')
        .select()
        .eq('id', user.id)
        .maybeSingle();

    final meta = user.userMetadata ?? {};
    return GoogleSignInResult(
      isNewUser: existing == null,
      name: existing?['name'] as String? ??
          meta['full_name'] as String? ??
          meta['name'] as String? ??
          'Пользователь',
      email: user.email ?? existing?['email'] as String? ?? '',
      photoUrl: meta['avatar_url'] as String? ??
          existing?['photo_url'] as String?,
    );
  }

  /// Сообщение об ошибке Google-входа для UI.
  static String googleSignInErrorMessage(Object e) {
    final s = e.toString().toLowerCase();
    if (s.contains('sign_in_canceled') || s.contains('canceled')) {
      return 'Вход через Google отменён';
    }
    if (s.contains('apiexception: 10') ||
        s.contains('developer_error') ||
        s.contains('idtoken')) {
      return 'Ошибка настройки Google OAuth. Добавь SHA-1 в Google Cloud или обнови приложение.';
    }
    if (s.contains('network') || s.contains('socket')) {
      return 'Нет сети. Проверь интернет и попробуй снова.';
    }
    return 'Ошибка Google входа: ${e.toString().replaceFirst('Exception: ', '').replaceFirst('AuthException: ', '')}';
  }

  // ── СОХРАНИТЬ ПРОФИЛЬ GOOGLE ─────────────────
  Future<void> saveGoogleProfile({
    required String name,
    required String email,
    required int age,
    String? photoUrl,
  }) async {
    final uid = currentUser?.id;
    if (uid == null) return;
    final existing = await supabase
        .from('users')
        .select('coins, xp, streak')
        .eq('id', uid)
        .maybeSingle();

    await supabase.from('users').upsert({
      'id': uid,
      'name': name,
      'email': email,
      'age': age,
      if (photoUrl != null) 'photo_url': photoUrl,
      'streak': existing?['streak'] ?? 1,
      'xp': existing?['xp'] ?? 0,
      'coins': existing?['coins'] ?? 500,
      'selected_language': '',
      'first_login': false,
      'subscription_type': 'free',
      'last_active_at': DateTime.now().toIso8601String(),
    });
  }

  // ── ВЫХОД ────────────────────────────────────
  Future<void> signOut() async {
    try {
      await GoogleSignIn(serverClientId: _googleServerClientId).signOut();
    } catch (_) {}
    await supabase.auth.signOut();
  }

  // ── СОХРАНИТЬ ПРОФИЛЬ В SUPABASE ─────────────
  Future<void> _saveUserProfile({
    required String uid,
    required String name,
    required int age,
    required String email,
    DateTime? birthDate,
  }) async {
    try {
      await supabase.from('users').upsert({
        'id': uid,
        'name': name,
        'age': age,
        'email': email,
        if (birthDate != null)
          'birth_date': birthDate.toIso8601String().split('T').first,
        'streak': 0,
        'xp': 0,
        'coins': 0,
        'words_learned': 0,
        'selected_language': '',
        'subscription_type': 'free',
        'created_at': DateTime.now().toIso8601String(),
        'last_active_at': DateTime.now().toIso8601String(),
      });
    } catch (_) {
      // таблица ещё не создана — продолжаем без сохранения профиля
    }
  }

  // ── ПОЛУЧИТЬ ДАННЫЕ ПОЛЬЗОВАТЕЛЯ ─────────────
  Future<Map<String, dynamic>?> getUserData() async {
    final uid = currentUser?.id;
    if (uid == null) return null;
    try {
      final data = await supabase
          .from('users')
          .select()
          .eq('id', uid)
          .maybeSingle();
      return data ?? _defaultProfile(uid);
    } catch (_) {
      return _defaultProfile(uid);
    }
  }

  Map<String, dynamic> _defaultProfile(String uid) => {
    'id': uid,
    'name': currentUser?.email?.split('@').first ?? 'Пользователь',
    'age': 13,
    'xp': 0,
    'streak': 0,
    'words_learned': 0,
    'selected_language': '',
    'subscription_type': 'free',
  };

  // ── ОБНОВИТЬ ЯЗЫК ОБУЧЕНИЯ ───────────────────
  Future<void> updateSelectedLanguage(String langCode) async {
    final uid = currentUser?.id;
    if (uid == null) return;
    await supabase.from('users').update({
      'selected_language': langCode,
      'last_active_at': DateTime.now().toIso8601String(),
    }).eq('id', uid);
  }

  // ── ОБНОВИТЬ ПОДПИСКУ ────────────────────────
  Future<void> updateSubscription(String plan) async {
    final uid = currentUser?.id;
    if (uid == null) return;
    await supabase.from('users').update({
      'subscription_type': plan,
    }).eq('id', uid);
  }

  // ── ОБНОВИТЬ ПРОГРЕСС ────────────────────────
  Future<void> updateProgress({
    required int xpToAdd,
    required int wordsLearned,
  }) async {
    final uid = currentUser?.id;
    if (uid == null) return;
    final data = await getUserData();
    if (data == null) return;

    await supabase.from('users').update({
      'xp': (data['xp'] ?? 0) + xpToAdd,
      'words_learned': (data['words_learned'] ?? 0) + wordsLearned,
      'last_active_at': DateTime.now().toIso8601String(),
    }).eq('id', uid);
  }

  // ── ОБНОВИТЬ STREAK ──────────────────────────
  Future<void> updateStreak() async {
    final uid = currentUser?.id;
    if (uid == null) return;
    final data = await getUserData();
    if (data == null) return;

    await supabase.from('users').update({
      'streak': (data['streak'] ?? 0) + 1,
    }).eq('id', uid);
  }
}
