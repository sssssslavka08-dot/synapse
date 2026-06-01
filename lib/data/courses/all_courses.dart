import 'course_structure.dart';
import 'english_course.dart';
import 'german_course.dart';
import 'french_course.dart';
import 'spanish_course.dart';
import 'italian_course.dart';
import 'turkish_course.dart';
import 'russian_course.dart';
import 'kazakh_course.dart';
import 'chinese_course.dart';
import 'japanese_course.dart';
import 'korean_course.dart';
import 'arabic_course.dart';

// Все доступные курсы
const List<LanguageCourse> allCourses = [
  englishCourse,
  russianCourse,
  kazakhCourse,
  germanCourse,
  frenchCourse,
  spanishCourse,
  italianCourse,
  turkishCourse,
  chineseCourse,
  japaneseCourse,
  koreanCourse,
  arabicCourse,
];

// Поиск курса по коду языка
LanguageCourse? getCourseByLang(String langCode) {
  try {
    return allCourses.firstWhere((c) => c.langCode == langCode);
  } catch (_) {
    return null;
  }
}
