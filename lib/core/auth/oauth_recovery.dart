import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:supabase_flutter/supabase_flutter.dart';

/// Восстановление сессии после Google OAuth (web PKCE / hash).
class OAuthRecovery {
  OAuthRecovery._();

  static bool hasCallback(Uri uri) =>
      uri.queryParameters.containsKey('code') ||
      uri.fragment.contains('access_token') ||
      uri.fragment.contains('refresh_token');

  /// Вызывать сразу после [Supabase.initialize] и из Splash.
  static Future<void> tryRecoverFromUri() async {
    if (!kIsWeb) return;

    final uri = Uri.base;
    if (!hasCallback(uri)) return;

    final auth = Supabase.instance.client.auth;

    final code = uri.queryParameters['code'];
    if (code != null && code.isNotEmpty) {
      try {
        await auth.exchangeCodeForSession(code);
        return;
      } catch (_) {}
    }

    try {
      await auth.getSessionFromUrl(uri);
    } catch (_) {}
  }

  static Future<Session?> waitForSession({
    Duration timeout = const Duration(seconds: 6),
  }) async {
    final auth = Supabase.instance.client.auth;

    await tryRecoverFromUri();

    var session = auth.currentSession;
    if (session != null && !session.isExpired) return session;

    final completer = Completer<Session?>();
    late final StreamSubscription<AuthState> sub;

    sub = auth.onAuthStateChange.listen((state) {
      final s = state.session;
      if (s != null && !s.isExpired && !completer.isCompleted) {
        completer.complete(s);
      }
    });

    Future.delayed(timeout, () {
      if (!completer.isCompleted) {
        completer.complete(auth.currentSession);
      }
    });

    session = await completer.future;
    await sub.cancel();

    if (session != null && !session.isExpired) return session;
    return null;
  }
}
