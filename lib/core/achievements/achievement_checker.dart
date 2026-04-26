class Achievement {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final bool earned;

  const Achievement({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.earned,
  });
}

class AchievementChecker {
  /// Вычисляет список достижений на основе данных профиля.
  /// Не требует отдельной таблицы в Supabase.
  static List<Achievement> compute({
    required int xp,
    required int streak,
    required int wordsLearned,
    required int totalDays,
    required String plan,
    required int correctCount,
    required int totalLessons,
  }) {
    final level = _levelFromXp(xp);

    return [
      Achievement(
        id: 'first_lesson',
        emoji: '⚡',
        title: 'Первый шаг',
        description: 'Пройди первый урок',
        earned: xp > 0,
      ),
      Achievement(
        id: 'streak_3',
        emoji: '🔥',
        title: '3 дня подряд',
        description: 'Учись 3 дня без перерыва',
        earned: streak >= 3,
      ),
      Achievement(
        id: 'streak_7',
        emoji: '🔥',
        title: 'Неделя огня',
        description: '7 дней подряд без пропусков',
        earned: streak >= 7,
      ),
      Achievement(
        id: 'streak_30',
        emoji: '🔥',
        title: 'Месяц силы',
        description: '30 дней подряд',
        earned: streak >= 30,
      ),
      Achievement(
        id: 'words_10',
        emoji: '📚',
        title: 'Начало словаря',
        description: 'Выучи 10 слов',
        earned: wordsLearned >= 10,
      ),
      Achievement(
        id: 'words_50',
        emoji: '📚',
        title: '50 слов',
        description: 'Выучи 50 слов',
        earned: wordsLearned >= 50,
      ),
      Achievement(
        id: 'words_200',
        emoji: '📚',
        title: 'Словарный запас',
        description: 'Выучи 200 слов',
        earned: wordsLearned >= 200,
      ),
      Achievement(
        id: 'words_500',
        emoji: '📖',
        title: 'Полиглот',
        description: 'Выучи 500 слов',
        earned: wordsLearned >= 500,
      ),
      Achievement(
        id: 'xp_100',
        emoji: '⭐',
        title: '100 XP',
        description: 'Накопи 100 очков опыта',
        earned: xp >= 100,
      ),
      Achievement(
        id: 'xp_500',
        emoji: '🌟',
        title: '500 XP',
        description: 'Накопи 500 очков опыта',
        earned: xp >= 500,
      ),
      Achievement(
        id: 'xp_1000',
        emoji: '💫',
        title: '1000 XP',
        description: 'Мастер уровня 1000',
        earned: xp >= 1000,
      ),
      Achievement(
        id: 'level_5',
        emoji: '🏅',
        title: 'Этаж 5',
        description: 'Достигни 5-го этажа',
        earned: level >= 5,
      ),
      Achievement(
        id: 'level_10',
        emoji: '🥇',
        title: 'Этаж 10',
        description: 'Достигни 10-го этажа',
        earned: level >= 10,
      ),
      Achievement(
        id: 'days_7',
        emoji: '📅',
        title: 'Неделя в SYNAPSE',
        description: 'Учись 7 дней с момента регистрации',
        earned: totalDays >= 7,
      ),
      Achievement(
        id: 'days_30',
        emoji: '🗓️',
        title: 'Месяц в SYNAPSE',
        description: '30 дней с нами',
        earned: totalDays >= 30,
      ),
      Achievement(
        id: 'pro',
        emoji: '⚡',
        title: 'PRO пользователь',
        description: 'Оформи подписку PRO',
        earned: plan == 'pro' || plan == 'legenda',
      ),
      Achievement(
        id: 'legenda',
        emoji: '👑',
        title: 'LEGENDA',
        description: 'Достигни легендарного статуса',
        earned: plan == 'legenda',
      ),
    ];
  }

  static int _levelFromXp(int xp) {
    if (xp < 100) return 1;
    if (xp < 250) return 2;
    if (xp < 500) return 3;
    if (xp < 900) return 4;
    if (xp < 1500) return 5;
    if (xp < 2400) return 6;
    if (xp < 3600) return 7;
    if (xp < 5200) return 8;
    if (xp < 7200) return 9;
    return 10 + (xp - 7200) ~/ 2000;
  }
}
