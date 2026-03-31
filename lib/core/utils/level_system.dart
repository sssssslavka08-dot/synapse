// ═══════════════════════════════════════════════════════════════
//  LevelSystem — XP → этаж/уровень, прогресс, заголовок
// ═══════════════════════════════════════════════════════════════

class LevelSystem {
  LevelSystem._();

  // Пороги XP для каждого этажа (индекс = уровень-1)
  static const _thresholds = [
    0,    // Этаж 1  — Новичок
    150,  // Этаж 2  — Ученик
    350,  // Этаж 3  — Практикант
    650,  // Этаж 4  — Знаток
    1000, // Этаж 5  — Мастер
    1500, // Этаж 6  — Профи
    2200, // Этаж 7  — Эксперт
    3000, // Этаж 8  — Легенда
    4200, // Этаж 9  — Гранд-Мастер
    5800, // Этаж 10 — SYNAPSE
  ];

  static const _titles = [
    'Новичок',
    'Ученик',
    'Практикант',
    'Знаток',
    'Мастер',
    'Профи',
    'Эксперт',
    'Легенда',
    'Гранд-Мастер',
    'SYNAPSE',
  ];

  static const _emojis = [
    '🌱', '📖', '✏️', '💡', '🔑',
    '⚡', '🎯', '🏆', '👑', '🧠',
  ];

  static const maxLevel = 10;

  /// Уровень (1–10) по количеству XP
  static int levelFromXp(int xp) {
    for (int i = _thresholds.length - 1; i >= 0; i--) {
      if (xp >= _thresholds[i]) return i + 1;
    }
    return 1;
  }

  /// Заголовок уровня
  static String titleForLevel(int level) {
    final idx = (level - 1).clamp(0, _titles.length - 1);
    return _titles[idx];
  }

  /// Эмодзи уровня
  static String emojiForLevel(int level) {
    final idx = (level - 1).clamp(0, _emojis.length - 1);
    return _emojis[idx];
  }

  /// XP для начала текущего уровня
  static int xpForLevel(int level) {
    final idx = (level - 1).clamp(0, _thresholds.length - 1);
    return _thresholds[idx];
  }

  /// XP для начала следующего уровня
  static int xpForNextLevel(int level) {
    if (level >= maxLevel) return _thresholds.last;
    return _thresholds[level.clamp(0, _thresholds.length - 1)];
  }

  /// Прогресс внутри текущего уровня (0.0 – 1.0)
  static double progressInLevel(int xp) {
    final lvl = levelFromXp(xp);
    if (lvl >= maxLevel) return 1.0;
    final start = xpForLevel(lvl);
    final end = xpForNextLevel(lvl);
    if (end <= start) return 1.0;
    return ((xp - start) / (end - start)).clamp(0.0, 1.0);
  }

  /// XP, оставшихся до следующего уровня
  static int xpToNextLevel(int xp) {
    final lvl = levelFromXp(xp);
    if (lvl >= maxLevel) return 0;
    return (xpForNextLevel(lvl) - xp).clamp(0, 9999);
  }
}
