// Умные ответы Нейрончика без внешнего API (шаблоны + контекст урока).
class NeuronAiService {
  NeuronAiService._();
  static final NeuronAiService instance = NeuronAiService._();

  String reply({
    required String userMessage,
    required String languageName,
    required String chapterTitle,
    required bool isKids,
    String? theorySnippet,
  }) {
    final msg = userMessage.trim().toLowerCase();
    if (msg.isEmpty) {
      return isKids
          ? 'Спроси меня что-нибудь про урок! 🧠'
          : 'Напиши вопрос по теме главы — помогу разобраться.';
    }

    if (_contains(msg, ['привет', 'сәлем', 'hello', 'hi'])) {
      return isKids
          ? 'Привет! Я Нейрончик 🧠 Сегодня учим «$chapterTitle»!'
          : 'Привет! Разберём главу «$chapterTitle» на $languageName.';
    }

    if (_contains(msg, ['как', 'how', 'неге', 'почему', 'why'])) {
      return 'Хороший вопрос! В этой главе «$chapterTitle» главное — '
          'запомнить базовые фразы и повторить их вслух 3 раза. '
          '${_tipForLanguage(languageName, isKids)}';
    }

    if (_contains(msg, ['пример', 'example', 'покажи', 'show'])) {
      if (theorySnippet != null && theorySnippet.length > 20) {
        final short = theorySnippet.length > 180
            ? '${theorySnippet.substring(0, 180)}…'
            : theorySnippet;
        return 'Вот из теории: $short';
      }
      return 'Открой карточку теории выше — там примеры. '
          'Могу подсказать: выучи 3 фразы и используй их в упражнении.';
    }

    if (_contains(msg, ['сложно', 'трудно', 'hard', 'не понимаю', "don't understand"])) {
      return isKids
          ? 'Не переживай! 🌟 Пройди теорию ещё раз и сыграй в мини-игру — станет легче!'
          : 'Разбей тему на 5 слов. Прочитай теорию → сделай 3 упражнения → короткий экзамен. '
              'Так мозг запомнит лучше.';
    }

    if (_contains(msg, ['экзамен', 'exam', 'тест', 'test'])) {
      return 'На экзамене отвечай спокойно. Нужно ≥60% — '
          'вернись к упражнениям, если что-то забыто. Удачи! 🎯';
    }

    if (_contains(msg, ['спасибо', 'thanks', 'рахмет'])) {
      return isKids ? 'Пожалуйста! Ты молодец! ⭐' : 'Всегда рад помочь. Продолжай практику!';
    }

    return isKids
        ? 'Интересно! 🧠 Про «$chapterTitle»: повтори слова вслух и нажми ▶️ на карточке урока.'
        : 'По теме «$chapterTitle» ($languageName): сфокусируйся на ключевых фразах из теории. '
            'Если нужен пример — напиши «пример».';
  }

  bool _contains(String msg, List<String> keys) =>
      keys.any((k) => msg.contains(k));

  String _tipForLanguage(String languageName, bool isKids) {
    if (isKids) return 'Нарисуй слово в воздухе пальцем — так запоминается быстрее! ✏️';
    return 'Запиши 3 новых слова в заметки и используй их сегодня в чате.';
  }
}
