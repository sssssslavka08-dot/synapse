import '../courses/course_structure.dart';

const turkishCourse = LanguageCourse(
  langCode: 'tr',
  langName: 'Турецкий',
  nativeName: 'Türkçe',
  flag: '🇹🇷',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'tr_a1_01', title: 'Merhaba', subtitle: 'Приветствия и знакомство', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Merhaba — Привет\nGünaydın — Доброе утро\nİyi günler — Добрый день\nİyi akşamlar — Добрый вечер\nHoşça kal — До свидания\nGörüşürüz — Увидимся', examples: ['Merhaba! Nasılsın?', 'Günaydın! Ben Ayşe.', 'Hoşça kal!']),
        TheorySection(title: 'Знакомство', content: 'Adın ne? — Как тебя зовут?\nBenim adım ... — Меня зовут ...\nNerelisin? — Откуда ты?\nBen ... liyim — Я из ...', examples: ['Adın ne? — Benim adım Ali.', 'Nerelisin? — Ben Rusyalıyım.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как по-турецки "Доброе утро"?', options: ['İyi günler', 'Günaydın', 'Merhaba', 'İyi akşamlar'], correctIndex: 1, explanation: 'Günaydın = Доброе утро'),
        CourseExercise(type: ExerciseType.translation, question: 'Переведи: "Как тебя зовут?"', options: ['Nasılsın?', 'Nerelisin?', 'Adın ne?', 'Kaç yaşındasın?'], correctIndex: 2, explanation: 'Adın ne? — буквально "Твоё имя что?"'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Benim ___ Ali.', options: ['sen', 'adın', 'adım', 'ben'], correctIndex: 2, explanation: 'adım = моё имя (ad+ım)'),
      ],
      exam: [
        ExamQuestion(question: '"До свидания" по-турецки:', options: ['Merhaba', 'Teşekkürler', 'Hoşça kal', 'Evet'], correctIndex: 2, explanation: 'Hoşça kal = До свидания'),
        ExamQuestion(question: 'Adın ___? (Как тебя зовут?)', options: ['kim', 'ne', 'nere', 'nasıl'], correctIndex: 1, explanation: 'Adın ne? — стандартный вопрос о имени'),
        ExamQuestion(question: '"Привет" по-турецки:', options: ['Günaydın', 'Merhaba', 'Tamam', 'Evet'], correctIndex: 1, explanation: 'Merhaba = Привет'),
        ExamQuestion(question: 'Nerelisin? — это вопрос о...', options: ['имени', 'возрасте', 'происхождении', 'профессии'], correctIndex: 2, explanation: 'Nerelisin? = Откуда ты?'),
        ExamQuestion(question: '"Добрый вечер" по-турецки:', options: ['Günaydın', 'İyi günler', 'İyi akşamlar', 'İyi geceler'], correctIndex: 2, explanation: 'İyi akşamlar = Добрый вечер'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_02', title: 'Sayılar ve Alfabe', subtitle: 'Числа и алфавит', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Числа 1–20', content: '1-bir, 2-iki, 3-üç, 4-dört, 5-beş\n6-altı, 7-yedi, 8-sekiz, 9-dokuz, 10-on\n11-on bir, 12-on iki, 20-yirmi', examples: ['Ben yirmi yaşındayım.', 'Beş elma.', 'On iki öğrenci.']),
        TheorySection(title: 'Особые буквы', content: 'В турецком алфавите:\nÇ/ç — "ч"\nŞ/ş — "ш"\nĞ/ğ — удлиняет предыдущий гласный\nİ/i — с точкой и без\nÖ/ö — "ё"\nÜ/ü — "ю"', examples: ['çay — чай', 'şeker — сахар', 'dağ — гора']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как по-турецки число 5?', options: ['dört', 'beş', 'altı', 'üç'], correctIndex: 1, explanation: 'beş = 5'),
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Как читается буква "ş"?', options: ['з', 'с', 'ш', 'ж'], correctIndex: 2, explanation: 'ş читается как "ш"'),
        CourseExercise(type: ExerciseType.translation, question: '"Чай" по-турецки:', options: ['su', 'çay', 'kahve', 'süt'], correctIndex: 1, explanation: 'çay = чай (с буквой ç)'),
      ],
      exam: [
        ExamQuestion(question: '7 по-турецки:', options: ['altı', 'sekiz', 'yedi', 'dokuz'], correctIndex: 2, explanation: 'yedi = 7'),
        ExamQuestion(question: '20 по-турецки:', options: ['on', 'yirmi', 'otuz', 'elli'], correctIndex: 1, explanation: 'yirmi = 20'),
        ExamQuestion(question: 'Буква "ç" читается как:', options: ['с', 'ч', 'ж', 'з'], correctIndex: 1, explanation: 'ç = ч'),
        ExamQuestion(question: '3 + 4 = ?', options: ['altı', 'sekiz', 'yedi', 'beş'], correctIndex: 2, explanation: 'üç + dört = yedi'),
        ExamQuestion(question: '"Гора" по-турецки:', options: ['deniz', 'dağ', 'nehir', 'göl'], correctIndex: 1, explanation: 'dağ = гора (ğ удлиняет "а")'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_03', title: 'Aile ve Ev', subtitle: 'Семья и дом', emoji: '🏠',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Члены семьи', content: 'anne — мама\nbaba — папа\nkız kardeş — сестра\nerkek kardeş — брат\nbüyükanne — бабушка\nbüyükbaba — дедушка', examples: ['Annem çok güzel.', 'Bir erkek kardeşim var.', 'Babam çalışıyor.']),
        TheorySection(title: 'Притяжательные суффиксы', content: 'В турецком нет артиклей, но есть суффиксы:\n-m/-ım/-im/-um/-üm = мой/моя\n-n/-ın/-in/-un/-ün = твой/твоя', examples: ['annem — моя мама', 'baban — твой папа', 'evim — мой дом']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Мама" по-турецки:', options: ['baba', 'anne', 'abla', 'teyze'], correctIndex: 1, explanation: 'anne = мама'),
        CourseExercise(type: ExerciseType.translation, question: '"Мой дом" по-турецки:', options: ['senin evin', 'evim', 'ev', 'evler'], correctIndex: 1, explanation: 'ev + im = evim (мой дом)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bir erkek kardeş___ var. (у меня есть брат)', options: ['-im', '-in', '-ım', '-sin'], correctIndex: 2, explanation: 'kardeşim = мой брат'),
      ],
      exam: [
        ExamQuestion(question: '"Папа" по-турецки:', options: ['anne', 'abla', 'baba', 'dede'], correctIndex: 2, explanation: 'baba = папа'),
        ExamQuestion(question: '"Бабушка" по-турецки:', options: ['büyükbaba', 'teyze', 'büyükanne', 'nine'], correctIndex: 2, explanation: 'büyükanne = бабушка (büyük=большой, anne=мама)'),
        ExamQuestion(question: 'evim означает:', options: ['твой дом', 'мой дом', 'дома', 'дом'], correctIndex: 1, explanation: 'ev+im = мой дом'),
        ExamQuestion(question: '"Сестра" по-турецки:', options: ['erkek kardeş', 'kardeş', 'kız kardeş', 'abla'], correctIndex: 2, explanation: 'kız kardeş = сестра (kız=девочка)'),
        ExamQuestion(question: 'annen означает:', options: ['моя мама', 'твоя мама', 'её мама', 'наша мама'], correctIndex: 1, explanation: 'anne+n = твоя мама'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_04', title: 'Yiyecekler', subtitle: 'Еда и напитки', emoji: '🍎',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'ekmek — хлеб\net — мясо\nsebze — овощи\nmeyve — фрукты\nçorba — суп\npilav — рис\nyoğurt — йогурт', examples: ['Ekmek istiyorum.', 'Çorba çok lezzetli.', 'Meyve yiyorum.']),
        TheorySection(title: 'Напитки', content: 'su — вода\nçay — чай\nkahve — кофе\nsüt — молоко\nmeyve suyu — сок\nayran — айран', examples: ['Çay içiyorum.', 'Bir bardak su, lütfen.', 'Kahve sever misin?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Вода" по-турецки:', options: ['çay', 'süt', 'su', 'kahve'], correctIndex: 2, explanation: 'su = вода'),
        CourseExercise(type: ExerciseType.translation, question: '"Хлеб" по-турецки:', options: ['et', 'pilav', 'ekmek', 'peynir'], correctIndex: 2, explanation: 'ekmek = хлеб'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bir bardak ___, lütfen. (воды)', options: ['çay', 'su', 'süt', 'kahve'], correctIndex: 1, explanation: 'su = вода'),
      ],
      exam: [
        ExamQuestion(question: '"Чай" по-турецки:', options: ['kahve', 'su', 'çay', 'süt'], correctIndex: 2, explanation: 'çay = чай'),
        ExamQuestion(question: '"Суп" по-турецки:', options: ['pilav', 'çorba', 'ekmek', 'salata'], correctIndex: 1, explanation: 'çorba = суп'),
        ExamQuestion(question: 'lütfen означает:', options: ['спасибо', 'пожалуйста', 'извините', 'да'], correctIndex: 1, explanation: 'lütfen = пожалуйста'),
        ExamQuestion(question: '"Йогурт" по-турецки:', options: ['peynir', 'yoğurt', 'tereyağı', 'krema'], correctIndex: 1, explanation: 'yoğurt = йогурт (слово турецкого происхождения!)'),
        ExamQuestion(question: '"Фрукты" по-турецки:', options: ['sebze', 'meyve', 'et', 'tahıl'], correctIndex: 1, explanation: 'meyve = фрукты'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_05', title: 'Renkler ve Vücut', subtitle: 'Цвета и тело', emoji: '🎨',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Цвета', content: 'kırmızı — красный\nmavi — синий\nyeşil — зелёный\nsarı — жёлтый\nbeyaz — белый\nsiyah — чёрный\nturuncu — оранжевый', examples: ['Araba kırmızı.', 'Gökyüzü mavi.', 'Çim yeşil.']),
        TheorySection(title: 'Части тела', content: 'baş — голова\ngöz — глаз\nkulak — ухо\nburun — нос\nağız — рот\nel — рука\nayak — нога', examples: ['Başım ağrıyor.', 'İki gözüm var.', 'Ellerimi yıkıyorum.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Красный" по-турецки:', options: ['mavi', 'yeşil', 'kırmızı', 'sarı'], correctIndex: 2, explanation: 'kırmızı = красный'),
        CourseExercise(type: ExerciseType.translation, question: '"Глаз" по-турецки:', options: ['kulak', 'göz', 'burun', 'ağız'], correctIndex: 1, explanation: 'göz = глаз'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Gökyüzü ___. (синее небо)', options: ['yeşil', 'sarı', 'mavi', 'beyaz'], correctIndex: 2, explanation: 'gökyüzü mavi = небо синее'),
      ],
      exam: [
        ExamQuestion(question: '"Белый" по-турецки:', options: ['siyah', 'beyaz', 'gri', 'mor'], correctIndex: 1, explanation: 'beyaz = белый'),
        ExamQuestion(question: '"Нос" по-турецки:', options: ['göz', 'kulak', 'burun', 'ağız'], correctIndex: 2, explanation: 'burun = нос'),
        ExamQuestion(question: '"Зелёный" по-турецки:', options: ['sarı', 'mavi', 'turuncu', 'yeşil'], correctIndex: 3, explanation: 'yeşil = зелёный'),
        ExamQuestion(question: '"Голова" по-турецки:', options: ['el', 'ayak', 'baş', 'omuz'], correctIndex: 2, explanation: 'baş = голова'),
        ExamQuestion(question: '"Жёлтый" по-турецки:', options: ['kırmızı', 'sarı', 'mavi', 'yeşil'], correctIndex: 1, explanation: 'sarı = жёлтый'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_06', title: 'Zaman ve Günler', subtitle: 'Время и дни недели', emoji: '📅',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'Pazartesi — понедельник\nSalı — вторник\nÇarşamba — среда\nPerşembe — четверг\nCuma — пятница\nCumartesi — суббота\nPazar — воскресенье', examples: ['Pazartesi okula gidiyorum.', 'Cuma güzel bir gün.', 'Pazar tatil günü.']),
        TheorySection(title: 'Время', content: 'sabah — утро\nöğle — полдень\nöğleden sonra — после полудня\nakşam — вечер\ngece — ночь\nşimdi — сейчас\nbugün — сегодня', examples: ['Sabah erken kalkıyorum.', 'Bugün hava güzel.', 'Akşam yemek yiyoruz.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пятница" по-турецки:', options: ['Perşembe', 'Cuma', 'Cumartesi', 'Salı'], correctIndex: 1, explanation: 'Cuma = пятница'),
        CourseExercise(type: ExerciseType.translation, question: '"Утро" по-турецки:', options: ['akşam', 'gece', 'sabah', 'öğle'], correctIndex: 2, explanation: 'sabah = утро'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ hava güzel. (Сегодня погода хорошая)', options: ['Dün', 'Yarın', 'Bugün', 'Akşam'], correctIndex: 2, explanation: 'bugün = сегодня'),
      ],
      exam: [
        ExamQuestion(question: '"Понедельник" по-турецки:', options: ['Pazar', 'Salı', 'Pazartesi', 'Çarşamba'], correctIndex: 2, explanation: 'Pazartesi = понедельник'),
        ExamQuestion(question: '"Вечер" по-турецки:', options: ['sabah', 'öğle', 'akşam', 'gece'], correctIndex: 2, explanation: 'akşam = вечер'),
        ExamQuestion(question: '"Сегодня" по-турецки:', options: ['dün', 'yarın', 'bugün', 'şimdi'], correctIndex: 2, explanation: 'bugün = сегодня'),
        ExamQuestion(question: '"Воскресенье" по-турецки:', options: ['Cuma', 'Cumartesi', 'Pazar', 'Pazartesi'], correctIndex: 2, explanation: 'Pazar = воскресенье'),
        ExamQuestion(question: '"Ночь" по-турецки:', options: ['sabah', 'akşam', 'öğle', 'gece'], correctIndex: 3, explanation: 'gece = ночь'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_07', title: 'Hayvanlar', subtitle: 'Животные', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Домашние животные', content: 'köpek — собака\nkedi — кошка\nat — лошадь\ninek — корова\ntavuk — курица\nbalık — рыба', examples: ['Kedim çok sevimli.', 'Köpek havlıyor.', 'İneğin sütü içiyorum.']),
        TheorySection(title: 'Дикие животные', content: 'aslan — лев\nkaplan — тигр\nfil — слон\nmaymun — обезьяна\nkuş — птица\nyılan — змея', examples: ['Aslan ormanda yaşar.', 'Filler büyük hayvanlardır.', 'Kuş uçuyor.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-турецки:', options: ['köpek', 'kedi', 'at', 'kuş'], correctIndex: 1, explanation: 'kedi = кошка'),
        CourseExercise(type: ExerciseType.translation, question: '"Лев" по-турецки:', options: ['kaplan', 'fil', 'aslan', 'maymun'], correctIndex: 2, explanation: 'aslan = лев'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ havlıyor. (Собака лает)', options: ['Kedi', 'Kuş', 'Köpek', 'Balık'], correctIndex: 2, explanation: 'köpek = собака'),
      ],
      exam: [
        ExamQuestion(question: '"Птица" по-турецки:', options: ['balık', 'kuş', 'yılan', 'böcek'], correctIndex: 1, explanation: 'kuş = птица'),
        ExamQuestion(question: '"Слон" по-турецки:', options: ['aslan', 'kaplan', 'fil', 'zürafa'], correctIndex: 2, explanation: 'fil = слон'),
        ExamQuestion(question: '"Собака" по-турецки:', options: ['kedi', 'at', 'köpek', 'tavuk'], correctIndex: 2, explanation: 'köpek = собака'),
        ExamQuestion(question: '"Рыба" по-турецки:', options: ['kuş', 'kedi', 'yılan', 'balık'], correctIndex: 3, explanation: 'balık = рыба'),
        ExamQuestion(question: '"Тигр" по-турецки:', options: ['aslan', 'kaplan', 'leopar', 'panter'], correctIndex: 1, explanation: 'kaplan = тигр'),
      ],
    ),

    CourseChapter(
      id: 'tr_a1_08', title: 'Temel Fiiller', subtitle: 'Базовые глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Базовые глаголы', content: 'gitmek — идти\ngelmek — приходить\nyemek — есть\niçmek — пить\nkonuşmak — говорить\ndinlemek — слушать\nokumak — читать', examples: ['Okula gidiyorum.', 'Eve geliyorum.', 'Türkçe konuşuyorum.']),
        TheorySection(title: 'Настоящее время', content: 'Суффикс -iyor + личное окончание:\nben gidiyorum — я иду\nsen gidiyorsun — ты идёшь\no gidiyor — он/она идёт\nbiz gidiyoruz — мы идём', examples: ['Ben okuyorum.', 'Sen ne yapıyorsun?', 'O uyuyor.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я иду" по-турецки:', options: ['gidiyorsun', 'gidiyorum', 'gidiyor', 'gidiyoruz'], correctIndex: 1, explanation: 'gidiyorum = я иду (git+iyor+um)'),
        CourseExercise(type: ExerciseType.translation, question: '"Читать" по-турецки:', options: ['yazmak', 'okumak', 'konuşmak', 'dinlemek'], correctIndex: 1, explanation: 'okumak = читать'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ben Türkçe ___. (говорю)', options: ['gidiyorum', 'yiyorum', 'konuşuyorum', 'okuyorum'], correctIndex: 2, explanation: 'konuşmak → konuşuyorum = я говорю'),
      ],
      exam: [
        ExamQuestion(question: '"Приходить" по-турецки:', options: ['gitmek', 'gelmek', 'kalmak', 'dönmek'], correctIndex: 1, explanation: 'gelmek = приходить'),
        ExamQuestion(question: 'Ben yiyorum означает:', options: ['я пью', 'я иду', 'я ем', 'я читаю'], correctIndex: 2, explanation: 'yemek → yiyorum = я ем'),
        ExamQuestion(question: '"Ты слушаешь" по-турецки:', options: ['dinliyorum', 'dinliyorsun', 'dinliyor', 'dinliyoruz'], correctIndex: 1, explanation: 'dinlemek → dinliyorsun = ты слушаешь'),
        ExamQuestion(question: '"Пить" по-турецки:', options: ['yemek', 'içmek', 'almak', 'vermek'], correctIndex: 1, explanation: 'içmek = пить'),
        ExamQuestion(question: 'O uyuyor означает:', options: ['он читает', 'он идёт', 'он спит', 'он ест'], correctIndex: 2, explanation: 'uyumak → uyuyor = он/она спит'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'tr_a2_01', title: 'Geçmiş Zaman', subtitle: 'Прошедшее время', emoji: '⏮️',
      level: LanguageLevel.a2, order: 9, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Прошедшее время -di', content: 'Суффикс -di/-dı/-du/-dü (виденное прошедшее):\ngittim — я пошёл\ngeldin — ты пришёл\nyedi — он поел\nkonuştuk — мы говорили', examples: ['Dün okula gittim.', 'Ne yedin?', 'Kitap okuduk.']),
        TheorySection(title: 'Отрицание в прошедшем', content: 'Отрицание: -me/-ma перед -di:\ngitmedim — я не пошёл\ngelmedin — ты не пришёл\nyemedi — он не поел', examples: ['Dün okula gitmedim.', 'Bunu yapmadım.', 'O gelmedi.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я пошёл" по-турецки:', options: ['gidiyorum', 'gittim', 'gideceğim', 'giderdim'], correctIndex: 1, explanation: 'gittim = я пошёл (прош. вр.)'),
        CourseExercise(type: ExerciseType.translation, question: '"Мы говорили" по-турецки:', options: ['konuşuyoruz', 'konuştuk', 'konuşacağız', 'konuşurduk'], correctIndex: 1, explanation: 'konuştuk = мы говорили'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Dün okula ___. (Вчера я не пошёл в школу)', options: ['gittim', 'gitmedim', 'gidiyorum', 'gideceğim'], correctIndex: 1, explanation: 'gitmedim = я не пошёл'),
      ],
      exam: [
        ExamQuestion(question: '"Он поел" по-турецки:', options: ['yiyor', 'yedi', 'yiyecek', 'yerdi'], correctIndex: 1, explanation: 'yedi = он поел'),
        ExamQuestion(question: '"Ты не пришёл" по-турецки:', options: ['geldin', 'geliyorsun', 'gelmedin', 'gelmiyorsun'], correctIndex: 2, explanation: 'gelmedin = ты не пришёл'),
        ExamQuestion(question: 'dün означает:', options: ['сегодня', 'завтра', 'вчера', 'сейчас'], correctIndex: 2, explanation: 'dün = вчера'),
        ExamQuestion(question: '"Мы прочитали" по-турецки:', options: ['okuduk', 'okuyoruz', 'okuyacağız', 'okurduk'], correctIndex: 0, explanation: 'okuduk = мы прочитали'),
        ExamQuestion(question: '"Она не спала" по-турецки:', options: ['uyudu', 'uyumadı', 'uyumuyor', 'uyumayacak'], correctIndex: 1, explanation: 'uyumadı = она не спала'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_02', title: 'Ulaşım', subtitle: 'Транспорт', emoji: '🚌',
      level: LanguageLevel.a2, order: 10, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Транспорт', content: 'otobüs — автобус\nmetro — метро\ntaksi — такси\ntren — поезд\nuçak — самолёт\nvapur — паром\naraba — машина', examples: ['Otobüsle gidiyorum.', 'Metro daha hızlı.', 'Taksi çağırdım.']),
        TheorySection(title: 'Направления', content: 'sağ — направо\nsol — налево\ndüz — прямо\ngeri — назад\nyakın — близко\nuzak — далеко', examples: ['Sağa dönün.', 'Düz gidin.', 'Çok uzak değil.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-турецки:', options: ['tren', 'vapur', 'uçak', 'otobüs'], correctIndex: 2, explanation: 'uçak = самолёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Направо" по-турецки:', options: ['sol', 'düz', 'geri', 'sağ'], correctIndex: 3, explanation: 'sağ = направо'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ ile gidiyorum. (Еду на автобусе)', options: ['Tren', 'Uçak', 'Otobüs', 'Metro'], correctIndex: 2, explanation: 'otobüs ile = на автобусе'),
      ],
      exam: [
        ExamQuestion(question: '"Поезд" по-турецки:', options: ['uçak', 'vapur', 'tren', 'taksi'], correctIndex: 2, explanation: 'tren = поезд'),
        ExamQuestion(question: '"Налево" по-турецки:', options: ['sağ', 'düz', 'sol', 'geri'], correctIndex: 2, explanation: 'sol = налево'),
        ExamQuestion(question: '"Близко" по-турецки:', options: ['uzak', 'yakın', 'hızlı', 'yavaş'], correctIndex: 1, explanation: 'yakın = близко'),
        ExamQuestion(question: '"Метро" по-турецки:', options: ['otobüs', 'metro', 'tramvay', 'taksi'], correctIndex: 1, explanation: 'metro = метро'),
        ExamQuestion(question: '"Прямо" по-турецки:', options: ['sağ', 'sol', 'geri', 'düz'], correctIndex: 3, explanation: 'düz = прямо'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_03', title: 'Hava Durumu', subtitle: 'Погода', emoji: '🌤️',
      level: LanguageLevel.a2, order: 11, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'güneşli — солнечно\nbulutlu — облачно\nyağmurlu — дождливо\nkarlı — снежно\nrüzgarlı — ветрено\nsıcak — жарко\nsoğuk — холодно', examples: ['Bugün hava güneşli.', 'Yağmur yağıyor.', 'Çok soğuk.']),
        TheorySection(title: 'Сезоны', content: 'ilkbahar — весна\nyaz — лето\nsonbahar — осень\nkış — зима\nmevsim — сезон', examples: ['Yazın sıcak olur.', 'Kışın kar yağar.', 'En sevdiğim mevsim sonbahar.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Дождливо" по-турецки:', options: ['karlı', 'güneşli', 'yağmurlu', 'bulutlu'], correctIndex: 2, explanation: 'yağmurlu = дождливо'),
        CourseExercise(type: ExerciseType.translation, question: '"Лето" по-турецки:', options: ['kış', 'ilkbahar', 'sonbahar', 'yaz'], correctIndex: 3, explanation: 'yaz = лето'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bugün hava çok ___. (очень холодно)', options: ['sıcak', 'soğuk', 'güzel', 'güneşli'], correctIndex: 1, explanation: 'soğuk = холодно'),
      ],
      exam: [
        ExamQuestion(question: '"Зима" по-турецки:', options: ['yaz', 'ilkbahar', 'kış', 'sonbahar'], correctIndex: 2, explanation: 'kış = зима'),
        ExamQuestion(question: '"Ветрено" по-турецки:', options: ['karlı', 'rüzgarlı', 'yağmurlu', 'sisli'], correctIndex: 1, explanation: 'rüzgarlı = ветрено'),
        ExamQuestion(question: '"Жарко" по-турецки:', options: ['soğuk', 'ılık', 'sıcak', 'serin'], correctIndex: 2, explanation: 'sıcak = жарко/горячо'),
        ExamQuestion(question: '"Весна" по-турецки:', options: ['yaz', 'kış', 'sonbahar', 'ilkbahar'], correctIndex: 3, explanation: 'ilkbahar = весна'),
        ExamQuestion(question: '"Снежно" по-турецки:', options: ['karlı', 'yağmurlu', 'bulutlu', 'rüzgarlı'], correctIndex: 0, explanation: 'karlı = снежно (kar=снег)'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_04', title: 'Kıyafetler', subtitle: 'Одежда', emoji: '👕',
      level: LanguageLevel.a2, order: 12, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'gömlek — рубашка\npantolon — брюки\netek — юбка\nelbise — платье\nceket — пиджак\nayakkabı — обувь\nşapka — шляпа', examples: ['Beyaz gömlek giydim.', 'Bu elbise çok güzel.', 'Ayakkabılarım yeni.']),
        TheorySection(title: 'Глагол "надевать"', content: 'giymek — надевать\ngiyiyorum — я надеваю\ngiydim — я надел\nçıkarmak — снимать\nkıyafet — одежда', examples: ['Kırmızı elbise giydim.', 'Şapkamı çıkardım.', 'Ne giyeceksin?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Брюки" по-турецки:', options: ['gömlek', 'etek', 'pantolon', 'ceket'], correctIndex: 2, explanation: 'pantolon = брюки'),
        CourseExercise(type: ExerciseType.translation, question: '"Обувь" по-турецки:', options: ['şapka', 'çanta', 'ayakkabı', 'kemer'], correctIndex: 2, explanation: 'ayakkabı = обувь/туфли'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bugün ne ___? (что ты наденешь?)', options: ['giydin', 'giyiyorsun', 'giyeceksin', 'giydim'], correctIndex: 2, explanation: 'giyeceksin = ты наденешь (будущее)'),
      ],
      exam: [
        ExamQuestion(question: '"Платье" по-турецки:', options: ['gömlek', 'etek', 'elbise', 'bluz'], correctIndex: 2, explanation: 'elbise = платье'),
        ExamQuestion(question: '"Шляпа" по-турецки:', options: ['çanta', 'şapka', 'kemer', 'atkı'], correctIndex: 1, explanation: 'şapka = шляпа/шапка'),
        ExamQuestion(question: 'giymek означает:', options: ['снимать', 'покупать', 'надевать', 'стирать'], correctIndex: 2, explanation: 'giymek = надевать'),
        ExamQuestion(question: '"Пиджак" по-турецки:', options: ['gömlek', 'kazak', 'ceket', 'mont'], correctIndex: 2, explanation: 'ceket = пиджак'),
        ExamQuestion(question: '"Рубашка" по-турецки:', options: ['pantolon', 'gömlek', 'şort', 'tayt'], correctIndex: 1, explanation: 'gömlek = рубашка'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_05', title: 'Hobiler', subtitle: 'Хобби и свободное время', emoji: '🎯',
      level: LanguageLevel.a2, order: 13, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Хобби', content: 'müzik dinlemek — слушать музыку\nkitap okumak — читать книги\nspor yapmak — заниматься спортом\nresim yapmak — рисовать\nseyahat etmek — путешествовать\nfotoğraf çekmek — фотографировать', examples: ['Müzik dinlemeyi seviyorum.', 'Her gün spor yapıyorum.', 'Seyahat etmek istiyorum.']),
        TheorySection(title: 'Выражение предпочтений', content: 'sevmek — любить\nseviyorum — я люблю\nhoşlanmak — нравиться\nistiyorum — я хочу\nbeğenmek — нравиться/одобрять', examples: ['Kitap okumayı seviyorum.', 'Futboldan hoşlanırım.', 'Film izlemek istiyorum.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Путешествовать" по-турецки:', options: ['spor yapmak', 'müzik dinlemek', 'seyahat etmek', 'resim yapmak'], correctIndex: 2, explanation: 'seyahat etmek = путешествовать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я люблю читать" по-турецки:', options: ['Kitap okumaktan hoşlanmıyorum.', 'Kitap okumayı seviyorum.', 'Kitap okumak istiyorum.', 'Kitap okuyorum.'], correctIndex: 1, explanation: 'seviyorum + infinitive+yi = люблю делать'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Her gün spor ___. (я занимаюсь спортом каждый день)', options: ['yapıyorum', 'yapıyorsun', 'yapıyor', 'yapıyoruz'], correctIndex: 0, explanation: 'yapıyorum = я делаю/занимаюсь'),
      ],
      exam: [
        ExamQuestion(question: '"Рисовать" по-турецки:', options: ['müzik dinlemek', 'resim yapmak', 'dans etmek', 'şarkı söylemek'], correctIndex: 1, explanation: 'resim yapmak = рисовать'),
        ExamQuestion(question: 'seviyorum означает:', options: ['я хочу', 'я люблю', 'мне нравится', 'я знаю'], correctIndex: 1, explanation: 'seviyorum = я люблю (настоящее время)'),
        ExamQuestion(question: '"Фотографировать" по-турецки:', options: ['video çekmek', 'resim yapmak', 'fotoğraf çekmek', 'film izlemek'], correctIndex: 2, explanation: 'fotoğraf çekmek = фотографировать'),
        ExamQuestion(question: '"Слушать музыку" по-турецки:', options: ['şarkı söylemek', 'müzik dinlemek', 'dans etmek', 'enstrüman çalmak'], correctIndex: 1, explanation: 'müzik dinlemek = слушать музыку'),
        ExamQuestion(question: 'hoşlanmak означает:', options: ['ненавидеть', 'нравиться', 'знать', 'хотеть'], correctIndex: 1, explanation: 'hoşlanmak = нравиться/любить'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_06', title: 'Gelecek Zaman', subtitle: 'Будущее время', emoji: '🔮',
      level: LanguageLevel.a2, order: 14, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Будущее время -ecek/-acak', content: 'gideceğim — я пойду\ngeleceksin — ты придёшь\nyapacak — он сделает\nkonuşacağız — мы поговорим\nyarın — завтра\ngelecek hafta — на следующей неделе', examples: ['Yarın İstanbul\'a gideceğim.', 'Ne yapacaksın?', 'Gelecek hafta görüşeceğiz.']),
        TheorySection(title: 'Намерения', content: 'istemek — хотеть\nplanlamak — планировать\ndüşünmek — думать\numut etmek — надеяться\nbekliyorum — я жду/ожидаю', examples: ['Türkçe öğrenmek istiyorum.', 'Tatile gitmek planlıyorum.', 'Umarım gelirsin.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я пойду" (будущее) по-турецки:', options: ['gidiyorum', 'gittim', 'gideceğim', 'giderdim'], correctIndex: 2, explanation: 'gideceğim = я пойду'),
        CourseExercise(type: ExerciseType.translation, question: '"Завтра" по-турецки:', options: ['dün', 'bugün', 'yarın', 'şimdi'], correctIndex: 2, explanation: 'yarın = завтра'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Gelecek hafta seni ___. (я увижу тебя на следующей неделе)', options: ['göreceğim', 'görüyorum', 'gördüm', 'görürdüm'], correctIndex: 0, explanation: 'göreceğim = я увижу'),
      ],
      exam: [
        ExamQuestion(question: '"Ты придёшь" по-турецки:', options: ['geldin', 'geliyorsun', 'geleceksin', 'gelirsin'], correctIndex: 2, explanation: 'geleceksin = ты придёшь'),
        ExamQuestion(question: '"На следующей неделе" по-турецки:', options: ['geçen hafta', 'bu hafta', 'gelecek hafta', 'yarın'], correctIndex: 2, explanation: 'gelecek hafta = на следующей неделе'),
        ExamQuestion(question: 'istemek означает:', options: ['знать', 'уметь', 'хотеть', 'мочь'], correctIndex: 2, explanation: 'istemek = хотеть'),
        ExamQuestion(question: '"Мы поговорим" по-турецки:', options: ['konuşuyoruz', 'konuştuk', 'konuşacağız', 'konuşurduk'], correctIndex: 2, explanation: 'konuşacağız = мы поговорим'),
        ExamQuestion(question: '"Я надеюсь" по-турецки:', options: ['istiyorum', 'planlıyorum', 'umuyorum', 'bekliyorum'], correctIndex: 2, explanation: 'umuyorum = я надеюсь'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_07', title: 'Alışveriş', subtitle: 'Покупки', emoji: '🛍️',
      level: LanguageLevel.a2, order: 15, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'В магазине', content: 'mağaza — магазин\nsatmak — продавать\nsatın almak — покупать\nfiyat — цена\npahalı — дорогой\nucuz — дешёвый\nindirm — скидка', examples: ['Bu ne kadar?', 'Çok pahalı.', 'İndirim var mı?']),
        TheorySection(title: 'Числа и деньги', content: 'Türk lirası — турецкая лира\nkuruş — куруш (копейка)\nödemek — платить\nbozuk para — мелочь\nkart — карта\nnakiт — наличные', examples: ['Kaç lira?', 'Kartla ödeyebilir miyim?', 'Üstü kalsın.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Дорогой" по-турецки:', options: ['ucuz', 'pahalı', 'bedava', 'uygun'], correctIndex: 1, explanation: 'pahalı = дорогой'),
        CourseExercise(type: ExerciseType.translation, question: '"Сколько стоит?" по-турецки:', options: ['Ne zaman?', 'Bu ne?', 'Ne kadar?', 'Nerede?'], correctIndex: 2, explanation: 'Ne kadar? = Сколько? (о цене)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bu çok ___! (Это очень дёшево!)', options: ['pahalı', 'ucuz', 'güzel', 'büyük'], correctIndex: 1, explanation: 'ucuz = дешёвый'),
      ],
      exam: [
        ExamQuestion(question: '"Скидка" по-турецки:', options: ['fiyat', 'indirim', 'vergi', 'ücret'], correctIndex: 1, explanation: 'indirim = скидка'),
        ExamQuestion(question: '"Платить" по-турецки:', options: ['satmak', 'almak', 'ödemek', 'vermek'], correctIndex: 2, explanation: 'ödemek = платить'),
        ExamQuestion(question: '"Наличные" по-турецки:', options: ['kart', 'çek', 'nakit', 'havale'], correctIndex: 2, explanation: 'nakit = наличные'),
        ExamQuestion(question: '"Покупать" по-турецки:', options: ['satmak', 'ödemek', 'satın almak', 'vermek'], correctIndex: 2, explanation: 'satın almak = покупать'),
        ExamQuestion(question: '"Дешёвый" по-турецки:', options: ['pahalı', 'ucuz', 'uygun', 'bedava'], correctIndex: 1, explanation: 'ucuz = дешёвый'),
      ],
    ),

    CourseChapter(
      id: 'tr_a2_08', title: 'Soru Cümleleri', subtitle: 'Вопросительные предложения', emoji: '❓',
      level: LanguageLevel.a2, order: 16, coinsReward: 35, xpReward: 25,
      theory: [
        TheorySection(title: 'Вопросительные слова', content: 'ne — что\nkim — кто\nnerede — где\nnereye — куда\nnasıl — как\nneden/niçin — почему\nne zaman — когда\nkaç — сколько', examples: ['Ne yapıyorsun?', 'Kim geldi?', 'Nerede yaşıyorsun?']),
        TheorySection(title: 'Вопросительная частица', content: 'mi/mı/mu/mü — вопросительная частица\nGidiyor musun? — Ты идёшь?\nGeldi mi? — Он пришёл?\nSeviliyor musun? — Тебя любят?', examples: ['Türkçe biliyor musun?', 'Kahve içer misin?', 'Hazır mısın?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Где" по-турецки:', options: ['ne', 'kim', 'nerede', 'nasıl'], correctIndex: 2, explanation: 'nerede = где'),
        CourseExercise(type: ExerciseType.translation, question: '"Ты идёшь?" по-турецки:', options: ['Gideceksin?', 'Gittin mi?', 'Gidiyor musun?', 'Gidiyorsun?'], correctIndex: 2, explanation: 'Gidiyor musun? = Ты идёшь? (настоящее)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ yapıyorsun? (Что ты делаешь?)', options: ['Kim', 'Nerede', 'Ne', 'Nasıl'], correctIndex: 2, explanation: 'ne = что'),
      ],
      exam: [
        ExamQuestion(question: '"Кто" по-турецки:', options: ['ne', 'kim', 'nerede', 'nasıl'], correctIndex: 1, explanation: 'kim = кто'),
        ExamQuestion(question: '"Почему" по-турецки:', options: ['nasıl', 'ne zaman', 'neden', 'kaç'], correctIndex: 2, explanation: 'neden/niçin = почему'),
        ExamQuestion(question: '"Ты знаешь турецкий?" по-турецки:', options: ['Türkçe biliyorsun.', 'Türkçe biliyor musun?', 'Türkçe bildin mi?', 'Türkçe bilecek misin?'], correctIndex: 1, explanation: 'biliyor musun? = ты знаешь?'),
        ExamQuestion(question: '"Когда" по-турецки:', options: ['nasıl', 'neden', 'nerede', 'ne zaman'], correctIndex: 3, explanation: 'ne zaman = когда'),
        ExamQuestion(question: '"Как" по-турецки:', options: ['ne', 'kim', 'nasıl', 'kaç'], correctIndex: 2, explanation: 'nasıl = как'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'tr_b1_01', title: 'Koşul Cümleleri', subtitle: 'Условные предложения', emoji: '🔀',
      level: LanguageLevel.b1, order: 17, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Условные с -se/-sa', content: 'Условие: глагол + -se/-sa\nGelirsen — Если ты придёшь\nYağmur yağarsa — Если пойдёт дождь\nBilseydin — Если бы ты знал', examples: ['Gelirsen, birlikte gideriz.', 'Para olsaydı, alırdım.', 'Erken kalkarsan, yetişirsin.']),
        TheorySection(title: 'Модальность', content: 'bilmek (мочь, уметь): -ebil-\ngidebilirim — я могу пойти\ngidemezsim — я не могу\n-meli/-malı = должен\ngitmeliyim — я должен идти', examples: ['Türkçe konuşabiliyorum.', 'Gitmeliyim.', 'Yapamam.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я могу говорить" по-турецки:', options: ['konuşuyorum', 'konuşabiliyorum', 'konuşmalıyım', 'konuşuyordum'], correctIndex: 1, explanation: '-ebil- = мочь/уметь'),
        CourseExercise(type: ExerciseType.translation, question: '"Я должен идти" по-турецки:', options: ['Gidebilirim.', 'Gideceğim.', 'Gitmeliyim.', 'Gidiyorum.'], correctIndex: 2, explanation: '-meli + yim = должен'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Erken ___, yetişirsin. (Если встанешь рано, успеешь)', options: ['kalksan', 'kalkarsan', 'kalkacaksan', 'kalkıyorsan'], correctIndex: 1, explanation: 'kalkarsan = если встанешь'),
      ],
      exam: [
        ExamQuestion(question: '"Я не могу" по-турецки:', options: ['yapabilirim', 'yapmalıyım', 'yapamam', 'yapmıyorum'], correctIndex: 2, explanation: 'yapamam = я не могу'),
        ExamQuestion(question: '"Если пойдёт дождь" по-турецки:', options: ['Yağmur yağıyor', 'Yağmur yağarsa', 'Yağmur yağdı', 'Yağmur yağacak'], correctIndex: 1, explanation: 'yağarsa = если пойдёт (условный)'),
        ExamQuestion(question: '"Ты должен прийти" по-турецки:', options: ['geleceksin', 'gelebilirsin', 'gelmelisin', 'geliyorsun'], correctIndex: 2, explanation: 'gelmelisin = ты должен прийти'),
        ExamQuestion(question: '-ebil- суффикс обозначает:', options: ['долженствование', 'возможность/умение', 'прошедшее', 'будущее'], correctIndex: 1, explanation: '-ebil- = мочь, уметь'),
        ExamQuestion(question: '"Мы можем говорить" по-турецки:', options: ['konuşuyoruz', 'konuşabiliyoruz', 'konuşmalıyız', 'konuşacağız'], correctIndex: 1, explanation: 'konuşabiliyoruz = мы можем говорить'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_02', title: 'Edilgen Çatı', subtitle: 'Пассивный залог', emoji: '🔄',
      level: LanguageLevel.b1, order: 18, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Пассивный залог', content: 'Суффикс -il-/-ıl-/-ul-/-ül- или -in-/-ın-\nyapılıyor — делается\naçıldı — было открыто\nsatılıyor — продаётся\nyazılmış — написано', examples: ['Kitap yazıldı.', 'Mağaza açıldı.', 'Bu yemek burada yapılıyor.']),
        TheorySection(title: 'Применение пассива', content: 'Пассив используется когда:\n- исполнитель неизвестен\n- исполнитель неважен\n- официальный стиль\ntarafından = "со стороны"/кем', examples: ['Kitap Orhan Pamuk tarafından yazıldı.', 'Kapı kapatıldı.', 'Yemek pişiriliyor.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Продаётся" по-турецки:', options: ['satıyor', 'satılıyor', 'satın alıyor', 'sattı'], correctIndex: 1, explanation: 'satılıyor = продаётся (пассив)'),
        CourseExercise(type: ExerciseType.translation, question: '"Книга написана" по-турецки:', options: ['Kitap yazıyor.', 'Kitap yazıldı.', 'Kitap yazacak.', 'Kitap yazıyor mu?'], correctIndex: 1, explanation: 'yazıldı = была написана (пассив прош. вр.)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Kapı ___. (Дверь закрылась)', options: ['kapatıyor', 'kapatıldı', 'kapatacak', 'kapatıyorum'], correctIndex: 1, explanation: 'kapatıldı = была закрыта'),
      ],
      exam: [
        ExamQuestion(question: 'tarafından означает:', options: ['для', 'без', 'кем/со стороны', 'вместе с'], correctIndex: 2, explanation: 'tarafından = кем/со стороны (в пассивных конструкциях)'),
        ExamQuestion(question: '"Делается" по-турецки:', options: ['yapıyor', 'yapılıyor', 'yapmak', 'yapacak'], correctIndex: 1, explanation: 'yapılıyor = делается (пассив наст. вр.)'),
        ExamQuestion(question: '"Было открыто" по-турецки:', options: ['açıldı', 'açıyor', 'açacak', 'açtı'], correctIndex: 0, explanation: 'açıldı = было открыто'),
        ExamQuestion(question: 'Пассивный суффикс в турецком:', options: ['-iyor', '-meli', '-il/-ıl', '-ecek'], correctIndex: 2, explanation: '-il/-ıl/-ul/-ül = пассивный суффикс'),
        ExamQuestion(question: '"Пишется" по-турецки:', options: ['yazıyor', 'yazılıyor', 'yazacak', 'yazdı'], correctIndex: 1, explanation: 'yazılıyor = пишется (пассив)'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_03', title: 'Dolaylı Anlatım', subtitle: 'Косвенная речь', emoji: '💬',
      level: LanguageLevel.b1, order: 19, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Косвенная речь', content: 'dedi ki — сказал, что\ndiyor ki — говорит, что\ndiye — (что)\nsordu — спросил\ncevap verdi — ответил\nSöyledi ki — Он сказал что', examples: ['"Geleceğim" dedi. (Он сказал "приду")', 'Geldiğini söyledi. (Сказал, что пришёл)', 'Ne zaman geleceğini sordu.']),
        TheorySection(title: 'Придаточные с -diği/-eceği', content: 'Для косвенной речи: глагол + -diği/-dığı\ngeldiğini biliyorum — знаю, что пришёл\ngideceğini söyledi — сказал, что пойдёт\nzorunda olduğunu — что обязан', examples: ['Haklı olduğunu düşünüyorum.', 'Geleceğini söyledi.', 'Nerede olduğunu bilmiyorum.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Он сказал что придёт" по-турецки:', options: ['Geleceğini söyledi.', 'Geldi dedi.', 'Gelmeyeceğini söyledi.', 'Geldiğini söyledi.'], correctIndex: 0, explanation: 'geleceğini söyledi = сказал, что придёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Я знаю, что ты прав" по-турецки:', options: ['Haklısın.', 'Haklı olduğunu biliyorum.', 'Haklı olduğunu söylüyorum.', 'Haklı mısın?'], correctIndex: 1, explanation: 'haklı olduğunu biliyorum = знаю, что ты прав'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nerede ___ bilmiyorum. (Я не знаю, где он)', options: ['olduğunu', 'olduğum', 'olduğun', 'olduğunuz'], correctIndex: 0, explanation: 'olduğunu = что он есть (3-е лицо)'),
      ],
      exam: [
        ExamQuestion(question: 'dedi ki означает:', options: ['сказал ли', 'сказал, что', 'скажет', 'говорит'], correctIndex: 1, explanation: 'dedi ki = сказал, что'),
        ExamQuestion(question: '"Он спросил" по-турецки:', options: ['cevap verdi', 'söyledi', 'sordu', 'dedi'], correctIndex: 2, explanation: 'sordu = он спросил'),
        ExamQuestion(question: 'Суффикс -diği/-dığı используется для:', options: ['будущего времени', 'косвенной речи', 'пассива', 'условия'], correctIndex: 1, explanation: '-diği = для номинализации в косвенной речи'),
        ExamQuestion(question: '"Говорит, что знает" по-турецки:', options: ['Bildiğini söylüyor.', 'Biliyorum dedi.', 'Bileceğini söylüyor.', 'Bilmiyor dedi.'], correctIndex: 0, explanation: 'bildiğini söylüyor = говорит, что знает'),
        ExamQuestion(question: '"Сказал, что не придёт" по-турецки:', options: ['Geleceğini söyledi.', 'Gelmeyeceğini söyledi.', 'Geldiğini söyledi.', 'Gelmediğini söyledi.'], correctIndex: 1, explanation: 'gelmeyeceğini söyledi = сказал, что не придёт'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_04', title: 'Karşılaştırma', subtitle: 'Сравнения', emoji: '⚖️',
      level: LanguageLevel.b1, order: 20, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Степени сравнения', content: 'daha — более/сравнительная\nen — самый (превосходная)\nkadar — такой же как\ndan/den daha — чем... более\nAli daha uzun. — Али выше.', examples: ['Bu ev daha büyük.', 'En iyi öğrenci.', 'Benim kadar iyi.']),
        TheorySection(title: 'Сравнительные конструкции', content: 'A, B\'den daha — A более чем B\nA kadar B değil — не такой как\ngiderek — постепенно\nhep — всегда\nen az — наименее', examples: ['İstanbul, Ankara\'dan daha büyük.', 'O benim kadar hızlı değil.', 'En pahalı araba.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самый красивый" по-турецки:', options: ['daha güzel', 'en güzel', 'çok güzel', 'güzel kadar'], correctIndex: 1, explanation: 'en güzel = самый красивый'),
        CourseExercise(type: ExerciseType.translation, question: '"Этот дом больше" по-турецки:', options: ['Bu ev büyük.', 'Bu ev daha büyük.', 'Bu ev en büyük.', 'Bu ev çok büyük.'], correctIndex: 1, explanation: 'daha büyük = больше (сравнительная)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'İstanbul, Ankara\'___ daha büyük.', options: ['-de', '-den', '-da', '-dan'], correctIndex: 1, explanation: '-den daha = более чем'),
      ],
      exam: [
        ExamQuestion(question: '"Более быстрый" по-турецки:', options: ['en hızlı', 'daha hızlı', 'çok hızlı', 'hızlı kadar'], correctIndex: 1, explanation: 'daha hızlı = более быстрый'),
        ExamQuestion(question: '"Самый маленький" по-турецки:', options: ['daha küçük', 'çok küçük', 'en küçük', 'az küçük'], correctIndex: 2, explanation: 'en küçük = самый маленький'),
        ExamQuestion(question: '"Такой же хороший как" по-турецки:', options: ['daha iyi', 'en iyi', 'kadar iyi', 'az iyi'], correctIndex: 2, explanation: 'kadar iyi = такой же хороший как'),
        ExamQuestion(question: 'daha означает:', options: ['самый', 'такой же', 'более', 'менее'], correctIndex: 2, explanation: 'daha = более (сравнительная степень)'),
        ExamQuestion(question: '"Наименее дорогой" по-турецки:', options: ['en pahalı', 'daha ucuz', 'en az pahalı', 'en ucuz'], correctIndex: 3, explanation: 'en ucuz = самый дешёвый/наименее дорогой'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_05', title: 'Teknoloji', subtitle: 'Технологии', emoji: '💻',
      level: LanguageLevel.b1, order: 21, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Технологии', content: 'bilgisayar — компьютер\ntelefo — телефон\ninternet — интернет\nuygulama — приложение\nsosyal medya — соцсети\ne-posta — электронная почта\ndosya — файл', examples: ['Bilgisayarda çalışıyorum.', 'Uygulama indirdim.', 'E-posta attım.']),
        TheorySection(title: 'Действия с технологиями', content: 'indirmek — скачивать\nyüklemek — загружать\ngöndermek — отправлять\npaylaşmak — делиться\nbağlanmak — подключаться\ngüncelleme — обновление', examples: ['Uygulama güncellemesi var.', 'Dosyayı gönderdim.', 'Wi-Fi\'ye bağlandım.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Компьютер" по-турецки:', options: ['telefon', 'tablet', 'bilgisayar', 'ekran'], correctIndex: 2, explanation: 'bilgisayar = компьютер'),
        CourseExercise(type: ExerciseType.translation, question: '"Скачивать" по-турецки:', options: ['yüklemek', 'indirmek', 'göndermek', 'silmek'], correctIndex: 1, explanation: 'indirmek = скачивать'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Wi-Fi\'ye ___. (Я подключился к Wi-Fi)', options: ['bağlandım', 'bağlıyım', 'bağlanacağım', 'bağlanıyorum'], correctIndex: 0, explanation: 'bağlandım = я подключился'),
      ],
      exam: [
        ExamQuestion(question: '"Приложение" по-турецки:', options: ['internet', 'uygulama', 'program', 'oyun'], correctIndex: 1, explanation: 'uygulama = приложение'),
        ExamQuestion(question: '"Электронная почта" по-турецки:', options: ['mesaj', 'e-posta', 'mektup', 'faks'], correctIndex: 1, explanation: 'e-posta = электронная почта'),
        ExamQuestion(question: '"Обновление" по-турецки:', options: ['indirme', 'yükleme', 'güncelleme', 'silme'], correctIndex: 2, explanation: 'güncelleme = обновление'),
        ExamQuestion(question: '"Делиться" по-турецки:', options: ['göndermek', 'almak', 'paylaşmak', 'saklamak'], correctIndex: 2, explanation: 'paylaşmak = делиться'),
        ExamQuestion(question: '"Файл" по-турецки:', options: ['klasör', 'belge', 'dosya', 'sayfa'], correctIndex: 2, explanation: 'dosya = файл'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_06', title: 'Sağlık', subtitle: 'Здоровье', emoji: '🏥',
      level: LanguageLevel.b1, order: 22, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Здоровье', content: 'hasta — больной\nağrı — боль\nateş — температура\nilaç — лекарство\ndoktor — врач\nhastane — больница\nmuayene — осмотр', examples: ['Başım ağrıyor.', 'Ateşim var.', 'Doktora gittim.']),
        TheorySection(title: 'У врача', content: 'şikayet — жалоба\nreçete — рецепт\noperasyon — операция\ntedavi — лечение\nistirahat — отдых/больничный\nalerjim var — у меня аллергия', examples: ['Neyiniz var? (Что вас беспокоит?)', 'Reçete yazdı.', 'Bir hafta istirahat edin.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Больница" по-турецки:', options: ['eczane', 'klinik', 'hastane', 'poliklinik'], correctIndex: 2, explanation: 'hastane = больница'),
        CourseExercise(type: ExerciseType.translation, question: '"У меня температура" по-турецки:', options: ['Başım ağrıyor.', 'Ateşim var.', 'Midem ağrıyor.', 'Hasta hissediyorum.'], correctIndex: 1, explanation: 'Ateşim var = У меня температура'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ yazdı. (Врач выписал рецепт)', options: ['İlaç', 'Reçete', 'Tedavi', 'Rapor'], correctIndex: 1, explanation: 'Reçete yazdı = выписал рецепт'),
      ],
      exam: [
        ExamQuestion(question: '"Лекарство" по-турецки:', options: ['reçete', 'ilaç', 'hap', 'şurup'], correctIndex: 1, explanation: 'ilaç = лекарство'),
        ExamQuestion(question: '"Боль" по-турецки:', options: ['ateş', 'grip', 'ağrı', 'yara'], correctIndex: 2, explanation: 'ağrı = боль'),
        ExamQuestion(question: '"Лечение" по-турецки:', options: ['muayene', 'istirahat', 'tedavi', 'ameliyat'], correctIndex: 2, explanation: 'tedavi = лечение'),
        ExamQuestion(question: '"Больной" по-турецки:', options: ['sağlıklı', 'hasta', 'yorgun', 'zayıf'], correctIndex: 1, explanation: 'hasta = больной'),
        ExamQuestion(question: '"Рецепт" по-турецки:', options: ['rapor', 'reçete', 'belge', 'kart'], correctIndex: 1, explanation: 'reçete = рецепт'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_07', title: 'İş ve Kariyer', subtitle: 'Работа и карьера', emoji: '💼',
      level: LanguageLevel.b1, order: 23, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Работа', content: 'iş — работа\nçalışmak — работать\nişveren — работодатель\nçalışan — сотрудник\nmaaş — зарплата\nterfi — повышение\nistifa — увольнение', examples: ['Bir şirkette çalışıyorum.', 'Maaşım iyi.', 'Terfi aldım.']),
        TheorySection(title: 'Профессии', content: 'doktor — врач\nöğretmen — учитель\nmühendis — инженер\navukat — адвокат\nmuhasebeci — бухгалтер\nprogramcı — программист', examples: ['Öğretmen olarak çalışıyorum.', 'Mühendis olmak istiyorum.', 'Avukat tavsiye etti.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Зарплата" по-турецки:', options: ['terfi', 'maaş', 'ikramiye', 'ücret'], correctIndex: 1, explanation: 'maaş = зарплата'),
        CourseExercise(type: ExerciseType.translation, question: '"Учитель" по-турецки:', options: ['doktor', 'mühendis', 'öğretmen', 'avukat'], correctIndex: 2, explanation: 'öğretmen = учитель'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bir şirkette ___. (Я работаю в компании)', options: ['çalışıyorum', 'çalıştım', 'çalışacağım', 'çalışırdım'], correctIndex: 0, explanation: 'çalışıyorum = я работаю'),
      ],
      exam: [
        ExamQuestion(question: '"Инженер" по-турецки:', options: ['doktor', 'avukat', 'mühendis', 'mimar'], correctIndex: 2, explanation: 'mühendis = инженер'),
        ExamQuestion(question: '"Повышение" по-турецки:', options: ['maaş', 'istifa', 'terfi', 'izin'], correctIndex: 2, explanation: 'terfi = повышение по службе'),
        ExamQuestion(question: '"Программист" по-турецки:', options: ['tasarımcı', 'programcı', 'analist', 'yönetici'], correctIndex: 1, explanation: 'programcı = программист'),
        ExamQuestion(question: '"Работодатель" по-турецки:', options: ['çalışan', 'işçi', 'işveren', 'müdür'], correctIndex: 2, explanation: 'işveren = работодатель'),
        ExamQuestion(question: '"Увольнение" по-турецки:', options: ['terfi', 'istifa', 'izin', 'tatil'], correctIndex: 1, explanation: 'istifa = увольнение/отставка'),
      ],
    ),

    CourseChapter(
      id: 'tr_b1_08', title: 'Kültür ve Sanat', subtitle: 'Культура и искусство', emoji: '🎭',
      level: LanguageLevel.b1, order: 24, coinsReward: 40, xpReward: 30,
      theory: [
        TheorySection(title: 'Культура', content: 'kültür — культура\nsanat — искусство\nmüzik — музыка\nresim — картина/рисунок\nheykeltıraş — скульптор\ntiyatro — театр\nsinema — кино', examples: ['Tiyatroya gidiyorum.', 'Bu resim çok güzel.', 'Türk müziğini seviyorum.']),
        TheorySection(title: 'Турецкая культура', content: 'rakı — ракы (напиток)\nkebap — кебаб\nhammam — хаммам\nhalk dansı — народный танец\nmosque — cami\nbazaar — çarşı/pazar', examples: ['Kapalı Çarşı\'ya gittik.', 'Türk hamamı denedim.', 'Zeybek oynadı.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Театр" по-турецки:', options: ['sinema', 'tiyatro', 'müze', 'galeri'], correctIndex: 1, explanation: 'tiyatro = театр'),
        CourseExercise(type: ExerciseType.translation, question: '"Искусство" по-турецки:', options: ['kültür', 'bilim', 'sanat', 'tarih'], correctIndex: 2, explanation: 'sanat = искусство'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Türk ___ çok zengin. (Турецкая культура очень богатая)', options: ['sanatı', 'tarihi', 'kültürü', 'dili'], correctIndex: 2, explanation: 'kültürü = её культура'),
      ],
      exam: [
        ExamQuestion(question: '"Кино" по-турецки:', options: ['tiyatro', 'müze', 'sinema', 'konser'], correctIndex: 2, explanation: 'sinema = кино'),
        ExamQuestion(question: '"Базар/рынок" по-турецки:', options: ['mağaza', 'dükkân', 'çarşı', 'alışveriş merkezi'], correctIndex: 2, explanation: 'çarşı = базар'),
        ExamQuestion(question: '"Музей" по-турецки:', options: ['sinema', 'tiyatro', 'galeri', 'müze'], correctIndex: 3, explanation: 'müze = музей'),
        ExamQuestion(question: '"Народный танец" по-турецки:', options: ['dans', 'halk dansı', 'bale', 'modern dans'], correctIndex: 1, explanation: 'halk dansı = народный танец'),
        ExamQuestion(question: '"Мечеть" по-турецки:', options: ['kilise', 'sinagog', 'cami', 'manastır'], correctIndex: 2, explanation: 'cami = мечеть'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'tr_b2_01', title: 'İleri Gramer', subtitle: 'Продвинутая грамматика', emoji: '📚',
      level: LanguageLevel.b2, order: 25, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Причастия', content: 'Причастие настоящего: -en/-an\nokuyan öğrenci — читающий студент\ngelen adam — пришедший мужчина\nPричастие прошедшего: -miş/-mış\nocunan kitap — прочитанная книга', examples: ['Beni bekleyen biri var.', 'Yazılan mektup kayboldu.', 'Gelecek olan misafirler.']),
        TheorySection(title: 'Деепричастия', content: '-erek/-arak = делая\nkoşarak geldi — пришёл бегом\n-ip/-ıp = и, после того как\nkalkıp gitti — встал и ушёл\n-ince/-ınca = когда\ngelince söyle — скажи, когда придёт', examples: ['Gülerek yanıtladı.', 'Kitabı okuyup anlattı.', 'Eve gelince ara.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Читающий студент" по-турецки:', options: ['okutan öğrenci', 'okuyan öğrenci', 'okumuş öğrenci', 'okuyacak öğrenci'], correctIndex: 1, explanation: 'okuyan = читающий (причастие наст. вр.)'),
        CourseExercise(type: ExerciseType.translation, question: '"Пришёл бегом" по-турецки:', options: ['Koşarak geldi.', 'Koştu geldi.', 'Koşup geldi.', 'Koşunca geldi.'], correctIndex: 0, explanation: 'koşarak = бегом (деепричастие -arak)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Eve gel___ ara. (Позвони, когда придёшь домой)', options: ['-erek', '-ip', '-ince', '-arak'], correctIndex: 2, explanation: '-ince = когда (деепричастие)'),
      ],
      exam: [
        ExamQuestion(question: 'Суффикс -en/-an образует:', options: ['прошедшее время', 'причастие наст. вр.', 'деепричастие', 'пассив'], correctIndex: 1, explanation: '-en/-an = причастие настоящего времени'),
        ExamQuestion(question: '"Написанное письмо" по-турецки:', options: ['yazılan mektup', 'yazan mektup', 'yazacak mektup', 'yazılmış mektup'], correctIndex: 3, explanation: 'yazılmış = написанное (причастие прошедшего с пассивом)'),
        ExamQuestion(question: '-erek/-arak обозначает:', options: ['когда', 'если', 'делая', 'потому что'], correctIndex: 2, explanation: '-erek/-arak = делая (деепричастие образа действия)'),
        ExamQuestion(question: '"Встал и ушёл" по-турецки:', options: ['Kalkarak gitti.', 'Kalkınca gitti.', 'Kalkıp gitti.', 'Kalktı ve gitti.'], correctIndex: 2, explanation: 'kalkıp gitti = встал и ушёл (-ip деепричастие)'),
        ExamQuestion(question: '"Пришедший человек" по-турецки:', options: ['gelecek adam', 'gelen adam', 'gelmiş adam', 'gelen biri'], correctIndex: 1, explanation: 'gelen = пришедший/приходящий'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_02', title: 'İş Türkçesi', subtitle: 'Деловой турецкий', emoji: '🤝',
      level: LanguageLevel.b2, order: 26, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Деловая лексика', content: 'toplantı — встреча/совещание\nsunum — презентация\nrapor — отчёт\nsözleşme — контракт\nbütçe — бюджет\nkâr — прибыль\nzarar — убыток', examples: ['Toplantıya katıldım.', 'Sunum hazırladım.', 'Sözleşme imzalandı.']),
        TheorySection(title: 'Деловая коммуникация', content: 'Saygılarımla — С уважением\nİlginize teşekkürler — Спасибо за внимание\nAşağıda bulabilirsiniz — Вы можете найти ниже\nBilgilerinize — Для вашего сведения\nEk\'te — В приложении', examples: ['Ek\'te raporu bulabilirsiniz.', 'Saygılarımla, Ali Yılmaz', 'Bilgilerinize sunarız.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Совещание" по-турецки:', options: ['sunum', 'toplantı', 'görüşme', 'röportaj'], correctIndex: 1, explanation: 'toplantı = совещание/встреча'),
        CourseExercise(type: ExerciseType.translation, question: '"С уважением" по-турецки (в письме):', options: ['Teşekkürler', 'Saygılarımla', 'İyi günler', 'Hoşça kal'], correctIndex: 1, explanation: 'Saygılarımla = С уважением'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ek\'te ___ bulabilirsiniz. (В приложении вы найдёте отчёт)', options: ['toplantı', 'raporu', 'sunumu', 'bütçeyi'], correctIndex: 1, explanation: 'raporu = отчёт (объектный падеж)'),
      ],
      exam: [
        ExamQuestion(question: '"Контракт" по-турецки:', options: ['rapor', 'bütçe', 'sözleşme', 'fatura'], correctIndex: 2, explanation: 'sözleşme = контракт'),
        ExamQuestion(question: '"Прибыль" по-турецки:', options: ['zarar', 'gider', 'kâr', 'gelir'], correctIndex: 2, explanation: 'kâr = прибыль'),
        ExamQuestion(question: '"Презентация" по-турецки:', options: ['toplantı', 'sunum', 'rapor', 'brifing'], correctIndex: 1, explanation: 'sunum = презентация'),
        ExamQuestion(question: '"Бюджет" по-турецки:', options: ['hesap', 'bütçe', 'fon', 'sermaye'], correctIndex: 1, explanation: 'bütçe = бюджет'),
        ExamQuestion(question: '"Убыток" по-турецки:', options: ['kâr', 'gelir', 'zarar', 'gider'], correctIndex: 2, explanation: 'zarar = убыток'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_03', title: 'Deyimler', subtitle: 'Идиомы и пословицы', emoji: '🌿',
      level: LanguageLevel.b2, order: 27, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Турецкие идиомы', content: 'ağzından kaçırmak — проговориться\nbaşa çıkmak — справляться\nelini çabuk tutmak — торопиться\ngözden düşmek — потерять репутацию\nkafaya takmak — зациклиться', examples: ['Sırrı ağzından kaçırdı.', 'Bu sorunla başa çıkamıyorum.', 'Elini çabuk tut!']),
        TheorySection(title: 'Пословицы', content: 'Damlaya damlaya göl olur. — Капля камень точит.\nİt ürür, kervan yürür. — Собака лает, а ветер носит.\nSabır acıdır, meyvesi tatlıdır. — Терпение горько, но плод сладок.', examples: ['Damlaya damlaya göl olur — надо быть терпеливым.', 'İt ürür, kervan yürür — не реагируй на критику.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"başa çıkmak" означает:', options: ['начинать', 'заканчивать', 'справляться', 'бороться'], correctIndex: 2, explanation: 'başa çıkmak = справляться с чем-то'),
        CourseExercise(type: ExerciseType.translation, question: '"Damlaya damlaya göl olur" — смысл:', options: ['Вода дороже золота', 'Капля камень точит', 'Море глубокое', 'Дождь полезен'], correctIndex: 1, explanation: 'Буквально: "капля за каплей — озеро" = терпение и настойчивость'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Sırrı ağzından ___. (Он проговорился)', options: ['kaçırdı', 'tuttu', 'söyledi', 'aldı'], correctIndex: 0, explanation: 'ağzından kaçırmak = проговориться'),
      ],
      exam: [
        ExamQuestion(question: '"Ağzından kaçırmak" означает:', options: ['потерять что-то', 'проговориться', 'говорить тихо', 'промолчать'], correctIndex: 1, explanation: 'ağzından kaçırmak = проговориться'),
        ExamQuestion(question: '"İt ürür, kervan yürür" — смысл:', options: ['Путешествие опасно', 'Не реагируй на пустую критику', 'Собаки опасны', 'Нужно идти вперёд'], correctIndex: 1, explanation: 'Буквально: "собака лает, а керван идёт" = не обращай внимания на критику'),
        ExamQuestion(question: '"gözden düşmek" означает:', options: ['потерять зрение', 'упасть', 'потерять репутацию', 'забыть'], correctIndex: 2, explanation: 'gözden düşmek = потерять авторитет/репутацию'),
        ExamQuestion(question: '"kafaya takmak" означает:', options: ['думать', 'зациклиться', 'забыть', 'решить'], correctIndex: 1, explanation: 'kafaya takmak = зациклиться на чём-то'),
        ExamQuestion(question: '"elini çabuk tutmak" означает:', options: ['работать', 'торопиться', 'помогать', 'держать'], correctIndex: 1, explanation: 'elini çabuk tutmak = поторопиться'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_04', title: 'Medya ve Haber', subtitle: 'СМИ и новости', emoji: '📰',
      level: LanguageLevel.b2, order: 28, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'СМИ', content: 'gazete — газета\ndergi — журнал\ntelevizon — телевидение\nradyo — радио\nhaber — новость\nyayın — трансляция\ngazeteci — журналист', examples: ['Gazete okuyorum.', 'Haberler saat 8\'de.', 'Gazeteci röportaj yaptı.']),
        TheorySection(title: 'Медиа-лексика', content: 'manşet — заголовок\nmakale — статья\nröportaj — интервью\nbildirim — уведомление\nyorum — комментарий\npaylaşmak — делиться', examples: ['Manşet çok dikkat çekici.', 'Makaleyi okudum.', 'Haberi paylaştım.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Газета" по-турецки:', options: ['dergi', 'gazete', 'kitap', 'broşür'], correctIndex: 1, explanation: 'gazete = газета'),
        CourseExercise(type: ExerciseType.translation, question: '"Журналист" по-турецки:', options: ['editör', 'yazar', 'gazeteci', 'muhabir'], correctIndex: 2, explanation: 'gazeteci = журналист'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Sabah ___ okuyorum. (Читаю газету утром)', options: ['dergi', 'gazete', 'haber', 'makale'], correctIndex: 1, explanation: 'gazete okumak = читать газету'),
      ],
      exam: [
        ExamQuestion(question: '"Новость" по-турецки:', options: ['makale', 'röportaj', 'haber', 'yorum'], correctIndex: 2, explanation: 'haber = новость'),
        ExamQuestion(question: '"Заголовок" по-турецки:', options: ['manşet', 'başlık', 'alt başlık', 'metin'], correctIndex: 0, explanation: 'manşet = заголовок (в газете)'),
        ExamQuestion(question: '"Интервью" по-турецки:', options: ['yorum', 'makale', 'röportaj', 'analiz'], correctIndex: 2, explanation: 'röportaj = интервью/репортаж'),
        ExamQuestion(question: '"Журнал" по-турецки:', options: ['gazete', 'dergi', 'kitap', 'katalog'], correctIndex: 1, explanation: 'dergi = журнал'),
        ExamQuestion(question: '"Комментарий" по-турецки:', options: ['haber', 'makale', 'yorum', 'eleştiri'], correctIndex: 2, explanation: 'yorum = комментарий/интерпретация'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_05', title: 'Akademik Türkçe', subtitle: 'Академический турецкий', emoji: '🎓',
      level: LanguageLevel.b2, order: 29, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Академическая лексика', content: 'araştırma — исследование\nhipotez — гипотеза\nbulgu — вывод/находка\nyöntem — метод\nkaynak — источник\nözet — резюме/аннотация\nsonuç — результат', examples: ['Araştırma sonuçları açıklandı.', 'Hipotez doğrulandı.', 'Kaynakça eklendi.']),
        TheorySection(title: 'Академический стиль', content: 'Bu çalışmada — В данной работе\nİncelendiğinde — При рассмотрении\nSonuç olarak — В итоге\nBu bağlamda — В этом контексте\nÖte yandan — С другой стороны', examples: ['Bu bağlamda değerlendirmek gerekir.', 'Öte yandan, farklı görüşler var.', 'Sonuç olarak diyebiliriz ki...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Исследование" по-турецки:', options: ['hipotez', 'araştırma', 'bulgu', 'yöntem'], correctIndex: 1, explanation: 'araştırma = исследование'),
        CourseExercise(type: ExerciseType.translation, question: '"В итоге" по-турецки:', options: ['Bu bağlamda', 'Öte yandan', 'Sonuç olarak', 'Buna karşın'], correctIndex: 2, explanation: 'Sonuç olarak = В итоге/В заключение'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Bu ___ değerlendirmek gerekir. (В этом контексте нужно оценить)', options: ['durumda', 'bağlamda', 'aşamada', 'yerde'], correctIndex: 1, explanation: 'bağlamda = в контексте'),
      ],
      exam: [
        ExamQuestion(question: '"Гипотеза" по-турецки:', options: ['teori', 'hipotez', 'tez', 'bulgu'], correctIndex: 1, explanation: 'hipotez = гипотеза'),
        ExamQuestion(question: '"Источник" по-турецки:', options: ['sonuç', 'özet', 'kaynak', 'yöntem'], correctIndex: 2, explanation: 'kaynak = источник'),
        ExamQuestion(question: '"С другой стороны" по-турецки:', options: ['Sonuç olarak', 'Bu bağlamda', 'Öte yandan', 'Buna ek olarak'], correctIndex: 2, explanation: 'Öte yandan = С другой стороны'),
        ExamQuestion(question: '"Вывод/находка" по-турецки:', options: ['hipotez', 'araştırma', 'yöntem', 'bulgu'], correctIndex: 3, explanation: 'bulgu = вывод/находка'),
        ExamQuestion(question: '"Резюме/аннотация" по-турецки:', options: ['sonuç', 'özet', 'giriş', 'tartışma'], correctIndex: 1, explanation: 'özet = резюме/аннотация'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_06', title: 'Edebiyat ve Kültür', subtitle: 'Литература и культура', emoji: '📖',
      level: LanguageLevel.b2, order: 30, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Турецкая литература', content: 'Назим Хикмет — великий поэт\nОрхан Памук — нобелевский лауреат\nроман — roman\nшиир — şiir (поэзия)\nhikaye — рассказ\nedebiyat — литература', examples: ['Orhan Pamuk Nobel ödülü aldı.', 'Şiir okumayı seviyorum.', 'Roman çok etkileyiciydi.']),
        TheorySection(title: 'Литературные термины', content: 'protagonist — başkahraman\nantagonist — karşıt karakter\nmetafor — метафора\nsembol — sembol\ntema — tema\nanlatıcı — рассказчик', examples: ['Romanın teması özgürlük.', 'Güvercin barışın sembolü.', 'Başkahraman zorluklarla mücadele eder.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Поэзия" по-турецки:', options: ['roman', 'hikaye', 'şiir', 'makale'], correctIndex: 2, explanation: 'şiir = поэзия/стихотворение'),
        CourseExercise(type: ExerciseType.translation, question: '"Литература" по-турецки:', options: ['sanat', 'edebiyat', 'kültür', 'tarih'], correctIndex: 1, explanation: 'edebiyat = литература'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Romanın ___ özgürlük. (Тема романа — свобода)', options: ['konusu', 'teması', 'başlığı', 'yazarı'], correctIndex: 1, explanation: 'teması = его тема'),
      ],
      exam: [
        ExamQuestion(question: '"Роман" по-турецки:', options: ['hikaye', 'şiir', 'roman', 'makale'], correctIndex: 2, explanation: 'roman = роман'),
        ExamQuestion(question: '"Рассказ" по-турецки:', options: ['roman', 'hikaye', 'şiir', 'deneme'], correctIndex: 1, explanation: 'hikaye = рассказ'),
        ExamQuestion(question: '"Метафора" по-турецки:', options: ['sembol', 'metafor', 'benzetme', 'deyim'], correctIndex: 1, explanation: 'metafor = метафора'),
        ExamQuestion(question: 'Orhan Pamuk — это:', options: ['поэт', 'музыкант', 'нобелевский лауреат по литературе', 'художник'], correctIndex: 2, explanation: 'Orhan Pamuk получил Нобелевскую премию по литературе в 2006 году'),
        ExamQuestion(question: '"Главный герой" по-турецки:', options: ['anlatıcı', 'yazar', 'başkahraman', 'okuyucu'], correctIndex: 2, explanation: 'başkahraman = главный герой'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_07', title: 'Çevre ve Doğa', subtitle: 'Окружающая среда', emoji: '🌍',
      level: LanguageLevel.b2, order: 31, coinsReward: 45, xpReward: 35,
      theory: [
        TheorySection(title: 'Окружающая среда', content: 'çevre — окружающая среда\nkirlilik — загрязнение\ngeri dönüşüm — переработка\nyenilenebilir enerji — возобновляемая энергия\niklim değişikliği — изменение климата\nesirgemek — беречь', examples: ['Çevreyi koruyalım.', 'Geri dönüşüm önemli.', 'İklim değişikliği tehlike.']),
        TheorySection(title: 'Природа Турции', content: 'Boğaz — Босфор\nKapadokya — Каппадокия\nÇanakkale — Чанаккале\norman — лес\ndeniz — море\ndağ — гора', examples: ['Kapadokya\'ya gittim.', 'İstanbul Boğazı muhteşem.', 'Türkiye\'de ormanlar geniş.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Загрязнение" по-турецки:', options: ['çevre', 'kirlilik', 'atık', 'gürültü'], correctIndex: 1, explanation: 'kirlilik = загрязнение'),
        CourseExercise(type: ExerciseType.translation, question: '"Переработка" по-турецки:', options: ['atık yönetimi', 'geri dönüşüm', 'temizleme', 'yenileme'], correctIndex: 1, explanation: 'geri dönüşüm = переработка'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'İklim ___ büyük tehlike. (Изменение климата — большая опасность)', options: ['kirliliği', 'değişikliği', 'korunması', 'sorunu'], correctIndex: 1, explanation: 'değişikliği = изменение'),
      ],
      exam: [
        ExamQuestion(question: '"Окружающая среда" по-турецки:', options: ['doğa', 'çevre', 'iklim', 'ekosistem'], correctIndex: 1, explanation: 'çevre = окружающая среда'),
        ExamQuestion(question: '"Возобновляемая энергия" по-турецки:', options: ['nükleer enerji', 'fosil yakıt', 'yenilenebilir enerji', 'elektrik'], correctIndex: 2, explanation: 'yenilenebilir enerji = возобновляемая энергия'),
        ExamQuestion(question: '"Изменение климата" по-турецки:', options: ['hava kirliliği', 'iklim değişikliği', 'küresel ısınma', 'sel'], correctIndex: 1, explanation: 'iklim değişikliği = изменение климата'),
        ExamQuestion(question: 'Босфор по-турецки:', options: ['Boğaz', 'Körfez', 'Kanal', 'Nehir'], correctIndex: 0, explanation: 'Boğaz = пролив, Boğaz = Босфор в контексте Стамбула'),
        ExamQuestion(question: '"Беречь/охранять" по-турецки:', options: ['kirletmek', 'kullanmak', 'esirgemek/korumak', 'yok etmek'], correctIndex: 2, explanation: 'korumak/esirgemek = беречь, охранять'),
      ],
    ),

    CourseChapter(
      id: 'tr_b2_08', title: 'Final Sınavı', subtitle: 'Финальный экзамен', emoji: '🏆',
      level: LanguageLevel.b2, order: 32, coinsReward: 100, xpReward: 80,
      theory: [
        TheorySection(title: 'Итоговое повторение', content: 'Вы прошли весь курс турецкого языка!\nКлючевые достижения:\n• Грамматика: времена, залоги, причастия\n• Лексика: 500+ слов\n• Разговорные навыки: диалоги, переписка\n• Культура: история, традиции, идиомы', examples: ['Türkçe konuşabiliyorum!', 'Türk kültürünü anlıyorum.', 'Türkiye\'ye gidebilirim!']),
        TheorySection(title: 'Следующие шаги', content: 'После B2:\n• Смотрите турецкие сериалы без субтитров\n• Читайте турецкие газеты и книги\n• Общайтесь с носителями языка\n• Путешествуйте по Турции\n• Попробуйте уровень C1', examples: ['Dizi izle (смотри сериал)', 'Türk arkadaş edin (заведи турецкого друга)', 'Türkiye\'yi ziyaret et (посети Турцию)']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я могу говорить по-турецки" по-турецки:', options: ['Türkçe biliyorum.', 'Türkçe konuşabiliyorum.', 'Türkçe konuşmalıyım.', 'Türkçe öğreniyorum.'], correctIndex: 1, explanation: 'konuşabiliyorum = я могу говорить (-ebil-)'),
        CourseExercise(type: ExerciseType.translation, question: '"Читающий человек" по-турецки:', options: ['okumuş biri', 'okuyacak biri', 'okuyan biri', 'okuyan adam'], correctIndex: 2, explanation: 'okuyan biri = читающий человек (причастие -an)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Türkiye\'ye ___ istiyorum. (Хочу поехать в Турцию)', options: ['gitmeyi', 'gitmek', 'gideceğim', 'gidiyorum'], correctIndex: 1, explanation: 'gitmek istiyorum = хочу идти/ехать'),
      ],
      exam: [
        ExamQuestion(question: '"Было написано" (пассив прош.) по-турецки:', options: ['yazıyor', 'yazdı', 'yazıldı', 'yazılıyor'], correctIndex: 2, explanation: 'yazıldı = было написано (пассив прош. вр.)'),
        ExamQuestion(question: '"Если придёшь" по-турецки:', options: ['geldiğinde', 'gelirsen', 'gelince', 'geldiğin zaman'], correctIndex: 1, explanation: 'gelirsen = если придёшь (-se условный)'),
        ExamQuestion(question: '"Самый красивый" по-турецки:', options: ['daha güzel', 'çok güzel', 'en güzel', 'güzel kadar'], correctIndex: 2, explanation: 'en güzel = самый красивый (превосходная)'),
        ExamQuestion(question: 'Orhan Pamuk tarafından yazıldı. — смысл:', options: ['Орхан Памук читает.', 'Написано Орханом Памуком.', 'Орхан Памук пишет.', 'Орхан Памук написал.'], correctIndex: 1, explanation: 'tarafından yazıldı = написано кем-то (пассив)'),
        ExamQuestion(question: '"Пришёл бегом" по-турецки:', options: ['Koştu geldi.', 'Koşarak geldi.', 'Koşunca geldi.', 'Koşup geldi.'], correctIndex: 1, explanation: 'koşarak geldi = пришёл бегом (-arak деепричастие)'),
      ],
    ),
  ],
);
