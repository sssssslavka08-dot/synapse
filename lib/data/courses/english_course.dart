import 'course_structure.dart';

const englishCourse = LanguageCourse(
  langCode: 'en',
  langName: 'Английский',
  nativeName: 'English',
  flag: '🇬🇧',
  chapters: [
    // ══════════════════════════════════════════════
    //  A1 — НАЧИНАЮЩИЙ
    // ══════════════════════════════════════════════

    CourseChapter(
      id: 'en_a1_01',
      title: 'Приветствия и знакомство',
      subtitle: 'Как сказать привет и представиться',
      emoji: '👋',
      level: LanguageLevel.a1,
      order: 1,
      coinsReward: 30,
      xpReward: 20,
      theory: [
        TheorySection(
          title: 'Приветствия',
          content:
              'В английском языке есть несколько способов поздороваться в зависимости от времени суток и формальности:\n\n'
              '• Hello / Hi — Привет (универсально)\n'
              '• Good morning — Доброе утро (до 12:00)\n'
              '• Good afternoon — Добрый день (12:00–18:00)\n'
              '• Good evening — Добрый вечер (после 18:00)\n'
              '• Good night — Спокойной ночи (прощание)\n\n'
              'Ответные фразы:\n'
              '• How are you? — Как дела?\n'
              '• I\'m fine, thank you — Хорошо, спасибо\n'
              '• Nice to meet you — Приятно познакомиться',
          examples: [
            'Hi! My name is Alex. — Привет! Меня зовут Алекс.',
            'Good morning! How are you? — Доброе утро! Как дела?',
            'I\'m fine, thanks! — Хорошо, спасибо!',
            'Nice to meet you! — Приятно познакомиться!',
          ],
        ),
        TheorySection(
          title: 'Представление',
          content:
              'Чтобы представиться по-английски используй:\n\n'
              '• My name is ... — Меня зовут ...\n'
              '• I am ... / I\'m ... — Я ...\n'
              '• I am from ... — Я из ...\n'
              '• I am ... years old — Мне ... лет\n\n'
              'Вопросы при знакомстве:\n'
              '• What is your name? — Как тебя зовут?\n'
              '• Where are you from? — Откуда ты?\n'
              '• How old are you? — Сколько тебе лет?',
          examples: [
            'My name is Maria. I am 12 years old. — Меня зовут Мария. Мне 12 лет.',
            'I am from Kazakhstan. — Я из Казахстана.',
            'What is your name? — My name is John. — Как тебя зовут? — Меня зовут Джон.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Как сказать "Доброе утро" по-английски?',
          options: ['Good night', 'Good morning', 'Good evening', 'Hello'],
          correctIndex: 1,
          explanation: '"Good morning" — это "Доброе утро", используется до полудня.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Что означает фраза "Nice to meet you"?',
          options: ['Пока', 'Хорошо', 'Приятно познакомиться', 'Как дела?'],
          correctIndex: 2,
          explanation: '"Nice to meet you" переводится как "Приятно познакомиться" — говорится при знакомстве.',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "Меня зовут Анна. Мне 10 лет."',
          options: [
            'My name is Anna. I am 10 years old.',
            'I name Anna. My 10 old.',
            'Name me Anna. Age 10.',
            'Anna name. 10 old I am.',
          ],
          correctIndex: 0,
          explanation: 'Правильная структура: "My name is [имя]." и "I am [возраст] years old."',
        ),
        CourseExercise(
          type: ExerciseType.fillBlank,
          question: 'Заполни пропуск: "_____ are you from?" (Откуда ты?)',
          options: ['What', 'How', 'Where', 'Who'],
          correctIndex: 2,
          explanation: '"Where" используется для вопросов о месте. "Where are you from?" — Откуда ты?',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '"I\'m fine, thank you" — что это означает?',
          options: ['Я устал', 'Хорошо, спасибо', 'Меня зовут...', 'Пока!'],
          correctIndex: 1,
          explanation: 'Это стандартный ответ на вопрос "How are you?" — означает "Хорошо, спасибо".',
        ),
      ],
      exam: [
        ExamQuestion(
          question: 'Как поздороваться по-английски вечером?',
          options: ['Good morning', 'Good afternoon', 'Good evening', 'Good night'],
          correctIndex: 2,
          explanation: '"Good evening" — вечернее приветствие (после 18:00).',
        ),
        ExamQuestion(
          question: 'Как спросить "Как тебя зовут?"',
          options: [
            'How are you?',
            'What is your name?',
            'Where are you from?',
            'How old are you?'
          ],
          correctIndex: 1,
          explanation: '"What is your name?" — Как тебя зовут?',
        ),
        ExamQuestion(
          question: 'Выбери правильный перевод: "Я из России"',
          options: ['I am Russia', 'I from Russia', 'I am from Russia', 'From Russia I'],
          correctIndex: 2,
          explanation: '"I am from [страна]" — стандартная конструкция для указания происхождения.',
        ),
        ExamQuestion(
          question: 'Что значит "How old are you?"',
          options: ['Как ты?', 'Откуда ты?', 'Сколько тебе лет?', 'Как тебя зовут?'],
          correctIndex: 2,
          explanation: '"How old are you?" дословно — "Как старый ты?" = "Сколько тебе лет?"',
        ),
        ExamQuestion(
          question: '"Hi! I\'m Tom." — Что говорит Том?',
          options: [
            'Пока! Я Том.',
            'Привет! Я Том.',
            'Доброе утро! Меня зовут Том.',
            'Спасибо! Я Том.',
          ],
          correctIndex: 1,
          explanation: '"Hi" = "Привет", "I\'m Tom" = "Я Том" (сокращение от "I am Tom").',
        ),
        ExamQuestion(
          question: 'Как ответить на вопрос "How are you?"',
          options: [
            'My name is Anna',
            'I am from London',
            'I\'m fine, thank you',
            'Good morning'
          ],
          correctIndex: 2,
          explanation: '"I\'m fine, thank you" — стандартный ответ "Хорошо, спасибо".',
        ),
        ExamQuestion(
          question: 'Правильная фраза: "Приятно познакомиться"',
          options: ['Good to know', 'Nice to meet you', 'Happy morning', 'Fine meet'],
          correctIndex: 1,
          explanation: '"Nice to meet you" — устойчивая фраза "Приятно познакомиться".',
        ),
        ExamQuestion(
          question: 'Как сказать "Мне 15 лет"?',
          options: [
            'I have 15 years',
            'My age is 15',
            'I am 15 years old',
            'Years 15 I'
          ],
          correctIndex: 2,
          explanation: 'По-английски возраст выражается: "I am [число] years old".',
        ),
        ExamQuestion(
          question: '"Good night" используется:',
          options: [
            'Как приветствие утром',
            'Как прощание вечером/ночью',
            'Вместо "Hello"',
            'Для знакомства',
          ],
          correctIndex: 1,
          explanation: '"Good night" — прощание в вечернее/ночное время, аналог "Спокойной ночи".',
        ),
        ExamQuestion(
          question: 'Переведи: "Hello! What is your name?"',
          options: [
            'Привет! Откуда ты?',
            'Добрый день! Сколько тебе лет?',
            'Привет! Как тебя зовут?',
            'Здравствуй! Как дела?',
          ],
          correctIndex: 2,
          explanation: '"Hello" = "Привет", "What is your name?" = "Как тебя зовут?".',
        ),
      ],
    ),

    CourseChapter(
      id: 'en_a1_02',
      title: 'Числа и алфавит',
      subtitle: 'Считаем и произносим буквы',
      emoji: '🔢',
      level: LanguageLevel.a1,
      order: 2,
      coinsReward: 30,
      xpReward: 20,
      theory: [
        TheorySection(
          title: 'Числа 1–20',
          content:
              'Основные числа по-английски:\n\n'
              '1 — one  |  2 — two  |  3 — three\n'
              '4 — four  |  5 — five  |  6 — six\n'
              '7 — seven  |  8 — eight  |  9 — nine\n'
              '10 — ten  |  11 — eleven  |  12 — twelve\n'
              '13 — thirteen  |  14 — fourteen  |  15 — fifteen\n'
              '16 — sixteen  |  17 — seventeen  |  18 — eighteen\n'
              '19 — nineteen  |  20 — twenty\n\n'
              'Круглые десятки:\n'
              '30 — thirty  |  40 — forty  |  50 — fifty\n'
              '60 — sixty  |  70 — seventy  |  80 — eighty  |  90 — ninety  |  100 — one hundred',
          examples: [
            'I have two cats. — У меня два кота.',
            'She is fifteen years old. — Ей пятнадцать лет.',
            'There are twenty students. — Там двадцать учеников.',
          ],
        ),
        TheorySection(
          title: 'Английский алфавит',
          content:
              'В английском алфавите 26 букв:\n\n'
              'A(эй) B(би) C(си) D(ди) E(и) F(эф) G(джи)\n'
              'H(эйч) I(ай) J(джей) K(кей) L(эл) M(эм) N(эн)\n'
              'O(оу) P(пи) Q(кью) R(ар) S(эс) T(ти) U(ю)\n'
              'V(ви) W(даблъю) X(экс) Y(уай) Z(зед/зи)\n\n'
              'Гласные: A, E, I, O, U (+ иногда Y)',
          examples: [
            'How do you spell your name? — Как пишется твоё имя?',
            'My name is KATE: K-A-T-E. — Моё имя KATE: К-А-Т-И.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Как написать число "15" по-английски?',
          options: ['fifty', 'five', 'fifteen', 'fiveteen'],
          correctIndex: 2,
          explanation: '15 = fifteen. Обрати внимание: 13=thirteen, 14=fourteen, 15=fifteen.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Сколько букв в английском алфавите?',
          options: ['24', '25', '26', '28'],
          correctIndex: 2,
          explanation: 'В английском алфавите ровно 26 букв.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '"Forty" — это какое число?',
          options: ['14', '40', '4', '400'],
          correctIndex: 1,
          explanation: '"Forty" = 40. Внимание: пишется "forty", не "fourty"!',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "I have twelve books."',
          options: [
            'У меня двенадцать книг.',
            'У меня двадцать книг.',
            'У меня двести книг.',
            'У меня двадцать два книги.',
          ],
          correctIndex: 0,
          explanation: '"twelve" = 12, "books" = книги.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Какая буква идёт после "M" в алфавите?',
          options: ['L', 'N', 'O', 'K'],
          correctIndex: 1,
          explanation: '...K L M N O P... — после M идёт N.',
        ),
      ],
      exam: [
        ExamQuestion(question: '"Twenty" = ?', options: ['12', '20', '22', '200'], correctIndex: 1, explanation: 'twenty = 20'),
        ExamQuestion(question: 'Как написать 8?', options: ['ate', 'eight', 'eighty', 'eigt'], correctIndex: 1, explanation: '8 = eight'),
        ExamQuestion(question: '"Ninety" = ?', options: ['9', '19', '90', '900'], correctIndex: 2, explanation: 'ninety = 90'),
        ExamQuestion(question: 'Гласные буквы в английском:', options: ['A,E,I,O,U', 'A,B,C,D', 'E,I,O,Y', 'A,I,U'], correctIndex: 0, explanation: 'Гласные: A, E, I, O, U'),
        ExamQuestion(question: '"Thirteen" = ?', options: ['3', '30', '13', '31'], correctIndex: 2, explanation: 'thirteen = 13'),
        ExamQuestion(question: 'She is ___ years old. (17)', options: ['seventy', 'seventeen', 'seven', 'seventeenth'], correctIndex: 1, explanation: '17 = seventeen'),
        ExamQuestion(question: 'Сколько гласных в английском?', options: ['4', '5', '6', '7'], correctIndex: 1, explanation: 'Гласных 5: A, E, I, O, U'),
        ExamQuestion(question: '"One hundred" = ?', options: ['10', '100', '1000', '110'], correctIndex: 1, explanation: 'one hundred = 100'),
        ExamQuestion(question: 'Буква после "Z":',options: ['A (алфавит закольцован)', 'Нет буквы', 'AA', 'ZZ'], correctIndex: 1, explanation: 'Z — последняя буква алфавита, после неё букв нет.'),
        ExamQuestion(question: '"Fifty" = ?', options: ['15', '50', '500', '5'], correctIndex: 1, explanation: 'fifty = 50'),
      ],
    ),

    CourseChapter(
      id: 'en_a1_03',
      title: 'Цвета и базовые прилагательные',
      subtitle: 'Описываем мир вокруг',
      emoji: '🎨',
      level: LanguageLevel.a1,
      order: 3,
      coinsReward: 35,
      xpReward: 25,
      theory: [
        TheorySection(
          title: 'Основные цвета',
          content:
              'Цвета по-английски:\n\n'
              '🔴 red — красный\n'
              '🔵 blue — синий\n'
              '🟢 green — зелёный\n'
              '🟡 yellow — жёлтый\n'
              '🟠 orange — оранжевый\n'
              '🟣 purple — фиолетовый\n'
              '⚫ black — чёрный\n'
              '⚪ white — белый\n'
              '🟤 brown — коричневый\n'
              '🩷 pink — розовый\n\n'
              'Прилагательные ставятся ПЕРЕД существительным:\n'
              'a red car — красная машина\n'
              'a big blue house — большой синий дом',
          examples: [
            'The sky is blue. — Небо синее.',
            'I have a red bag. — У меня красная сумка.',
            'She likes green apples. — Она любит зелёные яблоки.',
          ],
        ),
        TheorySection(
          title: 'Базовые прилагательные',
          content:
              'Описание размера и качества:\n\n'
              'big / large — большой\n'
              'small / little — маленький\n'
              'tall — высокий  |  short — низкий/короткий\n'
              'fast — быстрый  |  slow — медленный\n'
              'hot — горячий  |  cold — холодный\n'
              'new — новый  |  old — старый\n'
              'good — хороший  |  bad — плохой\n'
              'happy — счастливый  |  sad — грустный',
          examples: [
            'This is a big cat. — Это большой кот.',
            'The water is cold. — Вода холодная.',
            'She is very happy. — Она очень счастлива.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Что означает "yellow"?',
          options: ['синий', 'зелёный', 'жёлтый', 'красный'],
          correctIndex: 2,
          explanation: '"Yellow" = жёлтый. Как подсолнух или лимон.',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "a big red house"',
          options: ['красный маленький дом', 'большой красный дом', 'большой синий дом', 'маленький красный дом'],
          correctIndex: 1,
          explanation: 'big = большой, red = красный, house = дом.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Антоним слова "hot" (горячий):',
          options: ['warm', 'cold', 'cool', 'big'],
          correctIndex: 1,
          explanation: '"cold" = холодный — антоним слова "hot" (горячий).',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '"The sky is ___." (Небо синее)',
          options: ['green', 'red', 'blue', 'yellow'],
          correctIndex: 2,
          explanation: 'Небо синее = The sky is blue.',
        ),
        CourseExercise(
          type: ExerciseType.trueOrFalse,
          question: '"Purple" означает "розовый".',
          options: ['Верно', 'Неверно'],
          correctIndex: 1,
          explanation: '"Purple" = фиолетовый. Розовый = "pink".',
        ),
      ],
      exam: [
        ExamQuestion(question: '"Black" = ?', options: ['белый', 'серый', 'чёрный', 'тёмный'], correctIndex: 2, explanation: 'black = чёрный'),
        ExamQuestion(question: 'Переведи "маленький":', options: ['big', 'tall', 'small', 'short'], correctIndex: 2, explanation: 'small = маленький'),
        ExamQuestion(question: 'Где ставится прилагательное?', options: ['после существительного', 'перед существительным', 'в конце предложения', 'перед глаголом'], correctIndex: 1, explanation: 'В английском прилагательное всегда перед существительным: a RED car.'),
        ExamQuestion(question: '"Happy" антоним:', options: ['good', 'bad', 'sad', 'angry'], correctIndex: 2, explanation: 'sad (грустный) — антоним happy (счастливый).'),
        ExamQuestion(question: '"Pink" = ?', options: ['фиолетовый', 'оранжевый', 'розовый', 'красный'], correctIndex: 2, explanation: 'pink = розовый'),
        ExamQuestion(question: 'a ___ cat (большой кот)', options: ['small', 'big', 'old', 'fast'], correctIndex: 1, explanation: 'big = большой.'),
        ExamQuestion(question: '"Slow" — антоним:', options: ['big', 'fast', 'cold', 'bad'], correctIndex: 1, explanation: 'fast (быстрый) — антоним slow (медленный).'),
        ExamQuestion(question: '"Brown" = ?', options: ['синий', 'зелёный', 'коричневый', 'серый'], correctIndex: 2, explanation: 'brown = коричневый'),
        ExamQuestion(question: 'Выбери прилагательное:', options: ['run', 'table', 'beautiful', 'go'], correctIndex: 2, explanation: '"beautiful" — прилагательное (красивый). Остальные — глагол или существительное.'),
        ExamQuestion(question: '"New" антоним:', options: ['big', 'good', 'old', 'fast'], correctIndex: 2, explanation: 'old (старый) — антоним new (новый).'),
      ],
    ),

    // ══════════════════════════════════════════════
    //  A2 — ЭЛЕМЕНТАРНЫЙ
    // ══════════════════════════════════════════════

    CourseChapter(
      id: 'en_a2_01',
      title: 'Настоящее простое время',
      subtitle: 'Present Simple — ежедневные действия',
      emoji: '⏰',
      level: LanguageLevel.a2,
      order: 4,
      coinsReward: 50,
      xpReward: 35,
      theory: [
        TheorySection(
          title: 'Present Simple — образование',
          content:
              'Present Simple используется для:\n'
              '• Регулярных действий (I eat breakfast every day)\n'
              '• Фактов и постоянных истин (The sun rises in the east)\n'
              '• Расписаний (The train leaves at 8 am)\n\n'
              'Образование:\n'
              '• I/You/We/They + глагол: I work, You play\n'
              '• He/She/It + глагол+s/es: He works, She plays\n\n'
              'Отрицание:\n'
              '• I/You/We/They + do not (don\'t) + глагол\n'
              '• He/She/It + does not (doesn\'t) + глагол\n\n'
              'Вопрос:\n'
              '• Do + I/You/We/They + глагол?\n'
              '• Does + He/She/It + глагол?',
          examples: [
            'I eat breakfast at 7 am. — Я завтракаю в 7 утра.',
            'She works in a bank. — Она работает в банке.',
            'They don\'t play football. — Они не играют в футбол.',
            'Does he like music? — Он любит музыку?',
          ],
          tables: [
            GrammarTable(
              title: 'Утвердительная форма',
              headers: ['Местоимение', 'Глагол', 'Пример'],
              rows: [
                ['I', 'work', 'I work every day'],
                ['You/We/They', 'work', 'They work here'],
                ['He/She/It', 'works (+s)', 'She works at home'],
              ],
            ),
          ],
        ),
        TheorySection(
          title: 'Наречия частоты',
          content:
              'С Present Simple часто используются:\n\n'
              'always — всегда (100%)\n'
              'usually — обычно (80%)\n'
              'often — часто (60%)\n'
              'sometimes — иногда (40%)\n'
              'rarely / seldom — редко (20%)\n'
              'never — никогда (0%)\n\n'
              'Позиция: перед основным глаголом, но после "to be"\n'
              'I always drink coffee. (перед глаголом)\n'
              'She is never late. (после "is")',
          examples: [
            'I always wake up at 7. — Я всегда просыпаюсь в 7.',
            'He sometimes plays chess. — Иногда он играет в шахматы.',
            'We never eat fast food. — Мы никогда не едим фастфуд.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'She ___ (to work) every day.',
          options: ['work', 'works', 'working', 'worked'],
          correctIndex: 1,
          explanation: 'С He/She/It добавляем -s к глаголу: she works.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'They ___ (not play) football.',
          options: ['don\'t play', 'doesn\'t play', 'not play', 'plays not'],
          correctIndex: 0,
          explanation: 'They → используем "don\'t": They don\'t play.',
        ),
        CourseExercise(
          type: ExerciseType.fillBlank,
          question: '___ he like pizza? (Does/Do)',
          options: ['Do', 'Does', 'Is', 'Are'],
          correctIndex: 1,
          explanation: 'Для he/she/it в вопросе используем "Does".',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "Я всегда пью кофе утром."',
          options: [
            'I always drinks coffee in the morning.',
            'I always drink coffee in the morning.',
            'I usually drink coffee morning.',
            'Always I drink coffee morning.',
          ],
          correctIndex: 1,
          explanation: 'I + всегда (always) + глагол (drink) + остальное.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Present Simple используется для:',
          options: [
            'действий в прошлом',
            'регулярных/привычных действий',
            'действий прямо сейчас',
            'будущих планов',
          ],
          correctIndex: 1,
          explanation: 'Present Simple — для регулярных, привычных действий и фактов.',
        ),
      ],
      exam: [
        ExamQuestion(question: 'He ___ (to go) to school.', options: ['go', 'goes', 'going', 'gone'], correctIndex: 1, explanation: 'He → goes (He/She/It + глагол+s)'),
        ExamQuestion(question: 'We ___ (not eat) meat.', options: ['doesn\'t eat', 'don\'t eat', 'not eat', 'don\'t eats'], correctIndex: 1, explanation: 'We → don\'t eat'),
        ExamQuestion(question: 'Где ставится "always"?', options: ['в конце', 'перед глаголом', 'после объекта', 'в начале всегда'], correctIndex: 1, explanation: 'Наречие частоты ставится перед основным глаголом: I always eat...'),
        ExamQuestion(question: '___ you speak English?', options: ['Does', 'Do', 'Is', 'Are'], correctIndex: 1, explanation: 'You → Do (Do you...?)'),
        ExamQuestion(question: 'She doesn\'t ___ coffee.', options: ['drinks', 'drink', 'drinking', 'drank'], correctIndex: 1, explanation: 'После "doesn\'t" глагол без -s: doesn\'t drink.'),
        ExamQuestion(question: '"Never" означает:', options: ['всегда', 'иногда', 'никогда', 'обычно'], correctIndex: 2, explanation: '"Never" = никогда.'),
        ExamQuestion(question: 'The sun ___ (to rise) in the east.', options: ['rise', 'rises', 'rising', 'risen'], correctIndex: 1, explanation: 'Факт о природе → Present Simple: The sun rises.'),
        ExamQuestion(question: 'Correct sentence:', options: ['She go to work', 'She goes to work', 'She going to work', 'She to go work'], correctIndex: 1, explanation: 'She goes to work — правильное Present Simple для she.'),
        ExamQuestion(question: 'Do they like ___ music?', options: ['an', 'a', '-', 'the'], correctIndex: 2, explanation: 'Перед "music" артикль не нужен (не считаемое существительное).'),
        ExamQuestion(question: '"Usually" = ?', options: ['никогда', 'всегда', 'иногда', 'обычно'], correctIndex: 3, explanation: '"Usually" = обычно (около 80% случаев).'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_02',
      title: 'Семья и дом',
      subtitle: 'Рассказываем о близких людях',
      emoji: '🏠',
      level: LanguageLevel.a2,
      order: 5,
      coinsReward: 50,
      xpReward: 35,
      theory: [
        TheorySection(
          title: 'Члены семьи',
          content:
              'Семья по-английски:\n\n'
              'mother / mom — мама  |  father / dad — папа\n'
              'parents — родители\n'
              'sister — сестра  |  brother — брат\n'
              'grandmother / grandma — бабушка\n'
              'grandfather / grandpa — дедушка\n'
              'grandparents — дедушка и бабушка\n'
              'aunt — тётя  |  uncle — дядя\n'
              'cousin — двоюродный брат/сестра\n'
              'son — сын  |  daughter — дочь\n'
              'husband — муж  |  wife — жена',
          examples: [
            'My mother is a teacher. — Моя мама — учительница.',
            'I have one sister and two brothers. — У меня одна сестра и два брата.',
            'My grandparents live in the village. — Мои бабушка и дедушка живут в деревне.',
          ],
        ),
        TheorySection(
          title: 'Дом и комнаты',
          content:
              'Помещения дома:\n\n'
              'house — дом  |  apartment — квартира\n'
              'room — комната\n'
              'living room — гостиная  |  bedroom — спальня\n'
              'kitchen — кухня  |  bathroom — ванная\n'
              'dining room — столовая  |  hall — коридор\n'
              'garden — сад  |  garage — гараж\n\n'
              'Мебель:\n'
              'table — стол  |  chair — стул  |  bed — кровать\n'
              'sofa — диван  |  wardrobe — шкаф',
          examples: [
            'We have a big kitchen. — У нас большая кухня.',
            'My bedroom is on the second floor. — Моя спальня на втором этаже.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '"Grandmother" — это:',
          options: ['тётя', 'бабушка', 'мама', 'сестра'],
          correctIndex: 1,
          explanation: '"Grandmother" = бабушка. Разговорный вариант: "grandma".',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '"Kitchen" — это:',
          options: ['спальня', 'гостиная', 'кухня', 'ванная'],
          correctIndex: 2,
          explanation: '"Kitchen" = кухня.',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "My father is a doctor."',
          options: [
            'Мой брат — доктор.',
            'Мой отец — доктор.',
            'Мой дядя — доктор.',
            'Мой сын — доктор.',
          ],
          correctIndex: 1,
          explanation: '"father" = отец/папа, "doctor" = доктор.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Противоположность "son" (сын):',
          options: ['brother', 'father', 'daughter', 'uncle'],
          correctIndex: 2,
          explanation: '"daughter" = дочь — противоположность "son" (сын).',
        ),
        CourseExercise(
          type: ExerciseType.fillBlank,
          question: 'I live in a small ___. (квартира)',
          options: ['house', 'apartment', 'room', 'kitchen'],
          correctIndex: 1,
          explanation: '"apartment" = квартира (особенно в американском английском). В британском: "flat".',
        ),
      ],
      exam: [
        ExamQuestion(question: '"Husband" = ?', options: ['жена', 'муж', 'сын', 'брат'], correctIndex: 1, explanation: 'husband = муж'),
        ExamQuestion(question: '"Bedroom" — это:', options: ['кухня', 'ванная', 'спальня', 'гостиная'], correctIndex: 2, explanation: 'bedroom = спальня'),
        ExamQuestion(question: '"Cousin" — это:', options: ['тётя', 'двоюродный брат/сестра', 'друг', 'сосед'], correctIndex: 1, explanation: 'cousin = двоюродный брат или двоюродная сестра'),
        ExamQuestion(question: 'Мебель (furniture): выбери лишнее', options: ['table', 'chair', 'kitchen', 'sofa'], correctIndex: 2, explanation: '"kitchen" — это комната, не мебель.'),
        ExamQuestion(question: '"Parents" — это:', options: ['дети', 'бабушка и дедушка', 'родители', 'братья и сёстры'], correctIndex: 2, explanation: '"parents" = родители (мама + папа).'),
        ExamQuestion(question: 'My sister\'s son is my ___:', options: ['cousin', 'nephew', 'uncle', 'brother'], correctIndex: 1, explanation: 'nephew = племянник (сын сестры или брата).'),
        ExamQuestion(question: '"Living room" = ?', options: ['спальня', 'столовая', 'гостиная', 'кухня'], correctIndex: 2, explanation: 'living room = гостиная'),
        ExamQuestion(question: '"Wardrobe" — это:', options: ['кровать', 'стул', 'стол', 'шкаф'], correctIndex: 3, explanation: 'wardrobe = шкаф (для одежды).'),
        ExamQuestion(question: 'Какое слово НЕ относится к комнатам:', options: ['bathroom', 'bedroom', 'sofa', 'kitchen'], correctIndex: 2, explanation: '"sofa" — это мебель, не комната.'),
        ExamQuestion(question: '"Grandparents" — это:', options: ['дедушка', 'бабушка', 'бабушка и дедушка', 'родители'], correctIndex: 2, explanation: '"grandparents" = оба прародителя (grandma + grandpa).'),
      ],
    ),

    // ══════════════════════════════════════════════
    //  B1 — СРЕДНИЙ
    // ══════════════════════════════════════════════

    CourseChapter(
      id: 'en_b1_01',
      title: 'Прошедшее время (Past Simple)',
      subtitle: 'Рассказываем о прошлом',
      emoji: '📅',
      level: LanguageLevel.b1,
      order: 6,
      coinsReward: 70,
      xpReward: 50,
      theory: [
        TheorySection(
          title: 'Past Simple — правильные глаголы',
          content:
              'Past Simple используется для завершённых действий в прошлом.\n\n'
              'Правильные глаголы → добавляем -ed:\n'
              'work → worked  |  play → played\n'
              'live → lived  |  study → studied\n'
              'watch → watched  |  cook → cooked\n\n'
              'Отрицание: did not (didn\'t) + глагол без -ed\n'
              'Вопрос: Did + подлежащее + глагол?\n\n'
              'Маркеры времени:\n'
              'yesterday — вчера  |  last week/year — на прошлой неделе/в прошлом году\n'
              'ago — назад: two days ago — два дня назад',
          examples: [
            'I watched a movie yesterday. — Я смотрел фильм вчера.',
            'She didn\'t cook dinner last night. — Она не готовила ужин прошлым вечером.',
            'Did you study English last year? — Ты учил английский в прошлом году?',
          ],
        ),
        TheorySection(
          title: 'Неправильные глаголы',
          content:
              'Наиболее важные неправильные глаголы:\n\n'
              'go → went (идти)  |  come → came (прийти)\n'
              'see → saw (видеть)  |  know → knew (знать)\n'
              'take → took (взять)  |  give → gave (дать)\n'
              'get → got (получить)  |  make → made (делать)\n'
              'say → said (сказать)  |  think → thought (думать)\n'
              'find → found (найти)  |  leave → left (уйти)\n'
              'buy → bought (купить)  |  eat → ate (есть)\n'
              'write → wrote (писать)  |  read → read (читать)',
          examples: [
            'He went to Paris last summer. — Прошлым летом он поехал в Париж.',
            'We ate pizza for dinner. — На ужин мы ели пиццу.',
            'She wrote a letter to her friend. — Она написала письмо подруге.',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'I ___ (to watch) TV yesterday.',
          options: ['watch', 'watching', 'watched', 'watches'],
          correctIndex: 2,
          explanation: 'Past Simple правильного глагола: watch → watched.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Past Simple от "go":',
          options: ['goed', 'goes', 'gone', 'went'],
          correctIndex: 3,
          explanation: '"go" — неправильный глагол: go → went (Past Simple).',
        ),
        CourseExercise(
          type: ExerciseType.fillBlank,
          question: 'She ___ (not come) to school yesterday.',
          options: ['didn\'t came', 'didn\'t come', 'doesn\'t come', 'not came'],
          correctIndex: 1,
          explanation: 'Отрицание Past Simple: didn\'t + глагол (без -ed): didn\'t come.',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: '___ you see him last week?',
          options: ['Do', 'Does', 'Did', 'Was'],
          correctIndex: 2,
          explanation: 'Вопрос в Past Simple: Did + подлежащее + глагол?',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи: "Два дня назад мы купили машину."',
          options: [
            'Two days ago we buyed a car.',
            'Two days ago we buy a car.',
            'Two days ago we bought a car.',
            'Two days ago we buying a car.',
          ],
          correctIndex: 2,
          explanation: '"buy" → нерегулярный глагол: bought. "Two days ago" = два дня назад.',
        ),
      ],
      exam: [
        ExamQuestion(question: 'Past Simple от "eat":', options: ['eated', 'ate', 'eaten', 'eatd'], correctIndex: 1, explanation: 'eat → ate (неправильный глагол)'),
        ExamQuestion(question: 'They ___ football yesterday.', options: ['play', 'plays', 'played', 'playing'], correctIndex: 2, explanation: 'play → played (правильный глагол в Past Simple)'),
        ExamQuestion(question: 'She didn\'t ___ him.', options: ['saw', 'seen', 'see', 'sees'], correctIndex: 2, explanation: 'После "didn\'t" — глагол в базовой форме: didn\'t see.'),
        ExamQuestion(question: '"Last year" означает:', options: ['в следующем году', 'в прошлом году', 'каждый год', 'в этом году'], correctIndex: 1, explanation: '"Last year" = в прошлом году.'),
        ExamQuestion(question: 'Past Simple от "write":', options: ['writed', 'wrote', 'written', 'writes'], correctIndex: 1, explanation: 'write → wrote (неправильный глагол)'),
        ExamQuestion(question: '___ he go to work yesterday?', options: ['Does', 'Is', 'Did', 'Was'], correctIndex: 2, explanation: 'Вопрос в Past Simple: Did he go...?'),
        ExamQuestion(question: '"Two days ago" — в каком времени?', options: ['Present Simple', 'Past Simple', 'Future Simple', 'Present Perfect'], correctIndex: 1, explanation: '"Two days ago" — маркер прошедшего времени (Past Simple).'),
        ExamQuestion(question: 'I ___ (to buy) a new phone.', options: ['buyed', 'buy', 'bought', 'buying'], correctIndex: 2, explanation: 'buy → bought (неправильный глагол)'),
        ExamQuestion(question: 'We didn\'t ___ the movie.', options: ['liked', 'like', 'likes', 'liking'], correctIndex: 1, explanation: 'После "didn\'t" — базовая форма: didn\'t like.'),
        ExamQuestion(question: '"Yesterday" — маркер времени:', options: ['Present Simple', 'Past Simple', 'Future', 'Present Continuous'], correctIndex: 1, explanation: '"Yesterday" (вчера) — маркер Past Simple.'),
      ],
    ),

    // A1 continued
    CourseChapter(
      id: 'en_a1_04', title: 'Еда и напитки', subtitle: 'Food & Drinks — вкусный словарный запас', emoji: '🍎',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'Продукты и блюда:\nbread — хлеб | butter — масло | cheese — сыр\nmeat — мясо | fish — рыба | chicken — курица\nrice — рис | pasta — паста | soup — суп\nsalad — салат | egg — яйцо | sandwich — бутерброд\n\nПриёмы пищи:\nbreakfast — завтрак | lunch — обед | dinner — ужин\nsnack — перекус', examples: ['I eat rice for lunch. — Я ем рис на обед.', 'She likes chicken soup. — Ей нравится куриный суп.']),
        TheorySection(title: 'Напитки', content: 'Популярные напитки:\nwater — вода | juice — сок | milk — молоко\ntea — чай | coffee — кофе | lemonade — лимонад\nI like/love — мне нравится/я люблю\nI don\'t like — мне не нравится', examples: ['I love orange juice. — Я обожаю апельсиновый сок.', 'Do you drink coffee? — Ты пьёшь кофе?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Breakfast" — это:', options: ['обед', 'ужин', 'завтрак', 'перекус'], correctIndex: 2, explanation: 'breakfast = завтрак'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как сказать "вода" по-английски?', options: ['milk', 'juice', 'water', 'tea'], correctIndex: 2, explanation: 'water = вода'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "I like cheese and bread."', options: ['Мне нравится сыр и хлеб.', 'Мне не нравится сыр и хлеб.', 'Я ем сыр и масло.', 'Мне нравится мясо и рыба.'], correctIndex: 0, explanation: 'like = нравится, cheese = сыр, bread = хлеб.'),
      ],
      exam: [
        ExamQuestion(question: '"Dinner" = ?', options: ['завтрак', 'обед', 'ужин', 'перекус'], correctIndex: 2, explanation: 'dinner = ужин'),
        ExamQuestion(question: '"Milk" = ?', options: ['вода', 'сок', 'кофе', 'молоко'], correctIndex: 3, explanation: 'milk = молоко'),
        ExamQuestion(question: '"Fish" = ?', options: ['мясо', 'курица', 'рыба', 'яйцо'], correctIndex: 2, explanation: 'fish = рыба'),
        ExamQuestion(question: 'I ___ orange juice. (люблю)', options: ['hate', 'love', 'eat', 'drink'], correctIndex: 1, explanation: 'love = любить/обожать'),
        ExamQuestion(question: '"Egg" = ?', options: ['сыр', 'масло', 'хлеб', 'яйцо'], correctIndex: 3, explanation: 'egg = яйцо'),
      ],
    ),

    CourseChapter(
      id: 'en_a1_05', title: 'Тело и здоровье', subtitle: 'Body & Health — говорим о самочувствии', emoji: '🩺',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Части тела', content: 'Тело человека:\nhead — голова | face — лицо | eye — глаз\near — ухо | nose — нос | mouth — рот\nneck — шея | shoulder — плечо | arm — рука (вся)\nhand — кисть | finger — палец | chest — грудь\nstomach — живот | leg — нога (вся) | foot — стопа', examples: ['My head hurts. — У меня болит голова.', 'She has brown eyes. — У неё карие глаза.']),
        TheorySection(title: 'Самочувствие', content: 'Как описать состояние здоровья:\nI feel... — Я чувствую себя...\ngood/well — хорошо | bad/sick — плохо/больным\ntired — уставшим | happy — счастливым\nI have a headache — У меня болит голова\nI have a cold — Я простужен\nI have a fever — У меня температура\nGo to the doctor — Идти к врачу', examples: ['I feel sick today. — Сегодня я чувствую себя плохо.', 'She has a headache. — У неё болит голова.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Head" — это:', options: ['рука', 'нога', 'голова', 'спина'], correctIndex: 2, explanation: 'head = голова'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I have a cold" означает:', options: ['Мне холодно', 'Я простужен', 'У меня температура', 'Я устал'], correctIndex: 1, explanation: '"Have a cold" = быть простуженным'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "My leg hurts."', options: ['У меня болит рука.', 'У меня болит нога.', 'У меня болит голова.', 'У меня болит живот.'], correctIndex: 1, explanation: 'leg = нога, hurts = болит'),
      ],
      exam: [
        ExamQuestion(question: '"Eye" = ?', options: ['ухо', 'нос', 'глаз', 'рот'], correctIndex: 2, explanation: 'eye = глаз'),
        ExamQuestion(question: '"Tired" = ?', options: ['больной', 'счастливый', 'злой', 'уставший'], correctIndex: 3, explanation: 'tired = уставший'),
        ExamQuestion(question: '"Stomach" = ?', options: ['грудь', 'живот', 'спина', 'плечо'], correctIndex: 1, explanation: 'stomach = живот'),
        ExamQuestion(question: 'I feel ___. (плохо)', options: ['good', 'well', 'bad', 'happy'], correctIndex: 2, explanation: 'bad = плохо'),
        ExamQuestion(question: '"Finger" = ?', options: ['рука', 'ладонь', 'палец', 'плечо'], correctIndex: 2, explanation: 'finger = палец'),
      ],
    ),

    CourseChapter(
      id: 'en_a1_06', title: 'Время и дни недели', subtitle: 'Time & Calendar — ориентируемся во времени', emoji: '📅',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели и месяцы', content: 'Дни недели:\nMonday — понедельник | Tuesday — вторник\nWednesday — среда | Thursday — четверг\nFriday — пятница | Saturday — суббота | Sunday — воскресенье\n\nМесяцы:\nJanuary, February, March, April, May, June\nJuly, August, September, October, November, December\n\nВсе дни и месяцы пишутся с ЗАГЛАВНОЙ буквы!', examples: ['Today is Monday. — Сегодня понедельник.', 'My birthday is in July. — Мой день рождения в июле.']),
        TheorySection(title: 'Время суток', content: 'Как говорить о времени:\nWhat time is it? — Который час?\nIt is 3 o\'clock. — Три часа.\nIt\'s half past two. — Половина третьего. (2:30)\nIt\'s a quarter past four. — Четверть пятого. (4:15)\nIt\'s a quarter to five. — Без четверти пять. (4:45)\nin the morning — утром | in the afternoon — днём\nin the evening — вечером | at night — ночью', examples: ['What time is it? — It\'s 7 o\'clock. — Сколько времени? — Семь часов.', 'I wake up at 7 in the morning. — Я просыпаюсь в 7 утра.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Какой день идёт после Wednesday?', options: ['Tuesday', 'Thursday', 'Friday', 'Monday'], correctIndex: 1, explanation: 'Monday-Tuesday-Wednesday-Thursday...'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"It\'s half past three" = ?', options: ['3:15', '3:30', '3:45', '4:30'], correctIndex: 1, explanation: '"half past" = 30 минут. Half past three = 3:30.'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Today is Friday."', options: ['Сегодня четверг.', 'Сегодня пятница.', 'Сегодня суббота.', 'Сегодня среда.'], correctIndex: 1, explanation: 'Friday = пятница'),
      ],
      exam: [
        ExamQuestion(question: '"Wednesday" = ?', options: ['вторник', 'среда', 'четверг', 'пятница'], correctIndex: 1, explanation: 'Wednesday = среда'),
        ExamQuestion(question: '"In the evening" = ?', options: ['утром', 'днём', 'вечером', 'ночью'], correctIndex: 2, explanation: 'in the evening = вечером'),
        ExamQuestion(question: '"August" — это месяц:', options: ['6й', '7й', '8й', '9й'], correctIndex: 2, explanation: 'August = август = 8й месяц'),
        ExamQuestion(question: '"It\'s a quarter past five" = ?', options: ['5:00', '5:15', '5:30', '5:45'], correctIndex: 1, explanation: '"a quarter past" = 15 минут после = 5:15'),
        ExamQuestion(question: '"Sunday" — это:', options: ['суббота', 'воскресенье', 'понедельник', 'пятница'], correctIndex: 1, explanation: 'Sunday = воскресенье'),
      ],
    ),

    CourseChapter(
      id: 'en_a1_07', title: 'Животные и природа', subtitle: 'Animals & Nature — живой мир', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Животные', content: 'Домашние животные:\ndog — собака | cat — кошка | bird — птица\nfish — рыба | rabbit — кролик | hamster — хомяк\n\nДикие животные:\nlion — лев | tiger — тигр | elephant — слон\nbear — медведь | wolf — волк | fox — лиса\nhorse — лошадь | cow — корова | sheep — овца', examples: ['I have a dog and a cat. — У меня есть собака и кошка.', 'The lion is big and strong. — Лев большой и сильный.']),
        TheorySection(title: 'Природа', content: 'Природные объекты:\ntree — дерево | flower — цветок | grass — трава\nriver — река | lake — озеро | sea/ocean — море/океан\nmountain — гора | forest — лес | sky — небо\ncloud — облако | sun — солнце | moon — луна | star — звезда', examples: ['The sky is full of stars. — Небо полно звёзд.', 'There is a big forest near our city. — Рядом с нашим городом большой лес.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Wolf" = ?', options: ['лиса', 'медведь', 'волк', 'тигр'], correctIndex: 2, explanation: 'wolf = волк'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Tree" = ?', options: ['трава', 'цветок', 'дерево', 'лес'], correctIndex: 2, explanation: 'tree = дерево'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "There is a river near the mountain."', options: ['Рядом с горой есть река.', 'Рядом с озером есть лес.', 'Рядом с рекой есть гора.', 'На горе есть озеро.'], correctIndex: 0, explanation: 'river = река, mountain = гора, near = рядом'),
      ],
      exam: [
        ExamQuestion(question: '"Bear" = ?', options: ['лев', 'тигр', 'волк', 'медведь'], correctIndex: 3, explanation: 'bear = медведь'),
        ExamQuestion(question: '"Ocean" = ?', options: ['река', 'озеро', 'океан', 'гора'], correctIndex: 2, explanation: 'ocean = океан'),
        ExamQuestion(question: '"Rabbit" — домашнее животное?', options: ['Нет', 'Да', 'Только дикое', 'Зависит от страны'], correctIndex: 1, explanation: 'rabbit (кролик) — часто держат дома.'),
        ExamQuestion(question: '"Star" = ?', options: ['солнце', 'луна', 'звезда', 'облако'], correctIndex: 2, explanation: 'star = звезда'),
        ExamQuestion(question: '"Horse" = ?', options: ['корова', 'овца', 'лошадь', 'свинья'], correctIndex: 2, explanation: 'horse = лошадь'),
      ],
    ),

    CourseChapter(
      id: 'en_a1_08', title: 'Базовые глаголы', subtitle: 'Basic Verbs — самые нужные действия', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Глагол to be', content: '"To be" (быть) — важнейший глагол:\nI am (I\'m) — я есть/являюсь\nYou are (You\'re) — ты есть\nHe/She/It is (He\'s) — он/она/оно\nWe/You/They are (We\'re) — мы/вы/они\n\nОтрицание:\nI am not (I\'m not)\nHe is not (He\'s not / He isn\'t)\nThey are not (They\'re not / They aren\'t)\n\nВопрос: Am I? / Are you? / Is he?', examples: ['I am a student. — Я студент.', 'Is she your sister? — Она твоя сестра?', 'They are not at home. — Их нет дома.']),
        TheorySection(title: 'Глагол to have + модальные', content: 'To have (иметь):\nI have / You have / We have / They have\nHe/She/It has\n\nTo can (мочь/уметь):\nI/You/He/She/It/We/They can\n\nWant to (хотеть):\nI want to eat. — Я хочу есть.\nShe wants to go. — Она хочет идти.', examples: ['I have two brothers. — У меня два брата.', 'She can swim. — Она умеет плавать.', 'Do you want to play? — Ты хочешь играть?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'He ___ a student.', options: ['am', 'are', 'is', 'be'], correctIndex: 2, explanation: 'He/She/It → is'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'She ___ (has/have) a cat.', options: ['have', 'has', 'is', 'are'], correctIndex: 1, explanation: 'She/He/It → has'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Can you swim?"', options: ['Хочешь плавать?', 'Умеешь ли ты плавать?', 'Ты плаваешь сейчас?', 'Ты плавал раньше?'], correctIndex: 1, explanation: '"Can" = мочь/уметь. "Can you swim?" = Ты умеешь плавать?'),
      ],
      exam: [
        ExamQuestion(question: 'We ___ happy.', options: ['am', 'is', 'are', 'be'], correctIndex: 2, explanation: 'We/They/You → are'),
        ExamQuestion(question: 'I ___ (have/has) a dog.', options: ['has', 'have', 'is', 'am'], correctIndex: 1, explanation: 'I → have'),
        ExamQuestion(question: '"She can\'t swim" = ?', options: ['Она не хочет плавать', 'Она не умеет плавать', 'Она не плавает', 'Она устала плавать'], correctIndex: 1, explanation: 'can\'t = не умеет/не может'),
        ExamQuestion(question: 'They ___ not at school.', options: ['am', 'is', 'are', 'be'], correctIndex: 2, explanation: 'They → are. They are not at school.'),
        ExamQuestion(question: '"Want to" перед глаголом означает:', options: ['уметь', 'должен', 'хотеть', 'мочь'], correctIndex: 2, explanation: '"want to" = хотеть (+ инфинитив)'),
      ],
    ),

    // A2 continued
    CourseChapter(
      id: 'en_a2_03', title: 'Настоящее длительное', subtitle: 'Present Continuous — прямо сейчас', emoji: '🔄',
      level: LanguageLevel.a2, order: 9, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Present Continuous — образование', content: 'Present Continuous = to be + глагол+ing\nДля действий, которые происходят ПРЯМО СЕЙЧАС:\nI am working. — Я работаю (сейчас).\nShe is reading. — Она читает (сейчас).\nThey are playing. — Они играют (сейчас).\n\nОтрицание: I am not (I\'m not) + -ing\nВопрос: Are you working? Is she reading?\n\nМаркеры: now, right now, at the moment, look!, listen!', examples: ['Look! It is raining! — Смотри! Идёт дождь!', 'I\'m studying English at the moment. — Сейчас я учу английский.', 'What are you doing? — Что ты делаешь?']),
        TheorySection(title: 'Present Simple vs Continuous', content: 'Present Simple — регулярные действия:\nI eat breakfast at 7. (каждый день)\n\nPresent Continuous — прямо сейчас:\nI\'m eating breakfast now. (в данный момент)\n\nГлаголы БЕЗ Continuous (состояния):\nknow, like, love, hate, want, need, believe, understand — не используются с -ing.', examples: ['I know the answer. (НЕ: I am knowing)', 'She likes coffee. (НЕ: She is liking)', 'He is sleeping now. (можно — это действие)']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'She ___ (read) a book now.', options: ['reads', 'read', 'is reading', 'reading'], correctIndex: 2, explanation: 'Present Continuous: She is reading.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Какое предложение правильное?', options: ['I am knowing him.', 'I know him.', 'I knowing him.', 'I am know him.'], correctIndex: 1, explanation: '"Know" — глагол состояния, не используется с -ing.'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ they watching TV? (Они смотрят ТВ?)', options: ['Do', 'Does', 'Are', 'Is'], correctIndex: 2, explanation: 'Вопрос Present Continuous: Are + they + watching?'),
      ],
      exam: [
        ExamQuestion(question: 'I ___ (to run) right now.', options: ['run', 'runs', 'am running', 'running'], correctIndex: 2, explanation: 'I + am + running = Present Continuous'),
        ExamQuestion(question: '"At the moment" — маркер:', options: ['Past Simple', 'Present Simple', 'Present Continuous', 'Future'], correctIndex: 2, explanation: '"at the moment" = в данный момент → Present Continuous'),
        ExamQuestion(question: 'He ___ not singing.', options: ['am', 'do', 'is', 'are'], correctIndex: 2, explanation: 'He + is = He is not singing.'),
        ExamQuestion(question: '"I am understanding" — правильно?', options: ['Да', 'Нет — "I understand"', 'Да, для настоящего', 'Зависит от контекста'], correctIndex: 1, explanation: '"Understand" — глагол состояния, Present Continuous не используется.'),
        ExamQuestion(question: 'What ___ you doing now?', options: ['do', 'does', 'are', 'is'], correctIndex: 2, explanation: 'What are you doing? — Present Continuous question.'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_04', title: 'Транспорт и путешествия', subtitle: 'Transport & Travel — двигаемся по миру', emoji: '✈️',
      level: LanguageLevel.a2, order: 10, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Виды транспорта', content: 'Транспорт:\ncar — машина | bus — автобус | train — поезд\nplane / aircraft — самолёт | ship — корабль\nbike / bicycle — велосипед | motorbike — мотоцикл\ntaxi — такси | underground/subway — метро\n\nПредлоги с транспортом:\nby car/bus/train — на машине/автобусе/поезде\non foot — пешком\nI go to school by bus. — Я езжу в школу на автобусе.', examples: ['She travels by train. — Она путешествует на поезде.', 'How do you get to work? — Как ты добираешься до работы?']),
        TheorySection(title: 'В аэропорту / на вокзале', content: 'Полезные фразы:\nticket — билет | passport — паспорт\ndeparture — отправление | arrival — прибытие\nplatform — платформа | gate — выход\ndelay — задержка | boarding — посадка\n\nExcuse me, where is...? — Простите, где...?\nHow long does it take? — Сколько времени это займёт?\nOne ticket to London, please. — Один билет до Лондона, пожалуйста.', examples: ['The train arrives at 5 pm. — Поезд прибывает в 17:00.', 'My flight is delayed. — Мой рейс задержан.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как сказать "на автобусе"?', options: ['in bus', 'by bus', 'on bus', 'with bus'], correctIndex: 1, explanation: 'С транспортом используем предлог "by": by bus, by train.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Passport" — это:', options: ['билет', 'паспорт', 'багаж', 'виза'], correctIndex: 1, explanation: 'passport = паспорт'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "The flight is delayed."', options: ['Рейс отменён.', 'Рейс задержан.', 'Рейс прибыл.', 'Рейс вылетел.'], correctIndex: 1, explanation: 'delayed = задержан'),
      ],
      exam: [
        ExamQuestion(question: '"Underground" = ?', options: ['самолёт', 'автобус', 'метро', 'поезд'], correctIndex: 2, explanation: 'underground = метро (британский вариант, также "tube")'),
        ExamQuestion(question: '"Departure" = ?', options: ['прибытие', 'задержка', 'посадка', 'отправление'], correctIndex: 3, explanation: 'departure = отправление/вылет'),
        ExamQuestion(question: 'I go to work ___ foot. (пешком)', options: ['by', 'on', 'in', 'with'], correctIndex: 1, explanation: '"on foot" = пешком'),
        ExamQuestion(question: '"Platform" = ?', options: ['ворота', 'платформа', 'выход', 'зал'], correctIndex: 1, explanation: 'platform = платформа (на вокзале)'),
        ExamQuestion(question: 'One ___ to Paris, please.', options: ['pass', 'ticket', 'card', 'book'], correctIndex: 1, explanation: 'ticket = билет'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_05', title: 'Погода и времена года', subtitle: 'Weather & Seasons — о природе и климате', emoji: '🌦',
      level: LanguageLevel.a2, order: 11, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Погода', content: 'Описание погоды:\nIt is sunny. — Солнечно.\nIt is raining. — Идёт дождь.\nIt is snowing. — Идёт снег.\nIt is cloudy. — Облачно.\nIt is windy. — Ветрено.\nIt is foggy. — Туманно.\nIt is hot/warm/cold/cool/freezing.\n\nWhat\'s the weather like? — Какая погода?\nWhat\'s the temperature? — Какая температура?\nIt\'s +25 degrees. — +25 градусов.', examples: ['What\'s the weather like in London? — It\'s often cloudy and rainy. — Какая погода в Лондоне? — Часто облачно и дождливо.']),
        TheorySection(title: 'Времена года', content: 'Четыре времени года:\nspring — весна (March, April, May)\nsummer — лето (June, July, August)\nautumn/fall — осень (September, October, November)\nwinter — зима (December, January, February)\n\nВ весной/летом и т.д.:\nin spring/summer/autumn/winter\nI love summer because it\'s warm. — Я люблю лето, потому что тепло.', examples: ['It snows a lot in winter. — Зимой много снега.', 'Spring is my favourite season. — Весна — моё любимое время года.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"It is snowing" — какая погода?', options: ['дождь', 'снег', 'туман', 'ветер'], correctIndex: 1, explanation: 'snowing = идёт снег'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Какое время года после spring?', options: ['winter', 'autumn', 'summer', 'spring'], correctIndex: 2, explanation: 'spring (весна) → summer (лето)'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "What\'s the weather like today?"', options: ['Какая погода была вчера?', 'Какая погода сегодня?', 'Будет ли дождь завтра?', 'Что ты думаешь о погоде?'], correctIndex: 1, explanation: '"What\'s the weather like?" = Какая погода?'),
      ],
      exam: [
        ExamQuestion(question: '"Autumn" = ?', options: ['весна', 'лето', 'осень', 'зима'], correctIndex: 2, explanation: 'autumn = осень'),
        ExamQuestion(question: '"Cloudy" = ?', options: ['солнечно', 'облачно', 'дождливо', 'туманно'], correctIndex: 1, explanation: 'cloudy = облачно'),
        ExamQuestion(question: '"Freezing" = ?', options: ['прохладно', 'тепло', 'очень холодно', 'жарко'], correctIndex: 2, explanation: 'freezing = очень холодно (мороз)'),
        ExamQuestion(question: 'Summer: June, July, ___', options: ['May', 'August', 'September', 'April'], correctIndex: 1, explanation: 'Лето: June, July, August'),
        ExamQuestion(question: 'In ___ it often rains. (осенью)', options: ['spring', 'summer', 'autumn', 'winter'], correctIndex: 2, explanation: 'in autumn = осенью'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_06', title: 'Одежда и шопинг', subtitle: 'Clothes & Shopping — покупаем и описываем', emoji: '👕',
      level: LanguageLevel.a2, order: 12, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Одежда', content: 'Предметы одежды:\nshirt — рубашка | T-shirt — футболка | blouse — блузка\njeans — джинсы | trousers/pants — брюки\nskirt — юбка | dress — платье | suit — костюм\njacket — куртка | coat — пальто | sweater/jumper — свитер\nshoes — туфли/ботинки | boots — сапоги | socks — носки\nhat — шляпа/шапка | scarf — шарф | gloves — перчатки\n\nto wear — носить (одежду)\nto put on — надевать | to take off — снимать', examples: ['She is wearing a red dress. — На ней красное платье.', 'Put on your coat, it\'s cold! — Надень пальто, холодно!']),
        TheorySection(title: 'В магазине', content: 'Шопинг:\nHow much does it cost? — Сколько это стоит?\nIt costs 20 pounds. — Стоит 20 фунтов.\nCan I try it on? — Можно примерить?\nDo you have this in size M? — Есть ли это в размере M?\nI\'ll take it. — Я возьму это.\nDo you accept credit cards? — Вы принимаете карты?\ndiscount / sale — скидка / распродажа\ncashier — касса | receipt — чек', examples: ['How much is this jacket? — Сколько стоит эта куртка?', 'I\'m looking for shoes. — Я ищу туфли.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Scarf" — это:', options: ['шапка', 'шарф', 'перчатки', 'пальто'], correctIndex: 1, explanation: 'scarf = шарф'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как спросить цену?', options: ['How big is it?', 'What size?', 'How much does it cost?', 'Where is it?'], correctIndex: 2, explanation: '"How much does it cost?" = Сколько это стоит?'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Can I try it on?"', options: ['Можно его купить?', 'Можно примерить?', 'Где примерочная?', 'Есть скидка?'], correctIndex: 1, explanation: '"try on" = примерять'),
      ],
      exam: [
        ExamQuestion(question: '"Boots" = ?', options: ['туфли', 'тапочки', 'сапоги', 'кроссовки'], correctIndex: 2, explanation: 'boots = сапоги/ботинки'),
        ExamQuestion(question: '"Receipt" = ?', options: ['скидка', 'касса', 'чек', 'цена'], correctIndex: 2, explanation: 'receipt = чек'),
        ExamQuestion(question: '"I\'ll take it" в магазине означает:', options: ['Мне не нравится', 'Я возьму это', 'Слишком дорого', 'Можно примерить?'], correctIndex: 1, explanation: '"I\'ll take it" = Я возьму это.'),
        ExamQuestion(question: '"To put on" = ?', options: ['снимать', 'носить', 'надевать', 'покупать'], correctIndex: 2, explanation: 'to put on = надевать'),
        ExamQuestion(question: '"Suit" = ?', options: ['свитер', 'пальто', 'костюм', 'куртка'], correctIndex: 2, explanation: 'suit = костюм (деловой)'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_07', title: 'Хобби и спорт', subtitle: 'Hobbies & Sports — чем ты занимаешься?', emoji: '⚽',
      level: LanguageLevel.a2, order: 13, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Хобби', content: 'Любимые занятия:\nreading — чтение | writing — письмо | drawing — рисование\npainting — живопись | cooking — готовка | gardening — садоводство\ngaming — игры | photography — фотография\ntravelling — путешествия | dancing — танцы\n\nI enjoy + -ing: I enjoy reading. — Мне нравится читать.\nI\'m into + -ing: I\'m into gaming. — Я увлечён играми.\nI can\'t stand + -ing: I can\'t stand cooking. — Я терпеть не могу готовить.', examples: ['What do you do in your free time? — Что ты делаешь в свободное время?', 'I enjoy drawing and photography. — Мне нравится рисование и фотография.']),
        TheorySection(title: 'Спорт', content: 'Виды спорта:\nfootball/soccer — футбол | basketball — баскетбол\ntennis — теннис | swimming — плавание\nrunning — бег | cycling — велоспорт\ngymnastics — гимнастика | boxing — бокс\n\nИграть в / заниматься:\nplay + командные и игровые виды: play football/tennis\ndo + индивидуальные виды: do gymnastics/karate\ngo + -ing: go swimming/running/cycling', examples: ['I play football twice a week. — Я играю в футбол дважды в неделю.', 'She goes swimming every morning. — Каждое утро она ходит плавать.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I enjoy ___" — что идёт после?', options: ['to read', 'read', 'reading', 'reads'], correctIndex: 2, explanation: 'enjoy + gerund (-ing): I enjoy reading.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Правильно: "go" или "play" со swimming?', options: ['play swimming', 'go swimming', 'do swimming', 'make swimming'], correctIndex: 1, explanation: '"go swimming" — правильная конструкция для занятий плаванием.'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "What do you do in your free time?"', options: ['Что ты делаешь на работе?', 'Чем ты занимаешься в свободное время?', 'Когда ты свободен?', 'Что ты любишь?'], correctIndex: 1, explanation: '"free time" = свободное время'),
      ],
      exam: [
        ExamQuestion(question: '"Photography" = ?', options: ['живопись', 'рисование', 'фотография', 'скульптура'], correctIndex: 2, explanation: 'photography = фотография'),
        ExamQuestion(question: '"She ___ gymnastics." (do/play/go)', options: ['plays', 'goes', 'does', 'makes'], correctIndex: 2, explanation: 'do + gymnastics: she does gymnastics.'),
        ExamQuestion(question: '"I can\'t stand cooking" означает:', options: ['Я люблю готовить', 'Мне нравится готовить', 'Я терпеть не могу готовить', 'Я учусь готовить'], correctIndex: 2, explanation: '"can\'t stand" = терпеть не мочь'),
        ExamQuestion(question: '"Cycling" = ?', options: ['плавание', 'бег', 'велоспорт', 'верховая езда'], correctIndex: 2, explanation: 'cycling = езда на велосипеде'),
        ExamQuestion(question: 'He ___ football every weekend.', options: ['does', 'goes', 'plays', 'makes'], correctIndex: 2, explanation: 'play + football (командная игра)'),
      ],
    ),

    CourseChapter(
      id: 'en_a2_08', title: 'Будущее время', subtitle: 'Future — will и going to', emoji: '🔮',
      level: LanguageLevel.a2, order: 14, coinsReward: 55, xpReward: 40,
      theory: [
        TheorySection(title: 'Will — спонтанные решения и предсказания', content: 'Will + инфинитив используется для:\n1. Спонтанных решений (принятых прямо сейчас)\nThe phone is ringing. — I\'ll answer it!\n\n2. Предсказаний без доказательств\nI think it will rain tomorrow.\n\n3. Обещаний\nI will call you later. — Я позвоню тебе позже.\n\nОтрицание: won\'t (will not)\nВопрос: Will you come?\n\nShall I/we...? — Мне/нам ...? (предложение)', examples: ['I think robots will replace many jobs. — Роботы заменят многие профессии.', 'I won\'t tell anyone your secret. — Я никому не расскажу твой секрет.']),
        TheorySection(title: 'Going to — планы и намерения', content: '"Be going to" + инфинитив:\nДля заранее запланированных действий:\nI am going to visit my grandparents next week.\n(Я собираюсь навестить бабушку и дедушку на следующей неделе.)\n\nДля очевидных ситуаций с доказательствами:\nLook at those clouds! It\'s going to rain.\n(Смотри на эти тучи! Сейчас пойдёт дождь.)\n\nwill vs going to:\nSpontaneous: "I\'ll have the soup." (решил сейчас)\nPlanned: "I\'m going to have soup for dinner." (планировал)', examples: ['She\'s going to study medicine. — Она собирается учиться на медика.', 'We\'re going to have a party on Friday. — В пятницу у нас будет вечеринка.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Спонтанное решение — какое время?', options: ['going to', 'will', 'Present Simple', 'Past Simple'], correctIndex: 1, explanation: '"will" — для спонтанных решений, принятых прямо сейчас.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I ___ going to see a doctor." (am/is/are)', options: ['is', 'am', 'are', 'be'], correctIndex: 1, explanation: 'I + am: I am going to see...'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "It will snow tomorrow."', options: ['Завтра идёт снег.', 'Завтра пойдёт снег.', 'Вчера шёл снег.', 'Сейчас идёт снег.'], correctIndex: 1, explanation: '"will snow" = пойдёт снег (предсказание о будущем)'),
      ],
      exam: [
        ExamQuestion(question: '"Won\'t" = ?', options: ['will not', 'would not', 'want not', 'was not'], correctIndex: 0, explanation: "won't = will not"),
        ExamQuestion(question: '"Going to" используется для:', options: ['спонтанных решений', 'заранее запланированных действий', 'регулярных действий', 'прошлых событий'], correctIndex: 1, explanation: '"going to" — для запланированных действий'),
        ExamQuestion(question: 'She ___ (going to) study tonight.', options: ['will', 'is going to', 'goes to', 'going to'], correctIndex: 1, explanation: 'She + is going to + V'),
        ExamQuestion(question: '"Shall I help you?" означает:', options: ['Я помогу тебе.', 'Помочь тебе?', 'Ты поможешь мне?', 'Ты хочешь помочь?'], correctIndex: 1, explanation: '"Shall I...?" = предложение помощи'),
        ExamQuestion(question: '"I will call you later" — тип:', options: ['план', 'обещание', 'факт', 'регулярное действие'], correctIndex: 1, explanation: '"I will call you" — обещание.'),
      ],
    ),

    // ══════════════════════════════════════════════
    //  B1 — СРЕДНИЙ
    // ══════════════════════════════════════════════

    CourseChapter(
      id: 'en_b1_02', title: 'Present Perfect', subtitle: 'Связываем прошлое и настоящее', emoji: '🔗',
      level: LanguageLevel.b1, order: 15, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Present Perfect — образование', content: 'Present Perfect = have/has + Past Participle (V3)\n\nИспользуется когда:\n1. Действие в прошлом, но результат важен сейчас\nI have lost my keys. (Я потерял ключи — их нет до сих пор)\n\n2. Жизненный опыт\nHave you ever been to France?\n\n3. С маркерами: ever, never, already, yet, just, recently\nI have just eaten. — Я только что поел.\nHave you finished yet? — Ты уже закончил?\n\nОтрицание: I haven\'t (have not) been there.\nВопрос: Have you seen this film?', examples: ['She has visited ten countries. — Она побывала в десяти странах.', 'Have you ever tried sushi? — Ты когда-нибудь пробовал суши?', 'I\'ve already done my homework. — Я уже сделал домашнюю работу.']),
        TheorySection(title: 'Present Perfect vs Past Simple', content: 'Present Perfect — связь с настоящим:\nI have seen that movie. (опыт, неважно когда)\n\nPast Simple — конкретное время в прошлом:\nI saw that movie last week. (конкретное прошлое)\n\nКлючевые маркеры Past Simple:\nyesterday, last week, in 2020, ago\n\nКлючевые маркеры Present Perfect:\never, never, already, yet, just, recently, so far', examples: ['Did you go to Paris? (конкретная поездка — Past)', 'Have you been to Paris? (опыт вообще — Perfect)', 'I just received your message. — Я только что получил твоё сообщение.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'She ___ (just finish) her exam.', options: ['just finished', 'has just finished', 'have just finished', 'had just finished'], correctIndex: 1, explanation: 'She + has + just + finished (V3) = Present Perfect.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Have you ___ been to Japan?"', options: ['already', 'yet', 'ever', 'just'], correctIndex: 2, explanation: '"ever" используется в вопросах: Have you ever been...?'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "I haven\'t eaten yet."', options: ['Я только что поел.', 'Я уже поел.', 'Я ещё не ел.', 'Я никогда не ел.'], correctIndex: 2, explanation: '"haven\'t...yet" = ещё не...'),
      ],
      exam: [
        ExamQuestion(question: '"Already" в Present Perfect означает:', options: ['ещё не', 'только что', 'уже', 'никогда'], correctIndex: 2, explanation: '"already" = уже'),
        ExamQuestion(question: 'They ___ (never see) snow.', options: ['never saw', 'have never seen', 'never seen', 'had never seen'], correctIndex: 1, explanation: 'have + never + V3 = Present Perfect negative'),
        ExamQuestion(question: '"Just" в Perfect означает:', options: ['ещё', 'уже давно', 'только что', 'никогда'], correctIndex: 2, explanation: '"just" = только что'),
        ExamQuestion(question: 'Выбери Present Perfect:', options: ['I saw him yesterday.', 'I have seen him today.', 'I see him every day.', 'I was seeing him.'], correctIndex: 1, explanation: '"have seen" = Present Perfect'),
        ExamQuestion(question: '"Have you finished yet?" — "yet" означает:', options: ['ещё / уже (в вопросах и отрицаниях)', 'только что', 'когда-нибудь', 'никогда'], correctIndex: 0, explanation: '"yet" в вопросах = уже?, в отрицаниях = ещё'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_03', title: 'Модальные глаголы', subtitle: 'Modal Verbs — выражаем возможность и обязанность', emoji: '🎯',
      level: LanguageLevel.b1, order: 16, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Can, Could, May, Might', content: 'CAN — умение/возможность в настоящем:\nI can swim. — Я умею плавать.\nCan you help me? — Ты можешь помочь?\n\nCOULD — умение/возможность в прошлом или вежливость:\nI could run fast when I was young.\nCould you pass the salt? (вежливее, чем "can")\n\nMAY — официальное разрешение или вероятность:\nYou may leave now. — Вы можете идти.\nIt may rain tonight. — Возможно, вечером будет дождь.\n\nMIGHT — меньшая вероятность (might < may):\nI might come to the party. — Я, возможно, приду.', examples: ['She can speak three languages. — Она умеет говорить на трёх языках.', 'Could you please speak slowly? — Не могли бы вы говорить медленнее?']),
        TheorySection(title: 'Must, Should, Ought to, Need', content: 'MUST — строгая обязанность или вывод:\nYou must wear a seatbelt. — Ты должен пристегнуться.\nShe must be tired. — Она, должно быть, устала.\n\nSHOULD / OUGHT TO — совет, рекомендация:\nYou should see a doctor. — Тебе стоит сходить к врачу.\n\nNEED TO — необходимость:\nI need to buy milk. — Мне нужно купить молоко.\n\nMUST NOT (MUSTN\'T) — строгий запрет:\nYou mustn\'t smoke here. — Здесь нельзя курить.\n\nDON\'T HAVE TO — отсутствие обязанности:\nYou don\'t have to come. — Тебе не нужно приходить.', examples: ['You should exercise more. — Тебе стоит больше заниматься.', 'I must finish this project by Friday. — Я должен закончить проект до пятницы.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"You ___ wear a seatbelt." (строгая обязанность)', options: ['should', 'might', 'must', 'can'], correctIndex: 2, explanation: '"must" = строгая обязанность/необходимость'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"It ___ rain tomorrow." (возможно, но неточно)', options: ['must', 'will', 'might', 'should'], correctIndex: 2, explanation: '"might" = возможно (меньшая уверенность, чем "may")'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "You don\'t have to come."', options: ['Ты не должен приходить (запрет).', 'Тебе не нужно приходить (необязательно).', 'Ты не хочешь приходить.', 'Ты не можешь приходить.'], correctIndex: 1, explanation: '"don\'t have to" = необязательно, без запрета'),
      ],
      exam: [
        ExamQuestion(question: '"Mustn\'t" vs "Don\'t have to":', options: ['одно и то же', 'mustn\'t = запрет, don\'t have to = не обязательно', 'mustn\'t = разрешение', 'don\'t have to = запрет'], correctIndex: 1, explanation: 'mustn\'t = строго нельзя; don\'t have to = не нужно, но можно'),
        ExamQuestion(question: '"Should" выражает:', options: ['строгую обязанность', 'совет/рекомендацию', 'разрешение', 'запрет'], correctIndex: 1, explanation: '"should" = совет: You should study more.'),
        ExamQuestion(question: '"Could you help me?" — это:', options: ['вопрос об умении', 'вежливая просьба', 'прошедшее время', 'предположение'], correctIndex: 1, explanation: '"could" в вопросе = вежливая просьба'),
        ExamQuestion(question: 'She ___ be the manager. (явный вывод)', options: ['might', 'could', 'must', 'should'], correctIndex: 2, explanation: '"must" для логического вывода: She must be the manager (очевидно).'),
        ExamQuestion(question: 'I ___ buy tickets in advance. (нужно)', options: ['should', 'might', 'need to', 'could'], correctIndex: 2, explanation: '"need to" = нужно (necessity)'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_04', title: 'Страдательный залог', subtitle: 'Passive Voice — когда важно действие', emoji: '🔄',
      level: LanguageLevel.b1, order: 17, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Passive Voice — образование', content: 'Passive = to be + Past Participle (V3)\n\nActive: Someone builds a house. (активный)\nPassive: A house is built. (страдательный)\n\nВремена в Passive:\nPresent Simple: is/are + V3\n  English is spoken here.\nPast Simple: was/were + V3\n  The letter was written yesterday.\nPresent Perfect: has/have been + V3\n  The book has been published.\nFuture Simple: will be + V3\n  The report will be sent tomorrow.\n\nДеятель (by):\nThe window was broken by the child.\n(Окно было разбито ребёнком.)', examples: ['The Eiffel Tower was built in 1889. — Эйфелева башня была построена в 1889.', 'This film is watched by millions. — Этот фильм смотрят миллионы.']),
        TheorySection(title: 'Когда использовать Passive', content: 'Passive используется когда:\n1. Деятель неизвестен: My car was stolen.\n2. Деятель очевиден: The thief was arrested.\n3. В официальных/научных текстах:\n   The experiment was conducted...\n4. Хотим сделать акцент на действии, а не деятеле.\n\nПреобразование Active → Passive:\nActive: They make iPhones in China.\nPassive: iPhones are made in China (by them).', examples: ['Mistakes were made. — Были допущены ошибки.', 'The new airport will be opened next year. — Новый аэропорт откроют в следующем году.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Passive Present Simple для "he": he ___ + V3', options: ['is', 'are', 'was', 'be'], correctIndex: 0, explanation: 'Present Simple Passive: he is + V3'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Active → Passive: "They write reports every week."', options: ['Reports write every week.', 'Reports are written every week.', 'Reports were written every week.', 'Reports is written every week.'], correctIndex: 1, explanation: '"are written" = Present Simple Passive (they → reports, write → are written)'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "English is spoken all over the world."', options: ['Английский говорят по всему миру.', 'Английский говорили раньше везде.', 'По всему миру говорят по-английски.', 'А и B правильны.'], correctIndex: 3, explanation: '"is spoken" = говорят (Passive Present Simple)'),
      ],
      exam: [
        ExamQuestion(question: 'Past Simple Passive: was/were + ___', options: ['V1 (base)', 'V2 (past)', 'V3 (participle)', 'Ving'], correctIndex: 2, explanation: 'Passive всегда: to be + V3 (past participle)'),
        ExamQuestion(question: '"The report will be sent." — какое время?', options: ['Present', 'Past', 'Present Perfect', 'Future'], correctIndex: 3, explanation: '"will be sent" = Future Simple Passive'),
        ExamQuestion(question: '"By" в Passive указывает на:', options: ['место', 'деятеля', 'время', 'причину'], correctIndex: 1, explanation: '"by" + деятель: "was built by Romans"'),
        ExamQuestion(question: '"My wallet was stolen." — деятель:', options: ['известен', 'неважен/неизвестен', 'я сам', 'мой кошелёк'], correctIndex: 1, explanation: 'Passive часто используется, когда деятель неизвестен.'),
        ExamQuestion(question: 'Correct Passive Past: "The book ___ last year."', options: ['is published', 'was published', 'published', 'has published'], correctIndex: 1, explanation: 'Past Passive: was + V3 = was published'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_05', title: 'Косвенная речь', subtitle: 'Reported Speech — передаём чужие слова', emoji: '💬',
      level: LanguageLevel.b1, order: 18, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Reporting Statements', content: 'Для передачи слов других людей:\n\nDirect: "I am tired," she said.\nReported: She said (that) she was tired.\n\nСдвиг времён (backshift):\nPresent → Past: am/is → was, have → had\nPast Simple → Past Perfect: went → had gone\nwill → would | can → could | may → might\n\nМестоимения также меняются:\n"I" → he/she | "we" → they | "my" → his/her\n"you" → I/he/she (в зависимости от контекста)', examples: ['"I live in London," he said. → He said he lived in London.', '"She has passed," the teacher said. → The teacher said she had passed.']),
        TheorySection(title: 'Reporting Questions & Orders', content: 'Вопросы в косвенной речи:\nDirect: "Where do you live?" he asked.\nReported: He asked where I lived.\n(Порядок слов как в утверждении, без "do")\n\nОбщие вопросы (yes/no) → if/whether:\n"Are you coming?" → She asked if I was coming.\n\nПрямые приказы/просьбы → told/asked + to:\n"Come here!" → He told me to come here.\n"Please help me." → She asked me to help her.\n"Don\'t be late!" → He told us not to be late.', examples: ['"What time is it?" she asked. → She asked what time it was.', '"Don\'t smoke here!" → He told us not to smoke there.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I am happy," she said. → She said she ___ happy.', options: ['is', 'was', 'has been', 'were'], correctIndex: 1, explanation: 'Backshift: am → was в косвенной речи.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Can you swim?" he asked. → He asked if I ___ swim.', options: ['can', 'could', 'will', 'would'], correctIndex: 1, explanation: 'Backshift: can → could в косвенной речи.'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи (Reported): She asked where I lived.', options: ['"Где ты живёшь?" — спросила она.', '"Где ты жил?" — сказала она.', '"Я живу здесь," — сказала она.', '"Где она живёт?" — спросил он.'], correctIndex: 0, explanation: 'Reported question = вопрос в косвенной речи.'),
      ],
      exam: [
        ExamQuestion(question: '"I will call you." → He said he ___ call me.', options: ['will', 'would', 'can', 'could'], correctIndex: 1, explanation: 'Backshift: will → would'),
        ExamQuestion(question: '"Close the door!" → She told him ___ the door.', options: ['close', 'to close', 'closed', 'closing'], correctIndex: 1, explanation: 'told + someone + to + V'),
        ExamQuestion(question: '"Are you OK?" → She asked if I ___ OK.', options: ['am', 'was', 'were', 'is'], correctIndex: 2, explanation: 'are → were в косвенной речи.'),
        ExamQuestion(question: '"Where do you work?" → He asked where I ___', options: ['work', 'worked', 'works', 'working'], correctIndex: 1, explanation: 'do work → worked (backshift + порядок слов как в утверждении)'),
        ExamQuestion(question: 'Reported Speech для "Don\'t run!"', options: ['She said to not run.', 'She told not run.', 'She told us not to run.', 'She said us not to run.'], correctIndex: 2, explanation: 'told + us + not to + V'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_06', title: 'Сравнения', subtitle: 'Comparatives & Superlatives — сравниваем всё', emoji: '📊',
      level: LanguageLevel.b1, order: 19, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Comparatives', content: 'Сравнительная степень (comparative):\nКороткие (1-2 слог): + -er + than\ntall → taller than | fast → faster than\nbig → bigger (удвоение) | happy → happier\n\nДлинные (3+ слоги): more + прилагательное + than\nexpensive → more expensive than\ninteresting → more interesting than\n\nНеправильные:\ngood → better than | bad → worse than\nfar → further/farther than | little → less than\nmuch/many → more than\n\nСтолько же: as ... as\nShe is as tall as her brother.', examples: ['This book is more interesting than that one. — Эта книга интереснее той.', 'My car is faster than yours. — Моя машина быстрее твоей.']),
        TheorySection(title: 'Superlatives', content: 'Превосходная степень (superlative):\nКороткие: the + -est\ntall → the tallest | fast → the fastest\nbig → the biggest | happy → the happiest\n\nДлинные: the most + прилагательное\nthe most beautiful | the most expensive\n\nНеправильные:\ngood → the best | bad → the worst\nfar → the furthest | little → the least\nmuch/many → the most\n\nС superlative часто: in (in the world), of (of all)', examples: ['Mount Everest is the highest mountain in the world. — Эверест — самая высокая гора в мире.', 'This is the worst film I have ever seen. — Это худший фильм, что я когда-либо смотрел.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Comparative от "good":', options: ['gooder', 'more good', 'better', 'best'], correctIndex: 2, explanation: 'good → better (неправильная форма)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Superlative от "expensive":', options: ['the most expensive', 'expensivest', 'the expensivest', 'most expensive'], correctIndex: 0, explanation: '3+ слога → the most expensive'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "She is the smartest student in the class."', options: ['Она умнее всех в классе.', 'Она очень умная студентка.', 'Она самая умная студентка в классе.', 'Она умнее, чем думает.'], correctIndex: 2, explanation: '"the smartest" = самая умная (superlative)'),
      ],
      exam: [
        ExamQuestion(question: '"Bad" → comparative:', options: ['badder', 'more bad', 'worse', 'worst'], correctIndex: 2, explanation: 'bad → worse (неправильное сравнение)'),
        ExamQuestion(question: '"She is ___ tall ___ her sister." (такая же)', options: ['more...than', 'as...as', 'the...in', 'so...as'], correctIndex: 1, explanation: '"as...as" = такой же ... как и'),
        ExamQuestion(question: '"Far" → superlative:', options: ['farest', 'most far', 'the furthest', 'further'], correctIndex: 2, explanation: 'far → further/farther → the furthest/farthest'),
        ExamQuestion(question: 'Comparative от "beautiful":', options: ['beautifuller', 'more beautiful', 'the most beautiful', 'beautifuler'], correctIndex: 1, explanation: '3+ слога: more beautiful'),
        ExamQuestion(question: '"The best" — это:', options: ['comparative of good', 'superlative of good', 'comparative of bad', 'superlative of well'], correctIndex: 1, explanation: 'the best = превосходная степень от good'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_07', title: 'Технологии и интернет', subtitle: 'Technology — цифровой словарный запас', emoji: '💻',
      level: LanguageLevel.b1, order: 20, coinsReward: 70, xpReward: 50,
      theory: [
        TheorySection(title: 'Гаджеты и устройства', content: 'Технологии:\nsmartphone — смартфон | laptop — ноутбук\ntablet — планшет | smartwatch — умные часы\nheadphones — наушники | charger — зарядное устройство\nwifi — вайфай | Bluetooth — блютус\napp — приложение | software — программное обеспечение\nhardware — аппаратное обеспечение\n\nГлаголы:\ndownload — скачивать | upload — загружать\ninstall — устанавливать | update — обновлять\ndelete — удалять | search — искать | browse — просматривать', examples: ['I need to charge my phone. — Мне нужно зарядить телефон.', 'Download the app for free. — Скачай приложение бесплатно.']),
        TheorySection(title: 'Социальные сети и коммуникация', content: 'Соцсети и интернет:\npost — публикация/публиковать\nshare — делиться | like — лайкать\nfollow — подписываться | subscribe — подписаться\ncomment — комментировать | tag — отмечать\nvideo call — видеозвонок | livestream — прямой эфир\nhack — взломать | password — пароль\nprivacy — конфиденциальность | data — данные\n\nПолезные фразы:\nI\'m out of battery. — У меня сел аккумулятор.\nThe wifi is slow. — Вайфай медленный.', examples: ['She posted a photo on Instagram. — Она опубликовала фото в Instagram.', 'My phone was hacked. — Мой телефон взломали.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Download" означает:', options: ['загружать (на сервер)', 'скачивать (с интернета)', 'удалять', 'обновлять'], correctIndex: 1, explanation: 'download = скачивать; upload = загружать на сервер'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I\'m out of battery" означает:', options: ['У меня нет зарядника', 'У меня сел аккумулятор', 'Мой телефон сломан', 'Вайфай не работает'], correctIndex: 1, explanation: '"out of battery" = аккумулятор разряжен'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Update the software before using it."', options: ['Удали программное обеспечение.', 'Обнови программное обеспечение перед использованием.', 'Установи программное обеспечение заново.', 'Скачай программное обеспечение.'], correctIndex: 1, explanation: 'update = обновлять'),
      ],
      exam: [
        ExamQuestion(question: '"App" = ?', options: ['аппаратное обеспечение', 'приложение', 'устройство', 'программа'], correctIndex: 1, explanation: 'app = приложение (application)'),
        ExamQuestion(question: '"Password" = ?', options: ['логин', 'пароль', 'электронная почта', 'аккаунт'], correctIndex: 1, explanation: 'password = пароль'),
        ExamQuestion(question: '"Wifi is slow" — что это значит?', options: ['Вайфай отсутствует', 'Вайфай медленный', 'Вайфай отключён', 'Вайфай взломан'], correctIndex: 1, explanation: '"slow wifi" = медленный интернет'),
        ExamQuestion(question: '"Subscribe" означает:', options: ['лайкать', 'комментировать', 'подписаться', 'отмечать'], correctIndex: 2, explanation: 'subscribe = подписаться на канал/аккаунт'),
        ExamQuestion(question: '"Delete" = ?', options: ['обновить', 'установить', 'скачать', 'удалить'], correctIndex: 3, explanation: 'delete = удалять'),
      ],
    ),

    CourseChapter(
      id: 'en_b1_08', title: 'Здоровье и медицина', subtitle: 'Health & Medicine — в больнице', emoji: '🏥',
      level: LanguageLevel.b1, order: 21, coinsReward: 75, xpReward: 55,
      theory: [
        TheorySection(title: 'У врача', content: 'На приёме у врача:\nappointment — запись/приём\ndoctor / physician — врач\nnurse — медсестра | surgeon — хирург\nspecialist — специалист | pharmacist — фармацевт\n\nСимптомы:\nsymptom — симптом | pain — боль\nI have a pain in my... — У меня болит...\nI have been feeling unwell. — Я чувствую себя плохо.\nI have a sore throat. — У меня болит горло.\nI feel dizzy. — У меня кружится голова.\nI have been vomiting. — Меня рвало.', examples: ['I\'d like to make an appointment. — Я хотел бы записаться на приём.', 'How long have you had these symptoms? — Как долго у вас эти симптомы?']),
        TheorySection(title: 'Лечение и лекарства', content: 'Лечение:\ndiagnosis — диагноз | prescription — рецепт\nmedicine / medication — лекарство\npill / tablet — таблетка | injection — укол\noperation — операция | surgery — хирургия\nrecovery — выздоровление\n\nТипы боли:\nI have a sharp pain. — Острая боль.\nI have a dull ache. — Тупая боль.\nThe pain is constant. — Постоянная боль.\nIt hurts when I... — Больно, когда я...\n\nShe was prescribed antibiotics.\n(Ей выписали антибиотики.)', examples: ['Take this pill twice a day. — Принимайте эту таблетку дважды в день.', 'I was told to rest for a week. — Мне сказали отдыхать неделю.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Prescription" — это:', options: ['симптом', 'диагноз', 'рецепт', 'инъекция'], correctIndex: 2, explanation: 'prescription = рецепт (от врача)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I feel dizzy" означает:', options: ['Мне больно', 'У меня кружится голова', 'Мне плохо', 'Я устал'], correctIndex: 1, explanation: '"feel dizzy" = кружится голова'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "I\'d like to make an appointment."', options: ['Я хотел бы отменить запись.', 'Я хотел бы записаться на приём.', 'Есть ли записи к врачу?', 'Когда следующий приём?'], correctIndex: 1, explanation: '"make an appointment" = записаться на приём'),
      ],
      exam: [
        ExamQuestion(question: '"Surgeon" = ?', options: ['медсестра', 'фармацевт', 'терапевт', 'хирург'], correctIndex: 3, explanation: 'surgeon = хирург'),
        ExamQuestion(question: '"Symptom" = ?', options: ['лечение', 'рецепт', 'симптом', 'диагноз'], correctIndex: 2, explanation: 'symptom = симптом'),
        ExamQuestion(question: '"Sore throat" = ?', options: ['кашель', 'боль в горле', 'температура', 'насморк'], correctIndex: 1, explanation: 'sore throat = боль в горле'),
        ExamQuestion(question: '"Recovery" = ?', options: ['операция', 'инъекция', 'выздоровление', 'симптом'], correctIndex: 2, explanation: 'recovery = выздоровление'),
        ExamQuestion(question: '"Take this pill twice a day" означает:', options: ['один раз в день', 'дважды в день', 'три раза в день', 'по необходимости'], correctIndex: 1, explanation: 'twice a day = дважды в день'),
      ],
    ),

    // ══════════════════════════════════════════════
    //  B2 — ВЫШЕ СРЕДНЕГО
    // ══════════════════════════════════════════════

    CourseChapter(
      id: 'en_b2_01',
      title: 'Условные предложения',
      subtitle: 'Conditionals — реальное и нереальное',
      emoji: '🔀',
      level: LanguageLevel.b2,
      order: 7,
      coinsReward: 100,
      xpReward: 70,
      theory: [
        TheorySection(
          title: 'Zero & First Conditional',
          content:
              'Zero Conditional (общие истины):\n'
              'If + Present Simple, Present Simple\n'
              'If you heat water to 100°C, it boils.\n'
              '(Если нагреть воду до 100°, она кипит.)\n\n'
              'First Conditional (реальное будущее):\n'
              'If + Present Simple, will + инфинитив\n'
              'If it rains tomorrow, I will stay home.\n'
              '(Если завтра пойдёт дождь, я останусь дома.)\n\n'
              'Порядок частей можно менять:\n'
              'I will call you if I find out. = If I find out, I will call you.',
          examples: [
            'If you study hard, you pass the exam. (Zero)',
            'If she comes, we will have a party. (First)',
            'I will help you if you ask me. (First)',
          ],
        ),
        TheorySection(
          title: 'Second & Third Conditional',
          content:
              'Second Conditional (нереальное настоящее/будущее):\n'
              'If + Past Simple, would + инфинитив\n'
              'If I had more time, I would travel the world.\n'
              '(Если бы у меня было больше времени, я бы путешествовал.)\n\n'
              'Third Conditional (нереальное прошлое):\n'
              'If + Past Perfect, would have + Past Participle\n'
              'If I had studied harder, I would have passed.\n'
              '(Если бы я больше учился, я бы сдал.)\n\n'
              'Mixed Conditional (смешанный):\n'
              'If I had taken that job, I would be rich now.\n'
              '(Если бы я взял ту работу, сейчас бы был богат.)',
          examples: [
            'If I were you, I would apologise. (Second — нереальный совет)',
            'If they had left earlier, they wouldn\'t have missed the train. (Third)',
            'If she had studied medicine, she would be a doctor now. (Mixed)',
          ],
        ),
      ],
      exercises: [
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Тип: "If it rains, I will take an umbrella."',
          options: ['Zero Conditional', 'First Conditional', 'Second Conditional', 'Third Conditional'],
          correctIndex: 1,
          explanation: 'If + Present Simple, will + V — это First Conditional (реальное будущее).',
        ),
        CourseExercise(
          type: ExerciseType.fillBlank,
          question: 'If I ___ (to be) rich, I would travel more. (Second)',
          options: ['am', 'was/were', 'will be', 'have been'],
          correctIndex: 1,
          explanation: 'Second Conditional: If + Past Simple (was/were): If I were rich...',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Third Conditional выражает:',
          options: [
            'реальную ситуацию в будущем',
            'нереальную ситуацию в прошлом',
            'общую истину',
            'нереальную ситуацию в настоящем',
          ],
          correctIndex: 1,
          explanation: 'Third Conditional — о нереальном прошлом: чего не произошло, но могло бы.',
        ),
        CourseExercise(
          type: ExerciseType.translation,
          question: 'Переведи (Second Conditional): "Если бы я знал ответ, я бы сказал тебе."',
          options: [
            'If I know the answer, I will tell you.',
            'If I knew the answer, I would tell you.',
            'If I had known the answer, I would have told you.',
            'If I know the answer, I would tell you.',
          ],
          correctIndex: 1,
          explanation: 'Second Conditional: If + Past Simple (knew) + would + infinitive (tell).',
        ),
        CourseExercise(
          type: ExerciseType.multipleChoice,
          question: 'Zero Conditional используется для:',
          options: ['личных планов', 'общих истин и законов', 'прошлых событий', 'гипотетических ситуаций'],
          correctIndex: 1,
          explanation: 'Zero Conditional — для фактов, законов природы, общих истин.',
        ),
      ],
      exam: [
        ExamQuestion(question: 'If + Past Simple + ___: (Second Conditional)', options: ['will + V', 'would + V', 'would have + V3', 'have + V3'], correctIndex: 1, explanation: 'Second Conditional: If + Past Simple, would + infinitive.'),
        ExamQuestion(question: 'If she ___ harder, she would pass.', options: ['studied', 'studies', 'will study', 'has studied'], correctIndex: 0, explanation: 'Second Conditional: If + Past Simple (studied).'),
        ExamQuestion(question: '"If I were you" — какой тип?', options: ['Zero', 'First', 'Second', 'Third'], correctIndex: 2, explanation: '"If I were you" — Second Conditional (нереальный совет).'),
        ExamQuestion(question: 'Third Conditional: If I had known, I ___ differently.', options: ['act', 'would act', 'would have acted', 'will act'], correctIndex: 2, explanation: 'Third Conditional: would have + Past Participle (would have acted).'),
        ExamQuestion(question: 'If you ___ water, it evaporates. (Zero)', options: ['heated', 'heat', 'will heat', 'had heated'], correctIndex: 1, explanation: 'Zero Conditional: If + Present Simple (heat), Present Simple.'),
        ExamQuestion(question: 'Нереальное прошлое выражает:', options: ['First', 'Zero', 'Second', 'Third'], correctIndex: 3, explanation: 'Third Conditional — нереальное прошлое.'),
        ExamQuestion(question: 'If it ___ tomorrow, we won\'t go. (First)', options: ['rained', 'rains', 'will rain', 'had rained'], correctIndex: 1, explanation: 'First Conditional: If + Present Simple (rains).'),
        ExamQuestion(question: '"I would travel if I had money" — тип:', options: ['Zero', 'First', 'Second', 'Third'], correctIndex: 2, explanation: 'would + V при If + Past Simple → Second Conditional.'),
        ExamQuestion(question: 'Mixed Conditional сочетает:', options: ['Zero + First', 'First + Second', 'Past condition + Present result', 'Second + Third'], correctIndex: 2, explanation: 'Mixed = условие в прошлом (Third) + результат в настоящем (Second).'),
        ExamQuestion(question: 'Правильная форма Third Conditional:', options: [
          'If he studied, he would pass.',
          'If he had studied, he would pass.',
          'If he had studied, he would have passed.',
          'If he studies, he will pass.',
        ], correctIndex: 2, explanation: 'Third Conditional: If + Past Perfect (had studied), would have + V3 (would have passed).'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_02', title: 'Инверсия и эмфаза', subtitle: 'Inversion & Emphasis — выразительность', emoji: '🎭',
      level: LanguageLevel.b2, order: 23, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Инверсия', content: 'Инверсия = вспомогательный глагол перед подлежащим для акцента.\n\nПосле отрицательных наречий:\nNever have I seen such beauty.\nNot only did she sing, but she also danced.\nHardly/Scarcely had we arrived when it started raining.\nNo sooner had he left than she called.\nRarely do I agree with this.\n\nПосле "only":\nOnly then did I understand.\nOnly when I saw him did I believe it.', examples: ['Never have I been so embarrassed. — Никогда мне не было так стыдно.', 'Not only did he lie, but he also stole. — Он не только солгал, но ещё и украл.']),
        TheorySection(title: 'Клефт-конструкции (Cleft sentences)', content: 'Для акцентирования части предложения:\n\nIt-cleft: It is/was + [акцент] + that/who...\nIt was John who broke the window.\n(Именно Джон разбил окно.)\n\nWhat-cleft: What + clause + is/was + [акцент]\nWhat I need is a long holiday.\n(Что мне нужно — это долгий отпуск.)', examples: ['It was in Paris that they first met. — Именно в Париже они впервые встретились.', 'What surprised me was his reaction. — Меня удивила его реакция.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Never ___ I seen such a mess."', options: ['have', 'had', 'did', 'was'], correctIndex: 0, explanation: 'После "Never" инверсия: Never have I seen...'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"It was ___ who solved the problem." (Именно он)', options: ['him', 'he', 'his', 'himself'], correctIndex: 1, explanation: 'В it-cleft после "It was": It was he who...'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Not only did she win, but she broke the record."', options: ['Она выиграла и побила рекорд.', 'Она не только выиграла, но и побила рекорд.', 'Она не выиграла, но побила рекорд.', 'Только она выиграла и побила рекорд.'], correctIndex: 1, explanation: '"not only...but also" = не только...но и'),
      ],
      exam: [
        ExamQuestion(question: 'Инверсия после "Rarely":', options: ['Rarely I go there.', 'Rarely do I go there.', 'Rarely going I there.', 'Rarely I do go there.'], correctIndex: 1, explanation: 'Rarely + do/does/did + subject + V'),
        ExamQuestion(question: '"What I love is jazz." — это:', options: ['Passive Voice', 'Cleft sentence', 'Reported speech', 'Conditional'], correctIndex: 1, explanation: '"What-cleft": What + clause + is + focus'),
        ExamQuestion(question: '"Hardly ___ we arrived when it rained."', options: ['have', 'had', 'did', 'were'], correctIndex: 1, explanation: 'Hardly had (Past Perfect) + subject + Past Participle'),
        ExamQuestion(question: 'Cleft с it: "It was Paris ___ they met."', options: ['where', 'which', 'that', 'who'], correctIndex: 2, explanation: 'It-cleft: It was [noun] that...'),
        ExamQuestion(question: '"Not only did she study hard, ___ she also practised."', options: ['but', 'however', 'although', 'even'], correctIndex: 0, explanation: '"Not only...but also" — двойная конструкция'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_03', title: 'Сослагательное наклонение', subtitle: 'Subjunctive & Wish — выражаем желания', emoji: '✨',
      level: LanguageLevel.b2, order: 24, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Wish и If only', content: 'WISH + Past Simple → желание изменить настоящее:\nI wish I knew the answer. — Жаль, что я не знаю ответа.\nI wish I were taller. — Жаль, что я невысокий.\n\nWISH + Past Perfect → сожаление о прошлом:\nI wish I had studied harder. — Жаль, что я не учился усерднее.\n\nWISH + would → раздражение или желание изменить будущее:\nI wish he would stop talking. — Хотел бы я, чтоб он замолчал.\n\nIF ONLY — то же, но сильнее:\nIf only I could fly! — Если бы я только мог летать!', examples: ['I wish I spoke French fluently. — Жаль, что я не говорю по-французски свободно.', 'If only we had left earlier! — Если бы мы только уехали раньше!']),
        TheorySection(title: 'Subjunctive Mood', content: 'Формальное сослагательное наклонение (особенно в официальных текстах):\n\nAfter "suggest, recommend, insist, demand, propose, require":\nI suggest (that) he take the exam. (не "takes")\nThe doctor recommended that she rest.\n\nFormal subjunctive "be":\nIt is essential that he be present.\nIf I were you... (not "was" — формально)\n\nФразы с Subjunctive:\nCome what may — что бы ни случилось\nBe that as it may — как бы то ни было\nSo be it — да будет так', examples: ['The committee insisted that he resign. — Комитет настаивал на его отставке.', 'It is vital that every student attend the lecture. — Важно, чтобы каждый студент присутствовал на лекции.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I wish I ___ taller." (желание изменить настоящее)', options: ['am', 'was/were', 'will be', 'would be'], correctIndex: 1, explanation: 'Wish + Past Simple для желаний о настоящем.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I wish I ___ harder at school." (сожаление о прошлом)', options: ['studied', 'study', 'had studied', 'would study'], correctIndex: 2, explanation: 'Wish + Past Perfect для сожаления о прошлом.'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "I suggest that he attend the meeting."', options: ['Я предлагаю, чтобы он посетил встречу.', 'Я предлагаю ему посетить встречу.', 'Я предложил ему встречу.', 'Мне предложили встречу.'], correctIndex: 0, explanation: 'suggest that + Subjunctive (базовая форма)'),
      ],
      exam: [
        ExamQuestion(question: '"If only she ___ here now!" (сожаление о настоящем)', options: ['is', 'was/were', 'has been', 'would be'], correctIndex: 1, explanation: 'If only + Past Simple для настоящего'),
        ExamQuestion(question: '"I wish he ___ stop smoking." (раздражение)', options: ['could', 'would', 'will', 'can'], correctIndex: 1, explanation: 'Wish + would — для желания изменить поведение другого'),
        ExamQuestion(question: '"They insisted that she ___ the project." (Subjunctive)', options: ['completes', 'completed', 'complete', 'completing'], correctIndex: 2, explanation: 'После insist that: базовая форма глагола (complete)'),
        ExamQuestion(question: '"If only we ___ them earlier!" (прошлое)', options: ['met', 'had met', 'have met', 'meet'], correctIndex: 1, explanation: 'If only + Past Perfect для сожаления о прошлом'),
        ExamQuestion(question: '"Come what may" означает:', options: ['приходи, когда можешь', 'что бы ни случилось', 'когда придёт время', 'если придётся'], correctIndex: 1, explanation: '"Come what may" = что бы ни произошло'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_04', title: 'Деловой английский', subtitle: 'Business English — в профессиональной среде', emoji: '💼',
      level: LanguageLevel.b2, order: 25, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Профессиональная переписка', content: 'Деловое письмо:\nDear Mr./Ms. [Surname], — Уважаемый/ая...\nI am writing to... — Пишу, чтобы...\nWith reference to... — В связи с...\nI would be grateful if... — Я был бы признателен, если...\nPlease find attached... — Во вложении...\nI look forward to hearing from you. — С нетерпением жду вашего ответа.\nYours sincerely, — С уважением, (знаете имя)\nYours faithfully, — С уважением, (не знаете имя)', examples: ['Dear Ms. Smith, I am writing to enquire about the position. — Уважаемая г-жа Смит, пишу по поводу вакансии.', 'Please find the report attached. — Во вложении отчёт.']),
        TheorySection(title: 'На совещании', content: 'Деловые переговоры:\nshall we begin? — Начнём?\nCould you clarify...? — Не могли бы вы пояснить...?\nI\'d like to point out that... — Хотел бы отметить, что...\nTo sum up / In conclusion — Подводя итог...\nWe need to discuss... — Нам нужно обсудить...\nI agree / I disagree — Я согласен/не согласен\nThat\'s a valid point. — Это справедливое замечание.\nDeadline — срок | Budget — бюджет | Target — цель', examples: ['Shall we move on to the next point? — Перейдём к следующему пункту?', 'We\'re running over time. — Мы выходим за рамки времени.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"I look forward to hearing from you" — эта фраза:', options: ['в начале письма', 'в конце письма', 'в теме письма', 'в подписи'], correctIndex: 1, explanation: 'Фраза используется в конце письма перед подписью.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Yours faithfully" используется когда:', options: ['знаете имя получателя', 'не знаете имя получателя', 'всегда в деловых письмах', 'в неформальных письмах'], correctIndex: 1, explanation: '"Yours faithfully" = не знаете имени. "Yours sincerely" = знаете.'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Could you clarify the deadline?"', options: ['Каков дедлайн?', 'Можете ли вы пояснить срок?', 'Не могли бы вы перенести дедлайн?', 'Дедлайн уже прошёл?'], correctIndex: 1, explanation: '"clarify" = пояснять, уточнять'),
      ],
      exam: [
        ExamQuestion(question: '"Please find attached" означает:', options: ['найдите файл онлайн', 'во вложении файл', 'файл отправлен отдельно', 'см. приложение внизу'], correctIndex: 1, explanation: '"find attached" = во вложении'),
        ExamQuestion(question: '"Deadline" = ?', options: ['бюджет', 'цель', 'срок', 'план'], correctIndex: 2, explanation: 'deadline = срок (выполнения)'),
        ExamQuestion(question: '"To sum up" = ?', options: ['чтобы начать', 'подводя итог', 'с другой стороны', 'несмотря на это'], correctIndex: 1, explanation: '"to sum up" = подводя итог/итого'),
        ExamQuestion(question: '"That\'s a valid point" означает:', options: ['Это неверно', 'Это справедливое замечание', 'Я не согласен', 'Это неважно'], correctIndex: 1, explanation: '"valid point" = справедливое/весомое замечание'),
        ExamQuestion(question: '"With reference to your email" используется:', options: ['в начале в ответном письме', 'в конце письма', 'в теме', 'как приветствие'], correctIndex: 0, explanation: 'Используется в начале письма: "В ответ на ваше письмо..."'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_05', title: 'Идиомы и фразовые глаголы', subtitle: 'Idioms & Phrasal Verbs — говорим как носители', emoji: '🗣',
      level: LanguageLevel.b2, order: 26, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Популярные идиомы', content: 'Идиомы — устойчивые выражения:\n\nbreak the ice — растопить лёд (начать разговор)\nhit the nail on the head — попасть в точку\nbite the bullet — стиснуть зубы и сделать\nspill the beans — проболтаться\na piece of cake — плёвое дело\nunder the weather — чувствовать себя плохо\nback to square one — начинать с нуля\npull someone\'s leg — шутить/разыгрывать\nbite off more than you can chew — взять на себя слишком много\nkill two birds with one stone — убить двух зайцев', examples: ['"Are you pulling my leg?" — "Ты шутишь?"', '"The exam was a piece of cake." — "Экзамен был плёвым делом."']),
        TheorySection(title: 'Фразовые глаголы', content: 'Phrasal verbs — глагол + предлог/наречие:\n\ngive up — сдаваться | give in — уступить\nput off — откладывать | put up with — мириться с\nget on with — ладить с | get over — преодолеть\nbring up — воспитывать; упоминать\ncarry out — выполнять | look into — расследовать\nrun out of — закончиться | come across — наткнуться\nset up — основать | turn down — отвергнуть\ncall off — отменить | break down — сломаться', examples: ['Don\'t give up! — Не сдавайся!', 'We had to call off the meeting. — Нам пришлось отменить встречу.', 'I came across an interesting article. — Я наткнулся на интересную статью.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Break the ice" означает:', options: ['разбить лёд', 'начать разговор', 'испортить настроение', 'остыть'], correctIndex: 1, explanation: '"break the ice" = начать разговор, растопить лёд (переносно)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Put off" = ?', options: ['одевать', 'выключать', 'откладывать', 'убирать'], correctIndex: 2, explanation: '"put off" = откладывать (procrastinate)'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "I\'m under the weather today."', options: ['Я под дождём.', 'Я чувствую себя неважно.', 'Я на улице.', 'У меня плохая погода настроения.'], correctIndex: 1, explanation: '"under the weather" = чувствовать себя нехорошо'),
      ],
      exam: [
        ExamQuestion(question: '"Kill two birds with one stone" = ?', options: ['сделать одно дело', 'убить двух зайцев', 'решить сложную задачу', 'быть жестоким'], correctIndex: 1, explanation: 'Убить двух зайцев одним выстрелом'),
        ExamQuestion(question: '"Give up" = ?', options: ['дать', 'сдаться', 'отдать', 'выдать'], correctIndex: 1, explanation: '"give up" = сдаваться'),
        ExamQuestion(question: '"Come across" = ?', options: ['перейти', 'наткнуться (случайно найти)', 'пересечь', 'пройти мимо'], correctIndex: 1, explanation: '"come across" = случайно наткнуться'),
        ExamQuestion(question: '"A piece of cake" означает:', options: ['кусок торта', 'что-то вкусное', 'лёгкое дело', 'награда'], correctIndex: 2, explanation: '"piece of cake" = очень лёгкое дело'),
        ExamQuestion(question: '"Run out of" = ?', options: ['убегать', 'закончиться', 'выбежать', 'перебежать'], correctIndex: 1, explanation: '"run out of" = закончиться (запасы): I ran out of milk.'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_06', title: 'Академическое письмо', subtitle: 'Academic Writing — пишем эссе и аргументы', emoji: '📝',
      level: LanguageLevel.b2, order: 27, coinsReward: 110, xpReward: 75,
      theory: [
        TheorySection(title: 'Структура эссе', content: 'Академическое эссе:\n\nIntroduction (Введение):\n- Тема и контекст\n- Тезис (thesis statement): основная идея\n\nBody paragraphs (Основная часть):\n- Topic sentence — главная мысль параграфа\n- Evidence/example — доказательство\n- Explanation — пояснение\n- Link — переход к следующей идее\n\nConclusion (Заключение):\n- Обобщение аргументов\n- Restating thesis\n- Final thought', examples: ['This essay will argue that... — Данное эссе будет отстаивать позицию, что...', 'In conclusion, it is clear that... — В заключение очевидно, что...']),
        TheorySection(title: 'Академические связки', content: 'Linking words для эссе:\n\nДобавление: Furthermore, Moreover, In addition, Additionally\nКонтраст: However, Nevertheless, On the other hand, Although\nПричина: Therefore, As a result, Consequently, Hence\nИллюстрация: For example, For instance, Such as, In particular\nУтверждение: In fact, Indeed, Evidently\nЗаключение: In conclusion, To sum up, Overall, Ultimately\n\nАкадемический тон:\n- Избегай "I think" → "It could be argued that..."\n- Избегай слова "very" → extremely, considerably', examples: ['Furthermore, research suggests that... — Более того, исследования показывают, что...', 'On the other hand, some experts argue... — С другой стороны, некоторые эксперты утверждают...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"However" — это союз для:', options: ['добавления', 'причины', 'контраста', 'иллюстрации'], correctIndex: 2, explanation: '"however" = однако — выражает контраст'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Что такое "thesis statement"?', options: ['название эссе', 'главная идея/позиция автора', 'список источников', 'пример из практики'], correctIndex: 1, explanation: 'Thesis statement = основная идея/аргумент эссе'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "In conclusion, it is clear that technology has changed our lives."', options: ['Вначале ясно, что технологии изменили жизнь.', 'В заключение очевидно, что технологии изменили нашу жизнь.', 'Поэтому технологии изменили нашу жизнь.', 'Несмотря на это, технологии изменили нашу жизнь.'], correctIndex: 1, explanation: '"In conclusion" = в заключение'),
      ],
      exam: [
        ExamQuestion(question: '"Furthermore" = ?', options: ['однако', 'более того/кроме того', 'поэтому', 'в заключение'], correctIndex: 1, explanation: '"furthermore" = более того (добавление)'),
        ExamQuestion(question: '"Consequently" = ?', options: ['следовательно', 'однако', 'например', 'кроме того'], correctIndex: 0, explanation: '"consequently" = следовательно/как следствие'),
        ExamQuestion(question: 'Академическая замена "very important":', options: ['really important', 'quite important', 'of paramount importance', 'super important'], correctIndex: 2, explanation: '"of paramount importance" = крайне важный (академический стиль)'),
        ExamQuestion(question: 'Функция topic sentence:', options: ['начало эссе', 'главная мысль параграфа', 'список источников', 'вывод'], correctIndex: 1, explanation: 'Topic sentence = первое предложение параграфа, его главная мысль'),
        ExamQuestion(question: '"On the other hand" используется для:', options: ['добавления аргументов', 'представления противоположного взгляда', 'иллюстрации', 'вывода'], correctIndex: 1, explanation: '"on the other hand" = с другой стороны (контраст)'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_07', title: 'Наука и общество', subtitle: 'Science & Society — обсуждаем глобальные темы', emoji: '🌍',
      level: LanguageLevel.b2, order: 28, coinsReward: 110, xpReward: 75,
      theory: [
        TheorySection(title: 'Наука и технологии', content: 'Научная лексика:\nresearch — исследование | experiment — эксперимент\nscientist — учёный | theory — теория | evidence — доказательство\ndiscovery — открытие | innovation — инновация\nbreakthrough — прорыв | phenomenon — явление\nhypothesis — гипотеза | data — данные\n\nИскусственный интеллект:\nAI (Artificial Intelligence) — искусственный интеллект\nmachine learning — машинное обучение\nautomation — автоматизация | algorithm — алгоритм', examples: ['Scientists have made a major breakthrough. — Учёные совершили крупный прорыв.', 'The data supports the hypothesis. — Данные подтверждают гипотезу.']),
        TheorySection(title: 'Глобальные проблемы', content: 'Экология и общество:\nclimate change — изменение климата\nglobal warming — глобальное потепление\npollution — загрязнение | renewable energy — возобновляемая энергия\nbiodiversity — биоразнообразие\noverpopulation — перенаселение\ninequality — неравенство | poverty — бедность\nsustainable development — устойчивое развитие\n\nВыражение мнения на уровне B2:\nIt is widely believed that... — Широко распространено мнение, что...\nEvidence suggests that... — Данные свидетельствуют, что...\nThis raises the question of... — Это поднимает вопрос о...', examples: ['Renewable energy is crucial for combating climate change. — Возобновляемая энергия важна для борьбы с изменением климата.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Breakthrough" = ?', options: ['провал', 'прорыв', 'открытие', 'теория'], correctIndex: 1, explanation: 'breakthrough = прорыв (крупное достижение)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Renewable energy" = ?', options: ['ядерная энергия', 'нефтяная энергия', 'возобновляемая энергия', 'угольная энергетика'], correctIndex: 2, explanation: 'renewable = возобновляемый'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "It is widely believed that AI will transform society."', options: ['ИИ трансформировал общество.', 'Широко распространено мнение, что ИИ изменит общество.', 'ИИ верит, что общество изменится.', 'Было широко распространено мнение.'], correctIndex: 1, explanation: '"It is widely believed that" = широко распространено мнение, что'),
      ],
      exam: [
        ExamQuestion(question: '"Hypothesis" = ?', options: ['теория', 'гипотеза', 'факт', 'данные'], correctIndex: 1, explanation: 'hypothesis = гипотеза (предположение для проверки)'),
        ExamQuestion(question: '"Climate change" = ?', options: ['загрязнение', 'изменение климата', 'глобальное потепление', 'экология'], correctIndex: 1, explanation: 'climate change = изменение климата'),
        ExamQuestion(question: '"Evidence" = ?', options: ['гипотеза', 'теория', 'доказательство', 'данные'], correctIndex: 2, explanation: 'evidence = доказательство/свидетельство'),
        ExamQuestion(question: '"Automation" = ?', options: ['алгоритм', 'автоматизация', 'ИИ', 'данные'], correctIndex: 1, explanation: 'automation = автоматизация'),
        ExamQuestion(question: '"Sustainable development" = ?', options: ['экономический рост', 'устойчивое развитие', 'промышленное развитие', 'технологический прогресс'], correctIndex: 1, explanation: 'sustainable development = устойчивое развитие'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_08', title: 'Подготовка к экзамену', subtitle: 'Exam Preparation — финальный уровень', emoji: '🏆',
      level: LanguageLevel.b2, order: 29, coinsReward: 150, xpReward: 100,
      theory: [
        TheorySection(title: 'Навыки для экзамена B2', content: 'Ключевые области B2 (FCE/IELTS 5.5-6.5):\n\n1. ЧТЕНИЕ: понимание сложных текстов, определение позиции автора, понимание деталей и контекста.\n\n2. ПИСЬМО: эссе с аргументами, официальные письма/email, отчёты и обзоры (180-220 слов).\n\n3. АУДИРОВАНИЕ: понимание интервью, дискуссий, лекций.\n\n4. ГОВОРЕНИЕ: дискуссия, обмен мнениями, переговоры, сравнение.\n\nОсновные грамматические темы B2:\n- All conditionals | Passive in all tenses\n- Modal verbs | Reported speech\n- Inversion | Cleft sentences\n- Wish/If only | Subjunctive', examples: ['I would argue that... — Я бы утверждал, что...', 'The text implies that... — Текст подразумевает, что...']),
        TheorySection(title: 'Стратегии экзамена', content: 'Советы для сдачи B2:\n\nЧтение:\n- Читай вопросы ДО текста\n- Ищи ключевые слова\n- Не паникуй из-за незнакомых слов — угадывай из контекста\n\nПисьмо:\n- Планируй: 5 мин на план\n- Используй разнообразные конструкции\n- Проверь грамматику и орфографию\n- Используй linking words\n\nГоворение:\n- Используй discourse markers: Well, Actually, You know...\n- Развивай идеи: Not only...but also...\n- Исправляй себя вслух: What I mean is...', examples: ['The passage suggests / implies / indicates that... — Отрывок предполагает/указывает, что...', 'To put it another way... — Иными словами...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'IELTS уровень B2 соответствует баллу:', options: ['4.0-4.5', '5.0-5.5', '5.5-6.5', '7.0+'], correctIndex: 2, explanation: 'B2 ≈ IELTS 5.5-6.5, FCE Cambridge (B2 First)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"The text implies that" означает:', options: ['Текст доказывает', 'Текст подразумевает', 'Текст упоминает', 'Текст отрицает'], correctIndex: 1, explanation: '"implies" = подразумевает, намекает'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Лучшая стратегия для чтения на экзамене:', options: ['Читать весь текст, потом вопросы', 'Читать только начало', 'Сначала прочитать вопросы', 'Начинать с последнего вопроса'], correctIndex: 2, explanation: 'Профессиональный совет: читай вопросы ДО текста — знаешь, что искать.'),
      ],
      exam: [
        ExamQuestion(question: '"To put it another way" = ?', options: ['с другой стороны', 'иными словами', 'в заключение', 'например'], correctIndex: 1, explanation: '"to put it another way" = иными словами/другими словами'),
        ExamQuestion(question: '"FCE" расшифровывается как:', options: ['First Certificate English', 'First Cambridge English', 'Final Certificate English', 'First Class English'], correctIndex: 0, explanation: 'FCE = First Certificate in English (Cambridge B2 exam)'),
        ExamQuestion(question: '"The passage suggests" в эссе означает:', options: ['автор доказал', 'текст предполагает/указывает', 'читатель считает', 'эксперт сказал'], correctIndex: 1, explanation: '"suggests/implies" используется для осторожных утверждений об источнике'),
        ExamQuestion(question: 'B2 уровень в европейской шкале CEFR означает:', options: ['начинающий', 'элементарный', 'средний', 'выше среднего'], correctIndex: 3, explanation: 'B2 = Upper Intermediate (выше среднего) по CEFR'),
        ExamQuestion(question: '"Discourse markers" в речи — это:', options: ['грамматические ошибки', 'слова-связки для организации речи', 'терминология', 'паузы'], correctIndex: 1, explanation: 'Discourse markers (well, actually, I mean...) организуют устную речь.'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_09', title: 'Продвинутые фразы и стиль', subtitle: 'Advanced Language — финальная полировка', emoji: '💎',
      level: LanguageLevel.b2, order: 30, coinsReward: 150, xpReward: 100,
      theory: [
        TheorySection(title: 'Сложные грамматические структуры', content: 'Nominalization (субстантивация):\nGlaciers are melting → The melting of glaciers\nPrices have increased → An increase in prices\n\nParticiple clauses:\nHaving finished his work, he went home.\n(Закончив работу, он пошёл домой.)\nBeing tired, she went to bed early.\n\nAbsolute clauses:\nThe weather permitting, we\'ll have a picnic.\n(Если позволит погода, устроим пикник.)\nAll things considered, it was a success.', examples: ['Having studied all night, she passed the exam. — Проучившись всю ночь, она сдала экзамен.', 'The situation having improved, they resumed work. — Ситуация улучшилась, и они возобновили работу.']),
        TheorySection(title: 'Регистр и стиль', content: 'Неформальный → Формальный:\nget → obtain/receive\nbig → significant/substantial\nbut → however/nevertheless\nso → therefore/consequently\nlots of → a great deal of/numerous\nstart → commence/initiate\nend → conclude/terminate\nbad → adverse/detrimental\nhelp → assist/facilitate\nshow → demonstrate/illustrate\n\nPassive for formality:\nWe will consider your application → Your application will be considered.', examples: ['"We got lots of feedback" → "We received a great deal of feedback"', '"It shows that..." → "It demonstrates that..."']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Having finished" в причастном обороте означает:', options: ['продолжая', 'закончив', 'не закончив', 'пока заканчиваю'], correctIndex: 1, explanation: '"Having + V3" = завершив действие (причастный оборот)'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Формальная замена "get":',options: ['take', 'obtain', 'grab', 'pick'], correctIndex: 1, explanation: '"obtain" = формальная версия "get"'),
        CourseExercise(type: ExerciseType.translation, question: 'Преобразуй в формальный стиль: "We showed that..."', options: ['We proved that...', 'We demonstrated that...', 'We found out that...', 'We told that...'], correctIndex: 1, explanation: '"demonstrate" = формальная версия "show"'),
      ],
      exam: [
        ExamQuestion(question: '"Commence" — это формальное слово для:', options: ['закончить', 'начать', 'продолжить', 'остановить'], correctIndex: 1, explanation: 'commence = начать (формально)'),
        ExamQuestion(question: '"Detrimental" = ?', options: ['полезный', 'нейтральный', 'вредный', 'неважный'], correctIndex: 2, explanation: 'detrimental = вредный (формально вместо "bad")'),
        ExamQuestion(question: 'Nominalization "prices increased" → ?', options: ['prices rising', 'an increase in prices', 'increased prices', 'price is increasing'], correctIndex: 1, explanation: 'Nominalization: verb → noun: increased → an increase in...'),
        ExamQuestion(question: '"Facilitate" = ?', options: ['начинать', 'облегчать/содействовать', 'завершать', 'оценивать'], correctIndex: 1, explanation: 'facilitate = облегчать, способствовать (формально вместо "help")'),
        ExamQuestion(question: '"All things considered" = ?', options: ['если рассмотреть всё', 'принимая всё во внимание', 'несмотря на всё', 'сверх всего'], correctIndex: 1, explanation: '"All things considered" = принимая всё во внимание (absolute clause)'),
      ],
    ),

    CourseChapter(
      id: 'en_b2_10', title: 'Итоговый экзамен', subtitle: 'Final Exam — проверяем всё', emoji: '🎓',
      level: LanguageLevel.b2, order: 31, coinsReward: 200, xpReward: 150,
      theory: [
        TheorySection(title: 'Обзор всего курса', content: 'A1: Приветствия, числа, цвета, еда, тело, время, животные, глаголы to be/have/can\n\nA2: Present Simple/Continuous, семья, транспорт, погода, одежда, хобби, Future will/going to\n\nB1: Present Perfect, Modal Verbs, Passive Voice, Reported Speech, Comparatives, Present Perfect, технологии, медицина\n\nB2: Conditionals (all 4), Inversion, Cleft sentences, Wish/Subjunctive, Business English, Idioms & Phrasal Verbs, Academic Writing, Science vocabulary, Advanced style', examples: ['Всё, что ты изучил — это фундамент для реального общения на уровне B2.', 'Congratulations on completing the course! — Поздравляем с завершением курса!']),
        TheorySection(title: 'Следующие шаги', content: 'После B2 — путь к C1/C2:\n\nЧитай аутентичные тексты: BBC, The Guardian, научные статьи\nСлушай: подкасты (BBC Radio 4, TED talks)\nГовори: найди языкового партнёра, запишись на разговорный клуб\nПиши: веди дневник на английском, участвуй в форумах\n\nПолезные ресурсы:\n• Cambridge English (exams.cambridgeenglish.org)\n• British Council (britishcouncil.org)\n• Oxford Learner\'s Dictionaries\n\nПомни: язык — это инструмент. Используй его каждый день!', examples: ['Language learning is a journey, not a destination. — Изучение языка — это путешествие, а не конечная точка.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Какой уровень следует после B2?', options: ['A1', 'A2', 'B1', 'C1'], correctIndex: 3, explanation: 'CEFR: A1→A2→B1→B2→C1→C2. После B2 следует C1.'),
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Congratulations on completing the course!" — правильно ли "on completing"?', options: ['Нет, должно быть "to complete"', 'Да, после "on" — герундий (-ing)', 'Нет, нужно "complete"', 'Нет, нужно "completed"'], correctIndex: 1, explanation: '"Congratulations on + -ing" — стандартная конструкция'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи финальную фразу: "Language learning is a journey."', options: ['Языки сложны.', 'Учить языки трудно.', 'Изучение языка — это путешествие.', 'Языковое обучение закончено.'], correctIndex: 2, explanation: '"Language learning" = изучение языка, "journey" = путешествие'),
      ],
      exam: [
        ExamQuestion(question: 'B2 = ... по CEFR:', options: ['Elementary', 'Pre-intermediate', 'Intermediate', 'Upper Intermediate'], correctIndex: 3, explanation: 'B2 = Upper Intermediate'),
        ExamQuestion(question: 'Выбери правильный Third Conditional:', options: ['If I studied, I would pass.', 'If I had studied, I would have passed.', 'If I study, I will pass.', 'If I was studying, I pass.'], correctIndex: 1, explanation: 'Third Conditional: If + Past Perfect, would have + V3'),
        ExamQuestion(question: 'Passive Past Perfect:', options: ['was written', 'has been written', 'had been written', 'is written'], correctIndex: 2, explanation: 'Past Perfect Passive = had been + V3'),
        ExamQuestion(question: '"Never ___ I been so happy!" (инверсия)', options: ['have', 'had', 'did', 'was'], correctIndex: 0, explanation: 'Never + have + I + V3 (Present Perfect Inversion)'),
        ExamQuestion(question: 'Академическое слово для "show":', options: ['prove', 'illustrate/demonstrate', 'say', 'explain'], correctIndex: 1, explanation: 'demonstrate/illustrate = академические синонимы "show"'),
      ],
    ),
  ],
);
