import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Глобальный клиент — используй везде в приложении
final db = Supabase.instance.client;

// ═══════════════════════════════════════════════════════════
//  SupabaseService — единая точка доступа к Supabase
// ═══════════════════════════════════════════════════════════
class SupabaseService {
  SupabaseService._();
  static final instance = SupabaseService._();

  // ── Текущий пользователь ─────────────────────────────────
  User? get currentUser => db.auth.currentUser;
  String? get uid => db.auth.currentUser?.id;
  bool get isLoggedIn => uid != null;

  // ── Стрим состояния авторизации ──────────────────────────
  Stream<AuthState> get authStream => db.auth.onAuthStateChange;

  // ═══════════════════════════════════════════════════════════
  //  AUTH — РЕГИСТРАЦИЯ / ВХОД
  // ═══════════════════════════════════════════════════════════

  // Регистрация по email
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    required int age,
  }) async {
    final res = await db.auth.signUp(
      email: email,
      password: password,
      data: {'name': name, 'age': age},
    );
    if (res.user != null) {
      await upsertProfile(
        uid: res.user!.id,
        name: name,
        age: age,
        email: email,
      );
    }
    return res;
  }

  // Вход по email
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await db.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Регистрация/вход по телефону (OTP)
  // Шаг 1 — отправить OTP
  Future<void> sendPhoneOtp(String phone) async {
    await db.auth.signInWithOtp(phone: phone);
  }

  // Шаг 2 — верифицировать OTP
  Future<AuthResponse> verifyPhoneOtp({
    required String phone,
    required String token,
    required String name,
    required int age,
  }) async {
    final res = await db.auth.verifyOTP(
      phone: phone,
      token: token,
      type: OtpType.sms,
    );
    if (res.user != null) {
      final existing = await db
          .from('users')
          .select('id')
          .eq('id', res.user!.id)
          .maybeSingle();
      if (existing == null) {
        await upsertProfile(
          uid: res.user!.id,
          name: name,
          age: age,
          phone: phone,
        );
      }
    }
    return res;
  }

  // Google Sign-In
  Future<AuthResponse?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final res = await db.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: googleAuth.idToken!,
      accessToken: googleAuth.accessToken,
    );

    if (res.user != null) {
      final existing = await db
          .from('users')
          .select('id')
          .eq('id', res.user!.id)
          .maybeSingle();
      if (existing == null) {
        await upsertProfile(
          uid: res.user!.id,
          name: googleUser.displayName ?? 'Пользователь',
          age: 0,
          email: googleUser.email,
        );
      }
    }
    return res;
  }

  // Выход
  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await db.auth.signOut();
  }

  // ═══════════════════════════════════════════════════════════
  //  USERS — профиль пользователя
  // ═══════════════════════════════════════════════════════════

  // Создать или обновить профиль
  Future<void> upsertProfile({
    required String uid,
    required String name,
    required int age,
    String? email,
    String? phone,
    String selectedLanguage = 'ru',
  }) async {
    final ageGroup = age > 0 && age <= 12 ? 'kids' : 'adult';
    await db.from('users').upsert({
      'id': uid,
      'name': name,
      'age': age,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      'selected_language': selectedLanguage,
      'streak': 0,
      'xp': 0,
      'subscription_type': 'free',
      'created_at': DateTime.now().toIso8601String(),
      'last_active_at': DateTime.now().toIso8601String(),
    });

    // Создаём запись в leaderboard
    await _initLeaderboard(uid: uid, ageGroup: ageGroup);
  }

  // Получить профиль текущего пользователя
  Future<Map<String, dynamic>?> getProfile() async {
    if (uid == null) return null;
    return await db.from('users').select().eq('id', uid!).maybeSingle();
  }

  // Получить профиль по uid
  Future<Map<String, dynamic>?> getProfileById(String userId) async {
    return await db.from('users').select().eq('id', userId).maybeSingle();
  }

  // Обновить язык изучения
  Future<void> updateLanguage(String langCode) async {
    if (uid == null) return;
    await db.from('users').update({
      'selected_language': langCode,
      'last_active_at': DateTime.now().toIso8601String(),
    }).eq('id', uid!);
  }

  // Обновить подписку
  Future<void> updateSubscription(String planType) async {
    if (uid == null) return;
    await db.from('users').update({
      'subscription_type': planType,
    }).eq('id', uid!);

    // Записываем в subscriptions
    await db.from('subscriptions').insert({
      'user_id': uid,
      'plan_type': planType,
      'started_at': DateTime.now().toIso8601String(),
      'expires_at': planType == 'free'
          ? null
          : DateTime.now().add(const Duration(days: 30)).toIso8601String(),
      'is_active': true,
    });
  }

  // Обновить last_active + опционально streak
  Future<void> touchActivity({bool incrementStreak = false}) async {
    if (uid == null) return;
    final update = {
      'last_active_at': DateTime.now().toIso8601String(),
    };
    if (incrementStreak) {
      final profile = await getProfile();
      update['streak'] = ((profile?['streak'] ?? 0) + 1).toString();
    }
    await db.from('users').update(update).eq('id', uid!);
  }

  // ═══════════════════════════════════════════════════════════
  //  PROGRESS — алгоритм SM-2 (Эббингауз)
  // ═══════════════════════════════════════════════════════════

  // Получить слова для повторения сегодня
  Future<List<Map<String, dynamic>>> getDueWords({int limit = 20}) async {
    if (uid == null) return [];
    final now = DateTime.now().toIso8601String();
    final rows = await db
        .from('progress')
        .select('*, words(*)')
        .eq('user_id', uid!)
        .lte('next_review', now)
        .order('next_review')
        .limit(limit);
    return List<Map<String, dynamic>>.from(rows);
  }

  // Получить новые слова (ещё не начатые)
  Future<List<Map<String, dynamic>>> getNewWords({
    required String language,
    int limit = 10,
  }) async {
    if (uid == null) return [];

    // ID слов, которые уже в прогрессе
    final done = await db
        .from('progress')
        .select('word_id')
        .eq('user_id', uid!);
    final doneIds = (done as List).map((r) => r['word_id'] as String).toList();

    var query = db
        .from('words')
        .select()
        .eq('language', language)
        .order('difficulty')
        .limit(limit);

    final rows = await query;
    final allWords = List<Map<String, dynamic>>.from(rows);

    // Фильтруем на стороне клиента слова, которые уже в прогрессе
    if (doneIds.isEmpty) return allWords;
    return allWords
        .where((w) => !doneIds.contains(w['id'] as String))
        .toList();
  }

  // Обновить прогресс слова после ответа (SM-2)
  // quality: 0–5 (0-2 = неправильно, 3-5 = правильно)
  Future<void> reviewWord({
    required String wordId,
    required int quality, // 0..5
  }) async {
    if (uid == null) return;

    // Загружаем текущую запись
    final row = await db
        .from('progress')
        .select()
        .eq('user_id', uid!)
        .eq('word_id', wordId)
        .maybeSingle();

    double easeFactor = row?['ease_factor']?.toDouble() ?? 2.5;
    int intervalDays = row?['interval_days'] ?? 1;
    int correctCount = row?['correct_count'] ?? 0;
    int wrongCount = row?['wrong_count'] ?? 0;

    // ── SM-2 алгоритм ──
    if (quality >= 3) {
      // Правильный ответ
      if (intervalDays == 1) {
        intervalDays = 6;
      } else {
        intervalDays = (intervalDays * easeFactor).round();
      }
      correctCount++;
    } else {
      // Неправильный — сброс
      intervalDays = 1;
      wrongCount++;
    }

    // Новый коэффициент лёгкости
    easeFactor = easeFactor +
        (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02));
    if (easeFactor < 1.3) easeFactor = 1.3;

    final nextReview =
        DateTime.now().add(Duration(days: intervalDays)).toIso8601String();

    await db.from('progress').upsert({
      'user_id': uid,
      'word_id': wordId,
      'ease_factor': easeFactor,
      'interval_days': intervalDays,
      'next_review': nextReview,
      'correct_count': correctCount,
      'wrong_count': wrongCount,
      'last_reviewed': DateTime.now().toIso8601String(),
    });

    // Обновляем XP и счётчик слов в users
    await _addXp(quality >= 3 ? 10 : 3);
    if (correctCount == 1 && quality >= 3) {
      await _incrementWordsLearned();
    }
  }

  // Получить статистику прогресса
  Future<Map<String, int>> getProgressStats() async {
    if (uid == null) return {};
    final rows = await db
        .from('progress')
        .select('correct_count, wrong_count')
        .eq('user_id', uid!);
    int totalCorrect = 0;
    int totalWrong = 0;
    for (final r in rows) {
      totalCorrect += (r['correct_count'] as int? ?? 0);
      totalWrong += (r['wrong_count'] as int? ?? 0);
    }
    return {
      'total_words': rows.length,
      'correct': totalCorrect,
      'wrong': totalWrong,
    };
  }

  // ═══════════════════════════════════════════════════════════
  //  LEADERBOARD — рейтинг
  // ═══════════════════════════════════════════════════════════

  // Получить топ недели (по возрастной группе)
  Future<List<Map<String, dynamic>>> getWeeklyTop({
    required String ageGroup, // 'kids' | 'adult'
    int limit = 20,
  }) async {
    final weekNum = _currentWeekNumber();
    final rows = await db
        .from('leaderboard')
        .select('*, users(name, xp, subscription_type)')
        .eq('week_number', weekNum)
        .eq('age_group', ageGroup)
        .order('xp_weekly', ascending: false)
        .limit(limit);
    return List<Map<String, dynamic>>.from(rows);
  }

  // Добавить XP в недельный рейтинг
  Future<void> addWeeklyXp(int xp) async {
    if (uid == null) return;
    final weekNum = _currentWeekNumber();
    final profile = await getProfile();
    final ageGroup =
        (profile?['age'] ?? 13) <= 12 ? 'kids' : 'adult';

    final existing = await db
        .from('leaderboard')
        .select()
        .eq('user_id', uid!)
        .eq('week_number', weekNum)
        .maybeSingle();

    if (existing == null) {
      await db.from('leaderboard').insert({
        'user_id': uid,
        'xp_weekly': xp,
        'league': 'bronze',
        'age_group': ageGroup,
        'week_number': weekNum,
        'updated_at': DateTime.now().toIso8601String(),
      });
    } else {
      await db.from('leaderboard').update({
        'xp_weekly': (existing['xp_weekly'] ?? 0) + xp,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', existing['id']);
    }
  }

  // ═══════════════════════════════════════════════════════════
  //  WORDS — слова из базы
  // ═══════════════════════════════════════════════════════════

  Future<List<Map<String, dynamic>>> getWordsByLanguage({
    required String language,
    String? category,
    int? difficulty,
    int limit = 50,
  }) async {
    var query = db
        .from('words')
        .select()
        .eq('language', language);
    if (category != null) query = query.eq('category', category);
    if (difficulty != null) query = query.eq('difficulty', difficulty);
    final rows = await query.limit(limit);
    return List<Map<String, dynamic>>.from(rows);
  }

  // ═══════════════════════════════════════════════════════════
  //  ПРИВАТНЫЕ ХЕЛПЕРЫ
  // ═══════════════════════════════════════════════════════════

  Future<void> _addXp(int amount) async {
    if (uid == null) return;
    final p = await getProfile();
    final current = (p?['xp'] ?? 0) as int;
    await db
        .from('users')
        .update({'xp': current + amount}).eq('id', uid!);
    await addWeeklyXp(amount);
  }

  Future<void> _incrementWordsLearned() async {
    // Используем RPC если нужна атомарность, иначе простой update
    if (uid == null) return;
    final p = await getProfile();
    await db.from('users').update({
      'xp': ((p?['xp'] ?? 0) as int),
    }).eq('id', uid!);
  }

  Future<void> _initLeaderboard({
    required String uid,
    required String ageGroup,
  }) async {
    final weekNum = _currentWeekNumber();
    await db.from('leaderboard').upsert({
      'user_id': uid,
      'xp_weekly': 0,
      'league': 'bronze',
      'age_group': ageGroup,
      'week_number': weekNum,
    });
  }

  // ISO-неделя текущего года: YYYYWW
  int _currentWeekNumber() {
    final now = DateTime.now();
    final firstDay = DateTime(now.year, 1, 1);
    final weekDay = firstDay.weekday;
    final weekNum =
        ((now.difference(firstDay).inDays + weekDay) / 7).ceil();
    return int.parse(
        '${now.year}${weekNum.toString().padLeft(2, '0')}');
  }
}
