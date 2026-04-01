import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeNotifier extends ChangeNotifier {
  static const _key = 'theme_color';

  static const themes = [
    _AppThemeOption('Бирюзовый', Color(0xFF0ABDB9), Color(0xFFD6F5F4), Color(0xFFF4FEFE)),
    _AppThemeOption('Фиолетовый', Color(0xFF7C3AED), Color(0xFFEDE9FE), Color(0xFFF5F3FF)),
    _AppThemeOption('Синий',      Color(0xFF2563EB), Color(0xFFDBEAFE), Color(0xFFF0F7FF)),
    _AppThemeOption('Зелёный',    Color(0xFF059669), Color(0xFFD1FAE5), Color(0xFFF0FDF4)),
    _AppThemeOption('Оранжевый',  Color(0xFFEA580C), Color(0xFFFFEDD5), Color(0xFFFFF7F0)),
    _AppThemeOption('Розовый',    Color(0xFFDB2777), Color(0xFFFCE7F3), Color(0xFFFFF0F7)),
  ];

  late _AppThemeOption _current;
  AppThemeNotifier() : _current = themes[0];

  _AppThemeOption get current => _current;
  Color get primary => _current.primary;
  Color get light => _current.light;
  Color get bg => _current.bg;

  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final idx = prefs.getInt(_key) ?? 0;
      _current = themes[idx.clamp(0, themes.length - 1)];
      notifyListeners();
    } catch (_) {}
  }

  Future<void> setTheme(int index) async {
    _current = themes[index.clamp(0, themes.length - 1)];
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, index);
    } catch (_) {}
  }
}

class _AppThemeOption {
  final String name;
  final Color primary;
  final Color light;
  final Color bg;
  const _AppThemeOption(this.name, this.primary, this.light, this.bg);
}

// Global singleton
final appTheme = AppThemeNotifier();
