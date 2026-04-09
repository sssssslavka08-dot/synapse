import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

final supabase = Supabase.instance.client;

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
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
      data: {'name': name, 'age': age},
    );

    if (response.user != null) {
      await _saveUserProfile(
        uid: response.user!.id,
        name: name,
        age: age,
        email: email,
      );
    }
    return response;
  }

  // ── ВХОД ПО EMAIL ────────────────────────────
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // ── ВХОД ЧЕРЕЗ GOOGLE ────────────────────────
  Future<GoogleSignInResult?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final response = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken,
    );

    if (response.user == null) return null;

    // Проверяем, новый ли пользователь
    final existing = await supabase
        .from('users')
        .select()
        .eq('id', response.user!.id)
        .maybeSingle();

    final isNew = existing == null;

    return GoogleSignInResult(
      isNewUser: isNew,
      name: googleUser.displayName ?? existing?['name'] ?? 'Пользователь',
      email: googleUser.email,
      photoUrl: googleUser.photoUrl,
    );
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
    await supabase.from('users').upsert({
      'id': uid,
      'name': name,
      'email': email,
      'age': age,
      if (photoUrl != null) 'photo_url': photoUrl,
      'streak': 0,
      'xp': 0,
      'words_learned': 0,
      'selected_language': '',
      'subscription_type': 'free',
      'created_at': DateTime.now().toIso8601String(),
      'last_active_at': DateTime.now().toIso8601String(),
    });
  }

  // ── ВЫХОД ────────────────────────────────────
  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await supabase.auth.signOut();
  }

  // ── СОХРАНИТЬ ПРОФИЛЬ В SUPABASE ─────────────
  Future<void> _saveUserProfile({
    required String uid,
    required String name,
    required int age,
    required String email,
  }) async {
    try {
      await supabase.from('users').upsert({
        'id': uid,
        'name': name,
        'age': age,
        'email': email,
        'streak': 0,
        'xp': 0,
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
