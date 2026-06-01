import 'package:flutter/foundation.dart';
import 'supabase_service.dart';

/// Кэш монет/XP — обновляется сразу после наград, без перезагрузки страницы.
class UserStore extends ChangeNotifier {
  UserStore._();
  static final instance = UserStore._();

  int coins = 0;
  int xp = 0;
  int streak = 0;
  bool loaded = false;

  Future<void> refresh() async {
    final p = await SupabaseService.instance.getProfile();
    if (p == null) return;
    coins = (p['coins'] as int?) ?? 0;
    xp = (p['xp'] as int?) ?? 0;
    streak = (p['streak'] as int?) ?? 0;
    loaded = true;
    notifyListeners();
  }

  void applyDelta({int coinsDelta = 0, int xpDelta = 0}) {
    if (coinsDelta != 0) coins += coinsDelta;
    if (xpDelta != 0) xp += xpDelta;
    notifyListeners();
  }
}
