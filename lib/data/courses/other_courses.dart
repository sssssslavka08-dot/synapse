import 'course_structure.dart';

// ══════════════════════════════════════════════════════════════
//  КАЗАХСКИЙ ЯЗЫК
// ══════════════════════════════════════════════════════════════

const kazakhCourse = LanguageCourse(
  langCode: 'kz',
  langName: 'Казахский',
  nativeName: 'Қазақша',
  flag: '🇰🇿',
  chapters: [
    CourseChapter(
      id: 'kz_a1_01', title: 'Сәлемдесу — Приветствия', subtitle: 'Алғашқы сөздер', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Негізгі сәлемдесулер',
          content: 'Казахские приветствия:\n\nСәлем! — Привет!\nСәлеметсіз бе? — Здравствуйте! (формально)\nҚалыңыз қалай? — Как ваши дела?\nЖақсы, рахмет! — Хорошо, спасибо!\nТаныстырайын — Позвольте представиться\nМенің атым... — Меня зовут...\nСау болыңыз! — До свидания!\nКөрісемін! — Пока!',
          examples: [
            'Сәлем! Менің атым Айгерім. — Привет! Меня зовут Айгерим.',
            'Сәлеметсіз бе? Қалыңыз қалай? — Здравствуйте! Как дела?',
            'Жақсы, рахмет! — Хорошо, спасибо!',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сәлем!" означает:', options: ['До свидания', 'Привет', 'Спасибо', 'Пожалуйста'], correctIndex: 1, explanation: '"Сәлем" — неформальное приветствие, аналог "Привет".'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Рахмет" — это:', options: ['Привет', 'Пожалуйста', 'Спасибо', 'Хорошо'], correctIndex: 2, explanation: '"Рахмет" = спасибо. Очень важное слово!'),
        CourseExercise(type: ExerciseType.translation, question: '"Менің атым Данияр" означает:', options: ['Я из Казахстана', 'Меня зовут Данияр', 'Я хорошо', 'Привет Данияр'], correctIndex: 1, explanation: '"Менің атым" = моё имя = меня зовут.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как попрощаться формально:', options: ['Сәлем', 'Рахмет', 'Сау болыңыз', 'Жақсы'], correctIndex: 2, explanation: '"Сау болыңыз" — формальное прощание, аналог "До свидания".'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Қалыңыз қалай?" — это:', options: ['Как тебя зовут?', 'Откуда ты?', 'Как ваши дела?', 'Сколько лет?'], correctIndex: 2, explanation: '"Қалыңыз қалай?" — формальный вопрос "Как ваши дела?".'),
      ],
      exam: [
        ExamQuestion(question: '"Сәлеметсіз бе?" — значение:', options: ['Привет', 'Здравствуйте', 'Пока', 'Спасибо'], correctIndex: 1, explanation: 'Формальное приветствие = Здравствуйте.'),
        ExamQuestion(question: '"Жақсы" = ?', options: ['плохо', 'хорошо', 'нормально', 'отлично'], correctIndex: 1, explanation: 'жақсы = хорошо'),
        ExamQuestion(question: 'Как сказать "Меня зовут Нұрлан":', options: ['Менің атым Нұрлан', 'Мен Нұрлан', 'Нұрлан атым', 'Атым мен Нұрлан'], correctIndex: 0, explanation: '"Менің атым [имя]" — правильная конструкция.'),
        ExamQuestion(question: '"Көрісемін" означает:', options: ['Привет', 'Спасибо', 'Пока', 'Хорошо'], correctIndex: 2, explanation: '"Көрісемін" = До встречи / Пока.'),
        ExamQuestion(question: '"Рахмет" — это:', options: ['пожалуйста', 'спасибо', 'привет', 'хорошо'], correctIndex: 1, explanation: 'рахмет = спасибо'),
        ExamQuestion(question: 'Неформальное приветствие:', options: ['Сәлеметсіз бе', 'Сәлем', 'Сау болыңыз', 'Рахмет'], correctIndex: 1, explanation: '"Сәлем" — неформальное. "Сәлеметсіз бе" — формальное.'),
        ExamQuestion(question: 'Ответ на "Қалыңыз қалай?":', options: ['Менің атым...', 'Жақсы, рахмет', 'Сәлем', 'Сау болыңыз'], correctIndex: 1, explanation: '"Жақсы, рахмет" = Хорошо, спасибо.'),
        ExamQuestion(question: 'Как познакомиться (позвольте представиться):', options: ['Сәлем', 'Таныстырайын', 'Рахмет', 'Жақсы'], correctIndex: 1, explanation: '"Таныстырайын" = Позвольте представиться.'),
        ExamQuestion(question: '"Менің атым" переводится:', options: ['Я из...', 'Мне нравится...', 'Меня зовут / Моё имя', 'Я хочу...'], correctIndex: 2, explanation: '"Менің" = мой/моя, "атым" = имя → "Моё имя".'),
        ExamQuestion(question: 'Как сказать "Хорошо, спасибо":', options: ['Сәлем рахмет', 'Жақсы рахмет', 'Сау болыңыз', 'Таныстырайын'], correctIndex: 1, explanation: '"Жақсы, рахмет" = Хорошо, спасибо.'),
      ],
    ),

    CourseChapter(
      id: 'kz_a1_02', title: 'Сандар мен түстер', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Сандар (Числа 1–10)',
          content: 'Числа по-казахски:\n\n1 — бір\n2 — екі\n3 — үш\n4 — төрт\n5 — бес\n6 — алты\n7 — жеті\n8 — сегіз\n9 — тоғыз\n10 — он\n20 — жиырма\n30 — отыз\n100 — жүз',
          examples: ['Бір кітап — одна книга', 'Екі бала — два ребёнка', 'Он жаста — десять лет'],
        ),
        TheorySection(
          title: 'Түстер (Цвета)',
          content: 'Цвета по-казахски:\n\n🔴 қызыл — красный\n🔵 көк — синий\n🟢 жасыл — зелёный\n🟡 сары — жёлтый\n⚫ қара — чёрный\n⚪ ақ — белый\n🟤 қоңыр — коричневый\n🟠 қызғылт сары — оранжевый\n🩷 қызғылт — розовый',
          examples: ['Қызыл алма — красное яблоко', 'Көк аспан — синее небо', 'Ақ қар — белый снег'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Үш" = ?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: '"Үш" = три (3).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Қызыл" = ?', options: ['синий', 'зелёный', 'красный', 'жёлтый'], correctIndex: 2, explanation: '"Қызыл" = красный.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сары" = ?', options: ['синий', 'жёлтый', 'белый', 'чёрный'], correctIndex: 1, explanation: '"Сары" = жёлтый.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Он" = ?', options: ['1', '5', '10', '20'], correctIndex: 2, explanation: '"Он" = 10 (десять).'),
        CourseExercise(type: ExerciseType.translation, question: '"Ақ қар" означает:', options: ['красный цветок', 'синее небо', 'белый снег', 'зелёное дерево'], correctIndex: 2, explanation: '"Ақ" = белый, "қар" = снег.'),
      ],
      exam: [
        ExamQuestion(question: '"Жеті" = ?', options: ['6', '7', '8', '9'], correctIndex: 1, explanation: 'жеті = 7'),
        ExamQuestion(question: '"Қара" = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: 'қара = чёрный'),
        ExamQuestion(question: '"Екі" = ?', options: ['1', '2', '3', '4'], correctIndex: 1, explanation: 'екі = 2'),
        ExamQuestion(question: '"Жасыл" = ?', options: ['красный', 'синий', 'зелёный', 'жёлтый'], correctIndex: 2, explanation: 'жасыл = зелёный'),
        ExamQuestion(question: '"Жиырма" = ?', options: ['12', '20', '22', '200'], correctIndex: 1, explanation: 'жиырма = 20'),
        ExamQuestion(question: '"Бес" = ?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: 'бес = 5'),
        ExamQuestion(question: '"Ақ" = ?', options: ['чёрный', 'серый', 'белый', 'красный'], correctIndex: 2, explanation: 'ақ = белый'),
        ExamQuestion(question: '"Тоғыз" = ?', options: ['7', '8', '9', '10'], correctIndex: 2, explanation: 'тоғыз = 9'),
        ExamQuestion(question: '"Көк" = ?', options: ['красный', 'синий/голубой', 'зелёный', 'жёлтый'], correctIndex: 1, explanation: 'көк = синий/голубой'),
        ExamQuestion(question: '"Жүз" = ?', options: ['10', '50', '100', '1000'], correctIndex: 2, explanation: 'жүз = 100'),

      ],
    ),

    CourseChapter(
      id: 'kz_a2_01', title: 'Отбасы — Семья', subtitle: 'Жақын адамдар', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a2, order: 3, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(
          title: 'Отбасы мүшелері',
          content: 'Члены семьи по-казахски:\n\nана — мама  |  әке — папа\nата — дедушка  |  әже — бабушка\nаға — старший брат  |  іні — младший брат\nапа — старшая сестра  |  сіңлі — младшая сестра\nбала — ребёнок  |  ұл — сын  |  қыз — дочь\nнемере — внук/внучка\nнемере аға/апа — двоюродный брат/сестра',
          examples: [
            'Менің анам мұғалім. — Моя мама — учитель.',
            'Менің екі ағам бар. — У меня два старших брата.',
            'Атам ауылда тұрады. — Мой дедушка живёт в деревне.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Ана" = ?', options: ['папа', 'мама', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"Ана" = мама.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Ата" = ?', options: ['папа', 'брат', 'дедушка', 'дядя'], correctIndex: 2, explanation: '"Ата" = дедушка.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Ұл" = ?', options: ['дочь', 'сын', 'брат', 'отец'], correctIndex: 1, explanation: '"Ұл" = сын.'),
        CourseExercise(type: ExerciseType.translation, question: '"Менің анам мұғалім" означает:', options: ['Моя сестра учитель', 'Мой папа учитель', 'Моя мама учитель', 'Моя бабушка учитель'], correctIndex: 2, explanation: '"Менің анам" = моя мама, "мұғалім" = учитель.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Iні" = ?', options: ['старший брат', 'младший брат', 'старшая сестра', 'младшая сестра'], correctIndex: 1, explanation: '"Іні" = младший брат. "Аға" = старший брат.'),
      ],
      exam: [
        ExamQuestion(question: '"Әже" = ?', options: ['мама', 'тётя', 'бабушка', 'сестра'], correctIndex: 2, explanation: 'әже = бабушка'),
        ExamQuestion(question: '"Қыз" = ?', options: ['сын', 'дочь', 'сестра', 'девочка (все варианты)'], correctIndex: 3, explanation: 'қыз = дочь/девочка/девушка'),
        ExamQuestion(question: '"Немере" = ?', options: ['двоюродный', 'племянник', 'внук', 'дядя'], correctIndex: 2, explanation: 'немере = внук/внучка'),
        ExamQuestion(question: '"Менің" = ?', options: ['твой', 'его', 'мой', 'наш'], correctIndex: 2, explanation: '"Менің" = мой/моя (притяжательное)'),
        ExamQuestion(question: '"Бар" в казахском означает:', options: ['нет', 'есть/имеется', 'хочу', 'иду'], correctIndex: 1, explanation: '"Бар" = есть/имеется. "...бар" = "у меня есть..."'),
        ExamQuestion(question: '"Аға" = ?', options: ['младший брат', 'старший брат', 'отец', 'дядя'], correctIndex: 1, explanation: 'аға = старший брат (также уважительное обращение к мужчине)'),
        ExamQuestion(question: '"Апа" = ?', options: ['мама', 'тётя', 'старшая сестра', 'бабушка'], correctIndex: 2, explanation: 'апа = старшая сестра (также уважит. обращение к женщине)'),
        ExamQuestion(question: '"Менің әкем дәрігер" означает:', options: ['Мой брат врач', 'Мой папа врач', 'Мой дедушка врач', 'Моя мама врач'], correctIndex: 1, explanation: '"Әкем" = мой папа, "дәрігер" = врач.'),
        ExamQuestion(question: '"Сіңлі" = ?', options: ['старшая сестра', 'младшая сестра', 'тётя', 'мама'], correctIndex: 1, explanation: 'сіңлі = младшая сестра'),
        ExamQuestion(question: '"Балам" = ?', options: ['мой ребёнок', 'твой ребёнок', 'маленький', 'дом'], correctIndex: 0, explanation: '"Бала" = ребёнок, "-м" = притяжательный суффикс → "мой ребёнок".'),
      ],
    ),

    CourseChapter(
      id: 'kz_b1_01', title: 'Күнделікті өмір', subtitle: 'Ежедневная жизнь', emoji: '🌅',
      level: LanguageLevel.b1, order: 4, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(
          title: 'Күн тәртібі — Распорядок дня',
          content: 'Слова о времени суток:\n\nТаңертең — утром  |  Күндіз — днём\nКешке — вечером  |  Түнде — ночью\n\nДействия:\nТұру — вставать  |  Жуыну — умываться\nТамақ іщу — есть/кушать  |  Жұмыс/мектеп — работа/школа\nДемалу — отдыхать  |  Ұйықтау — спать\n\nВопросы:\nСаған нешеде? — В котором часу?\nКезінде — вовремя  |  Ерте — рано  |  Кеш — поздно',
          examples: [
            'Мен таңертең сағат жетіде тұрамын. — Я встаю в 7 утра.',
            'Күндіз мектепте оқимын. — Днём учусь в школе.',
            'Кешке кітап оқимын. — Вечером читаю книгу.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Таңертең" = ?', options: ['вечером', 'ночью', 'днём', 'утром'], correctIndex: 3, explanation: '"Таңертең" = утром.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Ұйықтау" = ?', options: ['есть', 'спать', 'идти', 'читать'], correctIndex: 1, explanation: '"Ұйықтау" = спать.'),
        CourseExercise(type: ExerciseType.translation, question: '"Кешке демаламын" означает:', options: ['Утром я встаю', 'Вечером отдыхаю', 'Ночью сплю', 'Днём ем'], correctIndex: 1, explanation: '"Кешке" = вечером, "демаламын" = я отдыхаю.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Ерте" = ?', options: ['поздно', 'вовремя', 'рано', 'быстро'], correctIndex: 2, explanation: '"Ерте" = рано. Антоним: "кеш" = поздно.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Тамақ ішу" = ?', options: ['пить воду', 'есть/кушать', 'готовить', 'покупать'], correctIndex: 1, explanation: '"Тамақ ішу" = есть/кушать (буквально: "пить еду").'),
      ],
      exam: [
        ExamQuestion(question: '"Күндіз" = ?', options: ['утром', 'вечером', 'ночью', 'днём'], correctIndex: 3, explanation: 'күндіз = днём'),
        ExamQuestion(question: '"Тұру" = ?', options: ['спать', 'вставать', 'идти', 'сидеть'], correctIndex: 1, explanation: 'тұру = вставать (также: стоять)'),
        ExamQuestion(question: '"Кеш" = ?', options: ['рано', 'поздно', 'быстро', 'медленно'], correctIndex: 1, explanation: 'кеш = поздно'),
        ExamQuestion(question: '"Жұмыс" = ?', options: ['школа', 'дом', 'работа', 'магазин'], correctIndex: 2, explanation: 'жұмыс = работа'),
        ExamQuestion(question: 'Маркер утреннего времени:', options: ['Кешке', 'Таңертең', 'Күндіз', 'Түнде'], correctIndex: 1, explanation: '"Таңертең" = утром.'),
        ExamQuestion(question: '"Жуыну" = ?', options: ['есть', 'спать', 'умываться', 'одеваться'], correctIndex: 2, explanation: 'жуыну = умываться, мыться'),
        ExamQuestion(question: '"Демалу" = ?', options: ['работать', 'учиться', 'отдыхать', 'играть'], correctIndex: 2, explanation: 'демалу = отдыхать'),
        ExamQuestion(question: '"Мен таңертең... тұрамын" означает:', options: ['Я вечером ложусь', 'Я утром встаю', 'Я днём отдыхаю', 'Ночью я сплю'], correctIndex: 1, explanation: '"Тұрамын" = я встаю; "таңертең" = утром.'),
        ExamQuestion(question: '"Саған нешеде?" = ?', options: ['Как дела?', 'Где ты?', 'В котором часу у тебя?', 'Что ты делаешь?'], correctIndex: 2, explanation: '"Нешеде" = в котором часу.'),
        ExamQuestion(question: '"Түнде" = ?', options: ['днём', 'вечером', 'утром', 'ночью'], correctIndex: 3, explanation: 'түнде = ночью'),
      ],
    ),
  ],
);

// ══════════════════════════════════════════════════════════════
//  КИТАЙСКИЙ ЯЗЫК
// ══════════════════════════════════════════════════════════════

const chineseCourse = LanguageCourse(
  langCode: 'zh',
  langName: 'Китайский',
  nativeName: '中文',
  flag: '🇨🇳',
  chapters: [
    CourseChapter(
      id: 'zh_a1_01', title: '问候 — Приветствия', subtitle: '基本用语 Базовые фразы', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Основные приветствия',
          content: '你好 (Nǐ hǎo) — Привет/Здравствуй\n您好 (Nín hǎo) — Здравствуйте (форм.)\n早上好 (Zǎoshang hǎo) — Доброе утро\n下午好 (Xiàwǔ hǎo) — Добрый день\n晚上好 (Wǎnshang hǎo) — Добрый вечер\n再见 (Zàijiàn) — До свидания\n谢谢 (Xièxie) — Спасибо\n不客气 (Bú kèqi) — Пожалуйста\n\nПредставление:\n我叫... (Wǒ jiào...) — Меня зовут...\n你叫什么名字? (Nǐ jiào shénme míngzi?) — Как тебя зовут?\n你好吗? (Nǐ hǎo ma?) — Как дела?',
          examples: [
            '你好! 我叫王明。 — Привет! Меня зовут Ван Мин.',
            '你好吗? 我很好,谢谢! — Как дела? Хорошо, спасибо!',
            '再见! — До свидания!',
          ],
        ),
        TheorySection(
          title: 'Тоны в китайском',
          content: 'Китайский язык — тональный. Один слог с разным тоном = разное значение!\n\n4 тона + нейтральный:\n1-й тон (—): ровный, высокий: mā (мама)\n2-й тон (′): восходящий: má (конопля)\n3-й тон (∨): падающий-восходящий: mǎ (лошадь)\n4-й тон (\\): нисходящий: mà (ругать)\nНейтральный: ma — частица вопроса\n\nhǎo (3-й тон) = хорошо\nnǐ (3-й тон) = ты\nwǒ (3-й тон) = я',
          examples: [
            'nǐ — ты  |  nín — вы (форм.)',
            'hǎo — хороший  |  bù hǎo — нехороший',
            'ma — вопросительная частица',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"你好" произносится:', options: ['Wǒ hǎo', 'Nǐ hǎo', 'Nín hǎo', 'Zàijiàn'], correctIndex: 1, explanation: '"你好" = Nǐ hǎo = Привет/Здравствуй.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"谢谢" (Xièxie) = ?', options: ['Привет', 'Пожалуйста', 'Спасибо', 'Пока'], correctIndex: 2, explanation: '"谢谢 (Xièxie)" = спасибо.'),
        CourseExercise(type: ExerciseType.translation, question: '"我叫李华" (Wǒ jiào Lǐ Huá) = ?', options: ['Я из Китая', 'Меня зовут Ли Хуа', 'Я студент', 'Привет Ли Хуа'], correctIndex: 1, explanation: '"我叫" (Wǒ jiào) = меня зовут.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"再见" (Zàijiàn) = ?', options: ['Привет', 'Спасибо', 'До свидания', 'Хорошо'], correctIndex: 2, explanation: '"再见" (Zàijiàn) = до свидания.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Сколько тонов в китайском (основных)?', options: ['3', '4', '5', '6'], correctIndex: 1, explanation: '4 основных тона + нейтральный (лёгкий).'),
      ],
      exam: [
        ExamQuestion(question: '"早上好" = ?', options: ['Добрый вечер', 'Добрый день', 'Доброе утро', 'Пока'], correctIndex: 2, explanation: '"早上好" (Zǎoshang hǎo) = Доброе утро'),
        ExamQuestion(question: '"不客气" = ?', options: ['Спасибо', 'Пожалуйста', 'Привет', 'Хорошо'], correctIndex: 1, explanation: '"不客气 (Bú kèqi)" = пожалуйста (ответ на спасибо)'),
        ExamQuestion(question: '"我" (wǒ) = ?', options: ['ты', 'он/она', 'я', 'мы'], correctIndex: 2, explanation: '"我" (wǒ) = я'),
        ExamQuestion(question: '"你好吗?" = ?', options: ['Как тебя зовут?', 'Откуда ты?', 'Как дела?', 'Сколько лет?'], correctIndex: 2, explanation: '"你好吗?" (Nǐ hǎo ma?) = Как дела?'),
        ExamQuestion(question: 'Тон в слове "mǎ" (лошадь):', options: ['1-й', '2-й', '3-й', '4-й'], correctIndex: 2, explanation: '"ǎ" — символ 3-го тона (падающий-восходящий).'),
        ExamQuestion(question: '"您好" отличается от "你好":', options: ['нет разницы', 'более формальное', 'более неформальное', 'другое значение'], correctIndex: 1, explanation: '"您好" — более вежливая/формальная форма приветствия.'),
        ExamQuestion(question: '"晚上好" = ?', options: ['Доброе утро', 'Добрый день', 'Добрый вечер', 'Спокойной ночи'], correctIndex: 2, explanation: '"晚上好" (Wǎnshang hǎo) = Добрый вечер'),
        ExamQuestion(question: '2-й тон (восходящий) обозначается:', options: ['—', '′', '∨', '\\'], correctIndex: 1, explanation: '2-й тон — восходящий, обозначается ′ (accent aigu): á'),
        ExamQuestion(question: '"你叫什么名字?" = ?', options: ['Как дела?', 'Откуда ты?', 'Как тебя зовут?', 'Сколько лет?'], correctIndex: 2, explanation: '"你叫什么名字?" = Как тебя зовут?'),
        ExamQuestion(question: '"很好" (hěn hǎo) = ?', options: ['не очень', 'плохо', 'очень хорошо', 'нормально'], correctIndex: 2, explanation: '"很" (hěn) = очень, "好" (hǎo) = хорошо → "очень хорошо"'),
      ],
    ),

    CourseChapter(
      id: 'zh_a1_02', title: '数字和颜色', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: '数字 1–20 (Shùzì)',
          content: '1 — 一 (yī)\n2 — 二 (èr)\n3 — 三 (sān)\n4 — 四 (sì)\n5 — 五 (wǔ)\n6 — 六 (liù)\n7 — 七 (qī)\n8 — 八 (bā)\n9 — 九 (jiǔ)\n10 — 十 (shí)\n11 — 十一 (shíyī)\n12 — 十二 (shí\'èr)\n20 — 二十 (èrshí)\n100 — 一百 (yī bǎi)\n\nВозраст: 我二十岁。(Wǒ èrshí suì.) — Мне 20 лет.',
          examples: ['三个苹果 (sān gè píngguǒ) — три яблока', '十个学生 — десять студентов', '你几岁? — Сколько тебе лет?'],
        ),
        TheorySection(
          title: '颜色 (Yánsè) — Цвета',
          content: '🔴 红色 (hóng sè) — красный\n🔵 蓝色 (lán sè) — синий\n🟢 绿色 (lǜ sè) — зелёный\n🟡 黄色 (huáng sè) — жёлтый\n⚫ 黑色 (hēi sè) — чёрный\n⚪ 白色 (bái sè) — белый\n🟠 橙色 (chéng sè) — оранжевый\n🩷 粉色 (fěn sè) — розовый\n\n"色" (sè) = цвет (можно опускать в разговоре):\n红的 = красный',
          examples: ['天空是蓝色的。(Tiānkōng shì lánsè de.) — Небо синее.', '红色很漂亮。— Красный очень красивый.', '我喜欢绿色。— Я люблю зелёный.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"五" (wǔ) = ?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: '"五" (wǔ) = 5.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"红色" (hóng sè) = ?', options: ['синий', 'зелёный', 'красный', 'жёлтый'], correctIndex: 2, explanation: '"红色" = красный цвет.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"二十" = ?', options: ['10', '12', '15', '20'], correctIndex: 3, explanation: '"二十" (èrshí) = 20. "二" = 2, "十" = 10.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"黄色" (huáng sè) = ?', options: ['белый', 'чёрный', 'жёлтый', 'оранжевый'], correctIndex: 2, explanation: '"黄色" = жёлтый цвет.'),
        CourseExercise(type: ExerciseType.translation, question: '"天空是蓝色的" = ?', options: ['Море синее', 'Небо синее', 'Кот синий', 'Цветок синий'], correctIndex: 1, explanation: '"天空" = небо, "蓝色" = синий.'),
      ],
      exam: [
        ExamQuestion(question: '"八" (bā) = ?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: '八 = 8'),
        ExamQuestion(question: '"绿色" (lǜ sè) = ?', options: ['красный', 'синий', 'зелёный', 'жёлтый'], correctIndex: 2, explanation: '绿色 = зелёный'),
        ExamQuestion(question: '"十二" = ?', options: ['10', '11', '12', '13'], correctIndex: 2, explanation: '十二 (shí\'èr) = 12'),
        ExamQuestion(question: '"黑色" = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: '黑色 (hēi sè) = чёрный'),
        ExamQuestion(question: '"三" (sān) = ?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: '三 = 3'),
        ExamQuestion(question: '"白色" = ?', options: ['чёрный', 'серый', 'белый', 'бежевый'], correctIndex: 2, explanation: '白色 (bái sè) = белый'),
        ExamQuestion(question: '"十" (shí) = ?', options: ['8', '9', '10', '11'], correctIndex: 2, explanation: '十 = 10'),
        ExamQuestion(question: '"色" (sè) означает:', options: ['число', 'цвет', 'человек', 'день'], correctIndex: 1, explanation: '"色" (sè) = цвет'),
      ],
    ),

    CourseChapter(
      id: 'zh_a1_03', title: '家庭', subtitle: 'Семья и родственники', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a1, order: 3, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(
          title: '家庭成员 (Jiātíng chéngyuán)',
          content: '爸爸 (bàba) — папа\n妈妈 (māma) — мама\n儿子 (érzi) — сын\n女儿 (nǚ\'ér) — дочь\n哥哥 (gēge) — старший брат\n弟弟 (dìdi) — младший брат\n姐姐 (jiějie) — старшая сестра\n妹妹 (mèimei) — младшая сестра\n爷爷 (yéye) — дедушка (по отцу)\n奶奶 (nǎinai) — бабушка (по отцу)\n丈夫 (zhàngfu) — муж\n妻子 (qīzi) — жена\n父母 (fùmǔ) — родители',
          examples: ['我有一个哥哥。— У меня есть старший брат.', '我妈妈叫王芳。— Мою маму зовут Ван Фан.', '我家有四口人。— В моей семье 4 человека.'],
        ),
        TheorySection(
          title: '我的/你的 — мой/твой',
          content: '的 (de) — притяжательная частица:\n我的 (wǒ de) — мой/моя/мои\n你的 (nǐ de) — твой/твоя\n他的 (tā de) — его\n她的 (tā de) — её\n\n我家有... — В моей семье есть...\n我没有... — У меня нет...\n我有几个兄弟姐妹? — Сколько у тебя братьев и сестёр?',
          examples: ['我的爸爸是医生。— Мой папа врач.', '你的妈妈在哪里? — Где твоя мама?', '我没有兄弟。— У меня нет братьев.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"妈妈" (māma) = ?', options: ['отец', 'мать', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"妈妈" = мама.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"我的爸爸" = ?', options: ['твой папа', 'мой папа', 'его папа', 'наш папа'], correctIndex: 1, explanation: '"我的" = мой/моя, "爸爸" = папа.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"爷爷" (yéye) = ?', options: ['отец', 'дядя', 'дедушка', 'брат'], correctIndex: 2, explanation: '"爷爷" = дедушка (по отцу).'),
        CourseExercise(type: ExerciseType.translation, question: '"我有一个姐姐" = ?', options: ['У меня есть брат', 'У меня есть старшая сестра', 'У меня нет сестры', 'Моя сестра'], correctIndex: 1, explanation: '"我有" = у меня есть, "姐姐" = старшая сестра.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"父母" (fùmǔ) = ?', options: ['дети', 'бабушки', 'родители', 'братья'], correctIndex: 2, explanation: '"父母" = родители.'),
      ],
      exam: [
        ExamQuestion(question: '"奶奶" (nǎinai) = ?', options: ['тётя', 'мать', 'бабушка', 'сестра'], correctIndex: 2, explanation: '"奶奶" = бабушка (мама отца)'),
        ExamQuestion(question: '"我的女儿" = ?', options: ['моя мать', 'моя сестра', 'моя дочь', 'твоя дочь'], correctIndex: 2, explanation: '"女儿" = дочь'),
        ExamQuestion(question: '"丈夫" (zhàngfu) = ?', options: ['сын', 'брат', 'дядя', 'муж'], correctIndex: 3, explanation: '"丈夫" = муж'),
        ExamQuestion(question: '"我没有兄弟" = ?', options: ['у меня есть брат', 'у меня нет братьев', 'мой брат', 'где мой брат?'], correctIndex: 1, explanation: '"没有" = нет/не имею'),
        ExamQuestion(question: '"儿子" (érzi) = ?', options: ['мать', 'сестра', 'дочь', 'сын'], correctIndex: 3, explanation: '"儿子" = сын'),
        ExamQuestion(question: '"的" (de) используется для:', options: ['вопросов', 'отрицания', 'притяжания', 'времени'], correctIndex: 2, explanation: '"的" (de) — притяжательная частица: 我的 = мой'),
        ExamQuestion(question: '"妹妹" = ?', options: ['старшая сестра', 'младшая сестра', 'старший брат', 'младший брат'], correctIndex: 1, explanation: '"妹妹" = младшая сестра'),
        ExamQuestion(question: '"我家有四口人" — "口" здесь считает:', options: ['комнаты', 'людей', 'животных', 'вещи'], correctIndex: 1, explanation: '"口" (kǒu) — счётное слово для членов семьи'),
      ],
    ),
  ],
);

// ══════════════════════════════════════════════════════════════
//  ЯПОНСКИЙ ЯЗЫК
// ══════════════════════════════════════════════════════════════

const japaneseCourse = LanguageCourse(
  langCode: 'ja',
  langName: 'Японский',
  nativeName: '日本語',
  flag: '🇯🇵',
  chapters: [
    CourseChapter(
      id: 'ja_a1_01', title: 'あいさつ — Приветствия', subtitle: '基本フレーズ', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Основные приветствия',
          content: 'おはようございます (Ohayō gozaimasu) — Доброе утро\nこんにちは (Konnichiwa) — Здравствуйте/Добрый день\nこんばんは (Konbanwa) — Добрый вечер\nおやすみなさい (Oyasumi nasai) — Спокойной ночи\nさようなら (Sayōnara) — До свидания\nありがとう (Arigatō) — Спасибо\nどういたしまして (Dōitashimashite) — Пожалуйста\n\nПредставление:\nわたしは... です (Watashi wa... desu) — Я... / Меня зовут...\nおなまえは? (Onamae wa?) — Как вас зовут?\nはじめまして (Hajimemashite) — Рад познакомиться',
          examples: [
            'こんにちは! わたしはケン です。— Привет! Я Кен.',
            'はじめまして、よろしくおねがいします。— Рад познакомиться, прошу любить и жаловать.',
            'ありがとうございます! — Большое спасибо!',
          ],
        ),
        TheorySection(
          title: 'Хирагана — основная азбука',
          content: 'Японский использует 3 системы письма:\n1. Хирагана (ひらがな) — японские слова\n2. Катакана (カタカナ) — иностранные слова\n3. Кандзи (漢字) — китайские иероглифы\n\nОсновные хираганы:\nあ (a) い (i) う (u) え (e) お (o)\nか (ka) き (ki) く (ku) け (ke) こ (ko)\nさ (sa) し (shi) す (su) せ (se) そ (so)\nた (ta) ち (chi) つ (tsu) て (te) と (to)\nな (na) に (ni) ぬ (nu) ね (ne) の (no)',
          examples: [
            'わ (wa) た (ta) し (shi) = わたし = watashi = я',
            'あ (a) り (ri) が (ga) と (to) う (u) = ありがとう = arigatou = спасибо',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"こんにちは" используется:', options: ['только утром', 'только вечером', 'днём (приветствие)', 'при прощании'], correctIndex: 2, explanation: '"こんにちは" (Konnichiwa) = дневное приветствие.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"ありがとう" (Arigatō) = ?', options: ['Пожалуйста', 'Привет', 'Спасибо', 'Пока'], correctIndex: 2, explanation: '"ありがとう" = спасибо.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"さようなら" = ?', options: ['Привет', 'Спасибо', 'Доброе утро', 'До свидания'], correctIndex: 3, explanation: '"さようなら" (Sayōnara) = До свидания.'),
        CourseExercise(type: ExerciseType.translation, question: '"わたしはマリア です" = ?', options: ['Я из Японии', 'Меня зовут Мария', 'Я студентка', 'Привет Мария'], correctIndex: 1, explanation: '"わたしは [имя] です" = Я / Меня зовут [имя].'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Сколько систем письма в японском?', options: ['1', '2', '3', '4'], correctIndex: 2, explanation: 'Три: хирагана, катакана и кандзи.'),
      ],
      exam: [
        ExamQuestion(question: '"おはようございます" = ?', options: ['Добрый вечер', 'Спокойной ночи', 'Доброе утро', 'До свидания'], correctIndex: 2, explanation: '"おはようございます" = Доброе утро (вежливо)'),
        ExamQuestion(question: '"こんばんは" = ?', options: ['Доброе утро', 'Добрый день', 'Добрый вечер', 'Пока'], correctIndex: 2, explanation: '"こんばんは" = Добрый вечер'),
        ExamQuestion(question: '"はじめまして" = ?', options: ['Спасибо', 'Пожалуйста', 'Рад познакомиться', 'Пока'], correctIndex: 2, explanation: '"はじめまして" = Рад познакомиться (при первой встрече)'),
        ExamQuestion(question: '"どういたしまして" = ?', options: ['Спасибо', 'Пожалуйста', 'Привет', 'До свидания'], correctIndex: 1, explanation: '"どういたしまして" = пожалуйста (ответ на ありがとう)'),
        ExamQuestion(question: '"わたし" (watashi) = ?', options: ['ты', 'он', 'я', 'мы'], correctIndex: 2, explanation: '"わたし" = я'),
        ExamQuestion(question: 'Иностранные слова пишутся:', options: ['хираганой', 'катаканой', 'кандзи', 'ромадзи'], correctIndex: 1, explanation: 'Катакана используется для иностранных/заимствованных слов.'),
        ExamQuestion(question: '"おやすみなさい" = ?', options: ['Доброе утро', 'Добрый вечер', 'Спокойной ночи', 'До свидания'], correctIndex: 2, explanation: '"おやすみなさい" = Спокойной ночи'),
        ExamQuestion(question: '"ありがとうございます" — это:', options: ['неформальное спасибо', 'формальное спасибо', 'привет', 'пока'], correctIndex: 1, explanation: '"ありがとうございます" — более вежливая форма "ありがとう".'),
        ExamQuestion(question: '"です" (desu) в конце предложения:', options: ['вопрос', 'отрицание', 'вежливый глагол-связка', 'прошедшее время'], correctIndex: 2, explanation: '"です" = вежливый глагол-связка (является/есть).'),
        ExamQuestion(question: '"おなまえは?" = ?', options: ['Как дела?', 'Как вас зовут?', 'Откуда вы?', 'Сколько лет?'], correctIndex: 1, explanation: '"おなまえは?" = Как вас зовут?'),
      ],
    ),

    CourseChapter(
      id: 'ja_a1_02', title: '数字と色', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: '数字 (かず) 1–20',
          content: '1 — いち (ichi)\n2 — に (ni)\n3 — さん (san)\n4 — し/よん (shi/yon)\n5 — ご (go)\n6 — ろく (roku)\n7 — しち/なな (shichi/nana)\n8 — はち (hachi)\n9 — く/きゅう (ku/kyū)\n10 — じゅう (jū)\n11 — じゅういち (jūichi)\n12 — じゅうに (jūni)\n20 — にじゅう (nijū)\n100 — ひゃく (hyaku)\n\n何歳ですか? (Nansai desu ka?) — Сколько лет?',
          examples: ['五つのりんご — пять яблок', 'じゅうにん — десять человек', 'わたしは にじゅうさい です。— Мне 20 лет.'],
        ),
        TheorySection(
          title: '色 (いろ) — Цвета',
          content: '🔴 あか (赤/aka) — красный\n🔵 あお (青/ao) — синий/зелёный\n🟢 みどり (緑/midori) — зелёный\n🟡 き/きいろ (黄色/kiiro) — жёлтый\n⚫ くろ (黒/kuro) — чёрный\n⚪ しろ (白/shiro) — белый\n🟠 オレンジ (orenji) — оранжевый\n🩷 ピンク (pinku) — розовый\n🟤 ちゃいろ (茶色/chairo) — коричневый\n\n〜い — прилагательное: あかい (красный), くろい (чёрный)',
          examples: ['そらはあおい。— Небо синее.', 'りんごはあかい。— Яблоко красное.', 'みどりがすきです。— Я люблю зелёный.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"ご" (go) = ?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: '"ご" (go) = 5.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"あか" (aka) = ?', options: ['синий', 'зелёный', 'красный', 'жёлтый'], correctIndex: 2, explanation: '"あか" = красный.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"にじゅう" = ?', options: ['10', '12', '15', '20'], correctIndex: 3, explanation: '"にじゅう" = 20. "に" = 2, "じゅう" = 10.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"きいろ" (kiiro) = ?', options: ['белый', 'чёрный', 'жёлтый', 'оранжевый'], correctIndex: 2, explanation: '"きいろ" = жёлтый.'),
        CourseExercise(type: ExerciseType.translation, question: '"そらはあおい" = ?', options: ['Море синее', 'Небо синее', 'Кот синий', 'Цветок синий'], correctIndex: 1, explanation: '"そら" = небо, "あおい" = синий.'),
      ],
      exam: [
        ExamQuestion(question: '"はち" (hachi) = ?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: 'はち = 8'),
        ExamQuestion(question: '"みどり" (midori) = ?', options: ['красный', 'синий', 'зелёный', 'жёлтый'], correctIndex: 2, explanation: 'みどり = зелёный'),
        ExamQuestion(question: '"じゅうに" = ?', options: ['10', '11', '12', '13'], correctIndex: 2, explanation: 'じゅうに = 12'),
        ExamQuestion(question: '"くろ" (kuro) = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: 'くろ = чёрный'),
        ExamQuestion(question: '"さん" (san) = ?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: 'さん = 3'),
        ExamQuestion(question: '"しろ" (shiro) = ?', options: ['чёрный', 'серый', 'белый', 'бежевый'], correctIndex: 2, explanation: 'しろ = белый'),
        ExamQuestion(question: '"じゅう" (jū) = ?', options: ['8', '9', '10', '11'], correctIndex: 2, explanation: 'じゅう = 10'),
        ExamQuestion(question: '"あおい" = прилагательное, "あお" = ?', options: ['существительное', 'глагол', 'наречие', 'частица'], correctIndex: 0, explanation: '"あお" — существительное (название цвета), "あおい" — прилагательное'),
      ],
    ),

    CourseChapter(
      id: 'ja_a1_03', title: '家族', subtitle: 'Семья и родственники', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a1, order: 3, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(
          title: '家族のメンバー (Kazoku no menbā)',
          content: 'В японском разные слова для "своей" и "чужой" семьи:\n\nСвоя семья (простые):\nちち (chichi) — отец\nはは (haha) — мать\nあに (ani) — старший брат\nあね (ane) — старшая сестра\nおとうと (otōto) — младший брат\nいもうと (imōto) — младшая сестра\nそふ (sofu) — дедушка\nそぼ (sobo) — бабушка\n\nЧужая семья (вежливые):\nおとうさん (otōsan) — папа\nおかあさん (okāsan) — мама\nおにいさん — старший брат\nおじいさん — дедушка',
          examples: ['わたしにはあにがいます。— У меня есть старший брат.', 'はははたなかです。— Мою маму зовут Танака.', 'かぞくはよにんです。— В семье 4 человека.'],
        ),
        TheorySection(
          title: '〜がいます/あります',
          content: 'います (imasu) — есть (живые существа)\nあります (arimasu) — есть (неодушевлённые)\n\nいます/います で:\nあにがいます。— У меня есть старший брат.\nいもうとがいません。— У меня нет младшей сестры.\n\nわたしの〜 — мой/моя:\nわたしのちち — мой отец\nあなたのおかあさん — ваша мама',
          examples: ['あにがふたりいます。— У меня два старших брата.', 'きょうだいはいますか? — У тебя есть братья/сёстры?', 'わたしにはいもうとがいません。— У меня нет младшей сестры.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"おかあさん" = ?', options: ['папа', 'мама', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"おかあさん" = мама (вежливо).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"わたしのちち" = ?', options: ['твой папа', 'мой папа', 'его папа', 'наш папа'], correctIndex: 1, explanation: '"わたしの" = мой/моя, "ちち" = отец (своей семьи).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"おじいさん" = ?', options: ['папа', 'дядя', 'дедушка', 'брат'], correctIndex: 2, explanation: '"おじいさん" = дедушка (вежливо).'),
        CourseExercise(type: ExerciseType.translation, question: '"あねがいます" = ?', options: ['У меня есть брат', 'У меня есть старшая сестра', 'У меня нет сестры', 'Где моя сестра?'], correctIndex: 1, explanation: '"あね" = старшая сестра, "がいます" = есть.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"います" используется для:', options: ['предметов', 'живых существ', 'мест', 'времени'], correctIndex: 1, explanation: '"います" = есть (для одушевлённых).'),
      ],
      exam: [
        ExamQuestion(question: '"そぼ" (sobo) = ?', options: ['тётя', 'мать', 'бабушка', 'сестра'], correctIndex: 2, explanation: '"そぼ" = бабушка (своей семьи)'),
        ExamQuestion(question: '"おとうさん" = ?', options: ['мама', 'папа', 'дедушка', 'брат'], correctIndex: 1, explanation: '"おとうさん" = папа (вежливо)'),
        ExamQuestion(question: '"いもうと" (imōto) = ?', options: ['старшая сестра', 'младшая сестра', 'старший брат', 'младший брат'], correctIndex: 1, explanation: '"いもうと" = младшая сестра'),
        ExamQuestion(question: '"きょうだいはいますか?" = ?', options: ['Как вас зовут?', 'Откуда вы?', 'Есть ли у вас братья/сёстры?', 'Сколько лет?'], correctIndex: 2, explanation: '"きょうだい" = братья и сёстры, "いますか?" = есть?'),
        ExamQuestion(question: '"あに" (ani) = ?', options: ['младший брат', 'старший брат', 'дядя', 'отец'], correctIndex: 1, explanation: '"あに" = старший брат (своей семьи)'),
        ExamQuestion(question: '"いません" = ?', options: ['есть', 'нет (живых)', 'нет (вещей)', 'не знаю'], correctIndex: 1, explanation: '"いません" = нет (отрицание "います" для живых существ)'),
        ExamQuestion(question: '"はは" (haha) = ?', options: ['папа', 'мама', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"はは" = мать (своей семьи, простая форма)'),
        ExamQuestion(question: '"かぞく" (kazoku) = ?', options: ['дом', 'семья', 'город', 'школа'], correctIndex: 1, explanation: '"かぞく" = семья'),
      ],
    ),
  ],
);

// ══════════════════════════════════════════════════════════════
//  КОРЕЙСКИЙ ЯЗЫК
// ══════════════════════════════════════════════════════════════

const koreanCourse = LanguageCourse(
  langCode: 'ko',
  langName: 'Корейский',
  nativeName: '한국어',
  flag: '🇰🇷',
  chapters: [
    CourseChapter(
      id: 'ko_a1_01', title: '인사 — Приветствия', subtitle: '기본 표현', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Корейские приветствия',
          content: '안녕하세요 (Annyeonghaseyo) — Здравствуйте (форм.)\n안녕 (Annyeong) — Привет/Пока (нефор.)\n좋은 아침이에요 (Joeun achimieyo) — Доброе утро\n안녕히 계세요 (Annyeonghi gyeseyo) — До свидания (уходишь)\n감사합니다 (Gamsahamnida) — Спасибо (форм.)\n고마워요 (Gomawoyo) — Спасибо (неформально)\n천만에요 (Cheonmaneyo) — Пожалуйста\n\nПредставление:\n저는 [имя]이에요/예요 — Я [имя]\n이름이 뭐예요? — Как тебя зовут?\n어디서 왔어요? — Откуда ты?',
          examples: [
            '안녕하세요! 저는 민준이에요. — Здравствуйте! Я Минджун.',
            '반갑습니다! — Рад познакомиться!',
            '감사합니다! — Спасибо!',
          ],
        ),
        TheorySection(
          title: 'Алфавит Хангыль',
          content: 'Корейский язык использует алфавит ХАНГЫЛЬ (한글).\nСоздан в 1443 году, очень логичный и легко учится!\n\nСогласные:\nㄱ (g/k)  ㄴ (n)  ㄷ (d/t)  ㄹ (r/l)  ㅁ (m)\nㅂ (b/p)  ㅅ (s)  ㅇ (ng/-)  ㅈ (j)  ㅎ (h)\n\nГласные:\nㅏ (a)  ㅣ (i)  ㅜ (u)  ㅔ (e)  ㅗ (o)\n\nБуквы складываются в слоги: 한 = ㅎ+ㅏ+ㄴ = han',
          examples: [
            '안 = ㅏ+ㄴ (an)',
            '녕 = ㄴ+ㅕ+ㅇ (nyeong)',
            '안녕 = annyeong = привет/пока',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"안녕하세요" используется как:', options: ['только привет', 'только пока', 'формальное приветствие', 'только утром'], correctIndex: 2, explanation: '"안녕하세요" — формальное приветствие в любое время суток.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"감사합니다" = ?', options: ['Привет', 'Пожалуйста', 'Спасибо (форм.)', 'Пока'], correctIndex: 2, explanation: '"감사합니다" — формальное "спасибо".'),
        CourseExercise(type: ExerciseType.translation, question: '"저는 소피아예요" = ?', options: ['Я из Кореи', 'Я Соня/Меня зовут Соня', 'Я студентка', 'Привет Соня'], correctIndex: 1, explanation: '"저는 [имя]예요" = Я [имя].'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Корейский алфавит называется:', options: ['Кана', 'Хангыль', 'Кандзи', 'Пиньинь'], correctIndex: 1, explanation: 'Корейский алфавит = Хангыль (한글), создан в 1443 году.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"안녕" (неформально) = ?', options: ['только привет', 'только пока', 'и привет и пока', 'спасибо'], correctIndex: 2, explanation: '"안녕" — неформально и приветствие, и прощание.'),
      ],
      exam: [
        ExamQuestion(question: '"반갑습니다" = ?', options: ['Спасибо', 'Пожалуйста', 'Рад познакомиться', 'До свидания'], correctIndex: 2, explanation: '"반갑습니다" = Рад познакомиться'),
        ExamQuestion(question: '"고마워요" = ?', options: ['Пожалуйста', 'Привет', 'Спасибо (нефор.)', 'Пока'], correctIndex: 2, explanation: '"고마워요" = неформальное спасибо'),
        ExamQuestion(question: '"이름이 뭐예요?" = ?', options: ['Как дела?', 'Откуда ты?', 'Как тебя зовут?', 'Сколько лет?'], correctIndex: 2, explanation: '"이름이 뭐예요?" = Как тебя зовут?'),
        ExamQuestion(question: 'Формальное до свидания (уходя):', options: ['안녕하세요', '안녕히 계세요', '감사합니다', '안녕'], correctIndex: 1, explanation: '"안녕히 계세요" = До свидания (когда вы уходите)'),
        ExamQuestion(question: '"저는" = ?', options: ['ты', 'я (форм.)', 'он', 'мы'], correctIndex: 1, explanation: '"저는" = я (форм./вежл.). "나는" = я (неформально).'),
        ExamQuestion(question: 'Когда год создан алфавит хангыль?', options: ['1243', '1443', '1643', '1843'], correctIndex: 1, explanation: 'Хангыль создан в 1443 году по указу короля Седжона.'),
        ExamQuestion(question: '"천만에요" = ?', options: ['Спасибо', 'Пожалуйста', 'Привет', 'Хорошо'], correctIndex: 1, explanation: '"천만에요" = пожалуйста (ответ на спасибо)'),
        ExamQuestion(question: '"좋은 아침이에요" = ?', options: ['Добрый вечер', 'Добрый день', 'Доброе утро', 'Пока'], correctIndex: 2, explanation: '"좋은 아침이에요" = Доброе утро'),
        ExamQuestion(question: '"어디서 왔어요?" = ?', options: ['Как дела?', 'Откуда ты?', 'Как зовут?', 'Сколько лет?'], correctIndex: 1, explanation: '"어디서 왔어요?" = Откуда ты?'),
        ExamQuestion(question: 'В Хангыль буквы складываются в:', options: ['строки', 'слоги', 'иероглифы', 'блоки по 4'], correctIndex: 1, explanation: 'Буквы хангыль комбинируются в слоговые блоки.'),
      ],
    ),

    CourseChapter(
      id: 'ko_a1_02', title: '숫자와 색깔', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: '숫자 (Числа) 1–10',
          content: 'В корейском ДВЕ системы счёта:\n\nКорейская (для возраста, часов):\n하나 (hana) — 1\n둘 (dul) — 2\n셋 (set) — 3\n넷 (net) — 4\n다섯 (daseot) — 5\n여섯 (yeoseot) — 6\n일곱 (ilgop) — 7\n여덟 (yeodeol) — 8\n아홉 (ahop) — 9\n열 (yeol) — 10\n\nКитайская (для денег, дат, этажей):\n일(il) 이(i) 삼(sam) 사(sa) 오(o)\n육(yuk) 칠(chil) 팔(pal) 구(gu) 십(sip)',
          examples: ['저는 스물 살이에요. — Мне 20 лет.', '사과 다섯 개 — пять яблок', '몇 살이에요? — Сколько вам лет?'],
        ),
        TheorySection(
          title: '색깔 (Цвета)',
          content: '🔴 빨간색 (ppalgan saek) — красный\n🔵 파란색 (paran saek) — синий\n🟢 초록색 (chorok saek) — зелёный\n🟡 노란색 (noran saek) — жёлтый\n⚫ 검정색 (geomjeong saek) — чёрный\n⚪ 흰색 (huin saek) — белый\n🟠 주황색 (juhwang saek) — оранжевый\n🩷 분홍색 (bunhong saek) — розовый\n🟤 갈색 (gal saek) — коричневый\n\n"색" = цвет (можно сокращать: 빨간 = красный)',
          examples: ['하늘이 파래요. — Небо синее.', '빨간 사과 — красное яблоко', '초록색을 좋아해요. — Я люблю зелёный.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"다섯" (daseot) = ?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: '"다섯" = 5 (корейская система).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"빨간색" = ?', options: ['синий', 'зелёный', 'красный', 'жёлтый'], correctIndex: 2, explanation: '"빨간색" = красный цвет.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"열" (yeol) = ?', options: ['8', '9', '10', '11'], correctIndex: 2, explanation: '"열" = 10 (корейская система).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"노란색" = ?', options: ['белый', 'чёрный', 'жёлтый', 'оранжевый'], correctIndex: 2, explanation: '"노란색" = жёлтый.'),
        CourseExercise(type: ExerciseType.translation, question: '"하늘이 파래요" = ?', options: ['Море синее', 'Небо синее', 'Кот синий', 'Цветок синий'], correctIndex: 1, explanation: '"하늘" = небо, "파래요" = синее.'),
      ],
      exam: [
        ExamQuestion(question: '"여덟" (yeodeol) = ?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: '여덟 = 8 (корейская)'),
        ExamQuestion(question: '"초록색" = ?', options: ['красный', 'синий', 'зелёный', 'жёлтый'], correctIndex: 2, explanation: '초록색 = зелёный'),
        ExamQuestion(question: '"십이" (sibi) = ? (китайская система)', options: ['10', '11', '12', '13'], correctIndex: 2, explanation: '십(10) + 이(2) = 12'),
        ExamQuestion(question: '"검정색" = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: '검정색 = чёрный'),
        ExamQuestion(question: '"셋" (set) = ?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: '셋 = 3 (корейская система)'),
        ExamQuestion(question: '"흰색" = ?', options: ['чёрный', 'серый', 'белый', 'бежевый'], correctIndex: 2, explanation: '흰색 = белый'),
        ExamQuestion(question: 'Корейская система счёта используется для:', options: ['денег', 'дат', 'возраста', 'телефонов'], correctIndex: 2, explanation: 'Корейская система — для возраста, часов, предметов'),
        ExamQuestion(question: '"색" (saek) означает:', options: ['число', 'цвет', 'человек', 'день'], correctIndex: 1, explanation: '"색" = цвет'),
      ],
    ),

    CourseChapter(
      id: 'ko_a1_03', title: '가족', subtitle: 'Семья и родственники', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a1, order: 3, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(
          title: '가족 구성원 (члены семьи)',
          content: '아버지/아빠 (abeoji/appa) — отец/папа\n어머니/엄마 (eomeoni/eomma) — мать/мама\n아들 (adeul) — сын\n딸 (ttal) — дочь\n오빠 (oppa) — старший брат (для девушки)\n형 (hyeong) — старший брат (для юноши)\n언니 (eonni) — старшая сестра (для девушки)\n누나 (nuna) — старшая сестра (для юноши)\n남동생 (nam dongsaeng) — младший брат\n여동생 (yeo dongsaeng) — младшая сестра\n할아버지 — дедушка\n할머니 — бабушка\n부모님 — родители',
          examples: ['저는 오빠가 있어요. — У меня есть старший брат.', '우리 엄마 이름은 수진이에요. — Мою маму зовут Суджин.', '우리 가족은 네 명이에요. — В нашей семье 4 человека.'],
        ),
        TheorySection(
          title: '있어요/없어요 — есть/нет',
          content: '있어요 (isseoyo) — есть/имеется\n없어요 (eopseoyo) — нет/отсутствует\n\n저는 형이 있어요. — У меня есть старший брат.\n저는 형이 없어요. — У меня нет старшего брата.\n\n우리 (uri) — наш/наша:\n우리 엄마 — наша мама / моя мама\n우리 집 — наш дом\n\n몇 명이에요? — Сколько человек?',
          examples: ['동생이 있어요? — У вас есть младший брат/сестра?', '아니요, 없어요. — Нет, нет.', '우리 가족은 다섯 명이에요. — Нас в семье пятеро.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"엄마" (eomma) = ?', options: ['папа', 'мама', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"엄마" = мама (разг.).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"형이 있어요" = ?', options: ['нет брата', 'есть старший брат', 'мой брат', 'где брат?'], correctIndex: 1, explanation: '"있어요" = есть; "형" = старший брат (для юноши).'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"할아버지" = ?', options: ['папа', 'дядя', 'дедушка', 'брат'], correctIndex: 2, explanation: '"할아버지" = дедушка.'),
        CourseExercise(type: ExerciseType.translation, question: '"여동생이 있어요" = ?', options: ['У меня есть брат', 'У меня есть младшая сестра', 'У меня нет сестры', 'Моя сестра'], correctIndex: 1, explanation: '"여동생" = младшая сестра, "있어요" = есть.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"부모님" = ?', options: ['дети', 'бабушки', 'родители', 'братья'], correctIndex: 2, explanation: '"부모님" = родители (вежл.).'),
      ],
      exam: [
        ExamQuestion(question: '"할머니" = ?', options: ['тётя', 'мать', 'бабушка', 'сестра'], correctIndex: 2, explanation: '"할머니" = бабушка'),
        ExamQuestion(question: '"딸" (ttal) = ?', options: ['мать', 'сестра', 'дочь', 'тётя'], correctIndex: 2, explanation: '"딸" = дочь'),
        ExamQuestion(question: '"아들" (adeul) = ?', options: ['мать', 'сестра', 'дочь', 'сын'], correctIndex: 3, explanation: '"아들" = сын'),
        ExamQuestion(question: '"없어요" = ?', options: ['есть', 'нет', 'много', 'мало'], correctIndex: 1, explanation: '"없어요" = нет/отсутствует'),
        ExamQuestion(question: '"오빠" используется:', options: ['юношей о старшем брате', 'девушкой о старшем брате', 'всеми о любом брате', 'о младшем брате'], correctIndex: 1, explanation: '"오빠" — так девушка называет своего старшего брата'),
        ExamQuestion(question: '"우리 엄마" означает:', options: ['эта мама', 'моя/наша мама', 'её мама', 'чужая мама'], correctIndex: 1, explanation: '"우리" = наш/мой (в контексте семьи)'),
        ExamQuestion(question: '"남동생" = ?', options: ['старший брат', 'младший брат', 'старшая сестра', 'младшая сестра'], correctIndex: 1, explanation: '"남동생" = младший брат ("남" = мужской)'),
        ExamQuestion(question: '"몇 명이에요?" = ?', options: ['Как дела?', 'Сколько лет?', 'Сколько человек?', 'Где вы?'], correctIndex: 2, explanation: '"몇 명이에요?" = Сколько человек?'),
      ],
    ),
  ],
);

// ══════════════════════════════════════════════════════════════
//  АРАБСКИЙ ЯЗЫК
// ══════════════════════════════════════════════════════════════

const arabicCourse = LanguageCourse(
  langCode: 'ar',
  langName: 'Арабский',
  nativeName: 'العربية',
  flag: '🇸🇦',
  chapters: [
    CourseChapter(
      id: 'ar_a1_01', title: 'التحيات — Приветствия', subtitle: 'الكلمات الأساسية', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'Арабские приветствия',
          content: 'السلام عليكم (As-salāmu ʿalaykum) — Мир вам (формальное)\nوعليكم السلام (Wa ʿalaykum as-salām) — Ответ\nمرحبا (Marḥaban) — Привет\nصباح الخير (Ṣabāḥ al-khayr) — Доброе утро\nمساء الخير (Masāʾ al-khayr) — Добрый вечер\nمع السلامة (Maʿa s-salāma) — До свидания\nشكرا (Shukran) — Спасибо\nعفوا (ʿAfwan) — Пожалуйста / Извините\n\nПредставление:\nاسمي... (Ismi...) — Меня зовут...\nما اسمك؟ (Mā ismuk?) — Как тебя зовут?\nمن أين أنت؟ (Min ayna anta?) — Откуда ты?',
          examples: [
            'مرحبا! اسمي أحمد. — Привет! Меня зовут Ахмед.',
            'كيف حالك؟ — Как дела?  بخير شكرا — Хорошо, спасибо.',
            'مع السلامة! — До свидания!',
          ],
        ),
        TheorySection(
          title: 'Арабский алфавит — основы',
          content: 'Арабский пишется справа налево!\nВ алфавите 28 букв (только согласные).\nГласные обычно не пишутся (есть знаки огласовки).\n\nНесколько букв:\nا (alif) — долгое "а"\nب (bā) — "б"\nت (tā) — "т"\nث (thā) — "с/з"\nج (jīm) — "дж"\nد (dāl) — "д"\nر (rāʾ) — "р"\nس (sīn) — "с"\nع (ʿayn) — гортанный звук\nم (mīm) — "м"\nن (nūn) — "н"\nه (hāʾ) — "х"\nي (yāʾ) — "й/и"',
          examples: [
            'مرحبا = م+ر+ح+ب+ا = Marḥaban = Привет',
            'شكرا = ش+ك+ر+ا = Shukran = Спасибо',
          ],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"السلام عليكم" — это:', options: ['Спасибо', 'До свидания', 'Мир вам (приветствие)', 'Как дела?'], correctIndex: 2, explanation: '"السلام عليكم" — исламское приветствие "Мир вам".'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"شكرا" (Shukran) = ?', options: ['Пожалуйста', 'Привет', 'Спасибо', 'Пока'], correctIndex: 2, explanation: '"شكرا" = спасибо.'),
        CourseExercise(type: ExerciseType.translation, question: '"اسمي ليلى" = ?', options: ['Я из Саудовской Аравии', 'Меня зовут Лейла', 'Я студентка', 'Привет Лейла'], correctIndex: 1, explanation: '"اسمي" (ismi) = моё имя / меня зовут.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'В каком направлении пишется арабский?', options: ['слева направо', 'справа налево', 'сверху вниз', 'произвольно'], correctIndex: 1, explanation: 'Арабский (и иврит) пишутся справа налево.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"صباح الخير" = ?', options: ['Добрый вечер', 'Доброе утро', 'Привет', 'До свидания'], correctIndex: 1, explanation: '"صباح الخير" (Ṣabāḥ al-khayr) = Доброе утро.'),
      ],
      exam: [
        ExamQuestion(question: '"مساء الخير" = ?', options: ['Доброе утро', 'Добрый день', 'Добрый вечер', 'Спокойной ночи'], correctIndex: 2, explanation: '"مساء الخير" = Добрый вечер'),
        ExamQuestion(question: '"عفوا" = ?', options: ['Спасибо', 'Пожалуйста/Извините', 'Привет', 'Хорошо'], correctIndex: 1, explanation: '"عفوا" = пожалуйста (ответ на спасибо) / извините'),
        ExamQuestion(question: 'Сколько букв в арабском алфавите?', options: ['24', '26', '28', '32'], correctIndex: 2, explanation: 'В арабском алфавите 28 букв.'),
        ExamQuestion(question: '"مرحبا" = ?', options: ['Спасибо', 'До свидания', 'Привет', 'Доброе утро'], correctIndex: 2, explanation: '"مرحبا" (Marḥaban) = Привет'),
        ExamQuestion(question: '"كيف حالك؟" = ?', options: ['Как тебя зовут?', 'Откуда ты?', 'Как дела?', 'Сколько лет?'], correctIndex: 2, explanation: '"كيف حالك؟" = Как дела?'),
        ExamQuestion(question: '"مع السلامة" = ?', options: ['Привет', 'До свидания', 'Спасибо', 'Пожалуйста'], correctIndex: 1, explanation: '"مع السلامة" = До свидания (с миром)'),
        ExamQuestion(question: 'Ответ на "السلام عليكم":', options: ['شكرا', 'مرحبا', 'وعليكم السلام', 'مع السلامة'], correctIndex: 2, explanation: '"وعليكم السلام" — обязательный ответ на приветствие "Мир вам".'),
        ExamQuestion(question: '"بخير" = ?', options: ['плохо', 'нормально', 'хорошо', 'устал'], correctIndex: 2, explanation: '"بخير" = хорошо (в ответе на "как дела?")'),
        ExamQuestion(question: '"ما اسمك؟" = ?', options: ['Как дела?', 'Откуда ты?', 'Как тебя зовут?', 'Сколько лет?'], correctIndex: 2, explanation: '"ما اسمك؟" = Как тебя зовут?'),
        ExamQuestion(question: 'Гласные в арабском:', options: ['пишутся всегда', 'обычно не пишутся', 'пишутся только в детских книгах', 'всегда обозначаются'], correctIndex: 1, explanation: 'В обычных текстах гласные не пишутся, читатель знает их по контексту.'),
      ],
    ),

    CourseChapter(
      id: 'ar_a1_02', title: 'الأرقام والألوان', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(
          title: 'الأرقام 1–10 (Al-arqām)',
          content: 'واحد (wāḥid) — 1\nاثنان (ithnān) — 2\nثلاثة (thalātha) — 3\nأربعة (arbaʿa) — 4\nخمسة (khamsa) — 5\nستة (sitta) — 6\nسبعة (sabʿa) — 7\nثمانية (thamāniya) — 8\nتسعة (tisʿa) — 9\nعشرة (ʿashara) — 10\nعشرون (ʿishrūn) — 20\nمائة (miʾa) — 100\n\nكم عمرك؟ (Kam ʿumruk?) — Сколько тебе лет?\nعمري عشرون سنة. — Мне 20 лет.',
          examples: ['خمسة تفاحات — пять яблок', 'عشرة طلاب — десять студентов', 'ثلاثة وأربعة = سبعة — 3+4=7'],
        ),
        TheorySection(
          title: 'الألوان (Al-alwān) — Цвета',
          content: '🔴 أحمر (aḥmar) — красный\n🔵 أزرق (azraq) — синий\n🟢 أخضر (akhḍar) — зелёный\n🟡 أصفر (aṣfar) — жёлтый\n⚫ أسود (aswad) — чёрный\n⚪ أبيض (abyaḍ) — белый\n🟠 برتقالي (burtuqālī) — оранжевый\n🩷 وردي (wardī) — розовый\n🟤 بني (bunnī) — коричневый\n\nЖенские формы:\nحمراء (ḥamrāʾ) — красная\nزرقاء (zarqāʾ) — синяя',
          examples: ['السماء زرقاء. — Небо синее.', 'التفاحة حمراء. — Яблоко красное.', 'أحب اللون الأخضر. — Я люблю зелёный цвет.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"خمسة" (khamsa) = ?', options: ['3', '4', '5', '6'], correctIndex: 2, explanation: '"خمسة" = 5.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"أحمر" (aḥmar) = ?', options: ['синий', 'зелёный', 'красный', 'жёлтый'], correctIndex: 2, explanation: '"أحمر" = красный.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"عشرون" = ?', options: ['10', '15', '18', '20'], correctIndex: 3, explanation: '"عشرون" = 20.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"أصفر" (aṣfar) = ?', options: ['белый', 'чёрный', 'жёлтый', 'оранжевый'], correctIndex: 2, explanation: '"أصفر" = жёлтый.'),
        CourseExercise(type: ExerciseType.translation, question: '"السماء زرقاء" = ?', options: ['Море синее', 'Небо синее', 'Кот синий', 'Цветок синий'], correctIndex: 1, explanation: '"السماء" = небо, "زرقاء" = синяя (ж.р.).'),
      ],
      exam: [
        ExamQuestion(question: '"ثمانية" (thamāniya) = ?', options: ['6', '7', '8', '9'], correctIndex: 2, explanation: 'ثمانية = 8'),
        ExamQuestion(question: '"أخضر" = ?', options: ['красный', 'синий', 'зелёный', 'жёлтый'], correctIndex: 2, explanation: 'أخضر = зелёный'),
        ExamQuestion(question: '"اثنا عشر" = ?', options: ['10', '11', '12', '13'], correctIndex: 2, explanation: 'اثنا عشر = 12'),
        ExamQuestion(question: '"أسود" = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: 'أسود = чёрный'),
        ExamQuestion(question: '"ثلاثة" = ?', options: ['2', '3', '4', '5'], correctIndex: 1, explanation: 'ثلاثة = 3'),
        ExamQuestion(question: '"أبيض" = ?', options: ['чёрный', 'серый', 'белый', 'бежевый'], correctIndex: 2, explanation: 'أبيض = белый'),
        ExamQuestion(question: '"عشرة" = ?', options: ['8', '9', '10', '11'], correctIndex: 2, explanation: 'عشرة = 10'),
        ExamQuestion(question: 'Женская форма "أحمر" (красный):', options: ['أحمرة', 'حمراء', 'أحمري', 'حمرة'], correctIndex: 1, explanation: 'أحمر (м.р.) → حمراء (ж.р.)'),
      ],
    ),

    CourseChapter(
      id: 'ar_a1_03', title: 'الأسرة', subtitle: 'Семья и родственники', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a1, order: 3, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(
          title: 'أفراد الأسرة (Члены семьи)',
          content: 'الأب (al-ab) — отец\nالأم (al-umm) — мать\nالابن (al-ibn) — сын\nالبنت/الابنة (al-bint) — дочь\nالأخ (al-akh) — брат\nالأخت (al-ukht) — сестра\nالجد (al-jadd) — дедушка\nالجدة (al-jadda) — бабушка\nالزوج (az-zawj) — муж\nالزوجة (az-zawja) — жена\nالوالدان (al-wālidān) — родители\nالأولاد (al-awlād) — дети',
          examples: ['عندي أخ وأخت. — У меня есть брат и сестра.', 'اسم أمي فاطمة. — Мою маму зовут Фатима.', 'أسرتي مكونة من أربعة أفراد. — Моя семья состоит из 4 человек.'],
        ),
        TheorySection(
          title: 'عندي/ليس عندي — есть/нет',
          content: 'عندي (ʿindī) — у меня есть\nليس عندي (laysa ʿindī) — у меня нет\n\nАртикль ال (al-) = определённость:\nأخ — брат (какой-то)\nالأخ — этот брат\n\nАдъективное согласование:\nأخ كبير — старший брат\nأخت كبيرة — старшая сестра\n\nأبي — мой отец\nأمي — моя мать',
          examples: ['عندي أخ كبير. — У меня есть старший брат.', 'ليس عندي أخت. — У меня нет сестры.', 'أبي طبيب. — Мой отец врач.'],
        ),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"الأم" (al-umm) = ?', options: ['отец', 'мать', 'сестра', 'бабушка'], correctIndex: 1, explanation: '"الأم" = мать.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"عندي أخ" = ?', options: ['нет брата', 'есть брат', 'мой брат', 'где брат?'], correctIndex: 1, explanation: '"عندي" = у меня есть; "أخ" = брат.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"الجد" = ?', options: ['отец', 'дядя', 'дедушка', 'брат'], correctIndex: 2, explanation: '"الجد" = дедушка.'),
        CourseExercise(type: ExerciseType.translation, question: '"عندي أخت" = ?', options: ['У меня есть брат', 'У меня есть сестра', 'У меня нет сестры', 'Моя сестра'], correctIndex: 1, explanation: '"عندي" = у меня есть, "أخت" = сестра.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"الأولاد" = ?', options: ['родители', 'бабушки', 'дети', 'братья'], correctIndex: 2, explanation: '"الأولاد" = дети.'),
      ],
      exam: [
        ExamQuestion(question: '"الجدة" = ?', options: ['тётя', 'мать', 'бабушка', 'сестра'], correctIndex: 2, explanation: '"الجدة" = бабушка'),
        ExamQuestion(question: '"البنت" = ?', options: ['мать', 'сестра', 'дочь', 'тётя'], correctIndex: 2, explanation: '"البنت" = дочь/девочка'),
        ExamQuestion(question: '"الزوج" = ?', options: ['сын', 'брат', 'дядя', 'муж'], correctIndex: 3, explanation: '"الزوج" = муж'),
        ExamQuestion(question: '"ليس عندي أخت" = ?', options: ['у меня есть сестра', 'у меня нет сестры', 'моя сестра', 'где сестра?'], correctIndex: 1, explanation: '"ليس عندي" = у меня нет'),
        ExamQuestion(question: '"الابن" = ?', options: ['мать', 'сестра', 'дочь', 'сын'], correctIndex: 3, explanation: '"الابن" = сын'),
        ExamQuestion(question: '"أخت كبيرة" = ?', options: ['маленькая сестра', 'старшая сестра', 'младшая сестра', 'красивая сестра'], correctIndex: 1, explanation: '"كبيرة" = большая/старшая'),
        ExamQuestion(question: '"الوالدان" = ?', options: ['дети', 'родители', 'братья', 'дедушки'], correctIndex: 1, explanation: '"الوالدان" = оба родителя (двойственное число)'),
        ExamQuestion(question: '"أبي" = ?', options: ['твой отец', 'мой отец', 'его отец', 'наш отец'], correctIndex: 1, explanation: '"أبي" = мой отец ("أب" + "-ي" = мой)'),
      ],
    ),
  ],
);
