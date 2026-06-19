import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Локальные настройки пользователя (привязаны к uid).
class UserPrefs {
  UserPrefs._();

  static String _avatarKey(String? uid) => 'user_avatar_${uid ?? 'anon'}';
  static String _avatarPhotoKey(String? uid) =>
      'user_avatar_photo_${uid ?? 'anon'}';
  static String _usePhotoAvatarKey(String? uid) =>
      'user_use_photo_avatar_${uid ?? 'anon'}';
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

  static Future<String?> getAvatarPhotoPath() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_avatarPhotoKey(uid));
    } catch (_) {
      return null;
    }
  }

  static Future<void> setAvatarPhotoPath(String path) async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_avatarPhotoKey(uid), path);
    } catch (_) {}
  }

  static Future<bool> getUsePhotoAvatar() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_usePhotoAvatarKey(uid)) ?? false;
    } catch (_) {
      return false;
    }
  }

  static Future<void> setUsePhotoAvatar(bool value) async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_usePhotoAvatarKey(uid), value);
    } catch (_) {}
  }

  static String _premiumAvatarsKey(String? uid) =>
      'premium_avatars_${uid ?? 'anon'}';

  static Future<Set<String>> getOwnedPremiumAvatars() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      final list = prefs.getStringList(_premiumAvatarsKey(uid)) ?? [];
      return list.toSet();
    } catch (_) {
      return {};
    }
  }

  static Future<void> addOwnedPremiumAvatar(String emoji) async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      final owned = await getOwnedPremiumAvatars();
      owned.add(emoji);
      await prefs.setStringList(_premiumAvatarsKey(uid), owned.toList());
    } catch (_) {}
  }

  static Future<void> clearAvatarPhoto() async {
    try {
      final uid = Supabase.instance.client.auth.currentUser?.id;
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_avatarPhotoKey(uid));
      await prefs.setBool(_usePhotoAvatarKey(uid), false);
    } catch (_) {}
  }
}
