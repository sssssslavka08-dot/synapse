import '../courses/course_structure.dart';

const russianCourse = LanguageCourse(
  langCode: 'ru',
  langName: 'Русский',
  nativeName: 'Русский',
  flag: '🇷🇺',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'ru_a1_01', title: 'Привет!', subtitle: 'Приветствия и знакомство', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Привет — неформальное\nЗдравствуйте — формальное\nДоброе утро\nДобрый день\nДобрый вечер\nДо свидания\nПока — неформальное', examples: ['Привет! Как дела?', 'Здравствуйте! Меня зовут Анна.', 'До свидания!']),
        TheorySection(title: 'Знакомство', content: 'Как тебя зовут? — неформально\nКак вас зовут? — формально\nМеня зовут ...\nОткуда ты?\nЯ из ...\nОчень приятно!', examples: ['Как тебя зовут? — Меня зовут Иван.', 'Откуда ты? — Я из Казахстана.', 'Очень приятно!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Формальное приветствие по-русски:', options: ['Привет', 'Здравствуйте', 'Пока', 'Хай'], correctIndex: 1, explanation: '"Здравствуйте" — официальное приветствие'),
        CourseExercise(type: ExerciseType.translation, question: '"До свидания" — это:', options: ['приветствие', 'прощание', 'вопрос', 'ответ'], correctIndex: 1, explanation: '"До свидания" используется при прощании'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Меня ___ Анна.', options: ['зову', 'звать', 'зовут', 'называю'], correctIndex: 2, explanation: '"Меня зовут" — стандартная фраза для представления'),
      ],
      exam: [
        ExamQuestion(question: 'Неформальное "привет" по-русски:', options: ['Здравствуйте', 'Добрый день', 'Привет', 'Доброе утро'], correctIndex: 2, explanation: '"Привет" — разговорное приветствие'),
        ExamQuestion(question: '"Как дела?" — это вопрос о...', options: ['имени', 'происхождении', 'самочувствии', 'возрасте'], correctIndex: 2, explanation: '"Как дела?" спрашивают о состоянии/самочувствии'),
        ExamQuestion(question: '"Доброе утро" говорят:', options: ['вечером', 'ночью', 'утром', 'в полдень'], correctIndex: 2, explanation: '"Доброе утро" — приветствие в первой половине дня'),
        ExamQuestion(question: '"Очень приятно!" говорят при:', options: ['прощании', 'знакомстве', 'ссоре', 'просьбе'], correctIndex: 1, explanation: '"Очень приятно!" — реакция на знакомство'),
        ExamQuestion(question: '"Пока" — это:', options: ['формальное прощание', 'вопрос', 'неформальное прощание', 'приветствие'], correctIndex: 2, explanation: '"Пока" — неформальное "до свидания"'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_02', title: 'Алфавит и числа', subtitle: 'Кириллица и цифры', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Русский алфавит', content: 'В русском алфавите 33 буквы.\nГласные: А, Е, Ё, И, О, У, Ы, Э, Ю, Я\nСогласные: Б, В, Г, Д, Ж, З, К, Л, М, Н, П, Р, С, Т, Ф, Х, Ц, Ч, Ш, Щ\nЪ, Ь — знаки', examples: ['кот — cat', 'мир — world', 'дом — house']),
        TheorySection(title: 'Числа 1–20', content: '1-один, 2-два, 3-три, 4-четыре, 5-пять\n6-шесть, 7-семь, 8-восемь, 9-девять, 10-десять\n11-одиннадцать, 12-двенадцать, 20-двадцать', examples: ['Мне двадцать лет.', 'Пять яблок.', 'Два плюс три — пять.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Сколько букв в русском алфавите?', options: ['26', '30', '33', '36'], correctIndex: 2, explanation: 'В русском алфавите 33 буквы'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Число 7 по-русски:', options: ['шесть', 'восемь', 'семь', 'девять'], correctIndex: 2, explanation: '7 = семь'),
        CourseExercise(type: ExerciseType.translation, question: 'Число 12 по-русски:', options: ['одиннадцать', 'тринадцать', 'двенадцать', 'двадцать'], correctIndex: 2, explanation: '12 = двенадцать'),
      ],
      exam: [
        ExamQuestion(question: 'Ь называется:', options: ['твёрдый знак', 'мягкий знак', 'краткое', 'апостроф'], correctIndex: 1, explanation: 'Ь = мягкий знак, смягчает предыдущую согласную'),
        ExamQuestion(question: '5 + 3 = ?', options: ['семь', 'девять', 'восемь', 'шесть'], correctIndex: 2, explanation: 'пять + три = восемь'),
        ExamQuestion(question: '20 по-русски:', options: ['двенадцать', 'двадцать', 'двести', 'дважды'], correctIndex: 1, explanation: '20 = двадцать'),
        ExamQuestion(question: 'Ъ называется:', options: ['мягкий знак', 'твёрдый знак', 'ер', 'ерь'], correctIndex: 1, explanation: 'Ъ = твёрдый знак'),
        ExamQuestion(question: 'Буква Ё отличается от Е:', options: ['произношением', 'двумя точками сверху', 'оба варианта верны', 'ничем'], correctIndex: 2, explanation: 'Ё произносится как "йо" и пишется с двумя точками'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_03', title: 'Семья', subtitle: 'Члены семьи', emoji: '👨‍👩‍👧',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Семья', content: 'мама/мать — мама\nпапа/отец — папа\nсестра — сестра\nбрат — брат\nбабушка — бабушка\nдедушка — дедушка\nсын — сын\nдочь — дочь', examples: ['Моя мама работает врачом.', 'У меня есть брат.', 'Дедушка читает газету.']),
        TheorySection(title: 'Притяжательные местоимения', content: 'мой/моя/моё/мои — мой\nтвой/твоя/твоё/твои — твой\nего — его\nеё — её\nнаш/наша/наше/наши — наш', examples: ['Мой папа инженер.', 'Твоя сестра красивая.', 'Наша семья большая.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Бабушка" по-русски — это мать вашей:', options: ['сестры', 'тёти', 'мамы или папы', 'подруги'], correctIndex: 2, explanation: 'Бабушка — мать вашей мамы или папы'),
        CourseExercise(type: ExerciseType.translation, question: '"Моя сестра" — правильная форма:', options: ['мой сестра', 'моя сестра', 'моё сестра', 'мои сестра'], correctIndex: 1, explanation: 'сестра — женский род, поэтому "моя"'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ папа работает. (Мой)', options: ['Моё', 'Моя', 'Мой', 'Мои'], correctIndex: 2, explanation: 'папа — мужской род, поэтому "мой"'),
      ],
      exam: [
        ExamQuestion(question: '"Дочь" по-русски — это:', options: ['сын', 'девочка-ребёнок', 'сестра', 'племянница'], correctIndex: 1, explanation: 'дочь = daughter (девочка как ребёнок)'),
        ExamQuestion(question: '"Наш дом" — правильная форма:', options: ['нашa дом', 'наше дом', 'наш дом', 'наши дом'], correctIndex: 2, explanation: 'дом — мужской род, поэтому "наш"'),
        ExamQuestion(question: 'У меня ___ брат. (есть)', options: ['имею', 'есть', 'имеется', 'есть один'], correctIndex: 1, explanation: 'У меня есть = I have (конструкция с "есть")'),
        ExamQuestion(question: '"Твоя книга" — кому принадлежит книга?', options: ['мне', 'ему', 'тебе', 'нам'], correctIndex: 2, explanation: '"Твоя" = belonging to you (тебе)'),
        ExamQuestion(question: '"Его мама" — чья мама?', options: ['моя', 'его', 'её', 'их'], correctIndex: 1, explanation: '"Его" = his, принадлежащее ему'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_04', title: 'Еда', subtitle: 'Продукты и напитки', emoji: '🍎',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'хлеб — хлеб\nмясо — мясо\nрыба — рыба\nовощи — овощи\nфрукты — фрукты\nсуп — суп\nкаша — каша\nсалат — салат', examples: ['Я ем хлеб с маслом.', 'Суп очень вкусный.', 'Люблю фрукты.']),
        TheorySection(title: 'Напитки', content: 'вода — вода\nчай — чай\nкофе — кофе\nмолоко — молоко\nсок — сок\nкефир — кефир\nквас — квас', examples: ['Пью чай каждое утро.', 'Стакан воды, пожалуйста.', 'Кофе с молоком.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Чай" по-русски — это:', options: ['coffee', 'juice', 'tea', 'water'], correctIndex: 2, explanation: 'чай = tea'),
        CourseExercise(type: ExerciseType.translation, question: '"Хлеб" по-русски — это:', options: ['meat', 'fish', 'bread', 'soup'], correctIndex: 2, explanation: 'хлеб = bread'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Стакан ___, пожалуйста.', options: ['чай', 'вода', 'воды', 'молоко'], correctIndex: 2, explanation: 'После "стакан" используется родительный падеж: воды'),
      ],
      exam: [
        ExamQuestion(question: '"Молоко" по-русски — это:', options: ['kefir', 'juice', 'milk', 'cream'], correctIndex: 2, explanation: 'молоко = milk'),
        ExamQuestion(question: '"Рыба" по-русски — это:', options: ['meat', 'fish', 'chicken', 'shrimp'], correctIndex: 1, explanation: 'рыба = fish'),
        ExamQuestion(question: '"Пожалуйста" означает:', options: ['спасибо', 'пожалуйста/будьте добры', 'извините', 'да'], correctIndex: 1, explanation: '"Пожалуйста" = please или you\'re welcome'),
        ExamQuestion(question: '"Вкусный" означает:', options: ['beautiful', 'delicious', 'sweet', 'spicy'], correctIndex: 1, explanation: 'вкусный = tasty/delicious'),
        ExamQuestion(question: '"Квас" — это:', options: ['алкогольный напиток', 'безалкогольный ферментированный напиток', 'молочный продукт', 'сок'], correctIndex: 1, explanation: 'Квас — традиционный русский безалкогольный напиток из хлеба'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_05', title: 'Цвета и тело', subtitle: 'Цвета и части тела', emoji: '🎨',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Цвета', content: 'красный — red\nсиний — blue\nзелёный — green\nжёлтый — yellow\nбелый — white\nчёрный — black\nоранжевый — orange\nрозовый — pink', examples: ['Красная роза.', 'Синее небо.', 'Зелёная трава.']),
        TheorySection(title: 'Части тела', content: 'голова — head\nглаз — eye\nухо — ear\nнос — nose\nрот — mouth\nрука — arm/hand\nнога — leg/foot\nсердце — heart', examples: ['Болит голова.', 'Мои глаза карие.', 'Поднимите руку.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Красный" по-русски — это:', options: ['blue', 'green', 'red', 'yellow'], correctIndex: 2, explanation: 'красный = red'),
        CourseExercise(type: ExerciseType.translation, question: '"Голова" по-русски — это:', options: ['hand', 'foot', 'head', 'ear'], correctIndex: 2, explanation: 'голова = head'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'У меня ___ глаза. (карие)', options: ['карий', 'карие', 'карего', 'кареми'], correctIndex: 1, explanation: 'глаза — множественное число, поэтому "карие"'),
      ],
      exam: [
        ExamQuestion(question: '"Синий" — это:', options: ['red', 'blue', 'green', 'grey'], correctIndex: 1, explanation: 'синий = blue (тёмно-синий)'),
        ExamQuestion(question: '"Нос" по-русски — это:', options: ['ear', 'eye', 'nose', 'mouth'], correctIndex: 2, explanation: 'нос = nose'),
        ExamQuestion(question: '"Зелёный" — это:', options: ['yellow', 'blue', 'green', 'brown'], correctIndex: 2, explanation: 'зелёный = green'),
        ExamQuestion(question: '"Болит рука" означает:', options: ['My head hurts', 'My leg hurts', 'My arm hurts', 'My back hurts'], correctIndex: 2, explanation: 'рука = arm/hand'),
        ExamQuestion(question: '"Чёрный" — это:', options: ['white', 'grey', 'dark', 'black'], correctIndex: 3, explanation: 'чёрный = black'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_06', title: 'Время и дни', subtitle: 'Время и дни недели', emoji: '📅',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'понедельник — Monday\nвторник — Tuesday\nсреда — Wednesday\nчетверг — Thursday\nпятница — Friday\nсуббота — Saturday\nвоскресенье — Sunday', examples: ['В понедельник на работу.', 'Пятница — любимый день.', 'В воскресенье отдыхаю.']),
        TheorySection(title: 'Время суток', content: 'утро — morning\nдень — day/afternoon\nвечер — evening\nночь — night\nсегодня — today\nзавтра — tomorrow\nвчера — yesterday', examples: ['Доброе утро!', 'Сегодня хорошая погода.', 'Увидимся завтра.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пятница" по-русски — это:', options: ['Thursday', 'Friday', 'Saturday', 'Wednesday'], correctIndex: 1, explanation: 'пятница = Friday'),
        CourseExercise(type: ExerciseType.translation, question: '"Сегодня" по-русски означает:', options: ['yesterday', 'tomorrow', 'today', 'now'], correctIndex: 2, explanation: 'сегодня = today'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ утро! (Доброе)', options: ['Добрый', 'Добрая', 'Доброе', 'Добрые'], correctIndex: 2, explanation: 'утро — средний род, поэтому "Доброе"'),
      ],
      exam: [
        ExamQuestion(question: '"Воскресенье" по-русски — это:', options: ['Saturday', 'Friday', 'Sunday', 'Monday'], correctIndex: 2, explanation: 'воскресенье = Sunday'),
        ExamQuestion(question: '"Вчера" по-русски означает:', options: ['today', 'tomorrow', 'yesterday', 'soon'], correctIndex: 2, explanation: 'вчера = yesterday'),
        ExamQuestion(question: 'Рабочая неделя начинается с:', options: ['воскресенья', 'субботы', 'понедельника', 'вторника'], correctIndex: 2, explanation: 'В России рабочая неделя начинается с понедельника'),
        ExamQuestion(question: '"Вечер" — это:', options: ['morning', 'afternoon', 'evening', 'night'], correctIndex: 2, explanation: 'вечер = evening'),
        ExamQuestion(question: '"Завтра" по-русски означает:', options: ['yesterday', 'today', 'tomorrow', 'soon'], correctIndex: 2, explanation: 'завтра = tomorrow'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_07', title: 'Животные', subtitle: 'Домашние и дикие животные', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Домашние животные', content: 'кошка — cat\nсобака — dog\nлошадь — horse\nкорова — cow\nкурица — chicken\nрыбка — goldfish\nкролик — rabbit', examples: ['У нас есть кошка.', 'Собака лает.', 'Корова даёт молоко.']),
        TheorySection(title: 'Дикие животные', content: 'лев — lion\nтигр — tiger\nмедведь — bear\nволк — wolf\nлиса — fox\nзаяц — hare\nорёл — eagle', examples: ['Медведь — символ России.', 'Лиса хитрая.', 'Орёл летит высоко.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-русски — это:', options: ['dog', 'cat', 'rabbit', 'mouse'], correctIndex: 1, explanation: 'кошка = cat'),
        CourseExercise(type: ExerciseType.translation, question: '"Медведь" по-русски — это:', options: ['wolf', 'fox', 'bear', 'lion'], correctIndex: 2, explanation: 'медведь = bear (символ России)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'У нас есть ___. (кошка)', options: ['кот', 'кошку', 'кошка', 'кошке'], correctIndex: 2, explanation: 'После "есть" используется именительный падеж: кошка'),
      ],
      exam: [
        ExamQuestion(question: '"Собака" по-русски — это:', options: ['cat', 'dog', 'wolf', 'fox'], correctIndex: 1, explanation: 'собака = dog'),
        ExamQuestion(question: 'Символ России среди животных:', options: ['лев', 'орёл', 'медведь', 'волк'], correctIndex: 2, explanation: 'Медведь — традиционный символ России'),
        ExamQuestion(question: '"Лиса" по-русски — это:', options: ['wolf', 'bear', 'fox', 'hare'], correctIndex: 2, explanation: 'лиса = fox'),
        ExamQuestion(question: '"Орёл" по-русски — это:', options: ['pigeon', 'sparrow', 'eagle', 'owl'], correctIndex: 2, explanation: 'орёл = eagle'),
        ExamQuestion(question: '"Волк" по-русски — это:', options: ['fox', 'bear', 'hare', 'wolf'], correctIndex: 3, explanation: 'волк = wolf'),
      ],
    ),

    CourseChapter(
      id: 'ru_a1_08', title: 'Глаголы', subtitle: 'Базовые глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Основные глаголы', content: 'идти — to go (пешком)\nехать — to go (на транспорте)\nговорить — to speak\nпонимать — to understand\nзнать — to know\nлюбить — to love\nхотеть — to want', examples: ['Я иду в школу.', 'Ты говоришь по-русски?', 'Я люблю музыку.']),
        TheorySection(title: 'Настоящее время', content: 'я говорю\nты говоришь\nон/она говорит\nмы говорим\nвы говорите\nони говорят', examples: ['Я говорю по-русски.', 'Он понимает всё.', 'Мы хотим есть.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я говорю" — правильная форма:', options: ['я говорит', 'я говорю', 'я говоришь', 'я говорим'], correctIndex: 1, explanation: 'говорить: я говорю (1 лицо ед.ч.)'),
        CourseExercise(type: ExerciseType.translation, question: '"Ты понимаешь" — правильная форма:', options: ['ты понимает', 'ты понимаю', 'ты понимаешь', 'ты понимаем'], correctIndex: 2, explanation: 'понимать: ты понимаешь (2 лицо ед.ч.)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Мы ___ по-русски. (говорим)', options: ['говорю', 'говоришь', 'говорит', 'говорим'], correctIndex: 3, explanation: 'говорить: мы говорим (1 лицо мн.ч.)'),
      ],
      exam: [
        ExamQuestion(question: '"Хотеть" — форма 3-го лица ед.ч.:', options: ['хочу', 'хочешь', 'хочет', 'хотим'], correctIndex: 2, explanation: 'хотеть: он/она хочет'),
        ExamQuestion(question: '"Знать" — форма 1-го лица мн.ч.:', options: ['знаю', 'знаешь', 'знает', 'знаем'], correctIndex: 3, explanation: 'знать: мы знаем'),
        ExamQuestion(question: '"Идти" и "ехать" — разница:', options: ['нет разницы', 'идти — пешком, ехать — на транспорте', 'идти — быстро, ехать — медленно', 'идти — далеко, ехать — близко'], correctIndex: 1, explanation: 'идти = on foot, ехать = by transport'),
        ExamQuestion(question: '"Я люблю музыку" — "люблю" — это:', options: ['2 лицо', '1 лицо ед.ч.', '3 лицо', '1 лицо мн.ч.'], correctIndex: 1, explanation: 'любить: я люблю (1 лицо ед.ч.)'),
        ExamQuestion(question: '"Они говорят" — правильная форма:', options: ['говорю', 'говоришь', 'говорит', 'говорят'], correctIndex: 3, explanation: 'говорить: они говорят (3 лицо мн.ч.)'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'ru_a2_01', title: 'Прошедшее время', subtitle: 'Глаголы в прошлом', emoji: '⏮️',
      level: LanguageLevel.a2, order: 9, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Прошедшее время', content: 'Прошедшее время образуется от инфинитива:\nчитал (м.р.) / читала (ж.р.) / читало (ср.р.) / читали (мн.ч.)\nбыл/была/было/были — was/were\nпошёл/пошла/пошли — went', examples: ['Вчера я читал книгу.', 'Она была дома.', 'Мы пошли в кино.']),
        TheorySection(title: 'Род в прошедшем времени', content: 'Прошедшее время согласуется с родом подлежащего:\nОн читал (м.р.)\nОна читала (ж.р.)\nОно читало (ср.р.)\nОни читали (мн.ч.)', examples: ['Иван читал газету.', 'Анна читала книгу.', 'Дети читали вместе.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Она читала" — правильно, потому что:', options: ['это мужской род', 'это женский род', 'это множественное число', 'это средний род'], correctIndex: 1, explanation: 'читала — форма женского рода прошедшего времени'),
        CourseExercise(type: ExerciseType.translation, question: '"Мы пошли в кино" — правильная форма:', options: ['пошёл', 'пошла', 'пошло', 'пошли'], correctIndex: 3, explanation: 'пошли — форма множественного числа прошедшего времени'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Вчера он ___ дома. (был)', options: ['была', 'были', 'был', 'было'], correctIndex: 2, explanation: 'он — мужской род, поэтому "был"'),
      ],
      exam: [
        ExamQuestion(question: '"Анна пошла" — форма прошедшего:', options: ['мужской род', 'женский род', 'средний род', 'множественное число'], correctIndex: 1, explanation: 'пошла — женский род прошедшего времени'),
        ExamQuestion(question: 'Дети ___ книгу. (читали)', options: ['читал', 'читала', 'читало', 'читали'], correctIndex: 3, explanation: 'дети — множественное число, поэтому "читали"'),
        ExamQuestion(question: '"Было" — это форма:', options: ['мужского рода', 'женского рода', 'среднего рода', 'множественного числа'], correctIndex: 2, explanation: 'было — средний род прошедшего времени'),
        ExamQuestion(question: 'Иван ___ в школу. (пошёл)', options: ['пошла', 'пошло', 'пошли', 'пошёл'], correctIndex: 3, explanation: 'пошёл — мужской род прошедшего времени'),
        ExamQuestion(question: '"Вчера" по-русски означает:', options: ['today', 'tomorrow', 'yesterday', 'last week'], correctIndex: 2, explanation: 'вчера = yesterday'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_02', title: 'Транспорт', subtitle: 'Городской транспорт', emoji: '🚌',
      level: LanguageLevel.a2, order: 10, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Транспорт', content: 'автобус — bus\nметро — metro\nтакси — taxi\nтрамвай — tram\nпоезд — train\nсамолёт — airplane\nмашина — car', examples: ['Еду на метро.', 'Автобус приехал.', 'Такси заказал.']),
        TheorySection(title: 'Предлоги транспорта', content: 'на + предложный падеж:\nна автобусе — by bus\nна метро — by metro\nна машине — by car\nна поезде — by train\nпешком — on foot', examples: ['Еду на работу на метро.', 'Он приехал на машине.', 'Иду пешком.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-русски — это:', options: ['train', 'bus', 'airplane', 'ship'], correctIndex: 2, explanation: 'самолёт = airplane'),
        CourseExercise(type: ExerciseType.translation, question: '"На метро" означает:', options: ['in the metro', 'by metro', 'to the metro', 'from metro'], correctIndex: 1, explanation: 'на метро = by metro (предлог направления)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Я еду на работу ___ метро.', options: ['в', 'по', 'на', 'из'], correctIndex: 2, explanation: '"на метро" — конструкция с предлогом "на"'),
      ],
      exam: [
        ExamQuestion(question: '"Трамвай" по-русски — это:', options: ['bus', 'trolleybus', 'tram', 'subway'], correctIndex: 2, explanation: 'трамвай = tram'),
        ExamQuestion(question: '"Пешком" означает:', options: ['by car', 'by bike', 'on foot', 'by bus'], correctIndex: 2, explanation: 'пешком = on foot'),
        ExamQuestion(question: '"Поезд" по-русски — это:', options: ['bus', 'train', 'tram', 'metro'], correctIndex: 1, explanation: 'поезд = train'),
        ExamQuestion(question: 'Как сказать "by car" по-русски?', options: ['в машине', 'на машине', 'по машине', 'с машиной'], correctIndex: 1, explanation: 'на машине = by car'),
        ExamQuestion(question: '"Такси" по-русски — это:', options: ['bus', 'minibus', 'taxi', 'shuttle'], correctIndex: 2, explanation: 'такси = taxi'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_03', title: 'Погода', subtitle: 'Погода и сезоны', emoji: '🌤️',
      level: LanguageLevel.a2, order: 11, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'солнечно — sunny\nоблачно — cloudy\nдождливо — rainy\nснежно — snowy\nветрено — windy\nхолодно — cold\nтепло — warm\nжарко — hot', examples: ['Сегодня солнечно.', 'На улице холодно.', 'Идёт дождь.']),
        TheorySection(title: 'Сезоны', content: 'весна — spring\nлето — summer\nосень — autumn\nзима — winter\nвесной — in spring\nлетом — in summer\nосенью — in autumn\nзимой — in winter', examples: ['Летом жарко.', 'Зимой идёт снег.', 'Осенью листья желтеют.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Зима" по-русски — это:', options: ['spring', 'summer', 'autumn', 'winter'], correctIndex: 3, explanation: 'зима = winter'),
        CourseExercise(type: ExerciseType.translation, question: '"Идёт дождь" означает:', options: ['It is snowing', 'It is raining', 'It is sunny', 'It is windy'], correctIndex: 1, explanation: 'идёт дождь = it is raining'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ идёт снег. (Зимой)', options: ['Зима', 'Зимой', 'В зиму', 'Зимнее'], correctIndex: 1, explanation: 'зимой = in winter (творительный падеж)'),
      ],
      exam: [
        ExamQuestion(question: '"Лето" по-русски — это:', options: ['spring', 'summer', 'autumn', 'winter'], correctIndex: 1, explanation: 'лето = summer'),
        ExamQuestion(question: '"Холодно" означает:', options: ['warm', 'hot', 'cold', 'cool'], correctIndex: 2, explanation: 'холодно = it\'s cold'),
        ExamQuestion(question: '"Весна" по-русски — это:', options: ['winter', 'summer', 'spring', 'autumn'], correctIndex: 2, explanation: 'весна = spring'),
        ExamQuestion(question: '"Ветрено" означает:', options: ['rainy', 'snowy', 'windy', 'cloudy'], correctIndex: 2, explanation: 'ветрено = it\'s windy'),
        ExamQuestion(question: 'Как сказать "in summer" по-русски?', options: ['лето', 'летом', 'в лете', 'в лето'], correctIndex: 1, explanation: 'летом = in summer (творительный падеж)'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_04', title: 'Одежда', subtitle: 'Что мы носим', emoji: '👕',
      level: LanguageLevel.a2, order: 12, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'рубашка — shirt\nбрюки — trousers\nюбка — skirt\nплатье — dress\nпальто — coat\nшапка — hat/winter cap\nботинки — boots/shoes', examples: ['Надену белую рубашку.', 'Это красивое платье.', 'Где мои ботинки?']),
        TheorySection(title: 'Глаголы одежды', content: 'надевать/надеть — to put on\nносить — to wear\nснимать/снять — to take off\nодеваться — to get dressed\nраздеваться — to undress', examples: ['Надень пальто — холодно!', 'Я ношу очки.', 'Снимите шапку.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Платье" по-русски — это:', options: ['skirt', 'blouse', 'dress', 'coat'], correctIndex: 2, explanation: 'платье = dress'),
        CourseExercise(type: ExerciseType.translation, question: '"Надеть" означает:', options: ['to take off', 'to wash', 'to buy', 'to put on'], correctIndex: 3, explanation: 'надеть = to put on'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ пальто — холодно! (Надень)', options: ['Сними', 'Надень', 'Купи', 'Постирай'], correctIndex: 1, explanation: 'Надень = Put on (imperative)'),
      ],
      exam: [
        ExamQuestion(question: '"Шапка" по-русски — это:', options: ['scarf', 'gloves', 'hat/winter cap', 'umbrella'], correctIndex: 2, explanation: 'шапка = hat/winter cap'),
        ExamQuestion(question: '"Снять" означает:', options: ['to put on', 'to wear', 'to take off', 'to buy'], correctIndex: 2, explanation: 'снять = to take off'),
        ExamQuestion(question: '"Ботинки" по-русски — это:', options: ['slippers', 'sandals', 'sneakers', 'boots/shoes'], correctIndex: 3, explanation: 'ботинки = ankle boots/shoes'),
        ExamQuestion(question: '"Брюки" по-русски — это:', options: ['shorts', 'trousers', 'jeans', 'tights'], correctIndex: 1, explanation: 'брюки = trousers'),
        ExamQuestion(question: '"Пальто" по-русски — это:', options: ['jacket', 'coat', 'vest', 'sweater'], correctIndex: 1, explanation: 'пальто = coat (длинное)'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_05', title: 'Хобби', subtitle: 'Свободное время', emoji: '🎯',
      level: LanguageLevel.a2, order: 13, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Хобби', content: 'читать книги — read books\nслушать музыку — listen to music\nзаниматься спортом — do sports\nрисовать — draw\nпутешествовать — travel\nфотографировать — photograph\nиграть — play', examples: ['Люблю читать книги.', 'Каждый день занимаюсь спортом.', 'Хочу путешествовать.']),
        TheorySection(title: 'Выражение предпочтений', content: 'любить + инфинитив — to love doing\nнравиться — to like\nинтересоваться + тв. пад. — to be interested in\nувлекаться + тв. пад. — to be keen on', examples: ['Мне нравится музыка.', 'Увлекаюсь историей.', 'Интересуюсь наукой.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Путешествовать" по-русски — это:', options: ['to read', 'to travel', 'to draw', 'to play'], correctIndex: 1, explanation: 'путешествовать = to travel'),
        CourseExercise(type: ExerciseType.translation, question: '"Мне нравится музыка" означает:', options: ['I love music', 'I like music', 'I hate music', 'I know music'], correctIndex: 1, explanation: 'мне нравится = I like (букв. "мне нравится")'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Я ___ историей. (увлекаюсь)', options: ['увлекаюсь', 'увлекает', 'увлекаешься', 'увлекаются'], correctIndex: 0, explanation: 'я увлекаюсь = I am interested in'),
      ],
      exam: [
        ExamQuestion(question: '"Рисовать" по-русски — это:', options: ['to sing', 'to dance', 'to draw', 'to play'], correctIndex: 2, explanation: 'рисовать = to draw'),
        ExamQuestion(question: '"Нравиться" означает:', options: ['to love', 'to like', 'to hate', 'to want'], correctIndex: 1, explanation: 'нравиться = to like/to be pleasing'),
        ExamQuestion(question: '"Увлекаться" + какой падеж?', options: ['родительный', 'дательный', 'творительный', 'предложный'], correctIndex: 2, explanation: 'увлекаться + творительный: увлекаюсь музыкой'),
        ExamQuestion(question: '"Заниматься спортом" означает:', options: ['watch sports', 'do sports', 'love sports', 'play sports'], correctIndex: 1, explanation: 'заниматься спортом = to do sports'),
        ExamQuestion(question: '"Фотографировать" по-русски — это:', options: ['to film', 'to draw', 'to photograph', 'to paint'], correctIndex: 2, explanation: 'фотографировать = to photograph'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_06', title: 'Будущее время', subtitle: 'Планы и намерения', emoji: '🔮',
      level: LanguageLevel.a2, order: 14, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Будущее время', content: 'Несовершенный вид: буду + инфинитив\nбуду читать — I will be reading\nСовершенный вид: просто спрягается\nпрочитаю — I will read\nпойду — I will go\nскажу — I will say', examples: ['Завтра буду читать.', 'Я пойду в магазин.', 'Скажу маме.']),
        TheorySection(title: 'Планы', content: 'собираться + инфинитив — to be going to\nпланировать — to plan\nнадеяться — to hope\nхотеть — to want\nможет быть — maybe', examples: ['Собираюсь поехать в отпуск.', 'Планирую учиться.', 'Может быть, пойду в кино.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Буду читать" — это:', options: ['прошедшее', 'настоящее', 'будущее несов.', 'будущее сов.'], correctIndex: 2, explanation: 'буду + инфинитив = будущее несовершенное'),
        CourseExercise(type: ExerciseType.translation, question: '"Я пойду" — это форма:', options: ['настоящего', 'прошедшего', 'будущего совершенного', 'будущего несовершенного'], correctIndex: 2, explanation: 'пойду — будущее совершенного вида'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Завтра я ___ в кино. (пойду)', options: ['иду', 'шёл', 'пойду', 'буду идти'], correctIndex: 2, explanation: 'пойду = will go (будущее совершенное)'),
      ],
      exam: [
        ExamQuestion(question: '"Собираюсь" означает:', options: ['I am going to', 'I was going', 'I went', 'I go'], correctIndex: 0, explanation: 'собираюсь = I am going to / I plan to'),
        ExamQuestion(question: '"Может быть" означает:', options: ['definitely', 'never', 'maybe', 'always'], correctIndex: 2, explanation: 'может быть = maybe/perhaps'),
        ExamQuestion(question: '"Буду работать" — форма:', options: ['прошедшее', 'настоящее', 'будущее несовершенное', 'будущее совершенное'], correctIndex: 2, explanation: 'буду + инфинитив = несовершенный вид будущего'),
        ExamQuestion(question: '"Надеяться" означает:', options: ['to plan', 'to want', 'to hope', 'to decide'], correctIndex: 2, explanation: 'надеяться = to hope'),
        ExamQuestion(question: '"Планировать" означает:', options: ['to hope', 'to want', 'to plan', 'to try'], correctIndex: 2, explanation: 'планировать = to plan'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_07', title: 'Покупки', subtitle: 'В магазине', emoji: '🛍️',
      level: LanguageLevel.a2, order: 15, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'В магазине', content: 'магазин — store\nпродавец — seller\nпокупатель — buyer\nцена — price\nдорого — expensive\nдёшево — cheap\nскидка — discount\nчек — receipt', examples: ['Сколько стоит?', 'Слишком дорого.', 'Есть скидка?']),
        TheorySection(title: 'Диалог в магазине', content: 'Сколько стоит? — How much is it?\nПокажите, пожалуйста — Show me please\nВозьму — I\'ll take it\nМожно примерить? — Can I try it on?\nДайте сдачу — Give me change', examples: ['Сколько стоит эта рубашка?', 'Можно примерить?', 'Возьму!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сколько стоит?" означает:', options: ['Where is it?', 'What is it?', 'How much is it?', 'Is it good?'], correctIndex: 2, explanation: 'Сколько стоит? = How much does it cost?'),
        CourseExercise(type: ExerciseType.translation, question: '"Дёшево" означает:', options: ['expensive', 'cheap', 'free', 'discount'], correctIndex: 1, explanation: 'дёшево = cheap/inexpensive'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Слишком ___ (дорого)!', options: ['дёшево', 'дорого', 'красиво', 'плохо'], correctIndex: 1, explanation: 'дорого = expensive'),
      ],
      exam: [
        ExamQuestion(question: '"Скидка" по-русски — это:', options: ['price', 'receipt', 'discount', 'sale'], correctIndex: 2, explanation: 'скидка = discount'),
        ExamQuestion(question: '"Продавец" — это:', options: ['buyer', 'seller', 'cashier', 'manager'], correctIndex: 1, explanation: 'продавец = seller/shop assistant'),
        ExamQuestion(question: '"Возьму" означает:', options: ['I will look', 'I will try', 'I will take it', 'I will pay'], correctIndex: 2, explanation: 'возьму = I\'ll take it'),
        ExamQuestion(question: '"Чек" по-русски — это:', options: ['money', 'card', 'receipt', 'bill'], correctIndex: 2, explanation: 'чек = receipt'),
        ExamQuestion(question: '"Можно примерить?" означает:', options: ['Can I see it?', 'Can I try it on?', 'Can I buy it?', 'Can I return it?'], correctIndex: 1, explanation: 'Можно примерить? = Can I try it on?'),
      ],
    ),

    CourseChapter(
      id: 'ru_a2_08', title: 'Вопросы', subtitle: 'Вопросительные слова', emoji: '❓',
      level: LanguageLevel.a2, order: 16, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Вопросительные слова', content: 'что — what\nкто — who\nгде — where\nкуда — where to\nкак — how\nпочему — why\nкогда — when\nсколько — how many/much', examples: ['Что ты делаешь?', 'Кто пришёл?', 'Где ты живёшь?']),
        TheorySection(title: 'Где vs Куда', content: 'где — статичная позиция (where)\nкуда — направление (where to)\nОн дома — He is at home\nОн идёт домой — He is going home\nоткуда — where from', examples: ['Где ты? — Я здесь.', 'Куда идёшь? — Домой.', 'Откуда ты? — Из Москвы.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Почему" по-русски — это:', options: ['when', 'where', 'why', 'how'], correctIndex: 2, explanation: 'почему = why'),
        CourseExercise(type: ExerciseType.translation, question: '"Куда идёшь?" означает:', options: ['Where are you?', 'Where are you going?', 'Where do you live?', 'Where are you from?'], correctIndex: 1, explanation: 'куда = where to (направление)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ ты живёшь? (Where do you live?)', options: ['Куда', 'Откуда', 'Где', 'Когда'], correctIndex: 2, explanation: 'где = where (статичная позиция)'),
      ],
      exam: [
        ExamQuestion(question: '"Когда" по-русски — это:', options: ['how', 'why', 'when', 'who'], correctIndex: 2, explanation: 'когда = when'),
        ExamQuestion(question: '"Сколько" по-русски — это:', options: ['what', 'how', 'how many/much', 'which'], correctIndex: 2, explanation: 'сколько = how many/how much'),
        ExamQuestion(question: '"Откуда ты?" означает:', options: ['Where are you going?', 'Where are you?', 'Where are you from?', 'Why are you here?'], correctIndex: 2, explanation: 'откуда = where from'),
        ExamQuestion(question: '"Кто" по-русски — это:', options: ['what', 'who', 'which', 'whose'], correctIndex: 1, explanation: 'кто = who'),
        ExamQuestion(question: 'Разница между "где" и "куда":', options: ['нет разницы', 'где — позиция, куда — направление', 'где — направление, куда — позиция', 'оба о направлении'], correctIndex: 1, explanation: 'где = where (position), куда = where to (direction)'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'ru_b1_01', title: 'Падежи', subtitle: 'Система падежей', emoji: '📐',
      level: LanguageLevel.b1, order: 17, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: '6 падежей русского языка', content: 'Именительный (Им.) — кто? что?\nРодительный (Рд.) — кого? чего?\nДательный (Дт.) — кому? чему?\nВинительный (Вн.) — кого? что?\nТворительный (Тв.) — кем? чем?\nПредложный (Пр.) — о ком? о чём?', examples: ['Книга (Им.) на столе.', 'Нет книги (Рд.).', 'Даю книгу (Вн.) другу (Дт.).']),
        TheorySection(title: 'Окончания существительных', content: 'стол (м.р.): Рд.-стола, Дт.-столу, Вн.-стол, Тв.-столом, Пр.-о столе\nкнига (ж.р.): Рд.-книги, Дт.-книге, Вн.-книгу, Тв.-книгой, Пр.-о книге', examples: ['Иду в школу (Вн.).', 'Говорю о школе (Пр.).', 'Книга лежит на столе (Пр.).']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Дать книгу другу" — "другу" это:', options: ['именительный', 'родительный', 'дательный', 'винительный'], correctIndex: 2, explanation: 'кому? другу — дательный падеж'),
        CourseExercise(type: ExerciseType.translation, question: '"О школе" — это какой падеж?', options: ['родительный', 'творительный', 'предложный', 'дательный'], correctIndex: 2, explanation: '"о чём?" = предложный падеж'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Книга лежит на ___ (стол → предложный).', options: ['стол', 'стола', 'столу', 'столе'], correctIndex: 3, explanation: 'на столе — предложный падеж'),
      ],
      exam: [
        ExamQuestion(question: 'Родительный падеж отвечает на вопрос:', options: ['кто? что?', 'кому? чему?', 'кого? чего?', 'кем? чем?'], correctIndex: 2, explanation: 'Родительный: кого? чего?'),
        ExamQuestion(question: '"Вижу друга" — "друга" это:', options: ['именительный', 'родительный', 'дательный', 'винительный'], correctIndex: 3, explanation: 'кого вижу? друга — винительный падеж'),
        ExamQuestion(question: '"Говорю с другом" — "другом" это:', options: ['дательный', 'родительный', 'творительный', 'предложный'], correctIndex: 2, explanation: 'с кем? с другом — творительный падеж'),
        ExamQuestion(question: 'Предложный падеж используется:', options: ['после "видеть"', 'после "дать"', 'после "о/в/на"', 'после "нет"'], correctIndex: 2, explanation: 'предложный = после предлогов о, в, на'),
        ExamQuestion(question: 'Сколько падежей в русском языке?', options: ['4', '5', '6', '7'], correctIndex: 2, explanation: 'В современном русском 6 падежей'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_02', title: 'Виды глагола', subtitle: 'Совершенный и несовершенный вид', emoji: '🔄',
      level: LanguageLevel.b1, order: 18, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Виды глагола', content: 'Несовершенный вид (НСВ) — процесс:\nчитать — to be reading\nписать — to be writing\nСовершенный вид (СВ) — результат:\nпрочитать — to finish reading\nнаписать — to finish writing', examples: ['Я читал книгу. (процесс)', 'Я прочитал книгу. (закончил)', 'Пишу письмо / написал письмо.']),
        TheorySection(title: 'Образование видов', content: 'НСВ → СВ часто через приставку:\nделать → сделать\nписать → написать\nчитать → прочитать\nговорить → сказать (особый случай)', examples: ['Делал домашнее задание. (НСВ)', 'Сделал домашнее задание. (СВ)', 'Написал письмо. (СВ)']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Прочитал" — это:', options: ['НСВ настоящее', 'НСВ прошедшее', 'СВ прошедшее', 'НСВ будущее'], correctIndex: 2, explanation: 'прочитал — совершенный вид, прошедшее время'),
        CourseExercise(type: ExerciseType.translation, question: '"Я писал письмо" означает:', options: ['Я закончил писать письмо', 'Я был в процессе написания', 'Я напишу письмо', 'Я написал письмо'], correctIndex: 1, explanation: 'НСВ прошедшее = был в процессе'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Я ___ домашнее задание. (закончил делать — СВ)', options: ['делал', 'сделал', 'делаю', 'буду делать'], correctIndex: 1, explanation: 'сделал = finished doing (совершенный вид)'),
      ],
      exam: [
        ExamQuestion(question: 'Совершенный вид обозначает:', options: ['процесс', 'результат/завершённость', 'повторное действие', 'длительное действие'], correctIndex: 1, explanation: 'СВ = результат, завершённость действия'),
        ExamQuestion(question: '"Написать" — это:', options: ['НСВ', 'СВ', 'оба варианта', 'ни один'], correctIndex: 1, explanation: 'написать = совершенный вид (на- + писать)'),
        ExamQuestion(question: '"Читал" vs "прочитал" — разница:', options: ['нет разницы', 'читал = процесс, прочитал = завершил', 'читал = давно, прочитал = недавно', 'только стиль'], correctIndex: 1, explanation: 'НСВ = процесс, СВ = результат'),
        ExamQuestion(question: '"Делать" → СВ:', options: ['переделать', 'сделать', 'оба верны', 'доделать'], correctIndex: 1, explanation: 'основная пара: делать → сделать'),
        ExamQuestion(question: '"Говорить" → СВ:', options: ['поговорить', 'сказать', 'заговорить', 'оба первых верны'], correctIndex: 3, explanation: 'говорить → сказать (одноразовое) или поговорить (поговорить о чём-то)'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_03', title: 'Причастия', subtitle: 'Причастия и деепричастия', emoji: '📝',
      level: LanguageLevel.b1, order: 19, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Причастия', content: 'Действительное: читающий, читавший\nСтрадательное: читаемый, прочитанный\nПричастный оборот заменяет придаточное:\nчеловек, читающий книгу = человек, который читает', examples: ['Студент, читающий книгу.', 'Книга, прочитанная мной.', 'Письмо, написанное другом.']),
        TheorySection(title: 'Деепричастия', content: 'Деепричастие = как/когда + действие\nчитая — while reading\nпрочитав — having read\nговоря — while speaking\nсказав — having said', examples: ['Читая книгу, я заснул.', 'Прочитав книгу, я вернул её.', 'Говоря тихо, он извинился.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Читающий студент" — это:', options: ['деепричастие', 'причастие', 'наречие', 'глагол'], correctIndex: 1, explanation: 'читающий — причастие настоящего времени'),
        CourseExercise(type: ExerciseType.translation, question: '"Читая книгу" — это:', options: ['причастие', 'деепричастие', 'прилагательное', 'существительное'], correctIndex: 1, explanation: 'читая — деепричастие несовершенного вида'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ книгу, я заснул. (читая/прочитав)', options: ['Прочитав', 'Читая', 'Читавший', 'Читаемый'], correctIndex: 1, explanation: 'читая = while reading (одновременное действие)'),
      ],
      exam: [
        ExamQuestion(question: '"Прочитанная книга" — это:', options: ['действит. причастие наст.', 'действит. причастие прош.', 'страдат. причастие прош.', 'деепричастие'], correctIndex: 2, explanation: 'прочитанная = страдательное причастие прошедшего времени'),
        ExamQuestion(question: '"Прочитав книгу" означает:', options: ['while reading', 'having read', 'being read', 'to read'], correctIndex: 1, explanation: 'прочитав = having read (деепричастие СВ)'),
        ExamQuestion(question: 'Деепричастный оборот отделяется:', options: ['точкой', 'запятыми', 'скобками', 'тире'], correctIndex: 1, explanation: 'Деепричастный оборот выделяется запятыми'),
        ExamQuestion(question: '"Человек, читающий газету" — можно заменить на:', options: ['человек читал газету', 'человек, который читает газету', 'человек читает газету', 'читавший газету человек'], correctIndex: 1, explanation: 'причастный оборот = придаточное с "который"'),
        ExamQuestion(question: '"Говоря" — это:', options: ['причастие', 'деепричастие НСВ', 'деепричастие СВ', 'наречие'], correctIndex: 1, explanation: 'говоря = деепричастие несовершенного вида'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_04', title: 'Сравнения', subtitle: 'Степени сравнения', emoji: '⚖️',
      level: LanguageLevel.b1, order: 20, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Сравнительная степень', content: 'Простая форма: -ее/-ей или -е\nкрасивее — more beautiful\nбыстрее — faster\nтише — quieter\nАналитическая: более + прилагательное\nболее красивый — more beautiful', examples: ['Она красивее сестры.', 'Он бежит быстрее.', 'Это более сложная задача.']),
        TheorySection(title: 'Превосходная степень', content: 'Аналитическая: самый + прилагательное\nсамый красивый — the most beautiful\nСинтетическая: -айший/-ейший\nвеличайший — the greatest\nмудрейший — the wisest', examples: ['Это самый красивый город.', 'Он самый быстрый.', 'Величайший писатель.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самый большой" — это:', options: ['сравнительная', 'превосходная', 'положительная', 'относительная'], correctIndex: 1, explanation: 'самый + прилагательное = превосходная степень'),
        CourseExercise(type: ExerciseType.translation, question: '"Красивее" означает:', options: ['very beautiful', 'more beautiful', 'the most beautiful', 'quite beautiful'], correctIndex: 1, explanation: 'красивее = more beautiful (сравнительная)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Москва ___ Рязани. (больше)', options: ['большой', 'больше', 'самый большой', 'наибольший'], correctIndex: 1, explanation: 'больше + родительный падеж = bigger than'),
      ],
      exam: [
        ExamQuestion(question: '"Быстрее" — это:', options: ['превосходная', 'сравнительная', 'положительная', 'усилительная'], correctIndex: 1, explanation: 'быстрее = faster (сравнительная степень)'),
        ExamQuestion(question: '"Самый умный" означает:', options: ['very smart', 'smarter', 'the smartest', 'quite smart'], correctIndex: 2, explanation: 'самый умный = the smartest'),
        ExamQuestion(question: '"Более сложный" — это:', options: ['аналитическая сравнительная', 'синтетическая сравнительная', 'превосходная', 'относительная'], correctIndex: 0, explanation: 'более + прилагательное = аналитическая сравнительная'),
        ExamQuestion(question: 'Синтетическая превосходная степень образуется:', options: ['самый +', 'более +', 'суффиксами -айший/-ейший', 'очень +'], correctIndex: 2, explanation: '-айший/-ейший = синтетическая превосходная'),
        ExamQuestion(question: '"Тише" — сравнительная от:', options: ['тихий', 'тишина', 'тихо', 'все варианты'], correctIndex: 3, explanation: 'тише = тише чем (от "тихий" или "тихо")'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_05', title: 'Технологии', subtitle: 'Цифровой мир', emoji: '💻',
      level: LanguageLevel.b1, order: 21, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Технологии', content: 'компьютер — computer\nсмартфон — smartphone\nинтернет — internet\nприложение — application/app\nсоцсети — social media\nэлектронная почта — email\nпрограммирование — programming', examples: ['Работаю на компьютере.', 'Скачал приложение.', 'Отправил по электронной почте.']),
        TheorySection(title: 'Действия в интернете', content: 'скачивать/скачать — to download\nзагружать/загрузить — to upload\nотправлять/отправить — to send\nделиться/поделиться — to share\nподписываться/подписаться — to subscribe\nобновлять/обновить — to update', examples: ['Скачал файл.', 'Поделился фото.', 'Подпишитесь на канал.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Скачать" означает:', options: ['to upload', 'to download', 'to share', 'to delete'], correctIndex: 1, explanation: 'скачать = to download'),
        CourseExercise(type: ExerciseType.translation, question: '"Приложение" по-русски — это:', options: ['computer', 'internet', 'application/app', 'file'], correctIndex: 2, explanation: 'приложение = app/application'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Подпишитесь ___ канал! (на)', options: ['в', 'на', 'по', 'за'], correctIndex: 1, explanation: 'подписаться на + винительный падеж'),
      ],
      exam: [
        ExamQuestion(question: '"Загрузить" означает:', options: ['to download', 'to upload', 'to share', 'to delete'], correctIndex: 1, explanation: 'загрузить = to upload (в интернет)'),
        ExamQuestion(question: '"Электронная почта" — это:', options: ['SMS', 'email', 'chat', 'social media'], correctIndex: 1, explanation: 'электронная почта = email'),
        ExamQuestion(question: '"Поделиться" означает:', options: ['to download', 'to delete', 'to share', 'to block'], correctIndex: 2, explanation: 'поделиться = to share'),
        ExamQuestion(question: '"Обновить" означает:', options: ['to delete', 'to install', 'to update', 'to backup'], correctIndex: 2, explanation: 'обновить = to update'),
        ExamQuestion(question: '"Программирование" — это:', options: ['design', 'testing', 'programming', 'networking'], correctIndex: 2, explanation: 'программирование = programming'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_06', title: 'Здоровье', subtitle: 'Медицина и здоровье', emoji: '🏥',
      level: LanguageLevel.b1, order: 22, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Здоровье', content: 'больной — sick person/patient\nболь — pain\nтемпература — temperature/fever\nлекарство — medicine\nврач/доктор — doctor\nбольница — hospital\nрецепт — prescription', examples: ['Болит голова.', 'У меня температура.', 'Пошёл к врачу.']),
        TheorySection(title: 'У врача', content: 'Что вас беспокоит? — What bothers you?\nЖалобы — complaints\nДиагноз — diagnosis\nНазначение — prescription\nВыздоравливать — to recover\nБольничный — sick leave', examples: ['Что вас беспокоит?', 'Врач поставил диагноз.', 'Я выздоровел.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Больница" по-русски — это:', options: ['pharmacy', 'clinic', 'hospital', 'doctor\'s office'], correctIndex: 2, explanation: 'больница = hospital'),
        CourseExercise(type: ExerciseType.translation, question: '"У меня температура" означает:', options: ['I have a headache', 'I have a fever', 'I feel cold', 'I am tired'], correctIndex: 1, explanation: 'температура = fever/elevated temperature'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Врач поставил ___. (диагноз)', options: ['лечение', 'диагноз', 'рецепт', 'больничный'], correctIndex: 1, explanation: 'поставить диагноз = to make a diagnosis'),
      ],
      exam: [
        ExamQuestion(question: '"Лекарство" по-русски — это:', options: ['diagnosis', 'prescription', 'medicine', 'treatment'], correctIndex: 2, explanation: 'лекарство = medicine/drug'),
        ExamQuestion(question: '"Выздоравливать" означает:', options: ['to get sick', 'to recover', 'to treat', 'to diagnose'], correctIndex: 1, explanation: 'выздоравливать = to recover/get better'),
        ExamQuestion(question: '"Рецепт" по-русски — это:', options: ['diagnosis', 'prescription', 'treatment', 'insurance'], correctIndex: 1, explanation: 'рецепт = prescription'),
        ExamQuestion(question: '"Больничный" — это:', options: ['hospital ward', 'sick leave', 'ambulance', 'health insurance'], correctIndex: 1, explanation: 'больничный = sick leave document'),
        ExamQuestion(question: '"Болит" означает:', options: ['is ill', 'hurts', 'is sick', 'aches'], correctIndex: 1, explanation: 'болит = hurts (3 лицо от "болеть")'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_07', title: 'Работа', subtitle: 'Карьера и профессии', emoji: '💼',
      level: LanguageLevel.b1, order: 23, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Работа', content: 'работа — work/job\nпрофессия — profession\nдолжность — position\nзарплата — salary\nповышение — promotion\nувольнение — dismissal\nрезюме — resume/CV', examples: ['Нашёл новую работу.', 'Получил повышение.', 'Написал резюме.']),
        TheorySection(title: 'Профессии', content: 'врач — doctor\nучитель — teacher\nинженер — engineer\nюрист — lawyer\nбухгалтер — accountant\nпрограммист — programmer\nменеджер — manager', examples: ['Работаю учителем.', 'Хочу стать инженером.', 'Наш менеджер очень опытный.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Зарплата" по-русски — это:', options: ['bonus', 'salary', 'promotion', 'contract'], correctIndex: 1, explanation: 'зарплата = salary'),
        CourseExercise(type: ExerciseType.translation, question: '"Работаю учителем" — падеж слова "учителем":', options: ['именительный', 'родительный', 'дательный', 'творительный'], correctIndex: 3, explanation: '"работать кем?" — творительный падеж'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Нашёл новую ___. (работу)', options: ['работа', 'работе', 'работы', 'работу'], correctIndex: 3, explanation: 'найти что? работу — винительный падеж'),
      ],
      exam: [
        ExamQuestion(question: '"Программист" по-русски — это:', options: ['designer', 'analyst', 'programmer', 'administrator'], correctIndex: 2, explanation: 'программист = programmer'),
        ExamQuestion(question: '"Повышение" по-русски — это:', options: ['salary', 'bonus', 'promotion', 'contract'], correctIndex: 2, explanation: 'повышение = promotion'),
        ExamQuestion(question: '"Резюме" по-русски — это:', options: ['diploma', 'resume/CV', 'recommendation', 'certificate'], correctIndex: 1, explanation: 'резюме = resume/CV'),
        ExamQuestion(question: '"Юрист" по-русски — это:', options: ['judge', 'lawyer', 'notary', 'police'], correctIndex: 1, explanation: 'юрист = lawyer/legal specialist'),
        ExamQuestion(question: '"Должность" по-русски — это:', options: ['salary', 'profession', 'position/title', 'department'], correctIndex: 2, explanation: 'должность = job position/title'),
      ],
    ),

    CourseChapter(
      id: 'ru_b1_08', title: 'Культура России', subtitle: 'История и традиции', emoji: '🎭',
      level: LanguageLevel.b1, order: 24, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Русская культура', content: 'балет — ballet\nопера — opera\nклассическая музыка — classical music\nПушкин, Толстой, Достоевский — писатели\nЧайковский — композитор\nТретьяковская галерея — музей', examples: ['Большой театр — знаменитый театр.', 'Пушкин — великий поэт.', 'Чайковский написал "Лебединое озеро".']),
        TheorySection(title: 'Традиции', content: 'Масленица — блинный праздник\nНовый год — главный праздник\nПасха — православный праздник\nматрёшка — традиционная кукла\nсамовар — традиционный чайник\nбаня — русская баня', examples: ['На Масленицу едят блины.', 'Новый год отмечаем 1 января.', 'Матрёшка — сувенир из России.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Масленица" — это праздник:', options: ['летний', 'зимний', 'весенний', 'осенний'], correctIndex: 2, explanation: 'Масленица — праздник прихода весны, проводы зимы'),
        CourseExercise(type: ExerciseType.translation, question: '"Большой театр" — это:', options: ['Large Museum', 'Big Concert Hall', 'Bolshoi Theatre', 'Great Library'], correctIndex: 2, explanation: 'Большой театр = Bolshoi Theatre (большой = big)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'На Масленицу едят ___. (блины)', options: ['пироги', 'блины', 'пельмени', 'борщ'], correctIndex: 1, explanation: 'Блины — традиционное блюдо Масленицы'),
      ],
      exam: [
        ExamQuestion(question: 'Чайковский написал:', options: ['Войну и мир', 'Лебединое озеро', 'Преступление и наказание', 'Евгения Онегина'], correctIndex: 1, explanation: '"Лебединое озеро" — балет Чайковского'),
        ExamQuestion(question: '"Матрёшка" — это:', options: ['музыкальный инструмент', 'блюдо', 'традиционная кукла', 'танец'], correctIndex: 2, explanation: 'матрёшка = традиционная русская деревянная кукла'),
        ExamQuestion(question: 'Главный зимний праздник в России:', options: ['Рождество', 'Новый год', 'Масленица', 'Пасха'], correctIndex: 1, explanation: 'Новый год — главный праздник в России'),
        ExamQuestion(question: '"Баня" по-русски — это:', options: ['pool', 'sauna/bath house', 'shower', 'spa'], correctIndex: 1, explanation: 'баня = Russian bath house (похоже на сауну)'),
        ExamQuestion(question: 'Третьяковская галерея находится в:', options: ['Санкт-Петербурге', 'Москве', 'Казани', 'Новгороде'], correctIndex: 1, explanation: 'Третьяковская галерея — в Москве'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'ru_b2_01', title: 'Сложный синтаксис', subtitle: 'Придаточные предложения', emoji: '📚',
      level: LanguageLevel.b2, order: 25, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Типы придаточных', content: 'Придаточное определительное: который\nПридаточное изъяснительное: что, чтобы\nПридаточное условное: если, когда\nПридаточное причинное: потому что, так как\nПридаточное цели: чтобы', examples: ['Книга, которую я читал, интересная.', 'Знаю, что ты придёшь.', 'Пришёл, чтобы помочь.']),
        TheorySection(title: 'Союзы', content: 'хотя — although\nнесмотря на то что — despite the fact that\nкак только — as soon as\nдо тех пор пока — until\nблагодаря тому что — thanks to the fact that', examples: ['Хотя было холодно, пошли гулять.', 'Как только приду — позвоню.', 'Благодаря помощи друга.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пришёл, чтобы помочь" — тип придаточного:', options: ['определительное', 'изъяснительное', 'цели', 'условное'], correctIndex: 2, explanation: 'чтобы + инфинитив = придаточное цели'),
        CourseExercise(type: ExerciseType.translation, question: '"Хотя" означает:', options: ['because', 'if', 'although', 'when'], correctIndex: 2, explanation: 'хотя = although/even though'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Знаю, ___ ты придёшь. (что)', options: ['если', 'хотя', 'что', 'чтобы'], correctIndex: 2, explanation: '"знаю что" = I know that (изъяснительное)'),
      ],
      exam: [
        ExamQuestion(question: '"Так как" означает:', options: ['although', 'when', 'because', 'if'], correctIndex: 2, explanation: 'так как = because/since (причинный союз)'),
        ExamQuestion(question: '"Как только" означает:', options: ['how exactly', 'as soon as', 'although', 'until'], correctIndex: 1, explanation: 'как только = as soon as'),
        ExamQuestion(question: '"Который" в придаточных используется для:', options: ['времени', 'причины', 'определения', 'цели'], correctIndex: 2, explanation: 'который = who/which (определительное придаточное)'),
        ExamQuestion(question: '"Несмотря на то что" означает:', options: ['because', 'despite the fact that', 'as soon as', 'until'], correctIndex: 1, explanation: 'несмотря на то что = despite the fact that'),
        ExamQuestion(question: '"До тех пор пока" означает:', options: ['as soon as', 'while', 'until', 'after'], correctIndex: 2, explanation: 'до тех пор пока = until'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_02', title: 'Деловой русский', subtitle: 'Официальный стиль', emoji: '🤝',
      level: LanguageLevel.b2, order: 26, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Деловая лексика', content: 'совещание — meeting\nпрезентация — presentation\nотчёт — report\nдоговор — contract\nбюджет — budget\nприбыль — profit\nубыток — loss', examples: ['Провели совещание.', 'Подписали договор.', 'Составили отчёт.']),
        TheorySection(title: 'Деловая переписка', content: 'С уважением — Yours sincerely\nУважаемый/ая — Dear\nДовожу до вашего сведения — I would like to inform you\nПрошу рассмотреть — Please consider\nВ приложении — Attached', examples: ['Уважаемый Иван Иванович!', 'Довожу до вашего сведения...', 'С уважением, Петров А.И.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Деловое письмо начинается:', options: ['Привет!', 'Здравствуй!', 'Уважаемый...', 'Дорогой...'], correctIndex: 2, explanation: '"Уважаемый/ая" — официальное обращение'),
        CourseExercise(type: ExerciseType.translation, question: '"Договор" по-русски — это:', options: ['meeting', 'report', 'contract', 'budget'], correctIndex: 2, explanation: 'договор = contract/agreement'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Довожу до вашего ___ ... (сведения)', options: ['знания', 'сведения', 'ведения', 'информации'], correctIndex: 1, explanation: 'довожу до сведения = I would like to inform'),
      ],
      exam: [
        ExamQuestion(question: '"С уважением" в конце письма — это:', options: ['greeting', 'signature/closing', 'title', 'subject'], correctIndex: 1, explanation: '"С уважением" = Yours sincerely (закрытие письма)'),
        ExamQuestion(question: '"Совещание" по-русски — это:', options: ['conference', 'meeting/conference', 'seminar', 'workshop'], correctIndex: 1, explanation: 'совещание = meeting/conference'),
        ExamQuestion(question: '"Прибыль" по-русски — это:', options: ['loss', 'expense', 'profit', 'budget'], correctIndex: 2, explanation: 'прибыль = profit'),
        ExamQuestion(question: '"В приложении" означает:', options: ['in the application', 'attached', 'in the appendix', 'both b and c'], correctIndex: 3, explanation: '"В приложении" = attached / in the appendix'),
        ExamQuestion(question: '"Убыток" по-русски — это:', options: ['profit', 'loss', 'expense', 'cost'], correctIndex: 1, explanation: 'убыток = loss'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_03', title: 'Идиомы', subtitle: 'Фразеологизмы', emoji: '🌿',
      level: LanguageLevel.b2, order: 27, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Русские фразеологизмы', content: 'бить баклуши — бездельничать\nвешать лапшу на уши — обманывать\nзарубить на носу — запомнить навсегда\nлить воду — говорить впустую\nна всякий пожарный — на всякий случай', examples: ['Перестань бить баклуши!', 'Не вешай мне лапшу на уши.', 'Заруби себе на носу!']),
        TheorySection(title: 'Пословицы', content: 'Не всё то золото, что блестит. — All that glitters is not gold.\nЯблоко от яблони недалеко падает. — The apple doesn\'t fall far from the tree.\nТише едешь — дальше будешь. — Slow and steady wins the race.', examples: ['Не всё то золото, что блестит.', 'Тише едешь — дальше будешь.', 'Яблоко от яблони...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Бить баклуши" означает:', options: ['работать усердно', 'бездельничать', 'играть в игры', 'спорить'], correctIndex: 1, explanation: 'бить баклуши = to idle/loaf around'),
        CourseExercise(type: ExerciseType.translation, question: '"Вешать лапшу на уши" означает:', options: ['готовить лапшу', 'обманывать', 'шептать на ухо', 'подслушивать'], correctIndex: 1, explanation: 'вешать лапшу на уши = to pull someone\'s leg / to deceive'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Заруби себе на ___! (носу)', options: ['лбу', 'ухе', 'носу', 'голове'], correctIndex: 2, explanation: 'зарубить на носу = to carve on one\'s nose (= to remember forever)'),
      ],
      exam: [
        ExamQuestion(question: '"Лить воду" означает:', options: ['плакать', 'поливать', 'говорить впустую', 'быть добрым'], correctIndex: 2, explanation: 'лить воду = to talk around the subject / say nothing meaningful'),
        ExamQuestion(question: '"На всякий пожарный" означает:', options: ['в случае пожара', 'на всякий случай', 'очень срочно', 'с пожарниками'], correctIndex: 1, explanation: 'на всякий пожарный = just in case'),
        ExamQuestion(question: '"Не всё то золото, что блестит" — смысл:', options: ['золото дорогое', 'внешность обманчива', 'блеск красивый', 'экономить золото'], correctIndex: 1, explanation: 'Внешний вид может быть обманчивым'),
        ExamQuestion(question: '"Тише едешь — дальше будешь" — смысл:', options: ['ехать медленно безопаснее', 'осторожность и постепенность приводят к успеху', 'тихая езда экономит топливо', 'нельзя спешить'], correctIndex: 1, explanation: 'Slow and steady wins the race'),
        ExamQuestion(question: '"Яблоко от яблони недалеко падает" — смысл:', options: ['урожай яблок хороший', 'дети похожи на родителей', 'яблоки вкусные', 'сад рядом'], correctIndex: 1, explanation: 'Дети наследуют черты родителей'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_04', title: 'СМИ и общество', subtitle: 'Медиа и публичная речь', emoji: '📰',
      level: LanguageLevel.b2, order: 28, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'СМИ', content: 'газета — newspaper\nжурнал — magazine\nтелевидение — television\nрадио — radio\nновости — news\nтрансляция — broadcast\nжурналист — journalist', examples: ['Читаю газету онлайн.', 'Новости в 21:00.', 'Журналист взял интервью.']),
        TheorySection(title: 'Публичная речь', content: 'выступление — speech/performance\nдискуссия — discussion\nдебаты — debate\nаргумент — argument\nточка зрения — point of view\nсогласен/не согласен — agree/disagree', examples: ['Высказал свою точку зрения.', 'В ходе дискуссии...', 'Согласен с вашим мнением.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Точка зрения" по-русски — это:', options: ['opinion', 'point of view', 'conclusion', 'argument'], correctIndex: 1, explanation: 'точка зрения = point of view'),
        CourseExercise(type: ExerciseType.translation, question: '"Журналист" по-русски — это:', options: ['editor', 'journalist', 'writer', 'reporter'], correctIndex: 1, explanation: 'журналист = journalist'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Высказал свою ___ зрения. (точку)', options: ['точку', 'взгляд', 'мнение', 'позицию'], correctIndex: 0, explanation: 'точку зрения = point of view (вин. падеж)'),
      ],
      exam: [
        ExamQuestion(question: '"Дебаты" по-русски — это:', options: ['discussion', 'lecture', 'debate', 'seminar'], correctIndex: 2, explanation: 'дебаты = debate'),
        ExamQuestion(question: '"Согласен" означает:', options: ['I disagree', 'I agree', 'I think', 'I know'], correctIndex: 1, explanation: 'согласен = I agree'),
        ExamQuestion(question: '"Трансляция" по-русски — это:', options: ['translation', 'broadcast', 'transmission', 'transfer'], correctIndex: 1, explanation: 'трансляция = broadcast/transmission'),
        ExamQuestion(question: '"Выступление" по-русски — это:', options: ['exit', 'performance/speech', 'action', 'step'], correctIndex: 1, explanation: 'выступление = speech/performance/presentation'),
        ExamQuestion(question: '"Аргумент" по-русски — это:', options: ['quarrel', 'argument/point', 'disagreement', 'discussion'], correctIndex: 1, explanation: 'аргумент = argument/point (в дискуссии)'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_05', title: 'Академический стиль', subtitle: 'Научный русский', emoji: '🎓',
      level: LanguageLevel.b2, order: 29, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Академическая лексика', content: 'исследование — research\nгипотеза — hypothesis\nвывод — conclusion\nметодология — methodology\nисточник — source\nаннотация — abstract\nрезультаты — results', examples: ['Исследование показало...', 'Выдвинута гипотеза.', 'Сделаны выводы.']),
        TheorySection(title: 'Академические обороты', content: 'В данной работе — In this work\nСледует отметить — It should be noted\nВ результате — As a result\nС другой стороны — On the other hand\nТаким образом — Thus/Therefore', examples: ['Следует отметить, что...', 'Таким образом, можно заключить...', 'С другой стороны...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Исследование" по-русски — это:', options: ['experiment', 'research', 'theory', 'practice'], correctIndex: 1, explanation: 'исследование = research'),
        CourseExercise(type: ExerciseType.translation, question: '"Таким образом" означает:', options: ['for example', 'however', 'thus/therefore', 'on the contrary'], correctIndex: 2, explanation: 'таким образом = thus/therefore'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ отметить, что... (Следует)', options: ['Надо', 'Нужно', 'Следует', 'Стоит'], correctIndex: 2, explanation: '"следует отметить" — академический оборот'),
      ],
      exam: [
        ExamQuestion(question: '"Гипотеза" по-русски — это:', options: ['theory', 'hypothesis', 'conclusion', 'observation'], correctIndex: 1, explanation: 'гипотеза = hypothesis'),
        ExamQuestion(question: '"С другой стороны" означает:', options: ['furthermore', 'therefore', 'on the other hand', 'for example'], correctIndex: 2, explanation: 'с другой стороны = on the other hand'),
        ExamQuestion(question: '"Методология" по-русски — это:', options: ['method', 'methodology', 'approach', 'technique'], correctIndex: 1, explanation: 'методология = methodology'),
        ExamQuestion(question: '"В результате" означает:', options: ['in theory', 'as a result', 'in conclusion', 'in practice'], correctIndex: 1, explanation: 'в результате = as a result'),
        ExamQuestion(question: '"Аннотация" по-русски — это:', options: ['annotation', 'abstract', 'footnote', 'bibliography'], correctIndex: 1, explanation: 'аннотация = abstract (краткое содержание)'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_06', title: 'Литература', subtitle: 'Русская классика', emoji: '📖',
      level: LanguageLevel.b2, order: 30, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Великие писатели', content: 'Пушкин — основоположник лит. языка\nТолстой — "Война и мир", "Анна Каренина"\nДостоевский — "Преступление и наказание"\nЧехов — рассказы и пьесы\nБулгаков — "Мастер и Маргарита"', examples: ['Пушкин — "Евгений Онегин".', 'Толстой написал "Войну и мир".', 'Чехов — мастер рассказа.']),
        TheorySection(title: 'Литературные понятия', content: 'сюжет — plot\nперсонаж — character\nтема — theme\nметафора — metaphor\nавтор — author\nрассказчик — narrator\nкульминация — climax', examples: ['Главный герой романа...', 'Тема произведения — любовь.', 'Кульминация повести...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Мастер и Маргарита" написал:', options: ['Толстой', 'Пушкин', 'Булгаков', 'Достоевский'], correctIndex: 2, explanation: '"Мастер и Маргарита" — роман Михаила Булгакова'),
        CourseExercise(type: ExerciseType.translation, question: '"Сюжет" по-русски — это:', options: ['theme', 'character', 'plot', 'scene'], correctIndex: 2, explanation: 'сюжет = plot'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Главный ___ романа — Раскольников.', options: ['сюжет', 'тема', 'персонаж', 'герой'], correctIndex: 3, explanation: 'главный герой = main character'),
      ],
      exam: [
        ExamQuestion(question: '"Преступление и наказание" написал:', options: ['Толстой', 'Чехов', 'Достоевский', 'Тургенев'], correctIndex: 2, explanation: '"Преступление и наказание" — роман Достоевского'),
        ExamQuestion(question: '"Кульминация" в литературе — это:', options: ['начало', 'развязка', 'высшая точка напряжения', 'эпилог'], correctIndex: 2, explanation: 'кульминация = climax (высшая точка)'),
        ExamQuestion(question: '"Евгений Онегин" — это:', options: ['рассказ Чехова', 'роман в стихах Пушкина', 'пьеса Толстого', 'повесть Гоголя'], correctIndex: 1, explanation: '"Евгений Онегин" — роман в стихах А.С. Пушкина'),
        ExamQuestion(question: '"Рассказчик" в литературе — это:', options: ['автор', 'главный герой', 'тот, кто ведёт повествование', 'персонаж'], correctIndex: 2, explanation: 'рассказчик = narrator (не всегда автор)'),
        ExamQuestion(question: '"Метафора" — это:', options: ['прямое сравнение', 'скрытое сравнение', 'повторение', 'звукоподражание'], correctIndex: 1, explanation: 'метафора = скрытое сравнение (без "как")'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_07', title: 'Экология', subtitle: 'Экология и общество', emoji: '🌍',
      level: LanguageLevel.b2, order: 31, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Экология', content: 'окружающая среда — environment\nзагрязнение — pollution\nпереработка — recycling\nвозобновляемая энергия — renewable energy\nизменение климата — climate change\nбиоразнообразие — biodiversity', examples: ['Загрязнение воздуха опасно.', 'Надо заниматься переработкой.', 'Изменение климата угрожает планете.']),
        TheorySection(title: 'Природа России', content: 'Байкал — глубочайшее озеро мира\nСибирь — огромный регион\nтайга — хвойный лес\nтундра — безлесная зона\nВолга — главная река России', examples: ['Байкал — жемчужина Сибири.', 'Тайга занимает огромные площади.', 'Волга впадает в Каспийское море.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Загрязнение" по-русски — это:', options: ['environment', 'recycling', 'pollution', 'biodiversity'], correctIndex: 2, explanation: 'загрязнение = pollution'),
        CourseExercise(type: ExerciseType.translation, question: '"Байкал" — это:', options: ['mountain', 'river', 'lake', 'forest'], correctIndex: 2, explanation: 'Байкал — самое глубокое озеро в мире'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Изменение ___ угрожает планете. (климата)', options: ['погода', 'климата', 'природы', 'экологии'], correctIndex: 1, explanation: 'изменение климата = climate change (родительный падеж)'),
      ],
      exam: [
        ExamQuestion(question: '"Переработка" по-русски — это:', options: ['pollution', 'recycling', 'reforestation', 'conservation'], correctIndex: 1, explanation: 'переработка = recycling'),
        ExamQuestion(question: 'Тайга — это:', options: ['степь', 'тундра', 'хвойный лес', 'пустыня'], correctIndex: 2, explanation: 'тайга = taiga (хвойный бореальный лес)'),
        ExamQuestion(question: '"Возобновляемая энергия" — это:', options: ['nuclear energy', 'fossil fuels', 'renewable energy', 'thermal energy'], correctIndex: 2, explanation: 'возобновляемая энергия = renewable energy'),
        ExamQuestion(question: 'Волга впадает в:', options: ['Чёрное море', 'Балтийское море', 'Каспийское море', 'Северный Ледовитый океан'], correctIndex: 2, explanation: 'Волга впадает в Каспийское море'),
        ExamQuestion(question: '"Биоразнообразие" по-русски — это:', options: ['biology', 'ecosystem', 'biodiversity', 'wildlife'], correctIndex: 2, explanation: 'биоразнообразие = biodiversity'),
      ],
    ),

    CourseChapter(
      id: 'ru_b2_08', title: 'Финальный экзамен', subtitle: 'Итоговое тестирование', emoji: '🏆',
      level: LanguageLevel.b2, order: 32, coinsReward: 100, xpReward: 80,
      theory: [
        TheorySection(title: 'Итоговое повторение', content: 'Поздравляем! Вы освоили русский на уровне B2!\nКлючевые достижения:\n• Падежная система (6 падежей)\n• Виды глагола (СВ и НСВ)\n• Причастия и деепричастия\n• Стили речи: разговорный, деловой, научный', examples: ['Говорю по-русски свободно!', 'Понимаю сложные тексты.', 'Могу работать на русском языке.']),
        TheorySection(title: 'Следующие шаги', content: 'После B2:\n• Читайте русскую классику в оригинале\n• Смотрите фильмы без субтитров\n• Слушайте подкасты и радио\n• Общайтесь с носителями\n• Пишите на русские форумы', examples: ['Читайте Толстого и Чехова', 'Слушайте "Эхо Москвы"', 'Участвуйте в русскоязычных сообществах']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Читая книгу, я заснул" — "читая" это:', options: ['причастие', 'деепричастие НСВ', 'деепричастие СВ', 'прилагательное'], correctIndex: 1, explanation: 'читая = деепричастие несовершенного вида'),
        CourseExercise(type: ExerciseType.translation, question: '"Книга, которую я читал" — придаточное:', options: ['изъяснительное', 'определительное', 'условное', 'цели'], correctIndex: 1, explanation: '"которую" = определительное придаточное'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Работаю ___. (учителем — творительный)', options: ['учитель', 'учителя', 'учителю', 'учителем'], correctIndex: 3, explanation: 'работать кем? учителем — творительный падеж'),
      ],
      exam: [
        ExamQuestion(question: '"Прочитав книгу" — тип формы:', options: ['причастие наст. вр.', 'причастие прош. вр.', 'деепричастие НСВ', 'деепричастие СВ'], correctIndex: 3, explanation: 'прочитав = деепричастие совершенного вида'),
        ExamQuestion(question: '"Самый умный" — степень:', options: ['положительная', 'сравнительная', 'превосходная', 'усилительная'], correctIndex: 2, explanation: 'самый + прилагательное = превосходная степень'),
        ExamQuestion(question: 'СВ vs НСВ: "сделал" означает:', options: ['был в процессе делания', 'завершил действие', 'собирается сделать', 'привык делать'], correctIndex: 1, explanation: 'СВ прошедшее = завершённое действие с результатом'),
        ExamQuestion(question: '"Таким образом" в тексте обозначает:', options: ['contrast', 'example', 'conclusion', 'addition'], correctIndex: 2, explanation: 'таким образом = вывод/заключение'),
        ExamQuestion(question: 'Байкал — это:', options: ['река', 'море', 'глубочайшее озеро', 'горы'], correctIndex: 2, explanation: 'Байкал — самое глубокое озеро в мире'),
      ],
    ),
  ],
);
