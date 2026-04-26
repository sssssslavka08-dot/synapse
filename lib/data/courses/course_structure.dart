// ── Модели данных для системы курсов ────────────────────────────

enum LanguageLevel { a1, a2, b1, b2 }

extension LevelExt on LanguageLevel {
  String get label {
    switch (this) {
      case LanguageLevel.a1: return 'A1';
      case LanguageLevel.a2: return 'A2';
      case LanguageLevel.b1: return 'B1';
      case LanguageLevel.b2: return 'B2';
    }
  }

  String get description {
    switch (this) {
      case LanguageLevel.a1: return 'Начинающий';
      case LanguageLevel.a2: return 'Элементарный';
      case LanguageLevel.b1: return 'Средний';
      case LanguageLevel.b2: return 'Выше среднего';
    }
  }

  int get colorValue {
    switch (this) {
      case LanguageLevel.a1: return 0xFF4CAF50;
      case LanguageLevel.a2: return 0xFF2196F3;
      case LanguageLevel.b1: return 0xFFFF9800;
      case LanguageLevel.b2: return 0xFF9C27B0;
    }
  }
}

enum ExerciseType {
  multipleChoice,   // Выбрать правильный ответ
  fillBlank,        // Заполнить пропуск
  translation,      // Перевести фразу
  matching,         // Сопоставить пары
  trueOrFalse,      // Верно/Неверно
}

// ── Секция теории ────────────────────────────────────────────────
class TheorySection {
  final String title;
  final String content;
  final List<String> examples;
  final List<GrammarTable>? tables;

  const TheorySection({
    required this.title,
    required this.content,
    required this.examples,
    this.tables,
  });
}

class GrammarTable {
  final String title;
  final List<String> headers;
  final List<List<String>> rows;

  const GrammarTable({
    required this.title,
    required this.headers,
    required this.rows,
  });
}

// ── Упражнение ───────────────────────────────────────────────────
class CourseExercise {
  final ExerciseType type;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String? audio;

  const CourseExercise({
    required this.type,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    this.audio,
  });

  String get correctAnswer => options[correctIndex];
}

// ── Экзаменационный вопрос ───────────────────────────────────────
class ExamQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const ExamQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

// ── Глава курса ──────────────────────────────────────────────────
class CourseChapter {
  final String id;
  final String title;
  final String subtitle;
  final String emoji;
  final LanguageLevel level;
  final int order;
  final List<TheorySection> theory;
  final List<CourseExercise> exercises;
  final List<ExamQuestion> exam;
  final int coinsReward;
  final int xpReward;

  const CourseChapter({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.level,
    required this.order,
    required this.theory,
    required this.exercises,
    required this.exam,
    this.coinsReward = 50,
    this.xpReward = 30,
  });
}

// ── Курс языка ───────────────────────────────────────────────────
class LanguageCourse {
  final String langCode;
  final String langName;
  final String nativeName;
  final String flag;
  final List<CourseChapter> chapters;

  const LanguageCourse({
    required this.langCode,
    required this.langName,
    required this.nativeName,
    required this.flag,
    required this.chapters,
  });

  int get totalChapters => chapters.length;

  List<CourseChapter> get a1Chapters =>
      chapters.where((c) => c.level == LanguageLevel.a1).toList();
  List<CourseChapter> get a2Chapters =>
      chapters.where((c) => c.level == LanguageLevel.a2).toList();
  List<CourseChapter> get b1Chapters =>
      chapters.where((c) => c.level == LanguageLevel.b1).toList();
  List<CourseChapter> get b2Chapters =>
      chapters.where((c) => c.level == LanguageLevel.b2).toList();
}

// ── Статус главы для пользователя ────────────────────────────────
enum ChapterStatus { locked, available, inProgress, completed }

class ChapterProgress {
  final String chapterId;
  final ChapterStatus status;
  final int score;
  final DateTime? completedAt;
  final bool theoryDone;
  final bool exercisesDone;
  final bool examPassed;

  const ChapterProgress({
    required this.chapterId,
    required this.status,
    this.score = 0,
    this.completedAt,
    this.theoryDone = false,
    this.exercisesDone = false,
    this.examPassed = false,
  });
}
