import '../courses/course_structure.dart';

const germanCourse = LanguageCourse(
  langCode: 'de',
  langName: 'Немецкий',
  nativeName: 'Deutsch',
  flag: '🇩🇪',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'de_a1_01', title: 'Begrüßungen', subtitle: 'Приветствия и знакомство', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Hallo — Привет\nGuten Morgen — Доброе утро\nGuten Tag — Добрый день\nGuten Abend — Добрый вечер\nAuf Wiedersehen — До свидания\nTschüss — Пока', examples: ['Hallo! Wie heißt du?', 'Guten Morgen! Ich heiße Anna.', 'Auf Wiedersehen!']),
        TheorySection(title: 'Знакомство', content: 'Wie heißt du? — Как тебя зовут?\nIch heiße ... — Меня зовут ...\nWoher kommst du? — Откуда ты?\nIch komme aus ... — Я из ...', examples: ['Wie heißt du? — Ich heiße Max.', 'Woher kommst du? — Ich komme aus Russland.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как по-немецки "Доброе утро"?', options: ['Guten Tag', 'Guten Morgen', 'Guten Abend', 'Hallo'], correctIndex: 1, explanation: 'Guten Morgen = Доброе утро (Morgen = утро)'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Как тебя зовут?"', options: ['Wie alt bist du?', 'Woher kommst du?', 'Wie heißt du?', 'Was machst du?'], correctIndex: 2, explanation: 'Wie heißt du? буквально: "Как ты называешься?"'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich ___ aus Deutschland.', options: ['heißt', 'komme', 'bist', 'sind'], correctIndex: 1, explanation: 'kommen (приходить/быть из): ich komme'),
      ],
      exam: [
        ExamQuestion(question: '"До свидания" по-немецки:', options: ['Hallo', 'Danke', 'Auf Wiedersehen', 'Bitte'], correctIndex: 2, explanation: 'Auf Wiedersehen = До свидания'),
        ExamQuestion(question: 'Ich ___ Anna.', options: ['heißt', 'heiße', 'heißen', 'bin'], correctIndex: 1, explanation: 'heißen: ich heiße (1-е лицо ед.ч.)'),
        ExamQuestion(question: '"Привет" по-немецки:', options: ['Tschüss', 'Bitte', 'Hallo', 'Danke'], correctIndex: 2, explanation: 'Hallo = Привет (неформально)'),
        ExamQuestion(question: 'Woher ___ du?', options: ['kommt', 'komme', 'kommst', 'kommen'], correctIndex: 2, explanation: 'kommen: du kommst (2-е лицо ед.ч.)'),
        ExamQuestion(question: '"Добрый вечер" по-немецки:', options: ['Guten Morgen', 'Guten Tag', 'Guten Abend', 'Gute Nacht'], correctIndex: 2, explanation: 'Guten Abend = Добрый вечер (Abend = вечер)'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_02', title: 'Zahlen und Alphabet', subtitle: 'Числа и алфавит', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Числа 1–20', content: '1-ein, 2-zwei, 3-drei, 4-vier, 5-fünf\n6-sechs, 7-sieben, 8-acht, 9-neun, 10-zehn\n11-elf, 12-zwölf, 13-dreizehn, 20-zwanzig', examples: ['Ich bin zwanzig Jahre alt.', 'Das kostet fünf Euro.', 'Zwei plus drei ist fünf.']),
        TheorySection(title: 'Умляуты', content: 'В немецком есть особые буквы:\nÄ/ä — произносится как "э"\nÖ/ö — произносится как "ё"\nÜ/ü — произносится как "ю"\nß — двойное "с"', examples: ['Österreich — Австрия', 'München — Мюнхен', 'Straße — улица']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как по-немецки число 5?', options: ['vier', 'fünf', 'sechs', 'drei'], correctIndex: 1, explanation: 'fünf = 5'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как по-немецки число 12?', options: ['zwanzig', 'elf', 'zwölf', 'dreizehn'], correctIndex: 2, explanation: 'zwölf = 12 (особое слово, как в русском "двенадцать")'),
        CourseExercise(type: ExerciseType.translation, question: '"Улица" по-немецки:', options: ['Stadt', 'Straße', 'Haus', 'Platz'], correctIndex: 1, explanation: 'Straße = улица (с буквой ß)'),
      ],
      exam: [
        ExamQuestion(question: '7 по-немецки:', options: ['acht', 'sechs', 'sieben', 'neun'], correctIndex: 2, explanation: 'sieben = 7'),
        ExamQuestion(question: '20 по-немецки:', options: ['zwölf', 'zwanzig', 'dreißig', 'zehn'], correctIndex: 1, explanation: 'zwanzig = 20'),
        ExamQuestion(question: 'Какая буква отсутствует в русском алфавите?', options: ['A', 'Ü', 'E', 'I'], correctIndex: 1, explanation: 'Ü — умляут, специфичная немецкая буква'),
        ExamQuestion(question: '3 + 4 = ?', options: ['sechs', 'acht', 'sieben', 'neun'], correctIndex: 2, explanation: 'drei plus vier ist sieben'),
        ExamQuestion(question: 'ß называется:', options: ['умляут', 'эсцет', 'диерезис', 'лигатура'], correctIndex: 1, explanation: 'ß = Eszett или scharfes S (острое С)'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_03', title: 'Familie und Zuhause', subtitle: 'Семья и дом', emoji: '🏠',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Члены семьи', content: 'die Mutter — мама\nder Vater — папа\ndie Schwester — сестра\nder Bruder — брат\ndie Großmutter — бабушка\nder Großvater — дедушка', examples: ['Meine Mutter heißt Maria.', 'Ich habe einen Bruder.', 'Mein Vater arbeitet.']),
        TheorySection(title: 'Артикли', content: 'В немецком 3 рода:\nder (мужской): der Vater, der Bruder\ndie (женский): die Mutter, die Schwester\ndas (средний): das Kind, das Haus', examples: ['der Mann — мужчина', 'die Frau — женщина', 'das Kind — ребёнок']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Артикль слова "Mutter" (мама):', options: ['der', 'die', 'das', 'den'], correctIndex: 1, explanation: 'die Mutter — женский род'),
        CourseExercise(type: ExerciseType.translation, question: '"Брат" по-немецки:', options: ['Schwester', 'Bruder', 'Vater', 'Sohn'], correctIndex: 1, explanation: 'der Bruder = брат'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Meine ___ heißt Anna. (сестра)', options: ['Bruder', 'Vater', 'Schwester', 'Mutter'], correctIndex: 2, explanation: 'die Schwester = сестра'),
      ],
      exam: [
        ExamQuestion(question: '"Бабушка" по-немецки:', options: ['Großvater', 'Oma/Großmutter', 'Mutter', 'Tante'], correctIndex: 1, explanation: 'die Großmutter (официально) или die Oma (разговорно)'),
        ExamQuestion(question: 'Артикль слова "Haus" (дом):', options: ['der', 'die', 'das', 'ein'], correctIndex: 2, explanation: 'das Haus — средний род'),
        ExamQuestion(question: 'Ich ___ einen Bruder.', options: ['bin', 'habe', 'heißt', 'komme'], correctIndex: 1, explanation: 'haben (иметь): ich habe'),
        ExamQuestion(question: '"Папа" по-немецки:', options: ['Mutter', 'Bruder', 'Vater', 'Sohn'], correctIndex: 2, explanation: 'der Vater = папа'),
        ExamQuestion(question: 'Какой артикль у "Kind" (ребёнок)?', options: ['der', 'die', 'das', 'des'], correctIndex: 2, explanation: 'das Kind — средний род'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_04', title: 'Essen und Trinken', subtitle: 'Еда и напитки', emoji: '🍎',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'das Brot — хлеб\ndie Wurst — колбаса\nder Käse — сыр\ndas Fleisch — мясо\ndas Gemüse — овощи\ndas Obst — фрукты\ndie Suppe — суп', examples: ['Ich esse Brot mit Käse.', 'Das Gemüse ist frisch.', 'Möchtest du Suppe?']),
        TheorySection(title: 'Напитки', content: 'das Wasser — вода\nder Kaffee — кофе\nder Tee — чай\ndie Milch — молоко\nder Saft — сок\ndas Bier — пиво', examples: ['Ich trinke Kaffee.', 'Möchtest du Tee oder Kaffee?', 'Ein Glas Wasser, bitte.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Хлеб" по-немецки:', options: ['Fleisch', 'Käse', 'Brot', 'Wurst'], correctIndex: 2, explanation: 'das Brot = хлеб'),
        CourseExercise(type: ExerciseType.translation, question: '"Я пью кофе":', options: ['Ich esse Kaffee.', 'Ich trinke Kaffee.', 'Ich mag Kaffee.', 'Ich koche Kaffee.'], correctIndex: 1, explanation: 'trinken = пить; essen = есть (твёрдое)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ein ___ Wasser, bitte.', options: ['Flasche', 'Glas', 'Tasse', 'Becher'], correctIndex: 1, explanation: 'ein Glas Wasser = стакан воды'),
      ],
      exam: [
        ExamQuestion(question: '"Молоко" по-немецки:', options: ['Wasser', 'Saft', 'Milch', 'Bier'], correctIndex: 2, explanation: 'die Milch = молоко'),
        ExamQuestion(question: '"Овощи" по-немецки:', options: ['Obst', 'Gemüse', 'Fleisch', 'Brot'], correctIndex: 1, explanation: 'das Gemüse = овощи'),
        ExamQuestion(question: 'Möchtest du ___ oder Kaffee?', options: ['Wasser', 'Tee', 'Saft', 'Bier'], correctIndex: 1, explanation: 'Tee oder Kaffee = чай или кофе'),
        ExamQuestion(question: '"Сок" по-немецки:', options: ['Wasser', 'Milch', 'Saft', 'Tee'], correctIndex: 2, explanation: 'der Saft = сок'),
        ExamQuestion(question: 'Ich ___ gern Suppe.', options: ['trinke', 'esse', 'mag', 'koche'], correctIndex: 1, explanation: 'essen gern = есть с удовольствием'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_05', title: 'Körper und Gesundheit', subtitle: 'Тело и здоровье', emoji: '💪',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Части тела', content: 'der Kopf — голова\ndas Auge — глаз\ndie Nase — нос\nder Mund — рот\nder Arm — рука (рука)\ndie Hand — кисть руки\ndas Bein — нога\nder Fuß — ступня', examples: ['Mein Kopf tut weh.', 'Ich habe blaue Augen.', 'Die Hand ist wichtig.']),
        TheorySection(title: 'Самочувствие', content: 'Wie geht es Ihnen/dir? — Как вы/ты себя чувствуете?\nMir geht es gut. — Я в порядке.\nIch bin krank. — Я болен/больна.\nIch habe Kopfschmerzen. — У меня болит голова.\nIch brauche einen Arzt. — Мне нужен врач.', examples: ['Mir geht es nicht gut.', 'Ich habe Fieber.', 'Der Arzt hilft mir.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Голова" по-немецки:', options: ['Arm', 'Bein', 'Kopf', 'Hand'], correctIndex: 2, explanation: 'der Kopf = голова'),
        CourseExercise(type: ExerciseType.translation, question: '"Я болен" по-немецки:', options: ['Mir geht es gut.', 'Ich bin krank.', 'Ich bin müde.', 'Es geht mir schlecht.'], correctIndex: 1, explanation: 'krank = больной/больная'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich habe ___schmerzen. (болит голова)', options: ['Bauch', 'Kopf', 'Rücken', 'Zahn'], correctIndex: 1, explanation: 'Kopfschmerzen = головная боль'),
      ],
      exam: [
        ExamQuestion(question: '"Нос" по-немецки:', options: ['Auge', 'Mund', 'Nase', 'Ohr'], correctIndex: 2, explanation: 'die Nase = нос'),
        ExamQuestion(question: 'Mir geht es ___. (хорошо)', options: ['schlecht', 'krank', 'gut', 'müde'], correctIndex: 2, explanation: 'gut = хорошо'),
        ExamQuestion(question: '"Мне нужен врач":', options: ['Ich brauche einen Arzt.', 'Ich bin Arzt.', 'Der Arzt kommt.', 'Ich gehe zum Arzt.'], correctIndex: 0, explanation: 'brauchen = нуждаться; einen Arzt = врача (вин.п.)'),
        ExamQuestion(question: '"Нога" по-немецки:', options: ['Arm', 'Fuß', 'Hand', 'Bein'], correctIndex: 3, explanation: 'das Bein = нога; der Fuß = ступня'),
        ExamQuestion(question: 'Wie ___ es dir?', options: ['geht', 'macht', 'ist', 'hat'], correctIndex: 0, explanation: 'Wie geht es dir? = Как ты себя чувствуешь?'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_06', title: 'Zeit und Kalender', subtitle: 'Время и календарь', emoji: '🕐',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'Montag — понедельник\nDienstag — вторник\nMittwoch — среда\nDonnerstag — четверг\nFreitag — пятница\nSamstag — суббота\nSonntag — воскресенье', examples: ['Heute ist Montag.', 'Am Freitag habe ich frei.', 'Sonntag ist der Ruhetag.']),
        TheorySection(title: 'Время суток', content: 'Wie spät ist es? — Который час?\nEs ist ... Uhr. — Сейчас ... часов.\nmorgens — утром\nmittags — в полдень\nabends — вечером\nnachts — ночью', examples: ['Es ist neun Uhr.', 'Ich stehe morgens auf.', 'Abends lese ich.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Среда" по-немецки:', options: ['Montag', 'Dienstag', 'Mittwoch', 'Donnerstag'], correctIndex: 2, explanation: 'Mittwoch = среда (Mitte = середина, Woche = неделя)'),
        CourseExercise(type: ExerciseType.translation, question: '"Который час?":', options: ['Wie alt bist du?', 'Wie spät ist es?', 'Was machst du?', 'Wann kommst du?'], correctIndex: 1, explanation: 'Wie spät ist es? = Как поздно сейчас? = Который час?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Heute ___ Freitag.', options: ['bin', 'hat', 'ist', 'sind'], correctIndex: 2, explanation: 'sein (быть): es ist — сейчас/сегодня есть'),
      ],
      exam: [
        ExamQuestion(question: '"Воскресенье" по-немецки:', options: ['Samstag', 'Freitag', 'Sonntag', 'Montag'], correctIndex: 2, explanation: 'Sonntag = воскресенье (Sonne = солнце)'),
        ExamQuestion(question: 'Es ist ___ Uhr. (9 часов)', options: ['sieben', 'neun', 'acht', 'zehn'], correctIndex: 1, explanation: 'neun = 9'),
        ExamQuestion(question: '"Вечером" по-немецки:', options: ['morgens', 'mittags', 'abends', 'nachts'], correctIndex: 2, explanation: 'abends = вечером'),
        ExamQuestion(question: '"Понедельник" по-немецки:', options: ['Dienstag', 'Montag', 'Mittwoch', 'Donnerstag'], correctIndex: 1, explanation: 'Montag = понедельник'),
        ExamQuestion(question: 'Am ___ habe ich Deutsch. (пятница)', options: ['Montag', 'Mittwoch', 'Freitag', 'Sonntag'], correctIndex: 2, explanation: 'Freitag = пятница'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_07', title: 'Tiere und Natur', subtitle: 'Животные и природа', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Животные', content: 'der Hund — собака\ndie Katze — кошка\ndas Pferd — лошадь\nder Vogel — птица\nder Fisch — рыба\nder Bär — медведь\nder Wolf — волк', examples: ['Ich habe eine Katze.', 'Der Hund bellt.', 'Das Pferd ist groß.']),
        TheorySection(title: 'Природа', content: 'der Baum — дерево\ndie Blume — цветок\ndas Wasser — вода\nder Berg — гора\nder Fluss — река\nder Wald — лес\ndas Meer — море', examples: ['Der Wald ist grün.', 'Die Blume ist schön.', 'Das Meer ist blau.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-немецки:', options: ['Hund', 'Katze', 'Pferd', 'Vogel'], correctIndex: 1, explanation: 'die Katze = кошка'),
        CourseExercise(type: ExerciseType.translation, question: '"Лес" по-немецки:', options: ['Berg', 'Fluss', 'Wald', 'Meer'], correctIndex: 2, explanation: 'der Wald = лес'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Der Hund ___. (лает)', options: ['miaut', 'bellt', 'singt', 'fliegt'], correctIndex: 1, explanation: 'bellen = лаять; mianen = мяукать'),
      ],
      exam: [
        ExamQuestion(question: '"Медведь" по-немецки:', options: ['Wolf', 'Fuchs', 'Bär', 'Hirsch'], correctIndex: 2, explanation: 'der Bär = медведь'),
        ExamQuestion(question: '"Река" по-немецки:', options: ['See', 'Meer', 'Fluss', 'Bach'], correctIndex: 2, explanation: 'der Fluss = река'),
        ExamQuestion(question: 'Артикль слова "Blume" (цветок):', options: ['der', 'das', 'die', 'den'], correctIndex: 2, explanation: 'die Blume = цветок (женский род)'),
        ExamQuestion(question: '"Птица" по-немецки:', options: ['Fisch', 'Vogel', 'Katze', 'Hund'], correctIndex: 1, explanation: 'der Vogel = птица'),
        ExamQuestion(question: 'Das Meer ist ___. (голубое)', options: ['grün', 'rot', 'blau', 'gelb'], correctIndex: 2, explanation: 'blau = синий/голубой'),
      ],
    ),

    CourseChapter(
      id: 'de_a1_08', title: 'Grundverben', subtitle: 'Базовые глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Спряжение глаголов', content: 'ich — e (ich mache)\ndu — st (du machst)\ner/sie/es — t (er macht)\nwir — en (wir machen)\nihr — t (ihr macht)\nsie/Sie — en (sie machen)', examples: ['Ich wohne in Berlin.', 'Du spielst gut.', 'Er arbeitet viel.']),
        TheorySection(title: 'Часто используемые глаголы', content: 'sein — быть\nhaben — иметь\nmachen — делать\ngehen — идти\nkommen — приходить\nsehen — видеть\nessen — есть\ntrinken — пить', examples: ['Ich bin Student.', 'Wir haben Zeit.', 'Sie geht nach Hause.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'er ___ (arbeiten — работать)', options: ['arbeite', 'arbeitest', 'arbeitet', 'arbeiten'], correctIndex: 2, explanation: 'er/sie/es + t: er arbeitet'),
        CourseExercise(type: ExerciseType.translation, question: '"Мы идём домой":', options: ['Wir kommen nach Hause.', 'Wir gehen nach Hause.', 'Wir fahren nach Hause.', 'Wir laufen nach Hause.'], correctIndex: 1, explanation: 'gehen = идти пешком'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'du ___ (haben)', options: ['habe', 'hat', 'haben', 'hast'], correctIndex: 3, explanation: 'haben: du hast'),
      ],
      exam: [
        ExamQuestion(question: 'ich ___ (sein)', options: ['ist', 'bist', 'bin', 'sind'], correctIndex: 2, explanation: 'sein: ich bin'),
        ExamQuestion(question: 'wir ___ (machen)', options: ['macht', 'machst', 'mache', 'machen'], correctIndex: 3, explanation: 'machen: wir machen'),
        ExamQuestion(question: '"Видеть" по-немецки:', options: ['hören', 'sehen', 'sprechen', 'lesen'], correctIndex: 1, explanation: 'sehen = видеть'),
        ExamQuestion(question: 'er ___ (haben)', options: ['habe', 'hast', 'hat', 'haben'], correctIndex: 2, explanation: 'haben: er hat'),
        ExamQuestion(question: 'Sie ___ nach Berlin. (идёт)', options: ['kommt', 'geht', 'fährt', 'läuft'], correctIndex: 1, explanation: 'gehen = идти'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'de_a2_01', title: 'Präsens', subtitle: 'Настоящее время', emoji: '📝',
      level: LanguageLevel.a2, order: 1, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Сильные глаголы', content: 'Некоторые глаголы меняют корневую гласную:\nfahren: ich fahre, du fährst, er fährt\nlesen: ich lese, du liest, er liest\nschlafen: ich schlafe, du schläfst, er schläft', examples: ['Er fährt mit dem Bus.', 'Du liest ein Buch.', 'Sie schläft lange.']),
        TheorySection(title: 'Модальные глаголы', content: 'können — мочь/уметь\nmüssen — должен\nwollen — хотеть\ndürfen — разрешено\nsollen — следует\nmögen — нравиться', examples: ['Ich kann Deutsch sprechen.', 'Du musst lernen.', 'Er will schlafen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'er ___ (fahren)', options: ['fahre', 'fährst', 'fährt', 'fahren'], correctIndex: 2, explanation: 'fahren: er fährt (умлаут а→ä)'),
        CourseExercise(type: ExerciseType.translation, question: '"Я умею говорить по-немецки":', options: ['Ich will Deutsch sprechen.', 'Ich kann Deutsch sprechen.', 'Ich muss Deutsch sprechen.', 'Ich darf Deutsch sprechen.'], correctIndex: 1, explanation: 'können = уметь/мочь'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Du ___ das Buch lesen. (должен)', options: ['kannst', 'willst', 'musst', 'darfst'], correctIndex: 2, explanation: 'müssen: du musst'),
      ],
      exam: [
        ExamQuestion(question: 'du ___ (schlafen)', options: ['schlafe', 'schläfst', 'schläft', 'schlafen'], correctIndex: 1, explanation: 'schlafen: du schläfst'),
        ExamQuestion(question: '"Хотеть" по-немецки:', options: ['müssen', 'können', 'wollen', 'sollen'], correctIndex: 2, explanation: 'wollen = хотеть'),
        ExamQuestion(question: 'er ___ (lesen)', options: ['lese', 'liest', 'lest', 'lesen'], correctIndex: 1, explanation: 'lesen: er liest (e→ie)'),
        ExamQuestion(question: 'Ich ___ nicht kommen. (не могу)', options: ['will', 'muss', 'kann', 'soll'], correctIndex: 2, explanation: 'können (не мочь): ich kann nicht'),
        ExamQuestion(question: '"Разрешено" — модальный глагол:', options: ['müssen', 'wollen', 'dürfen', 'können'], correctIndex: 2, explanation: 'dürfen = иметь разрешение'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_02', title: 'Verkehr und Transport', subtitle: 'Транспорт', emoji: '🚗',
      level: LanguageLevel.a2, order: 2, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Виды транспорта', content: 'das Auto — машина\nder Bus — автобус\ndie U-Bahn — метро\nder Zug — поезд\ndas Flugzeug — самолёт\ndas Fahrrad — велосипед\nzu Fuß — пешком', examples: ['Ich fahre mit dem Bus.', 'Der Zug kommt um 9 Uhr.', 'Sie fliegt nach Berlin.']),
        TheorySection(title: 'Предлоги движения', content: 'mit + Dativ — на (транспорте)\nnach + место — в/на (город/страна)\nzu + человек/место — к/до\nvon ... bis ... — от ... до ...', examples: ['Ich fahre mit dem Zug.', 'Wir fliegen nach Deutschland.', 'Vom Bahnhof bis zum Hotel.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-немецки:', options: ['Auto', 'Zug', 'Flugzeug', 'Schiff'], correctIndex: 2, explanation: 'das Flugzeug = самолёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Я еду на поезде":', options: ['Ich fahre mit dem Auto.', 'Ich fahre mit dem Bus.', 'Ich fahre mit dem Zug.', 'Ich fliege mit dem Flugzeug.'], correctIndex: 2, explanation: 'mit dem Zug fahren = ехать на поезде'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Wir fliegen ___ Berlin.', options: ['zu', 'mit', 'nach', 'von'], correctIndex: 2, explanation: 'nach + город/страна без артикля'),
      ],
      exam: [
        ExamQuestion(question: '"Велосипед" по-немецки:', options: ['Motorrad', 'Fahrrad', 'Auto', 'Bus'], correctIndex: 1, explanation: 'das Fahrrad = велосипед (fahren + Rad = колесо)'),
        ExamQuestion(question: 'Ich fahre ___ dem Bus.', options: ['nach', 'zu', 'mit', 'von'], correctIndex: 2, explanation: 'mit + Dativ = на (транспорте)'),
        ExamQuestion(question: '"Метро" по-немецки:', options: ['Straßenbahn', 'U-Bahn', 'S-Bahn', 'Zug'], correctIndex: 1, explanation: 'die U-Bahn = метро (Untergrundbahn)'),
        ExamQuestion(question: 'Der Zug kommt ___ 10 Uhr.', options: ['in', 'bei', 'an', 'um'], correctIndex: 3, explanation: 'um + время = в ... часов'),
        ExamQuestion(question: '"Пешком" по-немецки:', options: ['mit dem Bus', 'per Auto', 'zu Fuß', 'mit dem Zug'], correctIndex: 2, explanation: 'zu Fuß = пешком'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_03', title: 'Wetter und Jahreszeiten', subtitle: 'Погода и времена года', emoji: '☀️',
      level: LanguageLevel.a2, order: 3, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'Es ist sonnig. — Солнечно.\nEs regnet. — Идёт дождь.\nEs schneit. — Идёт снег.\nEs ist bewölkt. — Облачно.\nEs ist windig. — Ветрено.\nEs ist heiß/kalt. — Жарко/Холодно.', examples: ['Heute regnet es.', 'Im Winter schneit es oft.', 'Es ist sehr heiß heute.']),
        TheorySection(title: 'Времена года', content: 'der Frühling — весна\nder Sommer — лето\nder Herbst — осень\nder Winter — зима\nim Frühling — весной\nim Sommer — летом', examples: ['Im Sommer ist es warm.', 'Im Winter ist es kalt.', 'Im Herbst fallen die Blätter.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Идёт снег" по-немецки:', options: ['Es regnet.', 'Es schneit.', 'Es ist windig.', 'Es ist kalt.'], correctIndex: 1, explanation: 'Es schneit. = Идёт снег.'),
        CourseExercise(type: ExerciseType.translation, question: '"Зима" по-немецки:', options: ['Frühling', 'Herbst', 'Winter', 'Sommer'], correctIndex: 2, explanation: 'der Winter = зима'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ Sommer ist es warm.', options: ['Am', 'In', 'Im', 'An'], correctIndex: 2, explanation: 'im = in dem; im Sommer = летом'),
      ],
      exam: [
        ExamQuestion(question: '"Весна" по-немецки:', options: ['Sommer', 'Herbst', 'Winter', 'Frühling'], correctIndex: 3, explanation: 'der Frühling = весна'),
        ExamQuestion(question: 'Es ___ heute. (дождь)', options: ['schneit', 'regnet', 'weht', 'scheint'], correctIndex: 1, explanation: 'regnen = идти (о дожде)'),
        ExamQuestion(question: '"Облачно" по-немецки:', options: ['windig', 'sonnig', 'bewölkt', 'neblig'], correctIndex: 2, explanation: 'bewölkt = облачно (Wolke = облако)'),
        ExamQuestion(question: 'Im ___ fallen die Blätter. (осенью)', options: ['Frühling', 'Sommer', 'Herbst', 'Winter'], correctIndex: 2, explanation: 'der Herbst = осень'),
        ExamQuestion(question: '"Жарко" по-немецки:', options: ['kalt', 'kühl', 'warm', 'heiß'], correctIndex: 3, explanation: 'heiß = жарко/очень тепло'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_04', title: 'Kleidung und Einkaufen', subtitle: 'Одежда и шопинг', emoji: '👗',
      level: LanguageLevel.a2, order: 4, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'das Hemd — рубашка\ndie Hose — брюки\nder Rock — юбка\ndas Kleid — платье\ndie Jacke — куртка\nder Mantel — пальто\ndie Schuhe — обувь', examples: ['Ich trage ein rotes Kleid.', 'Die Jacke ist warm.', 'Neue Schuhe sind teuer.']),
        TheorySection(title: 'Покупки', content: 'Was kostet das? — Сколько это стоит?\nDas kostet ... Euro. — Это стоит ... евро.\nIch hätte gern ... — Я бы хотел/а ...\nHaben Sie ... in Größe ...? — Есть ли у вас ... размера?', examples: ['Was kostet dieses Hemd?', 'Ich hätte gern die Jacke.', 'Haben Sie das in Größe 38?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Платье" по-немецки:', options: ['Hose', 'Rock', 'Kleid', 'Hemd'], correctIndex: 2, explanation: 'das Kleid = платье'),
        CourseExercise(type: ExerciseType.translation, question: '"Сколько это стоит?":', options: ['Was ist das?', 'Was kostet das?', 'Wie groß ist das?', 'Wie alt ist das?'], correctIndex: 1, explanation: 'kosten = стоить; Was kostet das? = Сколько стоит?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich ___ ein neues Hemd. (хотел бы)', options: ['will', 'möchte', 'hätte gern', 'kaufe'], correctIndex: 2, explanation: 'hätte gern = хотел бы (вежливая форма)'),
      ],
      exam: [
        ExamQuestion(question: '"Куртка" по-немецки:', options: ['Mantel', 'Jacke', 'Hemd', 'Pullover'], correctIndex: 1, explanation: 'die Jacke = куртка'),
        ExamQuestion(question: 'Das ___ 20 Euro.', options: ['kostet', 'kosten', 'kostete', 'hat gekostet'], correctIndex: 0, explanation: 'kosten: es kostet (3-е лицо ед.ч.)'),
        ExamQuestion(question: '"Брюки" по-немецки:', options: ['Rock', 'Kleid', 'Hose', 'Hemd'], correctIndex: 2, explanation: 'die Hose = брюки'),
        ExamQuestion(question: 'Haben Sie das in ___ 40?', options: ['Farbe', 'Größe', 'Art', 'Nummer'], correctIndex: 1, explanation: 'die Größe = размер'),
        ExamQuestion(question: '"Пальто" по-немецки:', options: ['Jacke', 'Mantel', 'Pullover', 'Anzug'], correctIndex: 1, explanation: 'der Mantel = пальто'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_05', title: 'Hobbys und Sport', subtitle: 'Хобби и спорт', emoji: '⚽',
      level: LanguageLevel.a2, order: 5, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Хобби', content: 'lesen — читать\nmusik hören — слушать музыку\nreisen — путешествовать\nkochen — готовить\nmalen — рисовать\nfotografieren — фотографировать', examples: ['In meiner Freizeit lese ich.', 'Ich höre gern Musik.', 'Sie reist oft ins Ausland.']),
        TheorySection(title: 'Спорт', content: 'Fußball spielen — играть в футбол\nschwimmen — плавать\nlaufen/joggen — бегать\nradfahren — кататься на велосипеде\nSkifahren — кататься на лыжах', examples: ['Er spielt jeden Samstag Fußball.', 'Ich schwimme gern.', 'Wir laufen morgens.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Путешествовать" по-немецки:', options: ['kochen', 'malen', 'reisen', 'lesen'], correctIndex: 2, explanation: 'reisen = путешествовать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я играю в футбол":', options: ['Ich spiele Basketball.', 'Ich spiele Fußball.', 'Ich sehe Fußball.', 'Ich mag Fußball.'], correctIndex: 1, explanation: 'Fußball spielen = играть в футбол'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich ___ gern Musik. (слушаю)', options: ['spiele', 'sehe', 'höre', 'lese'], correctIndex: 2, explanation: 'Musik hören = слушать музыку'),
      ],
      exam: [
        ExamQuestion(question: '"Плавать" по-немецки:', options: ['laufen', 'radfahren', 'schwimmen', 'klettern'], correctIndex: 2, explanation: 'schwimmen = плавать'),
        ExamQuestion(question: 'In meiner ___ lese ich. (свободное время)', options: ['Zeit', 'Freiheit', 'Freizeit', 'Urlaub'], correctIndex: 2, explanation: 'die Freizeit = свободное время'),
        ExamQuestion(question: '"Готовить" по-немецки:', options: ['essen', 'trinken', 'kochen', 'backen'], correctIndex: 2, explanation: 'kochen = готовить (варить)'),
        ExamQuestion(question: 'Er spielt jeden ___ Fußball.', options: ['Sonntag', 'Montag', 'Samstag', 'Freitag'], correctIndex: 2, explanation: 'jeden Samstag = каждую субботу'),
        ExamQuestion(question: '"Рисовать" по-немецки:', options: ['schreiben', 'malen', 'zeichnen', 'fotografieren'], correctIndex: 1, explanation: 'malen = рисовать красками; zeichnen = рисовать карандашом'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_06', title: 'Arbeit und Schule', subtitle: 'Работа и учёба', emoji: '💼',
      level: LanguageLevel.a2, order: 6, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Профессии', content: 'der Arzt / die Ärztin — врач\nder Lehrer / die Lehrerin — учитель\nder Ingenieur — инженер\nder Koch — повар\nder Programmierer — программист\nder Kaufmann — продавец/бизнесмен', examples: ['Ich bin Arzt.', 'Sie ist Lehrerin an einer Schule.', 'Er arbeitet als Ingenieur.']),
        TheorySection(title: 'Учёба', content: 'die Schule — школа\ndie Universität — университет\nlernen — учиться\nstudieren — изучать (в вузе)\ndie Prüfung — экзамен\ndas Fach — предмет', examples: ['Ich lerne Deutsch.', 'Sie studiert Medizin.', 'Morgen habe ich eine Prüfung.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Учитель" (ж.р.) по-немецки:', options: ['Ärztin', 'Lehrerin', 'Köchin', 'Ingenieurin'], correctIndex: 1, explanation: 'die Lehrerin = учительница (-in — суффикс женского рода)'),
        CourseExercise(type: ExerciseType.translation, question: '"Она изучает медицину":', options: ['Sie lernt Medizin.', 'Sie studiert Medizin.', 'Sie ist Ärztin.', 'Sie hat Medizin.'], correctIndex: 1, explanation: 'studieren = изучать в университете'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Morgen habe ich eine ___. (экзамен)', options: ['Schule', 'Prüfung', 'Klasse', 'Note'], correctIndex: 1, explanation: 'die Prüfung = экзамен/тест'),
      ],
      exam: [
        ExamQuestion(question: '"Программист" по-немецки:', options: ['Arzt', 'Ingenieur', 'Programmierer', 'Lehrer'], correctIndex: 2, explanation: 'der Programmierer = программист'),
        ExamQuestion(question: 'Ich ___ an der Universität. (учусь)', options: ['lerne', 'studiere', 'arbeite', 'unterrichte'], correctIndex: 1, explanation: 'studieren = учиться в вузе'),
        ExamQuestion(question: '"Предмет" (школьный) по-немецки:', options: ['Buch', 'Heft', 'Fach', 'Klasse'], correctIndex: 2, explanation: 'das Fach = учебный предмет'),
        ExamQuestion(question: '"Врач" (м.р.) по-немецки:', options: ['Lehrer', 'Arzt', 'Ingenieur', 'Zahnarzt'], correctIndex: 1, explanation: 'der Arzt = врач (мужчина)'),
        ExamQuestion(question: 'Er arbeitet ___ Programmierer.', options: ['wie', 'als', 'für', 'bei'], correctIndex: 1, explanation: 'als = в качестве/как (профессия)'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_07', title: 'Menschen beschreiben', subtitle: 'Описание людей', emoji: '🧑',
      level: LanguageLevel.a2, order: 7, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Внешность', content: 'groß / klein — высокий / низкий\ndick / dünn — полный / худой\nblonde Haare — светлые волосы\ndunkle Haare — тёмные волосы\nblaue Augen — голубые глаза\njung / alt — молодой / старый', examples: ['Er ist groß und hat blaue Augen.', 'Sie hat blonde Haare.', 'Mein Opa ist alt, aber fit.']),
        TheorySection(title: 'Характер', content: 'freundlich — дружелюбный\nlustig — весёлый\nruhig — спокойный\nfleißig — трудолюбивый\nklug — умный\nnett — приятный', examples: ['Meine Lehrerin ist sehr freundlich.', 'Er ist lustig und nett.', 'Sie ist fleißig und klug.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Высокий" по-немецки:', options: ['klein', 'groß', 'dick', 'jung'], correctIndex: 1, explanation: 'groß = большой/высокий'),
        CourseExercise(type: ExerciseType.translation, question: '"Он весёлый и умный":', options: ['Er ist ruhig und klug.', 'Er ist lustig und klug.', 'Er ist freundlich und nett.', 'Er ist fleißig und groß.'], correctIndex: 1, explanation: 'lustig = весёлый, klug = умный'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Sie hat ___ Haare. (тёмные)', options: ['blonde', 'rote', 'dunkle', 'lange'], correctIndex: 2, explanation: 'dunkle Haare = тёмные волосы'),
      ],
      exam: [
        ExamQuestion(question: '"Трудолюбивый" по-немецки:', options: ['lustig', 'ruhig', 'fleißig', 'nett'], correctIndex: 2, explanation: 'fleißig = трудолюбивый'),
        ExamQuestion(question: '"Худой" по-немецки:', options: ['groß', 'dick', 'dünn', 'klein'], correctIndex: 2, explanation: 'dünn = тонкий/худой'),
        ExamQuestion(question: 'Er hat ___ Augen. (голубые)', options: ['grüne', 'braune', 'blaue', 'schwarze'], correctIndex: 2, explanation: 'blaue Augen = голубые глаза'),
        ExamQuestion(question: '"Спокойный" по-немецки:', options: ['lustig', 'ruhig', 'laut', 'aktiv'], correctIndex: 1, explanation: 'ruhig = спокойный/тихий'),
        ExamQuestion(question: '"Молодой" по-немецки:', options: ['alt', 'neu', 'jung', 'modern'], correctIndex: 2, explanation: 'jung = молодой'),
      ],
    ),

    CourseChapter(
      id: 'de_a2_08', title: 'Zukunft', subtitle: 'Будущее время', emoji: '🔮',
      level: LanguageLevel.a2, order: 8, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Будущее с werden', content: 'werden + Infinitiv = Futur I\nich werde ... — я буду ...\ndu wirst ... — ты будешь ...\ner/sie wird ... — он/она будет ...', examples: ['Ich werde morgen kommen.', 'Du wirst es schaffen.', 'Er wird Arzt werden.']),
        TheorySection(title: 'Будущее с Präsens', content: 'В немецком будущее часто выражается через настоящее время + наречие времени:', examples: ['Morgen gehe ich ins Kino.', 'Nächste Woche reise ich nach Berlin.', 'Bald kommt der Zug.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'ich ___ morgen kommen. (буду)', options: ['bin', 'werde', 'wirst', 'wird'], correctIndex: 1, explanation: 'werden: ich werde'),
        CourseExercise(type: ExerciseType.translation, question: '"Он станет врачом":', options: ['Er ist Arzt.', 'Er wird Arzt.', 'Er war Arzt.', 'Er wird Arzt werden.'], correctIndex: 3, explanation: 'werden + Inf: Er wird Arzt werden.'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Du ___ es schaffen.', options: ['werde', 'wirst', 'wird', 'werden'], correctIndex: 1, explanation: 'werden: du wirst'),
      ],
      exam: [
        ExamQuestion(question: 'er ___ (werden)', options: ['werde', 'wirst', 'wird', 'werden'], correctIndex: 2, explanation: 'werden: er wird'),
        ExamQuestion(question: '"Завтра" по-немецки:', options: ['gestern', 'heute', 'morgen', 'bald'], correctIndex: 2, explanation: 'morgen = завтра'),
        ExamQuestion(question: 'Wir ___ nächste Woche reisen.', options: ['sind', 'haben', 'werden', 'würden'], correctIndex: 2, explanation: 'werden + Inf = Futur I'),
        ExamQuestion(question: '"Скоро" по-немецки:', options: ['gestern', 'heute', 'morgen', 'bald'], correctIndex: 3, explanation: 'bald = скоро'),
        ExamQuestion(question: 'Ich ___ Lehrerin werden.', options: ['will', 'werde', 'bin', 'wäre'], correctIndex: 1, explanation: 'werden: ich werde'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'de_b1_01', title: 'Vergangenheit', subtitle: 'Прошедшее время', emoji: '📚',
      level: LanguageLevel.b1, order: 1, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Perfekt', content: 'haben/sein + Partizip II\nПравильные глаголы: ge-...-t (gemacht, gespielt)\nНеправильные: ge-...-en (gegangen, gesehen)\nsein + Partizip: движение, изменение состояния', examples: ['Ich habe Deutsch gelernt.', 'Er ist nach Berlin gefahren.', 'Wir haben Pizza gegessen.']),
        TheorySection(title: 'Präteritum', content: 'Prät. используется в письменной речи и для sein/haben/модальных:\nsein: ich war, du warst, er war\nhaben: ich hatte, du hattest, er hatte\nkommen: ich kam, du kamst, er kam', examples: ['Gestern war ich krank.', 'Er hatte viel Arbeit.', 'Sie kam spät nach Hause.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Partizip II глагола "machen":', options: ['gemacht', 'gemacht', 'gemakt', 'gemachen'], correctIndex: 0, explanation: 'machen → gemacht (правильный глагол: ge + Stamm + t)'),
        CourseExercise(type: ExerciseType.translation, question: '"Я ездил в Берлин" (Perfekt):', options: ['Ich habe Berlin gefahren.', 'Ich bin nach Berlin gefahren.', 'Ich bin Berlin gegangen.', 'Ich habe Berlin besucht.'], correctIndex: 1, explanation: 'fahren + движение = sein: bin gefahren'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Gestern ___ ich krank. (был)', options: ['bin', 'habe', 'war', 'hatte'], correctIndex: 2, explanation: 'sein в Präteritum: ich war'),
      ],
      exam: [
        ExamQuestion(question: 'Ich ___ gestern Pizza gegessen.', options: ['bin', 'habe', 'war', 'hatte'], correctIndex: 1, explanation: 'essen — essen (еда) = haben: habe gegessen'),
        ExamQuestion(question: 'Partizip II от "gehen":', options: ['gegangen', 'gegeht', 'gegehen', 'ging'], correctIndex: 0, explanation: 'gehen → gegangen (неправильный)'),
        ExamQuestion(question: 'Er ___ nach Hause gegangen.', options: ['hat', 'ist', 'war', 'hatte'], correctIndex: 1, explanation: 'gehen = движение → sein: ist gegangen'),
        ExamQuestion(question: 'haben в Präteritum (ich):', options: ['habe', 'hatte', 'gehabt', 'haben'], correctIndex: 1, explanation: 'haben → ich hatte'),
        ExamQuestion(question: 'Partizip II от "schreiben":', options: ['geschrieben', 'geschreibt', 'geschrieben', 'schrieb'], correctIndex: 0, explanation: 'schreiben → geschrieben (неправильный: ei→ie)'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_02', title: 'Perfekt und Plusquamperfekt', subtitle: 'Перфект и плюсквамперфект', emoji: '⏪',
      level: LanguageLevel.b1, order: 2, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Perfekt — обзор', content: 'Perfekt = разговорное прошедшее:\nглаголы с haben: essen, kaufen, machen\nглаголы с sein: gehen, fahren, kommen, werden, sein, bleiben', examples: ['Ich habe das Buch gelesen.', 'Wir sind ins Kino gegangen.', 'Er ist Arzt geworden.']),
        TheorySection(title: 'Plusquamperfekt', content: 'hatte/war + Partizip II — предпрошедшее:\nВыражает действие ДО другого прошлого действия.', examples: ['Als er ankam, hatte ich schon gegessen.', 'Sie war schon gegangen, als ich rief.', 'Er hatte den Brief geschrieben, bevor er schlief.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Als er ankam, ___ ich schon gegessen.', options: ['hatte', 'habe', 'war', 'bin'], correctIndex: 0, explanation: 'Plusquamperfekt с haben: hatte gegessen'),
        CourseExercise(type: ExerciseType.translation, question: '"Она уже ушла, когда я позвонил":', options: ['Sie geht, als ich rief.', 'Sie ist gegangen, als ich rief.', 'Sie war schon gegangen, als ich rief.', 'Sie hatte gegangen, als ich rief.'], correctIndex: 2, explanation: 'war gegangen = Plusquamperfekt от gehen (sein)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Er ___ den Film schon gesehen, bevor er las.', options: ['ist', 'hat', 'hatte', 'war'], correctIndex: 2, explanation: 'sehen = haben: hatte gesehen'),
      ],
      exam: [
        ExamQuestion(question: 'Plusquamperfekt = hatte/war + ...', options: ['Infinitiv', 'Partizip I', 'Partizip II', 'Konjunktiv'], correctIndex: 2, explanation: 'Plusquamperfekt: hatte/war + Partizip II'),
        ExamQuestion(question: 'Bevor er schlief, ___ er gelesen.', options: ['ist', 'hat', 'hatte', 'war'], correctIndex: 2, explanation: 'lesen = haben: hatte gelesen (Plusquamperfekt)'),
        ExamQuestion(question: 'Partizip II von "bleiben":', options: ['geblieben', 'gebleibt', 'blieb', 'gebleiben'], correctIndex: 0, explanation: 'bleiben → geblieben (sein-глагол)'),
        ExamQuestion(question: 'Sie ___ schon gegangen, als ich kam.', options: ['hat', 'ist', 'hatte', 'war'], correctIndex: 3, explanation: 'gehen = sein: war gegangen'),
        ExamQuestion(question: 'Partizip II von "werden":', options: ['geworden', 'gewerdet', 'wurde', 'gewürdet'], correctIndex: 0, explanation: 'werden → geworden'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_03', title: 'Modalverben', subtitle: 'Модальные глаголы', emoji: '🎯',
      level: LanguageLevel.b1, order: 3, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Модальные в прошедшем', content: 'können → konnte\nmüssen → musste\nwollen → wollte\ndürfen → durfte\nsollen → sollte\nmögen → mochte', examples: ['Ich konnte nicht kommen.', 'Er musste arbeiten.', 'Wir wollten reisen.']),
        TheorySection(title: 'Модальные в Perfekt', content: 'Инфинитив вместо Partizip II:\nhaben + Inf + modal:\nIch habe nicht kommen können.\nEr hat arbeiten müssen.', examples: ['Sie hat schlafen wollen.', 'Wir haben reisen dürfen.', 'Er hat lesen sollen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'können в Präteritum (ich):', options: ['konnte', 'könnte', 'kann', 'gekonnt'], correctIndex: 0, explanation: 'können → ich konnte'),
        CourseExercise(type: ExerciseType.translation, question: '"Он должен был работать" (Präteritum):', options: ['Er muss arbeiten.', 'Er musste arbeiten.', 'Er hat arbeiten müssen.', 'Er sollte arbeiten.'], correctIndex: 1, explanation: 'müssen → er musste'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich habe nicht kommen ___. (Perfekt)', options: ['gekonnt', 'gekonnte', 'können', 'konnte'], correctIndex: 2, explanation: 'Modalverb in Perfekt = Infinitiv: können'),
      ],
      exam: [
        ExamQuestion(question: 'müssen в Präteritum (er):', options: ['muss', 'müsste', 'musste', 'gemusst'], correctIndex: 2, explanation: 'müssen → er musste'),
        ExamQuestion(question: 'wollen в Präteritum (wir):', options: ['wollen', 'wollten', 'wollte', 'wünschen'], correctIndex: 1, explanation: 'wollen → wir wollten'),
        ExamQuestion(question: 'Sie hat schlafen ___. (wollen)', options: ['gewollt', 'wollte', 'wollen', 'will'], correctIndex: 2, explanation: 'Perfekt с модальным = Infinitiv: wollen'),
        ExamQuestion(question: 'dürfen в Präteritum (du):', options: ['darf', 'dürftest', 'durftest', 'durfte'], correctIndex: 2, explanation: 'dürfen → du durftest'),
        ExamQuestion(question: 'mögen в Präteritum (ich):', options: ['mag', 'möchte', 'mochte', 'gemocht'], correctIndex: 2, explanation: 'mögen → ich mochte'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_04', title: 'Passiv', subtitle: 'Пассивный залог', emoji: '🔄',
      level: LanguageLevel.b1, order: 4, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Vorgangspassiv', content: 'werden + Partizip II\nПрезенс: Das Buch wird gelesen.\nПрошедшее: Das Buch wurde gelesen.\nСубъект действия — von + Dativ', examples: ['Das Haus wird gebaut.', 'Das Auto wurde repariert.', 'Der Brief wird von ihm geschrieben.']),
        TheorySection(title: 'Zustandspassiv', content: 'sein + Partizip II — результат/состояние:\nDas Fenster ist geöffnet. (результат открытия)\nDas Fenster wird geöffnet. (процесс открытия)', examples: ['Die Tür ist geschlossen.', 'Das Buch ist geschrieben.', 'Der Tisch ist gedeckt.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Das Haus ___ gebaut. (сейчас)', options: ['ist', 'wird', 'wurde', 'war'], correctIndex: 1, explanation: 'Präsens Passiv: wird + Partizip II'),
        CourseExercise(type: ExerciseType.translation, question: '"Машина была отремонтирована":', options: ['Das Auto wird repariert.', 'Das Auto ist repariert.', 'Das Auto wurde repariert.', 'Das Auto war repariert.'], correctIndex: 2, explanation: 'Präteritum Passiv: wurde + Partizip II'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Die Tür ist ___. (закрыта)', options: ['geschlossen', 'geschließt', 'schloss', 'schließend'], correctIndex: 0, explanation: 'Zustandspassiv: sein + Partizip II'),
      ],
      exam: [
        ExamQuestion(question: 'Partizip II von "bauen":', options: ['gebaut', 'gebäut', 'gebauen', 'baut'], correctIndex: 0, explanation: 'bauen → gebaut'),
        ExamQuestion(question: 'Der Brief ___ von ihm geschrieben.', options: ['ist', 'wird', 'hat', 'sein'], correctIndex: 1, explanation: 'Vorgangspassiv Präsens: wird'),
        ExamQuestion(question: 'Das Auto ___ gestern repariert. (Passiv Prät.)', options: ['wird', 'ist', 'wurde', 'war'], correctIndex: 2, explanation: 'Präteritum Passiv: wurde + Partizip II'),
        ExamQuestion(question: 'Von wem ___ das Buch geschrieben? (кем написана книга)', options: ['ist', 'wird', 'wurde', 'hat'], correctIndex: 2, explanation: 'Frage im Passiv: wurde geschrieben'),
        ExamQuestion(question: 'Das Fenster ___ geöffnet. (Zustandspassiv)', options: ['wird', 'wurde', 'ist', 'war'], correctIndex: 2, explanation: 'Zustandspassiv Präsens: ist'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_05', title: 'Indirekte Rede', subtitle: 'Косвенная речь', emoji: '💬',
      level: LanguageLevel.b1, order: 5, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Konjunktiv I', content: 'Используется в косвенной речи:\nсуществующая форма: er sei, sie habe, es gebe\nОбразование: Infinitiv-Stamm + e + окончания', examples: ['Er sagt, er sei krank.', 'Sie sagt, sie habe keine Zeit.', 'Er behauptet, er komme morgen.']),
        TheorySection(title: 'Konjunktiv II как замена', content: 'Если Konj. I = Präsens → используем Konj. II:\ner habe (Konj. I) vs. er hat (Präsens)\nОн ясен → Konj. I стоит\nсовпадает → Konj. II (er hätte, sie wäre)', examples: ['Er sagt, er wäre krank.', 'Sie meinte, sie hätte keine Zeit.', 'Er schrieb, er käme morgen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Er sagt, er ___ krank. (Konj. I от sein)', options: ['ist', 'sei', 'wäre', 'war'], correctIndex: 1, explanation: 'sein → Konjunktiv I: er sei'),
        CourseExercise(type: ExerciseType.translation, question: '"Она говорит, что у неё нет времени" (Konj. I):', options: ['Sie sagt, sie hat keine Zeit.', 'Sie sagt, sie habe keine Zeit.', 'Sie sagt, sie hätte keine Zeit.', 'Sie sagt, sie hatte keine Zeit.'], correctIndex: 1, explanation: 'haben Konj. I: sie habe'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Er behauptet, er ___ morgen. (kommen, Konj. I)', options: ['kommt', 'käme', 'komme', 'kommen'], correctIndex: 2, explanation: 'kommen Konj. I: er komme'),
      ],
      exam: [
        ExamQuestion(question: 'sein → Konjunktiv I (er):', options: ['ist', 'wäre', 'sei', 'sein'], correctIndex: 2, explanation: 'sein → er sei (Konjunktiv I)'),
        ExamQuestion(question: 'haben → Konjunktiv I (sie):', options: ['hat', 'hätte', 'habe', 'haben'], correctIndex: 2, explanation: 'haben → sie habe (Konj. I)'),
        ExamQuestion(question: 'Er schrieb, er ___ morgen. (kommen, Konj. II)', options: ['kommt', 'komme', 'käme', 'gekommen'], correctIndex: 2, explanation: 'kommen Konj. II: er käme'),
        ExamQuestion(question: 'Sie sagt, sie ___ keine Zeit. (Konj. II)', options: ['hat', 'habe', 'hätte', 'hatte'], correctIndex: 2, explanation: 'haben Konj. II: sie hätte'),
        ExamQuestion(question: 'Konjunktiv I используется в:', options: ['вопросах', 'косвенной речи', 'приказах', 'пассиве'], correctIndex: 1, explanation: 'Konjunktiv I — прежде всего в косвенной речи'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_06', title: 'Komparativ und Superlativ', subtitle: 'Сравнения', emoji: '📊',
      level: LanguageLevel.b1, order: 6, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Komparativ', content: 'Прилагательное + er:\nschnell → schneller\nalt → älter (умлаут)\ngroß → größer\nVorgleich: als\nEr ist größer als sie.', examples: ['Das Auto ist schneller als der Zug.', 'Er ist älter als ich.', 'Berlin ist größer als Hamburg.']),
        TheorySection(title: 'Superlativ', content: 'am + Adj. + sten (предикативно)\nder/die/das + Adj. + ste (атрибутивно)\nUнперегулярные: gut → besser → am besten\nviel → mehr → am meisten', examples: ['Er läuft am schnellsten.', 'Das ist das größte Haus.', 'Sie ist die beste Lehrerin.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Komparativ от "groß":', options: ['größer', 'großer', 'am größten', 'großer'], correctIndex: 0, explanation: 'groß → größer (с умлаутом)'),
        CourseExercise(type: ExerciseType.translation, question: '"Он бегает быстрее всех":', options: ['Er läuft schnell.', 'Er läuft schneller.', 'Er läuft am schnellsten.', 'Er läuft der schnellste.'], correctIndex: 2, explanation: 'Superlativ предикативный: am schnellsten'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'gut → besser → am ___', options: ['gutsten', 'besten', 'besssten', 'gutsten'], correctIndex: 1, explanation: 'gut — unregelmäßig: am besten'),
      ],
      exam: [
        ExamQuestion(question: 'Komparativ от "alt":', options: ['älter', 'alter', 'alterer', 'am ältesten'], correctIndex: 0, explanation: 'alt → älter (с умлаутом)'),
        ExamQuestion(question: 'Das ist das ___ Buch. (лучшее)', options: ['bessere', 'beste', 'bestes', 'güte'], correctIndex: 1, explanation: 'gut → best- (Superlativ атрибутивный с артиклем)'),
        ExamQuestion(question: 'Er ist ___ als sie. (больше/выше)', options: ['mehr', 'größter', 'größer', 'am größten'], correctIndex: 2, explanation: 'groß → größer (Komparativ + als)'),
        ExamQuestion(question: 'viel → mehr → am ___', options: ['mehrsten', 'meiststen', 'meisten', 'vieltsten'], correctIndex: 2, explanation: 'viel — unregelmäßig: am meisten'),
        ExamQuestion(question: 'Sie ist die ___ Lehrerin. (лучшая)', options: ['besser', 'gut', 'besten', 'beste'], correctIndex: 3, explanation: 'gut → die beste (Superlativ с def. Artikel, Nom. f)'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_07', title: 'Technologie und Internet', subtitle: 'Технологии и интернет', emoji: '💻',
      level: LanguageLevel.b1, order: 7, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Цифровой мир', content: 'das Internet — интернет\ndie App — приложение\ndie Website — веб-сайт\ndas Smartphone — смартфон\ndie KI (Künstliche Intelligenz) — ИИ\nherunterladen — скачивать\nhochladen — загружать', examples: ['Ich lade die App herunter.', 'Die KI wird immer wichtiger.', 'Schick mir den Link zur Website.']),
        TheorySection(title: 'Общение онлайн', content: 'eine E-Mail schreiben — написать email\njemanden anrufen — позвонить кому-то\neine Nachricht schicken — отправить сообщение\nsich einloggen — войти в аккаунт\nein Profil erstellen — создать профиль', examples: ['Ich schreibe eine E-Mail.', 'Hast du meine Nachricht bekommen?', 'Sie hat sich eingeloggt.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Скачивать" по-немецки:', options: ['hochladen', 'herunterladen', 'installieren', 'speichern'], correctIndex: 1, explanation: 'herunterladen = скачивать (herunter = вниз)'),
        CourseExercise(type: ExerciseType.translation, question: '"Я написал email":', options: ['Ich habe eine App geladen.', 'Ich habe eine E-Mail geschrieben.', 'Ich habe eine Nachricht geschickt.', 'Ich habe angerufen.'], correctIndex: 1, explanation: 'eine E-Mail schreiben → geschrieben'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Die KI ___ immer wichtiger.', options: ['werde', 'wird', 'ist', 'werden'], correctIndex: 1, explanation: 'werden: sie wird — (ИИ становится важнее)'),
      ],
      exam: [
        ExamQuestion(question: '"Смартфон" по-немецки:', options: ['Computer', 'Tablet', 'Smartphone', 'Laptop'], correctIndex: 2, explanation: 'das Smartphone = смартфон'),
        ExamQuestion(question: '"Загружать" (в сеть) по-немецки:', options: ['herunterladen', 'hochladen', 'installieren', 'senden'], correctIndex: 1, explanation: 'hochladen = загружать (hoch = вверх)'),
        ExamQuestion(question: '"Приложение" по-немецки:', options: ['Website', 'Link', 'App', 'Browser'], correctIndex: 2, explanation: 'die App = приложение'),
        ExamQuestion(question: 'Hast du meine ___ bekommen? (сообщение)', options: ['E-Mail', 'Nachricht', 'Anruf', 'Post'], correctIndex: 1, explanation: 'die Nachricht = сообщение/новость'),
        ExamQuestion(question: 'KI = Künstliche ___', options: ['Information', 'Intelligenz', 'Integration', 'Infrastruktur'], correctIndex: 1, explanation: 'KI = Künstliche Intelligenz = Искусственный интеллект'),
      ],
    ),

    CourseChapter(
      id: 'de_b1_08', title: 'Gesundheit und Medizin', subtitle: 'Здоровье и медицина', emoji: '🏥',
      level: LanguageLevel.b1, order: 8, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Медицинские термины', content: 'die Erkältung — простуда\ndas Fieber — температура\nder Husten — кашель\ndie Allergie — аллергия\nder Blutdruck — давление\ndas Rezept — рецепт\ndie Apotheke — аптека', examples: ['Ich habe eine Erkältung.', 'Mein Blutdruck ist zu hoch.', 'Ich brauche ein Rezept.']),
        TheorySection(title: 'У врача', content: 'Ich fühle mich nicht wohl. — Мне нехорошо.\nSeit wann haben Sie Schmerzen? — С каких пор у вас боль?\nIch verschreibe Ihnen ... — Я вам выписываю ...\nNehmen Sie die Tabletten 3x täglich. — Принимайте таблетки 3 раза в день.', examples: ['Ich fühle mich seit gestern schlecht.', 'Der Arzt verschreibt mir Tabletten.', 'Dreimal täglich eine Tablette.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Простуда" по-немецки:', options: ['Fieber', 'Erkältung', 'Husten', 'Kopfschmerzen'], correctIndex: 1, explanation: 'die Erkältung = простуда'),
        CourseExercise(type: ExerciseType.translation, question: '"Мне нехорошо":', options: ['Ich bin krank.', 'Ich fühle mich nicht wohl.', 'Mir tut es weh.', 'Ich habe Schmerzen.'], correctIndex: 1, explanation: 'sich nicht wohl fühlen = чувствовать себя нехорошо'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nehmen Sie die ___ dreimal täglich.', options: ['Rezept', 'Tabletten', 'Apotheke', 'Spritze'], correctIndex: 1, explanation: 'die Tabletten = таблетки'),
      ],
      exam: [
        ExamQuestion(question: '"Аптека" по-немецки:', options: ['Krankenhaus', 'Arztpraxis', 'Apotheke', 'Klinik'], correctIndex: 2, explanation: 'die Apotheke = аптека'),
        ExamQuestion(question: '"Кашель" по-немецки:', options: ['Fieber', 'Schnupfen', 'Husten', 'Schmerz'], correctIndex: 2, explanation: 'der Husten = кашель'),
        ExamQuestion(question: 'Ich ___ mich nicht wohl.', options: ['bin', 'fühle', 'habe', 'mache'], correctIndex: 1, explanation: 'sich fühlen: ich fühle mich'),
        ExamQuestion(question: '"Рецепт" по-немецки:', options: ['Rezept', 'Medikament', 'Tablette', 'Impfung'], correctIndex: 0, explanation: 'das Rezept = рецепт (и кулинарный, и медицинский)'),
        ExamQuestion(question: 'Seit ___ haben Sie Schmerzen?', options: ['wo', 'wie', 'wann', 'warum'], correctIndex: 2, explanation: 'Seit wann? = С каких пор?'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'de_b2_01', title: 'Konjunktional­sätze', subtitle: 'Придаточные предложения', emoji: '🔗',
      level: LanguageLevel.b2, order: 1, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Придаточные с союзами', content: 'dass — что\nweil — потому что\nobwohl — хотя\nwenn — когда/если\nals — когда (однократно в прошлом)\nfalls — в случае если\nPortal: глагол в конец!', examples: ['Ich weiß, dass er kommt.', 'Er bleibt, weil er müde ist.', 'Obwohl es regnet, gehe ich.']),
        TheorySection(title: 'Инфинитивные конструкции', content: 'um ... zu + Infinitiv — чтобы\nohne ... zu + Infinitiv — не ...-я\nanstatt ... zu + Infinitiv — вместо того чтобы', examples: ['Ich lerne, um Deutsch zu sprechen.', 'Er geht, ohne zu grüßen.', 'Sie lernt, anstatt fernzusehen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Ich weiß, ___ er krank ist.', options: ['weil', 'obwohl', 'dass', 'wenn'], correctIndex: 2, explanation: 'dass = что (дополнительное придаточное)'),
        CourseExercise(type: ExerciseType.translation, question: '"Хотя идёт дождь, я иду":', options: ['Weil es regnet, gehe ich.', 'Obwohl es regnet, gehe ich.', 'Wenn es regnet, gehe ich.', 'Falls es regnet, gehe ich.'], correctIndex: 1, explanation: 'obwohl = хотя (уступительный союз)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ich lerne, ___ Deutsch zu sprechen.', options: ['weil', 'dass', 'um', 'damit'], correctIndex: 2, explanation: 'um ... zu + Inf = чтобы'),
      ],
      exam: [
        ExamQuestion(question: '"Потому что" по-немецки:', options: ['dass', 'obwohl', 'weil', 'damit'], correctIndex: 2, explanation: 'weil = потому что (каузальный союз)'),
        ExamQuestion(question: 'Er bleibt, ___ er müde ist.', options: ['obwohl', 'weil', 'falls', 'wenn'], correctIndex: 1, explanation: 'weil = потому что'),
        ExamQuestion(question: '"Хотя" по-немецки:', options: ['weil', 'wenn', 'obwohl', 'dass'], correctIndex: 2, explanation: 'obwohl = хотя'),
        ExamQuestion(question: 'Sie lernt, anstatt fernzu___. (смотреть ТВ)', options: ['schauen', 'sehen', 'gucken', 'schauen'], correctIndex: 0, explanation: 'fernsehen: anstatt fernzusehen'),
        ExamQuestion(question: 'без um ... zu = целевое придаточное с:', options: ['dass', 'damit', 'weil', 'obwohl'], correctIndex: 1, explanation: 'damit + Nebensatz = чтобы (когда субъекты разные)'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_02', title: 'Konjunktiv II', subtitle: 'Сослагательное наклонение', emoji: '💭',
      level: LanguageLevel.b2, order: 2, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Konjunktiv II — образование', content: 'Регулярные глаголы: würde + Infinitiv\nÁнерегулярные: собственная форма:\nsein → wäre\nhaben → hätte\nkönnen → könnte\nmüssen → müsste', examples: ['Ich würde gern reisen.', 'Er wäre jetzt in Berlin.', 'Sie hätte mehr Zeit.']),
        TheorySection(title: 'Условные предложения', content: 'Тип 2 (нереальное): wenn + Konj. II, ... Konj. II\nWenn ich Zeit hätte, würde ich reisen.\nТип 3 (нереальное прошлое): Konj. II Perfekt\nWenn ich Zeit gehabt hätte, wäre ich gereist.', examples: ['Wenn ich reich wäre, würde ich eine Villa kaufen.', 'Wenn er gelernt hätte, hätte er bestanden.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Ich ___ gern reisen. (хотел бы)', options: ['will', 'wollte', 'würde', 'wäre'], correctIndex: 2, explanation: 'würde + Inf = Konjunktiv II'),
        CourseExercise(type: ExerciseType.translation, question: '"Если бы у меня было время, я бы путешествовал":', options: ['Wenn ich Zeit habe, reise ich.', 'Wenn ich Zeit hatte, reiste ich.', 'Wenn ich Zeit hätte, würde ich reisen.', 'Wenn ich Zeit gehabt hätte, wäre ich gereist.'], correctIndex: 2, explanation: 'Irrealis Gegenwart: hätte + würde ... reisen'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'sein → Konjunktiv II: ich ___', options: ['würde sein', 'wäre', 'sei', 'war'], correctIndex: 1, explanation: 'sein → ich wäre (Konj. II)'),
      ],
      exam: [
        ExamQuestion(question: 'haben → Konjunktiv II (er):', options: ['hat', 'hätte', 'habe', 'hatte'], correctIndex: 1, explanation: 'haben → er hätte'),
        ExamQuestion(question: 'können → Konjunktiv II (ich):', options: ['kann', 'konnte', 'könnte', 'können'], correctIndex: 2, explanation: 'können → ich könnte'),
        ExamQuestion(question: '"Если бы он учился, он бы сдал" (Irrealis прошлое):', options: ['Wenn er lernte, bestand er.', 'Wenn er gelernt hätte, hätte er bestanden.', 'Wenn er lernen würde, würde er bestehen.', 'Wenn er lernt, besteht er.'], correctIndex: 1, explanation: 'Irrealis Vergangenheit: hätte gelernt → hätte bestanden'),
        ExamQuestion(question: 'würde reisen = Konjunktiv II от:', options: ['sein', 'reisen', 'würden', 'fahren'], correctIndex: 1, explanation: 'würde + Infinitiv von reisen'),
        ExamQuestion(question: 'müssen → Konjunktiv II (wir):', options: ['müssen', 'müssten', 'müsste', 'mussten'], correctIndex: 1, explanation: 'müssen → wir müssten'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_03', title: 'Geschäftsdeutsch', subtitle: 'Деловой немецкий', emoji: '📊',
      level: LanguageLevel.b2, order: 3, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Деловая переписка', content: 'Sehr geehrte Damen und Herren — Уважаемые дамы и господа\nbezüglich / betreff — касательно / тема\nmit freundlichen Grüßen — с уважением\nHiermit teile ich Ihnen mit, dass ... — Настоящим сообщаю вам, что ...', examples: ['Sehr geehrte Frau Müller,', 'Betreff: Termin am 15. Mai', 'Mit freundlichen Grüßen, Max Schmidt']),
        TheorySection(title: 'Переговоры', content: 'Ich schlage vor, ... — Я предлагаю ...\nWie wäre es mit ...? — Как насчёт ...?\nDas wäre möglich. — Это возможно.\nLeider ist das nicht machbar. — К сожалению, это невозможно.', examples: ['Ich schlage einen Termin vor.', 'Wie wäre es mit Montag?', 'Leider ist das nicht möglich.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Стандартное завершение делового письма:', options: ['Tschüss', 'Auf Wiedersehen', 'Mit freundlichen Grüßen', 'Liebe Grüße'], correctIndex: 2, explanation: 'Mit freundlichen Grüßen = с уважением (официально)'),
        CourseExercise(type: ExerciseType.translation, question: '"Я предлагаю встречу в понедельник":', options: ['Ich will Montag treffen.', 'Ich schlage einen Termin am Montag vor.', 'Montag ist gut.', 'Können wir Montag treffen?'], correctIndex: 1, explanation: 'vorschlagen = предлагать: ich schlage vor'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Sehr geehrte ___ und Herren,', options: ['Leute', 'Freunde', 'Damen', 'Kollegen'], correctIndex: 2, explanation: 'Sehr geehrte Damen und Herren = стандартное обращение'),
      ],
      exam: [
        ExamQuestion(question: 'betreff = ?', options: ['вместо', 'тема/касательно', 'с уважением', 'уважаемые'], correctIndex: 1, explanation: 'Betreff = тема письма (Re:)'),
        ExamQuestion(question: '"К сожалению, это невозможно":', options: ['Das ist möglich.', 'Das wäre schön.', 'Leider ist das nicht machbar.', 'Das geht leider nicht so.'], correctIndex: 2, explanation: 'nicht machbar = неосуществимо'),
        ExamQuestion(question: 'Hiermit ___ ich Ihnen mit, dass ...', options: ['sage', 'teile', 'schreibe', 'melde'], correctIndex: 1, explanation: 'mitteilen = сообщать: ich teile mit'),
        ExamQuestion(question: '"Как насчёт среды?":', options: ['Können wir Mittwoch?', 'Wie wäre es mit Mittwoch?', 'Mittwoch ist gut.', 'Ich schlage Mittwoch vor.'], correctIndex: 1, explanation: 'Wie wäre es mit ...? = Как насчёт ...?'),
        ExamQuestion(question: 'Обращение к женщине в письме:', options: ['Lieber Herr', 'Sehr geehrte Frau', 'Hallo Frau', 'Liebe Frau'], correctIndex: 1, explanation: 'Sehr geehrte Frau ... = официальное обращение к женщине'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_04', title: 'Redewendungen', subtitle: 'Идиомы и фразеологизмы', emoji: '🎭',
      level: LanguageLevel.b2, order: 4, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Популярные идиомы', content: 'Daumen drücken — держать кулаки (желать удачи)\nDen Nagel auf den Kopf treffen — попасть в точку\nKein Blatt vor den Mund nehmen — говорить прямо\nJemandem auf die Finger schauen — присматривать за кем-то\nDas ist nicht mein Bier. — Это не моё дело.', examples: ['Ich drücke dir die Daumen!', 'Du hast den Nagel auf den Kopf getroffen.', 'Das ist nicht mein Bier.']),
        TheorySection(title: 'Разговорные выражения', content: 'Das geht mir auf die Nerven. — Это действует мне на нервы.\nIch bin am Ende. — Я на пределе/вымотан.\nNicht um den heißen Brei reden. — Говорить прямо.\nDas kommt mir bekannt vor. — Это мне знакомо.', examples: ['Das geht mir auf die Nerven!', 'Ich bin heute total am Ende.', 'Sag es direkt, rede nicht um den heißen Brei!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Держать кулаки" (желать удачи) по-немецки:', options: ['Daumen halten', 'Daumen drücken', 'Hände drücken', 'Finger kreuzen'], correctIndex: 1, explanation: 'jemandem die Daumen drücken = желать удачи'),
        CourseExercise(type: ExerciseType.translation, question: '"Это не моё дело":', options: ['Das ist mein Problem.', 'Das ist nicht mein Bier.', 'Das geht mich an.', 'Das kümmert mich.'], correctIndex: 1, explanation: 'Das ist nicht mein Bier. = буквально "это не моё пиво" = не моё дело'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Du hast den ___ auf den Kopf getroffen!', options: ['Hammer', 'Nagel', 'Finger', 'Daumen'], correctIndex: 1, explanation: 'Den Nagel auf den Kopf treffen = попасть в точку'),
      ],
      exam: [
        ExamQuestion(question: '"Это действует мне на нервы":', options: ['Das geht mir auf die Nerven.', 'Ich bin nervös.', 'Das nervt mich total.', 'Nerven auf die Seite.'], correctIndex: 0, explanation: 'auf die Nerven gehen = действовать на нервы'),
        ExamQuestion(question: '"Говорить прямо" (идиома):', options: ['direkt sprechen', 'kein Blatt vor den Mund nehmen', 'den Mund halten', 'laut sprechen'], correctIndex: 1, explanation: 'kein Blatt vor den Mund nehmen = говорить без обиняков'),
        ExamQuestion(question: 'Ich bin am ___. (вымотан)', options: ['Ende', 'Anfang', 'Limit', 'Rand'], correctIndex: 0, explanation: 'am Ende sein = быть на пределе'),
        ExamQuestion(question: '"Это мне знакомо":', options: ['Ich kenne das.', 'Das kommt mir bekannt vor.', 'Das weiß ich.', 'Das ist klar.'], correctIndex: 1, explanation: 'Das kommt mir bekannt vor. = это знакомо/кажется знакомым'),
        ExamQuestion(question: '"Присматривать за кем-то" (идиома):', options: ['auf jemanden schauen', 'jemandem auf die Finger schauen', 'jemanden beobachten', 'auf die Hände schauen'], correctIndex: 1, explanation: 'jemandem auf die Finger schauen = следить за кем-то'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_05', title: 'Kultur und Gesellschaft', subtitle: 'Культура и общество', emoji: '🏛️',
      level: LanguageLevel.b2, order: 5, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Немецкоязычные страны', content: 'Deutschland — Германия (80 млн)\nÖsterreich — Австрия (9 млн)\nSchweiz — Швейцария (8 млн, 4 языка)\nLiechtenstein — Лихтенштейн\nBelgien (teil) — Бельгия (часть)', examples: ['Ich bin in Deutschland aufgewachsen.', 'Wien ist die Hauptstadt Österreichs.', 'Die Schweiz hat vier Amtssprachen.']),
        TheorySection(title: 'Культурные особенности', content: 'Pünktlichkeit — пунктуальность (очень важна)\nDuzen/Siezen — ты/вы\nDeutsche Gründlichkeit — немецкая тщательность\nBrot und Wurst — культ хлеба и колбасы', examples: ['Pünktlichkeit ist sehr wichtig.', 'Darf ich Sie duzen?', 'Deutschland hat über 300 Brotsorten.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Столица Австрии:', options: ['Zürich', 'Bern', 'Wien', 'Salzburg'], correctIndex: 2, explanation: 'Wien (Вена) = столица Австрии'),
        CourseExercise(type: ExerciseType.translation, question: '"Пунктуальность очень важна":', options: ['Pünktlichkeit ist unwichtig.', 'Pünktlichkeit ist sehr wichtig.', 'Pünktlichkeit ist möglich.', 'Pünktlichkeit macht Spaß.'], correctIndex: 1, explanation: 'sehr wichtig = очень важно'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Die Schweiz hat vier ___sprachen.', options: ['Haupt', 'National', 'Amts', 'Landes'], correctIndex: 2, explanation: 'Amtssprachen = официальные языки'),
      ],
      exam: [
        ExamQuestion(question: 'Немецкоязычных стран (полностью/частично):',  options: ['3', '4', '5', '6'], correctIndex: 2, explanation: 'Германия, Австрия, Швейцария, Лихтенштейн, часть Бельгии = ~5'),
        ExamQuestion(question: 'Siezen = обращение на:', options: ['ты', 'вы', 'он', 'они'], correctIndex: 1, explanation: 'siezen = обращаться на Sie (вы)'),
        ExamQuestion(question: 'Deutsche ___ = немецкая тщательность:', options: ['Pünktlichkeit', 'Gründlichkeit', 'Qualität', 'Ordnung'], correctIndex: 1, explanation: 'Gründlichkeit = тщательность/основательность'),
        ExamQuestion(question: 'Столица Германии:', options: ['München', 'Hamburg', 'Berlin', 'Frankfurt'], correctIndex: 2, explanation: 'Berlin = столица Германии'),
        ExamQuestion(question: 'Duzen = обращение на:', options: ['вы', 'ты', 'он', 'мы'], correctIndex: 1, explanation: 'duzen = обращаться на du (ты)'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_06', title: 'Medien und Meinung', subtitle: 'СМИ и мнения', emoji: '📰',
      level: LanguageLevel.b2, order: 6, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Выражение мнения', content: 'Meiner Meinung nach ... — По моему мнению ...\nIch bin der Ansicht, dass ... — Я считаю, что ...\nEinerseits ... andererseits ... — С одной стороны ... с другой ...\nIm Großen und Ganzen ... — В целом ...', examples: ['Meiner Meinung nach ist das falsch.', 'Einerseits ist es teuer, andererseits ist es gut.', 'Im Großen und Ganzen bin ich einverstanden.']),
        TheorySection(title: 'Медиа', content: 'die Zeitung — газета\ndie Nachricht — новость\ndie Meinung — мнение\nder Bericht — репортаж\ndie Schlagzeile — заголовок\nfake news / Falschmeldung — фейк', examples: ['Die Zeitung berichtet über ...',  'Die Schlagzeile ist reißerisch.', 'Achte auf Falschmeldungen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"По моему мнению" по-немецки:', options: ['Ich denke,', 'Meiner Meinung nach,', 'Ich bin der Meinung,', 'Laut mir,'], correctIndex: 1, explanation: 'Meiner Meinung nach = по моему мнению'),
        CourseExercise(type: ExerciseType.translation, question: '"Заголовок" по-немецки:', options: ['Bericht', 'Meinung', 'Schlagzeile', 'Artikel'], correctIndex: 2, explanation: 'die Schlagzeile = заголовок'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ ist es teuer, andererseits ist es gut.', options: ['Jedoch', 'Einerseits', 'Trotzdem', 'Außerdem'], correctIndex: 1, explanation: 'einerseits ... andererseits = с одной ... с другой стороны'),
      ],
      exam: [
        ExamQuestion(question: '"В целом" по-немецки:', options: ['insgesamt', 'im Großen und Ganzen', 'meistens', 'übrigens'], correctIndex: 1, explanation: 'im Großen und Ganzen = в целом/в общем'),
        ExamQuestion(question: '"Репортаж" по-немецки:', options: ['Zeitung', 'Meinung', 'Bericht', 'Schlagzeile'], correctIndex: 2, explanation: 'der Bericht = репортаж/отчёт'),
        ExamQuestion(question: 'Я считаю, что это неправильно:', options: ['Meiner Meinung nach ist das falsch.', 'Das ist falsch.', 'Ich denke falsch.', 'Das weiß ich nicht.'], correctIndex: 0, explanation: 'Meiner Meinung nach = по моему мнению'),
        ExamQuestion(question: 'Falschmeldung = ?', options: ['правдивая новость', 'фейк', 'заголовок', 'репортаж'], correctIndex: 1, explanation: 'Falschmeldung = фейк/ложная новость'),
        ExamQuestion(question: '"Газета" по-немецки:', options: ['Zeitschrift', 'Zeitung', 'Magazin', 'Buch'], correctIndex: 1, explanation: 'die Zeitung = газета (ежедневная)'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_07', title: 'Erweiterte Grammatik', subtitle: 'Продвинутая грамматика', emoji: '🎓',
      level: LanguageLevel.b2, order: 7, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Partizipialkonstruktionen', content: 'Причастные обороты — замена придаточных:\nDer Mann, der im Park läuft. →\nDer im Park laufende Mann.\nDas Buch, das geschrieben wurde. →\nDas geschriebene Buch.', examples: ['Der weinende Mann.', 'Das beschädigte Auto.', 'Die schlafende Katze.']),
        TheorySection(title: 'Erweiterte Attribute', content: 'Расширенный атрибут стоит между артиклем и существительным:\nDas von ihm geschriebene Buch...\nDie in Berlin lebende Frau...\nEin aus Frankreich stammender Wein...', examples: ['Das von ihr gelesene Buch ist spannend.', 'Die in München wohnende Frau heißt Petra.', 'Ein sehr leckeres deutsches Bier.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Partizip I от "laufen":', options: ['gelaufen', 'laufend', 'läuft', 'lief'], correctIndex: 1, explanation: 'Partizip I = Infinitiv + d: laufend'),
        CourseExercise(type: ExerciseType.translation, question: '"Спящая кошка" (Partizip I):', options: ['Die geschlafene Katze', 'Die schlafende Katze', 'Die schläft Katze', 'Die Schlaf-Katze'], correctIndex: 1, explanation: 'schlafen → schlafend (Partizip I) → die schlafende Katze'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Das von ihm ___ Buch. (geschrieben — написанная)', options: ['schreibende', 'schreibt', 'geschriebene', 'schreiben'], correctIndex: 2, explanation: 'Partizip II als erweitertes Attribut: geschriebene'),
      ],
      exam: [
        ExamQuestion(question: 'Partizip I = ?', options: ['ge-...-t', 'Inf + d', 'würde + Inf', 'Inf + te'], correctIndex: 1, explanation: 'Partizip I = Infinitiv + d (z.B. laufend, schlafend)'),
        ExamQuestion(question: '"Плачущий мужчина" (Partizip I):', options: ['der weinende Mann', 'der geweinte Mann', 'der Mann, der weinen', 'der geweinte Mann'], correctIndex: 0, explanation: 'weinen → weinend → der weinende Mann'),
        ExamQuestion(question: '"Написанная книга" (Partizip II):', options: ['das schreibende Buch', 'das geschriebene Buch', 'das Buch geschrieben', 'das schreibt Buch'], correctIndex: 1, explanation: 'schreiben → geschrieben → das geschriebene Buch'),
        ExamQuestion(question: 'Die ___ Frau heißt Petra. (жить в Мюнхене)', options: ['in München wohnde', 'in München wohnende', 'wohnende München', 'München-wohnend'], correctIndex: 1, explanation: 'wohnen → wohnend → die in München wohnende Frau'),
        ExamQuestion(question: 'Расширенный атрибут стоит:', options: ['после существительного', 'в конце предложения', 'между артиклем и существительным', 'перед артиклем'], correctIndex: 2, explanation: 'Erweitertes Attribut стоит между артиклем и существительным'),
      ],
    ),

    CourseChapter(
      id: 'de_b2_08', title: 'Abschlussprüfung', subtitle: 'Финальный экзамен', emoji: '🏆',
      level: LanguageLevel.b2, order: 8, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Повторение A1–B1', content: 'A1: Приветствия, числа, семья, еда, время, животные, глаголы\nA2: Модальные, транспорт, погода, работа, будущее\nB1: Прошедшее (Perfekt/Präteritum), Passiv, Konjunktiv I, сравнения', examples: ['Ich bin nach Berlin gefahren.', 'Das Auto wurde repariert.', 'Er ist größer als sie.']),
        TheorySection(title: 'Повторение B2', content: 'B2: Придаточные, Konjunktiv II, деловой немецкий, идиомы, Partizipialkonstruktionen\nWenn ich Zeit hätte, würde ich reisen.\nDer im Park laufende Mann.\nMeiner Meinung nach ...', examples: ['Das geschriebene Buch ist gut.', 'Leider ist das nicht machbar.', 'Daumen drücken!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Wenn ich Zeit ___, würde ich reisen.', options: ['habe', 'hatte', 'hätte', 'gehabt habe'], correctIndex: 2, explanation: 'Konjunktiv II: hätte (Irrealis)'),
        CourseExercise(type: ExerciseType.translation, question: '"Книга была написана им":', options: ['Das Buch schreibt er.', 'Das Buch ist von ihm geschrieben worden.', 'Das Buch schrieb er.', 'Das Buch hat er geschrieben.'], correctIndex: 1, explanation: 'Passiv Perfekt: ist geschrieben worden'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Der im Park ___ Mann. (laufen, Parz. I)', options: ['gelaufene', 'laufende', 'läuft', 'laufenden'], correctIndex: 1, explanation: 'laufen → laufend → der laufende Mann'),
      ],
      exam: [
        ExamQuestion(question: 'Passiv Perfekt: Das Haus ___ gebaut ___.',  options: ['hat ... geworden', 'ist ... worden', 'wird ... sein', 'wurde ... gebaut'], correctIndex: 1, explanation: 'Passiv Perfekt: ist + Partizip II + worden'),
        ExamQuestion(question: 'Konjunktiv II von "haben" (ich):', options: ['habe', 'hatte', 'hätte', 'gehabt'], correctIndex: 2, explanation: 'haben → ich hätte (Konj. II)'),
        ExamQuestion(question: '"Den Nagel auf den Kopf treffen" = ?', options: ['забить гвоздь', 'попасть в точку', 'ударить по голове', 'найти решение'], correctIndex: 1, explanation: 'попасть в точку = den Nagel auf den Kopf treffen'),
        ExamQuestion(question: 'Einerseits ... ___ ... = с одной ... с другой стороны:', options: ['trotzdem', 'außerdem', 'andererseits', 'deshalb'], correctIndex: 2, explanation: 'einerseits ... andererseits'),
        ExamQuestion(question: 'Partizip I от "schlafen":', options: ['geschlafen', 'schläft', 'schlafend', 'schlief'], correctIndex: 2, explanation: 'schlafen → schlafend (Partizip I)'),
      ],
    ),
  ],
);
