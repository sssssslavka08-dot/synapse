import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Локальные настройки пользователя (привязаны к uid).
class UserPrefs {
  UserPrefs._();

  static String _avatarKey(String? uid) => 'user_avatar_${uid ?? 'anon'}';
  static const _legacyAvatarKey = 'user_avatar';

  static Future<String> getAvatarEmoji() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      final key = _avatarKey(uid);
      var emoji = prefs.getString(key);
      if (emoji == null) {
        emoji = prefs.getString(_legacyAvatarKey);
        if (emoji != null) await prefs.setString(key, emoji);
      }
      return emoji ?? '😀';
    } catch (_) {
      return '😀';
    }
  }

  static Future<void> setAvatarEmoji(String emoji) async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_avatarKey(uid), emoji);
    } catch (_) {}
  }
}
