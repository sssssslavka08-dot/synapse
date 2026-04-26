import '../courses/course_structure.dart';

const italianCourse = LanguageCourse(
  langCode: 'it',
  langName: 'Итальянский',
  nativeName: 'Italiano',
  flag: '🇮🇹',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'it_a1_01', title: 'Ciao!', subtitle: 'Приветствия', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Ciao — Привет\nBuongiorno — Доброе утро/день\nBuonasera — Добрый вечер\nArrivederci — До свидания\nA presto — До скорого\nGrazie — Спасибо\nPrego — Пожалуйста', examples: ['Ciao! Come ti chiami?', 'Buongiorno, signore.', 'Arrivederci, a domani!']),
        TheorySection(title: 'Знакомство', content: 'Come ti chiami? — Как тебя зовут?\nMi chiamo ... — Меня зовут ...\nDi dove sei? — Откуда ты?\nSono di ... — Я из ...\nPiacere — Приятно познакомиться', examples: ['Mi chiamo Marco.', 'Sono di Russia.', 'Piacere di conoscerti!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Добрый вечер" по-итальянски:', options: ['Buongiorno', 'Buonasera', 'Buonanotte', 'Ciao'], correctIndex: 1, explanation: 'Buonasera = добрый вечер'),
        CourseExercise(type: ExerciseType.translation, question: '"Как тебя зовут?":', options: ['Come stai?', 'Come ti chiami?', 'Di dove sei?', 'Cosa fai?'], correctIndex: 1, explanation: 'chiamarsi = называться; Come ti chiami?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi ___ Lucia.', options: ['sono', 'chiamo', 'ho', 'vengo'], correctIndex: 1, explanation: 'chiamarsi: mi chiamo'),
      ],
      exam: [
        ExamQuestion(question: '"Спасибо" по-итальянски:', options: ['Prego', 'Scusi', 'Grazie', 'Ciao'], correctIndex: 2, explanation: 'Grazie = спасибо'),
        ExamQuestion(question: 'Sono di Russia = ?', options: ['Я из России', 'Я русский', 'Я живу в России', 'Я еду в Россию'], correctIndex: 0, explanation: 'essere di = быть из'),
        ExamQuestion(question: '"До свидания" по-итальянски:', options: ['Ciao', 'Grazie', 'Prego', 'Arrivederci'], correctIndex: 3, explanation: 'Arrivederci = до свидания'),
        ExamQuestion(question: '"Пожалуйста" по-итальянски:', options: ['Grazie', 'Scusi', 'Arrivederci', 'Prego'], correctIndex: 3, explanation: 'Prego = пожалуйста'),
        ExamQuestion(question: '"Приятно познакомиться":', options: ['Grazie', 'Ciao', 'Piacere', 'Bene'], correctIndex: 2, explanation: 'Piacere = приятно (познакомиться)'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_02', title: 'Numeri e colori', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Числа 1–20', content: '1-uno, 2-due, 3-tre, 4-quattro, 5-cinque\n6-sei, 7-sette, 8-otto, 9-nove, 10-dieci\n11-undici, 12-dodici, 13-tredici, 20-venti', examples: ['Ho venti anni.', 'Sono le cinque.', 'Numero uno.']),
        TheorySection(title: 'Цвета', content: 'rosso — красный\nblu — синий\nverde — зелёный\ngiallo — жёлтый\nbianco — белый\nnero — чёрный\narancione — оранжевый', examples: ['Il cielo è blu.', 'La mela è rossa.', 'Mi piace il nero.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Синий" по-итальянски:', options: ['rosso', 'verde', 'blu', 'giallo'], correctIndex: 2, explanation: 'blu = синий'),
        CourseExercise(type: ExerciseType.translation, question: '7 по-итальянски:', options: ['sei', 'sette', 'otto', 'nove'], correctIndex: 1, explanation: 'sette = 7'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il cielo è ___. (синий)', options: ['rosso', 'verde', 'blu', 'nero'], correctIndex: 2, explanation: 'Il cielo (небо) è blu'),
      ],
      exam: [
        ExamQuestion(question: '12 по-итальянски:', options: ['undici', 'dodici', 'tredici', 'quattordici'], correctIndex: 1, explanation: 'dodici = 12'),
        ExamQuestion(question: '"Зелёный" по-итальянски:', options: ['rosso', 'blu', 'verde', 'giallo'], correctIndex: 2, explanation: 'verde = зелёный'),
        ExamQuestion(question: '20 по-итальянски:', options: ['dieci', 'quindici', 'venti', 'trenta'], correctIndex: 2, explanation: 'venti = 20'),
        ExamQuestion(question: '"Чёрный" по-итальянски:', options: ['bianco', 'grigio', 'marrone', 'nero'], correctIndex: 3, explanation: 'nero = чёрный'),
        ExamQuestion(question: '5 по-итальянски:', options: ['quattro', 'cinque', 'sei', 'sette'], correctIndex: 1, explanation: 'cinque = 5'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_03', title: 'Famiglia e casa', subtitle: 'Семья и дом', emoji: '🏠',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Семья', content: 'la madre — мама\nil padre — папа\nla sorella — сестра\nil fratello — брат\nla nonna — бабушка\nil nonno — дедушка\ni figli — дети', examples: ['Mia madre si chiama Maria.', 'Ho due fratelli.', 'Mio padre lavora.']),
        TheorySection(title: 'Артикли', content: 'il (муж.р. ед.ч.) — il padre, il fratello\nla (жен.р. ед.ч.) — la madre, la sorella\ni/le (мн.ч.) — i figli, le sorelle\nун/una — неопределённый артикль', examples: ['il libro — книга', 'la casa — дом', 'i bambini — дети']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сестра" по-итальянски:', options: ['fratello', 'sorella', 'figlia', 'donna'], correctIndex: 1, explanation: 'la sorella = сестра'),
        CourseExercise(type: ExerciseType.translation, question: '"Мой папа работает":', options: ['Mio padre mangia.', 'Mio padre lavora.', 'Mio padre dorme.', 'Mio padre parla.'], correctIndex: 1, explanation: 'lavorare = работать; lui lavora'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ho ___ fratello.', options: ['una', 'il', 'un', 'i'], correctIndex: 2, explanation: 'un = неопр.арт. муж.р.'),
      ],
      exam: [
        ExamQuestion(question: '"Дедушка" по-итальянски:', options: ['nonna', 'nonno', 'padre', 'zio'], correctIndex: 1, explanation: 'il nonno = дедушка'),
        ExamQuestion(question: 'Артикль "casa" (дом):', options: ['il', 'la', 'i', 'un'], correctIndex: 1, explanation: 'la casa — женский род'),
        ExamQuestion(question: '"Дети" по-итальянски:', options: ['figlie', 'figli/bambini', 'bebè', 'ragazzi'], correctIndex: 1, explanation: 'i figli = дети или i bambini'),
        ExamQuestion(question: '"Брат" по-итальянски:', options: ['padre', 'figlio', 'fratello', 'zio'], correctIndex: 2, explanation: 'il fratello = брат'),
        ExamQuestion(question: 'Mia madre ___ Maria.', options: ['è', 'si chiama', 'ha', 'viene'], correctIndex: 1, explanation: 'chiamarsi: si chiama'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_04', title: 'Cibo e bevande', subtitle: 'Еда и напитки', emoji: '🍕',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'il pane — хлеб\nil formaggio — сыр\nla carne — мясо\nle verdure — овощи\nla frutta — фрукты\nla pasta — паста\nla pizza — пицца', examples: ['Mangio la pasta.', 'Mi piace la pizza.', 'La pizza è italiana.']),
        TheorySection(title: 'Напитки', content: 'l\'acqua — вода\nil caffè — кофе\nil tè — чай\nil latte — молоко\nil succo — сок\nla birra — пиво', examples: ['Bevo un caffè.', 'Vuoi tè o caffè?', 'Un bicchiere d\'acqua, per favore.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Хлеб" по-итальянски:', options: ['formaggio', 'pane', 'carne', 'riso'], correctIndex: 1, explanation: 'il pane = хлеб'),
        CourseExercise(type: ExerciseType.translation, question: '"Я пью кофе":', options: ['Mangio il caffè.', 'Bevo un caffè.', 'Prendo caffè.', 'b e c sono corretti'], correctIndex: 3, explanation: 'bere/prendere = пить; оба верны в итальянском'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi ___ la pizza. (нравится)', options: ['piace', 'piaccio', 'piacete', 'piacciono'], correctIndex: 0, explanation: 'piacere: mi piace (ед.ч.)'),
      ],
      exam: [
        ExamQuestion(question: '"Молоко" по-итальянски:', options: ['acqua', 'succo', 'latte', 'birra'], correctIndex: 2, explanation: 'il latte = молоко'),
        ExamQuestion(question: '"Овощи" по-итальянски:', options: ['frutta', 'verdure', 'carne', 'pane'], correctIndex: 1, explanation: 'le verdure = овощи'),
        ExamQuestion(question: 'Vuoi tè ___ caffè?', options: ['e', 'o', 'ma', 'con'], correctIndex: 1, explanation: 'o = или'),
        ExamQuestion(question: '"Сок" по-итальянски:', options: ['acqua', 'latte', 'succo', 'tè'], correctIndex: 2, explanation: 'il succo = сок'),
        ExamQuestion(question: '"Паста" — это:', options: ['пицца', 'хлеб', 'макаронные изделия', 'рис'], correctIndex: 2, explanation: 'la pasta = макаронные изделия (паста)'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_05', title: 'Corpo e salute', subtitle: 'Тело и здоровье', emoji: '💪',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Части тела', content: 'la testa — голова\nl\'occhio — глаз\nil naso — нос\nla bocca — рот\nil braccio — рука\nla mano — кисть\nla gamba — нога\nil piede — ступня', examples: ['Mi fa male la testa.', 'Ho gli occhi azzurri.', 'Mi fa male la mano.']),
        TheorySection(title: 'Самочувствие', content: 'Come stai? — Как ты?\nSto bene. — Я в порядке.\nSono malato/a. — Я болен/больна.\nMi fa male ... — У меня болит ...\nHo la febbre. — У меня температура.', examples: ['Sto molto bene, grazie.', 'Mi fa male la schiena.', 'Lui è malato oggi.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Голова" по-итальянски:', options: ['mano', 'gamba', 'testa', 'braccio'], correctIndex: 2, explanation: 'la testa = голова'),
        CourseExercise(type: ExerciseType.translation, question: '"Я болен":', options: ['Sto bene.', 'Sono malato.', 'Mi fa male.', 'Ho freddo.'], correctIndex: 1, explanation: 'malato/a = больной/больная'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi fa male ___ testa.', options: ['il', 'la', 'mia', 'un'], correctIndex: 1, explanation: 'la testa (жен.р.)'),
      ],
      exam: [
        ExamQuestion(question: '"Нога" по-итальянски:', options: ['braccio', 'mano', 'piede', 'gamba'], correctIndex: 3, explanation: 'la gamba = нога; il piede = ступня'),
        ExamQuestion(question: 'Come stai? = ?', options: ['Как тебя зовут?', 'Откуда ты?', 'Как ты?', 'Что делаешь?'], correctIndex: 2, explanation: 'Come stai? = Как ты?'),
        ExamQuestion(question: '"Температура" по-итальянски:', options: ['dolore', 'febbre', 'raffreddore', 'tosse'], correctIndex: 1, explanation: 'la febbre = температура/жар'),
        ExamQuestion(question: '"Нос" по-итальянски:', options: ['occhio', 'bocca', 'naso', 'orecchio'], correctIndex: 2, explanation: 'il naso = нос'),
        ExamQuestion(question: 'Sto ___. (в порядке)', options: ['male', 'malato', 'bene', 'stanco'], correctIndex: 2, explanation: 'bene = хорошо/в порядке'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_06', title: 'Tempo e calendario', subtitle: 'Время и календарь', emoji: '🕐',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'lunedì — понедельник\nmartedì — вторник\nmercoledì — среда\ngiovedì — четверг\nvenerdì — пятница\nsabato — суббота\ndomenica — воскресенье', examples: ['Oggi è lunedì.', 'Il venerdì ho lezione.', 'La domenica mi riposo.']),
        TheorySection(title: 'Время', content: 'Che ore sono? — Который час?\nSono le ... — Сейчас ...\nÈ l\'una. — Сейчас час.\ndi mattina — утром\ndi sera — вечером\ndi notte — ночью', examples: ['Sono le nove.', 'Di mattina bevo il caffè.', 'Di sera leggo.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пятница" по-итальянски:', options: ['giovedì', 'venerdì', 'sabato', 'domenica'], correctIndex: 1, explanation: 'venerdì = пятница'),
        CourseExercise(type: ExerciseType.translation, question: '"Который час?":', options: ['Che giorno è?', 'Che ore sono?', 'Quando parti?', 'Quanto costa?'], correctIndex: 1, explanation: 'Che ore sono? = Который час?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Oggi ___ mercoledì.', options: ['sono', 'ho', 'è', 'fa'], correctIndex: 2, explanation: 'essere: oggi è (дни с essere)'),
      ],
      exam: [
        ExamQuestion(question: '"Воскресенье" по-итальянски:', options: ['sabato', 'domenica', 'venerdì', 'lunedì'], correctIndex: 1, explanation: 'domenica = воскресенье'),
        ExamQuestion(question: 'Sono le ___. (9 часов)', options: ['sette', 'otto', 'nove', 'dieci'], correctIndex: 2, explanation: 'nove = 9'),
        ExamQuestion(question: '"Вечером" по-итальянски:', options: ['di mattina', 'di pomeriggio', 'di sera', 'di notte'], correctIndex: 2, explanation: 'di sera = вечером'),
        ExamQuestion(question: '"Понедельник" по-итальянски:', options: ['martedì', 'lunedì', 'mercoledì', 'giovedì'], correctIndex: 1, explanation: 'lunedì = понедельник'),
        ExamQuestion(question: 'È ___ una. (один час)', options: ['le', 'l\'', 'la', 'il'], correctIndex: 1, explanation: 'È l\'una — только для 1 часа (l\' перед гласной)'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_07', title: 'Animali e natura', subtitle: 'Животные и природа', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Животные', content: 'il cane — собака\nil gatto — кошка\nil cavallo — лошадь\nl\'uccello — птица\nil pesce — рыба\nil lupo — волк\nl\'orso — медведь', examples: ['Ho un cane.', 'Il gatto è piccolo.', 'Il cavallo è grande.']),
        TheorySection(title: 'Природа', content: 'l\'albero — дерево\nil fiore — цветок\nil mare — море\nla montagna — гора\nil fiume — река\nil bosco — лес\nil cielo — небо', examples: ['Il mare è blu.', 'Il fiore è rosa.', 'Il bosco è verde.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-итальянски:', options: ['cane', 'gatto', 'cavallo', 'uccello'], correctIndex: 1, explanation: 'il gatto = кот/кошка'),
        CourseExercise(type: ExerciseType.translation, question: '"Лес" по-итальянски:', options: ['mare', 'montagna', 'bosco', 'fiume'], correctIndex: 2, explanation: 'il bosco = лес'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il ___ è blu. (море)', options: ['bosco', 'fiume', 'mare', 'lago'], correctIndex: 2, explanation: 'il mare = море (муж.р.)'),
      ],
      exam: [
        ExamQuestion(question: '"Птица" по-итальянски:', options: ['pesce', 'uccello', 'gatto', 'lupo'], correctIndex: 1, explanation: 'l\'uccello = птица'),
        ExamQuestion(question: '"Цветок" по-итальянски:', options: ['albero', 'fiore', 'erba', 'foglia'], correctIndex: 1, explanation: 'il fiore = цветок'),
        ExamQuestion(question: 'Артикль "cane" (собака):', options: ['la', 'il', 'i', 'un'], correctIndex: 1, explanation: 'il cane = собака (муж.р.)'),
        ExamQuestion(question: '"Небо" по-итальянски:', options: ['terra', 'mare', 'cielo', 'nuvola'], correctIndex: 2, explanation: 'il cielo = небо'),
        ExamQuestion(question: '"Гора" по-итальянски:', options: ['fiume', 'bosco', 'mare', 'montagna'], correctIndex: 3, explanation: 'la montagna = гора'),
      ],
    ),

    CourseChapter(
      id: 'it_a1_08', title: 'Verbi essenziali', subtitle: 'Основные глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Спряжение -are глаголов', content: 'io -o, tu -i, lui/lei -a\nnoi -iamo, voi -ate, loro -ano\nparlare: parlo, parli, parla\nparlìamo, parlate, parlano', examples: ['Io parlo italiano.', 'Tu lavori molto.', 'Noi abitiamo a Roma.']),
        TheorySection(title: 'Essere и avere', content: 'essere (быть): sono, sei, è, siamo, siete, sono\navere (иметь): ho, hai, ha, abbiamo, avete, hanno', examples: ['Sono studente.', 'Sei italiana?', 'Ho due gatti.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'lui ___ (parlare)', options: ['parlo', 'parli', 'parla', 'parlano'], correctIndex: 2, explanation: 'parlare: lui parla'),
        CourseExercise(type: ExerciseType.translation, question: '"Я студент":', options: ['Ho studente.', 'Sono studente.', 'Faccio studente.', 'Abito studente.'], correctIndex: 1, explanation: 'essere: sono'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Noi ___ a Roma. (abitare)', options: ['abitate', 'abitano', 'abitiamo', 'abita'], correctIndex: 2, explanation: 'abitare: noi abitiamo'),
      ],
      exam: [
        ExamQuestion(question: 'io ___ (avere)', options: ['è', 'hai', 'ho', 'abbiamo'], correctIndex: 2, explanation: 'avere: io ho'),
        ExamQuestion(question: 'voi ___ (essere)', options: ['siamo', 'siete', 'sono', 'sei'], correctIndex: 1, explanation: 'essere: voi siete'),
        ExamQuestion(question: '"Говорить" по-итальянски:', options: ['mangiare', 'abitare', 'parlare', 'lavorare'], correctIndex: 2, explanation: 'parlare = говорить'),
        ExamQuestion(question: 'loro ___ (mangiare)', options: ['mangia', 'mangi', 'mangiamo', 'mangiano'], correctIndex: 3, explanation: 'mangiare: loro mangiano'),
        ExamQuestion(question: 'tu ___ (essere)', options: ['è', 'siete', 'sei', 'sono'], correctIndex: 2, explanation: 'essere: tu sei'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'it_a2_01', title: 'Presente irregolare', subtitle: 'Неправильное настоящее', emoji: '📝',
      level: LanguageLevel.a2, order: 1, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Неправильные глаголы', content: 'andare: vado, vai, va, andiamo\nvenire: vengo, vieni, viene\nfare: faccio, fai, fa, facciamo\nuscire: esco, esci, esce\ndovere: devo, devi, deve\nvolere: voglio, vuoi, vuole', examples: ['Vado al cinema.', 'Cosa fai stasera?', 'Voglio imparare l\'italiano.']),
        TheorySection(title: 'Рефлексивные глаголы', content: 'alzarsi — вставать: mi alzo\nchimarsi — называться: mi chiamo\naddormentarsi — засыпать: mi addormento\nlavarsi — мыться: mi lavo', examples: ['Mi alzo alle sette.', 'Lei si addormenta presto.', 'Ci laviamo la mattina.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'lui ___ (andare)', options: ['vay', 'va', 'vai', 'andiamo'], correctIndex: 1, explanation: 'andare: lui va'),
        CourseExercise(type: ExerciseType.translation, question: '"Я хочу учить итальянский":', options: ['Posso imparare l\'italiano.', 'Voglio imparare l\'italiano.', 'Devo imparare l\'italiano.', 'Vado a imparare l\'italiano.'], correctIndex: 1, explanation: 'volere = хотеть: voglio'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi ___ alle sette. (alzarsi)', options: ['alza', 'alzo', 'alzi', 'alziamo'], correctIndex: 1, explanation: 'alzarsi: mi alzo'),
      ],
      exam: [
        ExamQuestion(question: 'io ___ (fare)', options: ['fai', 'fa', 'faccio', 'facciamo'], correctIndex: 2, explanation: 'fare: io faccio'),
        ExamQuestion(question: 'tu ___ (venire)', options: ['venite', 'vieni', 'viene', 'veniamo'], correctIndex: 1, explanation: 'venire: tu vieni'),
        ExamQuestion(question: '"Выходить" по-итальянски:', options: ['andare', 'venire', 'uscire', 'partire'], correctIndex: 2, explanation: 'uscire = выходить'),
        ExamQuestion(question: 'loro ___ (andare)', options: ['vanno', 'andate', 'andiamo', 'va'], correctIndex: 0, explanation: 'andare: loro vanno'),
        ExamQuestion(question: 'lei ___ (fare)', options: ['faccio', 'fai', 'fa', 'fanno'], correctIndex: 2, explanation: 'fare: lei fa'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_02', title: 'Trasporti e viaggi', subtitle: 'Транспорт', emoji: '✈️',
      level: LanguageLevel.a2, order: 2, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Транспорт', content: 'la macchina — машина\nl\'autobus — автобус\nla metropolitana — метро\nil treno — поезд\nl\'aereo — самолёт\nla bicicletta — велосипед\na piedi — пешком', examples: ['Prendo la metro.', 'Il treno arriva alle dieci.', 'Andiamo in aereo.']),
        TheorySection(title: 'Предлоги', content: 'in + транспорт: in macchina, in aereo\na piedi — пешком\nandare a/in — ехать в\nda ... a ... — от ... до ...', examples: ['Vado in macchina.', 'Viaggiamo in aereo.', 'Da Roma a Milano.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-итальянски:', options: ['treno', 'nave', 'aereo', 'autobus'], correctIndex: 2, explanation: 'l\'aereo = самолёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Я еду на машине":', options: ['Vado a piedi.', 'Prendo l\'autobus.', 'Vado in macchina.', 'Prendo il treno.'], correctIndex: 2, explanation: 'in macchina = на машине'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il treno ___ alle dieci.', options: ['viene', 'arriva', 'entra', 'passa'], correctIndex: 1, explanation: 'arrivare = прибывать'),
      ],
      exam: [
        ExamQuestion(question: '"Велосипед" по-итальянски:', options: ['moto', 'bicicletta', 'macchina', 'autobus'], correctIndex: 1, explanation: 'la bicicletta = велосипед'),
        ExamQuestion(question: 'Vado ___ macchina.', options: ['a', 'in', 'con', 'per'], correctIndex: 1, explanation: 'in macchina = на машине'),
        ExamQuestion(question: '"Метро" по-итальянски:', options: ['tram', 'metropolitana', 'treno', 'autobus'], correctIndex: 1, explanation: 'la metropolitana = метро'),
        ExamQuestion(question: '"Пешком" по-итальянски:', options: ['in macchina', 'a piedi', 'in bus', 'in bici'], correctIndex: 1, explanation: 'a piedi = пешком'),
        ExamQuestion(question: 'Il treno ___ alle dieci.', options: ['parte', 'arriva', 'viene', 'entra'], correctIndex: 1, explanation: 'arrivare = прибывать'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_03', title: 'Il tempo atmosferico', subtitle: 'Погода', emoji: '☀️',
      level: LanguageLevel.a2, order: 3, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'C\'è il sole. — Солнечно.\nFa caldo/freddo. — Жарко/Холодно.\nPiove. — Идёт дождь.\nNevica. — Идёт снег.\nC\'è vento. — Ветрено.\nÈ nuvoloso. — Облачно.', examples: ['Oggi c\'è il sole.', 'In inverno nevica.', 'C\'è molto vento oggi.']),
        TheorySection(title: 'Сезоны', content: 'la primavera — весна\nl\'estate — лето\nl\'autunno — осень\nl\'inverno — зима\nin primavera — весной\nd\'estate — летом', examples: ['D\'estate fa caldo.', 'D\'inverno fa freddo.', 'In autunno piove molto.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Идёт снег" по-итальянски:', options: ['Piove.', 'Nevica.', 'Fa freddo.', 'C\'è vento.'], correctIndex: 1, explanation: 'Nevica. = идёт снег (nevicare)'),
        CourseExercise(type: ExerciseType.translation, question: '"Зима" по-итальянски:', options: ['primavera', 'autunno', 'inverno', 'estate'], correctIndex: 2, explanation: 'l\'inverno = зима'),
        CourseExercise(type: ExerciseType.fillBlank, question: '_\'estate fa caldo.', options: ['In', 'D', 'A', 'Per'], correctIndex: 1, explanation: 'd\'estate = летом'),
      ],
      exam: [
        ExamQuestion(question: '"Весна" по-итальянски:', options: ['inverno', 'autunno', 'primavera', 'estate'], correctIndex: 2, explanation: 'la primavera = весна'),
        ExamQuestion(question: 'Oggi ___. (снег)', options: ['piove', 'nevica', 'fa vento', 'cade'], correctIndex: 1, explanation: 'nevicare: nevica = идёт снег'),
        ExamQuestion(question: '"Облачно" по-итальянски:', options: ['c\'è vento', 'c\'è il sole', 'è nuvoloso', 'fa nebbia'], correctIndex: 2, explanation: 'è nuvoloso = облачно'),
        ExamQuestion(question: '"Осень" по-итальянски:', options: ['primavera', 'estate', 'autunno', 'inverno'], correctIndex: 2, explanation: 'l\'autunno = осень'),
        ExamQuestion(question: '"Жарко" по-итальянски:', options: ['Fa freddo.', 'Fa caldo.', 'C\'è vento.', 'È nuvoloso.'], correctIndex: 1, explanation: 'Fa caldo. = жарко'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_04', title: 'Vestiti e shopping', subtitle: 'Одежда и шопинг', emoji: '👗',
      level: LanguageLevel.a2, order: 4, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'la camicia — рубашка\ni pantaloni — брюки\nla gonna — юбка\nil vestito — платье\nil cappotto — пальто\nle scarpe — обувь\nil maglione — свитер', examples: ['Porto un vestito rosso.', 'Lui compra un cappotto.', 'Queste scarpe sono care.']),
        TheorySection(title: 'Покупки', content: 'Quanto costa? — Сколько стоит?\nCosta ... euro. — Стоит ... евро.\nVorrei ... — Я бы хотел/а ...\nAvete questo in taglia ...? — Есть это в размере ...?', examples: ['Quanto costa questo vestito?', 'Vorrei provare questo cappotto.', 'Avete questo in taglia M?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Платье" по-итальянски:', options: ['gonna', 'vestito', 'camicia', 'maglione'], correctIndex: 1, explanation: 'il vestito = платье'),
        CourseExercise(type: ExerciseType.translation, question: '"Сколько стоит?":', options: ['Cos\'è questo?', 'Quanto costa?', 'Com\'è questo?', 'Quale taglia?'], correctIndex: 1, explanation: 'costare: Quanto costa?'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ provare questo maglione. (хотел бы)', options: ['Voglio', 'Vorrei', 'Posso', 'Devo'], correctIndex: 1, explanation: 'vorrei = хотел бы (condizionale)'),
      ],
      exam: [
        ExamQuestion(question: '"Брюки" по-итальянски:', options: ['gonna', 'vestito', 'pantaloni', 'camicia'], correctIndex: 2, explanation: 'i pantaloni = брюки'),
        ExamQuestion(question: 'Quanto ___? (стоит)', options: ['è', 'costa', 'vale', 'b e c sono corretti'], correctIndex: 3, explanation: 'costare e valere = стоить; оба используются'),
        ExamQuestion(question: '"Пальто" по-итальянски:', options: ['giacca', 'cappotto', 'maglione', 'giubbotto'], correctIndex: 1, explanation: 'il cappotto = пальто'),
        ExamQuestion(question: '"Размер" по-итальянски:', options: ['colore', 'prezzo', 'taglia', 'stile'], correctIndex: 2, explanation: 'la taglia = размер одежды'),
        ExamQuestion(question: '"Обувь" по-итальянски:', options: ['calzini', 'scarpe', 'stivali', 'sandali'], correctIndex: 1, explanation: 'le scarpe = обувь/туфли'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_05', title: 'Hobby e sport', subtitle: 'Хобби и спорт', emoji: '⚽',
      level: LanguageLevel.a2, order: 5, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Хобби', content: 'leggere — читать\nascoltare musica — слушать музыку\nviaggiare — путешествовать\ncucinare — готовить\ndipingere — рисовать\ngiocare ai videogiochi — играть в игры', examples: ['Mi piace leggere romanzi.', 'Lei ascolta musica la sera.', 'Viaggiamo ogni estate.']),
        TheorySection(title: 'Спорт', content: 'giocare a calcio — играть в футбол\nnuotare — плавать\ncorrere — бегать\nandare in bicicletta — кататься на велосипеде\nsciare — кататься на лыжах\nfare yoga — заниматься йогой', examples: ['Lui gioca a tennis.', 'Nuoto la domenica.', 'Lei fa yoga ogni giorno.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Плавать" по-итальянски:', options: ['correre', 'nuotare', 'saltare', 'camminare'], correctIndex: 1, explanation: 'nuotare = плавать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я играю в футбол":', options: ['Guardo il calcio.', 'Gioco a calcio.', 'Faccio calcio.', 'Mi piace il calcio.'], correctIndex: 1, explanation: 'giocare a calcio = играть в футбол'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi piace ___ musica. (слушать)', options: ['giocare', 'ascoltare', 'fare', 'guardare'], correctIndex: 1, explanation: 'ascoltare musica = слушать музыку'),
      ],
      exam: [
        ExamQuestion(question: '"Готовить" по-итальянски:', options: ['mangiare', 'cucinare', 'servire', 'assaggiare'], correctIndex: 1, explanation: 'cucinare = готовить'),
        ExamQuestion(question: 'Gioco ___ tennis.', options: ['di', 'a', 'con', 'il'], correctIndex: 1, explanation: 'giocare a (вид спорта)'),
        ExamQuestion(question: '"Читать" по-итальянски:', options: ['scrivere', 'parlare', 'leggere', 'imparare'], correctIndex: 2, explanation: 'leggere = читать'),
        ExamQuestion(question: '"Путешествовать" по-итальянски:', options: ['camminare', 'viaggiare', 'uscire', 'esplorare'], correctIndex: 1, explanation: 'viaggiare = путешествовать'),
        ExamQuestion(question: '"Бегать" по-итальянски:', options: ['camminare', 'nuotare', 'correre', 'saltare'], correctIndex: 2, explanation: 'correre = бегать'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_06', title: 'Lavoro e studio', subtitle: 'Работа и учёба', emoji: '💼',
      level: LanguageLevel.a2, order: 6, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Профессии', content: 'il medico — врач\nil professore — учитель\nl\'ingegnere — инженер\nil cuoco — повар\nil programmatore — программист\nl\'avvocato — адвокат', examples: ['Sono medico.', 'Lei è professoressa.', 'Lavora come ingegnere.']),
        TheorySection(title: 'Учёба', content: 'la scuola — школa\nl\'università — университет\nimparare — учить/узнавать\nstudiare — изучать\nl\'esame — экзамен\nla materia — предмет', examples: ['Imparo l\'italiano.', 'Studia medicina.', 'Domani ho un esame.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Учитель" (жен.) по-итальянски:', options: ['medica', 'avvocata', 'professoressa', 'ingegnera'], correctIndex: 2, explanation: 'la professoressa = учительница'),
        CourseExercise(type: ExerciseType.translation, question: '"Она изучает медицину":', options: ['È medica.', 'Studia medicina.', 'Impara medicina.', 'Lavora come medica.'], correctIndex: 1, explanation: 'studiare = изучать'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Domani ho ___ esame.', options: ['la', 'il', 'un', 'una'], correctIndex: 2, explanation: 'un esame (муж.р., неопр.арт.)'),
      ],
      exam: [
        ExamQuestion(question: '"Программист" по-итальянски:', options: ['medico', 'avvocato', 'programmatore', 'ingegnere'], correctIndex: 2, explanation: 'il programmatore = программист'),
        ExamQuestion(question: 'Imparo ___. (итальянский)', options: ['italiano', 'italiano', 'la lingua', 'l\'italiano'], correctIndex: 3, explanation: 'imparare l\'italiano = учить итальянский'),
        ExamQuestion(question: '"Предмет" (школьный) по-итальянски:', options: ['libro', 'classe', 'materia', 'lezione'], correctIndex: 2, explanation: 'la materia = учебный предмет'),
        ExamQuestion(question: '"Адвокат" по-итальянски:', options: ['medico', 'giudice', 'avvocato', 'notaio'], correctIndex: 2, explanation: 'l\'avvocato = адвокат'),
        ExamQuestion(question: 'Lavora ___ ingegnere.', options: ['come', 'da', 'per', 'a e b sono corretti'], correctIndex: 3, explanation: 'lavorare come/da = работать как'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_07', title: 'Descrivere persone', subtitle: 'Описание людей', emoji: '🧑',
      level: LanguageLevel.a2, order: 7, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Внешность', content: 'alto/basso — высокий/низкий\ngrasso/magro — толстый/худой\nbiondo — светловолосый\nbruno — темноволосый\nocchi azzurri — голубые глаза\ngiovane/vecchio — молодой/старый', examples: ['È alto e ha gli occhi azzurri.', 'Lei è bionda.', 'Mio nonno è vecchio ma attivo.']),
        TheorySection(title: 'Характер', content: 'simpatico — симпатичный\ndivertente — весёлый\ncalmo — спокойный\nlavoratore — трудолюбивый\nintelligente — умный\ngentile — вежливый', examples: ['La mia prof è molto simpatica.', 'Lui è divertente e gentile.', 'È lavoratrice e intelligente.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Высокий" по-итальянски:', options: ['basso', 'magro', 'alto', 'grasso'], correctIndex: 2, explanation: 'alto = высокий'),
        CourseExercise(type: ExerciseType.translation, question: '"Он весёлый и умный":', options: ['È calmo e intelligente.', 'È divertente e intelligente.', 'È simpatico e gentile.', 'È lavoratore e alto.'], correctIndex: 1, explanation: 'divertente = весёлый; intelligente = умный'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ha i capelli ___. (тёмные)', options: ['biondi', 'rossi', 'bruni', 'lunghi'], correctIndex: 2, explanation: 'capelli bruni = тёмные волосы'),
      ],
      exam: [
        ExamQuestion(question: '"Трудолюбивый" по-итальянски:', options: ['divertente', 'calmo', 'lavoratore', 'simpatico'], correctIndex: 2, explanation: 'lavoratore = трудолюбивый'),
        ExamQuestion(question: '"Худой/стройный" по-итальянски:', options: ['grasso', 'basso', 'alto', 'magro'], correctIndex: 3, explanation: 'magro = худой/стройный'),
        ExamQuestion(question: 'Ha gli occhi ___. (голубые)', options: ['verdi', 'marroni', 'azzurri', 'neri'], correctIndex: 2, explanation: 'gli occhi azzurri = голубые глаза'),
        ExamQuestion(question: '"Спокойный" по-итальянски:', options: ['divertente', 'intelligente', 'calmo', 'simpatico'], correctIndex: 2, explanation: 'calmo = спокойный'),
        ExamQuestion(question: '"Молодой" по-итальянски:', options: ['vecchio', 'nuovo', 'giovane', 'moderno'], correctIndex: 2, explanation: 'giovane = молодой'),
      ],
    ),

    CourseChapter(
      id: 'it_a2_08', title: 'Futuro', subtitle: 'Будущее время', emoji: '🔮',
      level: LanguageLevel.a2, order: 8, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Futuro semplice', content: 'Образование: основа + -ò, -ai, -à, -emo, -ete, -anno\nparlare → parlerò, parlerai, parlerà\nessere: sarò; avere: avrò\nandare: andrò; fare: farò', examples: ['Domani parlerò con il direttore.', 'Lei sarà medica.', 'Andremo in Italia.']),
        TheorySection(title: 'Будущее в разговорной речи', content: 'Presente используется для ближайшего будущего:\nDomani vado al cinema.\nIl futuro semplice = также предположение:\nSarà in casa. — Наверное, он дома.', examples: ['Stasera resto a casa.', 'Sarà stanco. (наверное)', 'L\'anno prossimo studio in Italia.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Завтра я поговорю" (futuro):', options: ['Parlo.', 'Parlerò.', 'Ho parlato.', 'Parlavo.'], correctIndex: 1, explanation: 'futuro: parlerò'),
        CourseExercise(type: ExerciseType.translation, question: '"Она станет врачом":', options: ['È medica.', 'Sarà medica.', 'Era medica.', 'Diventa medica.'], correctIndex: 1, explanation: 'essere futuro: sarà'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Andremo ___ Italia.', options: ['a', 'in', 'di', 'per'], correctIndex: 1, explanation: 'in + paese = в стране (без артикля)'),
      ],
      exam: [
        ExamQuestion(question: 'io ___ (parlare, futuro)', options: ['parlo', 'parlavo', 'parlerò', 'parlerà'], correctIndex: 2, explanation: 'futuro: parlerò'),
        ExamQuestion(question: 'fare → futuro (io):', options: ['farò', 'faccio', 'facevo', 'farei'], correctIndex: 0, explanation: 'fare → farò (неправильный futuro)'),
        ExamQuestion(question: '"Завтра" по-итальянски:', options: ['ieri', 'oggi', 'domani', 'presto'], correctIndex: 2, explanation: 'domani = завтра'),
        ExamQuestion(question: 'andare → futuro (noi):', options: ['andiamo', 'andavamo', 'andremo', 'andremmo'], correctIndex: 2, explanation: 'andare → andremo'),
        ExamQuestion(question: 'essere → futuro (lei):', options: ['è', 'era', 'sarà', 'sia'], correctIndex: 2, explanation: 'essere futuro: sarà'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'it_b1_01', title: 'Passato prossimo', subtitle: 'Прошедшее время', emoji: '📚',
      level: LanguageLevel.b1, order: 1, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Passato prossimo с avere', content: 'avere + participio passato\nparlare → parlato\nmangiare → mangiato\nvedere → visto\nfaire → fatto\nprendere → preso', examples: ['Ho mangiato la pizza.', 'Lei ha finito il lavoro.', 'Abbiamo visto un film.']),
        TheorySection(title: 'Passato prossimo с essere', content: 'Глаголы движения + рефлексивные:\nandare: sono andato/a\nvenire: sono venuto/a\nnascere, morire, partire, arrivare\nСогласование с субъектом!', examples: ['Lei è andata al cinema.', 'Sono arrivati ieri.', 'Mi sono alzato alle 7.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Participio passato от "mangiare":', options: ['mangiato', 'mangiuto', 'mangiando', 'mangiare'], correctIndex: 0, explanation: 'mangiare → mangiato'),
        CourseExercise(type: ExerciseType.translation, question: '"Она пошла в кино":', options: ['Ha andata al cinema.', 'È andata al cinema.', 'Andava al cinema.', 'Va al cinema.'], correctIndex: 1, explanation: 'andare = essere: è andata (согласование — а)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Abbiamo ___ un film. (vedere)', options: ['visto', 'veduto', 'vedendo', 'vedere'], correctIndex: 0, explanation: 'vedere → visto'),
      ],
      exam: [
        ExamQuestion(question: 'fare → participio passato:', options: ['fatto', 'facendo', 'facito', 'fare'], correctIndex: 0, explanation: 'fare → fatto'),
        ExamQuestion(question: 'Loro ___ partiti ieri. (partire)', options: ['hanno', 'sono', 'abbiamo', 'siete'], correctIndex: 1, explanation: 'partire = essere: sono partiti'),
        ExamQuestion(question: 'vedere → participio passato:', options: ['veduto', 'visto', 'vedere', 'vedendo'], correctIndex: 1, explanation: 'vedere → visto (неправильный)'),
        ExamQuestion(question: 'Lei ___ mangiato.', options: ['è', 'ha', 'ho', 'abbiamo'], correctIndex: 1, explanation: 'avere: lei ha'),
        ExamQuestion(question: 'prendere → participio passato:', options: ['prenduto', 'preso', 'prendendo', 'prendere'], correctIndex: 1, explanation: 'prendere → preso'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_02', title: 'Imperfetto', subtitle: 'Незаконченное прошедшее', emoji: '⏪',
      level: LanguageLevel.b1, order: 2, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование imperfetto', content: '-are: -avo, -avi, -ava, -avamo, -avate, -avano\n-ere: -evo, -evi, -eva, -evamo, -evate, -evano\n-ire: -ivo, -ivi, -iva, -ivamo, -ivate, -ivano\nessere: ero, eri, era', examples: ['Quando ero piccolo, giocavo.', 'Ogni giorno mangiava la pizza.', 'Andavamo al mare ogni estate.']),
        TheorySection(title: 'Употребление', content: 'Imperfetto = фон, привычка, незаконченное\nPassato prossimo = конкретный факт\nLeggevo quando è arrivato.', examples: ['Leggevo quando ha telefonato.', 'Da bambino mangiavo sempre la pizza.', 'Pioveva quando siamo usciti.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'parlare → imperfetto (io):', options: ['parlai', 'parlavo', 'parlerò', 'parlerei'], correctIndex: 1, explanation: 'imperfetto: parlavo'),
        CourseExercise(type: ExerciseType.translation, question: '"Когда я был маленьким, я играл" (привычка):', options: ['Quando ero piccolo, ho giocato.', 'Quando ero piccolo, giocavo.', 'Quando sono piccolo, gioco.', 'Quando fui piccolo, giocai.'], correctIndex: 1, explanation: 'Привычка = imperfetto'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Pioveva quando ___ (uscire, noi, passato prossimo)', options: ['uscivamo', 'usciamo', 'siamo usciti', 'usciremo'], correctIndex: 2, explanation: 'Событие = passato prossimo: siamo usciti'),
      ],
      exam: [
        ExamQuestion(question: 'mangiare → imperfetto (lei):', options: ['mangiò', 'mangiava', 'mangia', 'mangi'], correctIndex: 1, explanation: 'imperfetto: mangiava'),
        ExamQuestion(question: 'Imperfetto используется для:', options: ['конкретного события', 'привычки в прошлом', 'ближайшего будущего', 'команды'], correctIndex: 1, explanation: 'Imperfetto = повторяющееся/фоновое'),
        ExamQuestion(question: 'essere → imperfetto (io):', options: ['fui', 'ero', 'sarò', 'sia'], correctIndex: 1, explanation: 'essere imperfetto: ero'),
        ExamQuestion(question: 'Leggevo quando lui ___ (arrivare, p.p.)', options: ['arrivava', 'arriva', 'è arrivato', 'arriverà'], correctIndex: 2, explanation: 'Событие = passato prossimo: è arrivato'),
        ExamQuestion(question: 'andare → imperfetto (noi):', options: ['andammo', 'andavamo', 'andiamo', 'andremo'], correctIndex: 1, explanation: 'andare imperfetto: andavamo'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_03', title: 'Congiuntivo presente', subtitle: 'Сослагательное наклонение', emoji: '🎯',
      level: LanguageLevel.b1, order: 3, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование', content: '-are → -i (parli, parli, parli, parliamo)\n-ere/-ire → -a (mangi → mangia, veda)\nessere: sia; avere: abbia\nandare: vada; fare: faccia', examples: ['Spero che tu venga.', 'Voglio che lui parli.', 'È importante che studiate.']),
        TheorySection(title: 'После каких слов', content: 'После желания, необходимости, эмоций:\nvolere che, sperare che, è importante che\navere paura che, benché (хотя)', examples: ['Voglio che lei sia felice.', 'È necessario che tu venga.', 'Benché piova, esco.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'essere → congiuntivo (lei):', options: ['è', 'era', 'sia', 'sarebbe'], correctIndex: 2, explanation: 'essere congiuntivo: che lei sia'),
        CourseExercise(type: ExerciseType.translation, question: '"Нужно, чтобы ты пришёл":', options: ['Devi venire.', 'È necessario che tu venga.', 'È necessario venire.', 'Devi venire.'], correctIndex: 1, explanation: 'è necessario che + congiuntivo'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Voglio che lui ___ (parlare, cong.)', options: ['parla', 'parli', 'parlerà', 'parlava'], correctIndex: 1, explanation: 'parlare congiuntivo: che lui parli'),
      ],
      exam: [
        ExamQuestion(question: 'andare → congiuntivo (io):', options: ['vado', 'andavo', 'vada', 'andrò'], correctIndex: 2, explanation: 'andare congiuntivo: vada'),
        ExamQuestion(question: 'avere → congiuntivo: abbia (перев.):', options: ['есть', 'было', 'будет', 'есть (сослаг.)'], correctIndex: 3, explanation: 'abbia = congiuntivo от avere'),
        ExamQuestion(question: 'Congiuntivo используется после:', options: ['perché', 'quando (прош.)', 'volere che', 'se'], correctIndex: 2, explanation: 'volere che + congiuntivo'),
        ExamQuestion(question: 'Benché ___ (piovere), esco.', options: ['piove', 'piova', 'pioveva', 'piovrebbe'], correctIndex: 1, explanation: 'benché + congiuntivo = хотя'),
        ExamQuestion(question: 'mangiare → congiuntivo (tu):', options: ['mangi', 'mangia', 'mangiavi', 'mangerai'], correctIndex: 0, explanation: 'mangiare congiuntivo: che tu mangi'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_04', title: 'Forma passiva', subtitle: 'Пассивный залог', emoji: '🔄',
      level: LanguageLevel.b1, order: 4, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование пассива', content: 'essere + participio passato (согласован)\nIl libro è letto. — Книга читается.\nLa casa è costruita. — Дом строится.\nda + агент действия', examples: ['Questo romanzo è letto da tutti.', 'La lettera è stata scritta da Maria.', 'Le macchine sono riparate qui.']),
        TheorySection(title: 'Пассив с venire', content: 'venire + participio = пассив действия (без агента)\nIl libro viene letto ogni giorno.\n(venire = только Presente и Imperfetto)', examples: ['La pizza viene mangiata.', 'I bambini venivano aiutati.', 'Il film viene proiettato stasera.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Книга читается" (passivo presente):', options: ['Il libro legge.', 'Il libro è letto.', 'Il libro ha letto.', 'Si legge il libro.'], correctIndex: 1, explanation: 'Passivo: essere + participio passato'),
        CourseExercise(type: ExerciseType.translation, question: '"Письмо было написано Марией":', options: ['Maria ha scritto la lettera.', 'La lettera è scritta.', 'La lettera è stata scritta da Maria.', 'La lettera era scritta.'], correctIndex: 2, explanation: 'Passato prossimo passivo: è stata scritta da'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'La casa ___ costruita domani. (futuro)', options: ['è', 'era', 'sarà', 'è stata'], correctIndex: 2, explanation: 'Futuro passivo: sarà costruita'),
      ],
      exam: [
        ExamQuestion(question: 'leggere → participio passato:', options: ['leggendo', 'letto', 'leggito', 'legge'], correctIndex: 1, explanation: 'leggere → letto'),
        ExamQuestion(question: '"Дома строятся" (passivo):', options: ['Le case costruiscono.', 'Le case sono costruite.', 'Si costruiscono le case.', 'b e c sono corretti'], correctIndex: 3, explanation: 'Passivo con essere oppure si passivante'),
        ExamQuestion(question: 'scrivere → participio passato:', options: ['scritto', 'scrivendo', 'scritto', 'scrivito'], correctIndex: 0, explanation: 'scrivere → scritto'),
        ExamQuestion(question: 'Il film ___ proiettato stasera. (venire)', options: ['viene', 'è', 'sarà', 'veniva'], correctIndex: 0, explanation: 'venire + pp = passivo azione: viene proiettato'),
        ExamQuestion(question: 'fare → participio passato:', options: ['facendo', 'faccio', 'fatto', 'face'], correctIndex: 2, explanation: 'fare → fatto'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_05', title: 'Discorso indiretto', subtitle: 'Косвенная речь', emoji: '💬',
      level: LanguageLevel.b1, order: 5, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Косвенная речь', content: 'Dice che ... — Он говорит, что ...\nHa detto che ... — Он сказал, что ...\nСдвиг времён:\npresente → imperfetto\nfuturo → condizionale\npassato prossimo → trapassato prossimo', examples: ['Dice: "Sono stanco." → Dice che è stanco.', 'Ha detto: "Sono stanco." → Ha detto che era stanco.', 'Ha detto che sarebbe venuto.']),
        TheorySection(title: 'Косвенные вопросы', content: 'Да/нет: chiedere se + ...\nСпециальные: chiedere dove/quando/cosa + ...\nПорядок слов как в утверждении', examples: ['Chiede se vieni.', 'Chiede dove abiti.', 'Voglio sapere perché vai.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Dice: Sono malato" → discorso indiretto:', options: ['Dice che è malato.', 'Dice che era malato.', 'Dice che sarà malato.', 'Dice lui è malato.'], correctIndex: 0, explanation: 'dire presente: no сдвиг — è'),
        CourseExercise(type: ExerciseType.translation, question: '"Он спрашивает, придёшь ли ты":', options: ['Chiede se vieni.', 'Chiede che tu venga.', 'Chiede se venissi.', 'Vuole sapere vieni.'], correctIndex: 0, explanation: 'chiedere se = спрашивать (да/нет)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ha detto che ___ stanco. (essere, сдвиг)', options: ['è', 'era', 'è stato', 'sarà'], correctIndex: 1, explanation: 'ha detto (прошл.) → сдвиг: era'),
      ],
      exam: [
        ExamQuestion(question: 'Сдвиг presente → ? (при ha detto):', options: ['futuro', 'imperfetto', 'congiuntivo', 'condizionale'], correctIndex: 1, explanation: 'presente → imperfetto в косвенной речи'),
        ExamQuestion(question: '"Ha detto: Verrò" → indiretto:', options: ['Ha detto che verrà.', 'Ha detto che verrebbe.', 'Ha detto che viene.', 'Ha detto che veniva.'], correctIndex: 1, explanation: 'futuro → condizionale: verrebbe'),
        ExamQuestion(question: 'Косвенный вопрос "Dove abiti?":', options: ['Chiede dove abiti.', 'Chiede dove abiti?', 'Chiede se abiti.', 'Chiede che abiti.'], correctIndex: 0, explanation: 'Без инверсии и вопросительного знака'),
        ExamQuestion(question: 'Сдвиг futuro → ? (при ha detto):', options: ['imperfetto', 'congiuntivo', 'condizionale', 'presente'], correctIndex: 2, explanation: 'futuro → condizionale в косвенной речи'),
        ExamQuestion(question: 'Chiede ___ vai. (куда)', options: ['che', 'se', 'dove', 'quando'], correctIndex: 2, explanation: 'dove = где/куда'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_06', title: 'Comparativi e superlativi', subtitle: 'Сравнения', emoji: '📊',
      level: LanguageLevel.b1, order: 6, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Comparativo', content: 'più + agg + di/che — более ... чем\nmeno + agg + di/che — менее ... чем\ntanto ... quanto — такой же ... как\nbuono → migliore; cattivo → peggiore', examples: ['È più alto di me.', 'Questo libro è meno noioso di quello.', 'È tanto intelligente quanto suo fratello.']),
        TheorySection(title: 'Superlativo', content: 'Relativo: il/la/i/le più + agg — самый ...\nAssoluto: agg + -issimo/-issima\nbuono → buonissimo / ottimo\ncattivo → cattivissimo / pessimo', examples: ['È la città più bella del mondo.', 'È il più intelligente della classe.', 'Questo risotto è buonissimo!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Он выше меня":', options: ['È tanto alto quanto me.', 'È più alto di me.', 'È meno alto di me.', 'È il più alto.'], correctIndex: 1, explanation: 'più + agg + di = более ... чем'),
        CourseExercise(type: ExerciseType.translation, question: '"Это лучший ресторан":', options: ['È un buon ristorante.', 'È il miglior ristorante.', 'È più buono.', 'È buonissimo.'], correctIndex: 1, explanation: 'buono → il miglior (superlativo relativo)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'È ___ intelligente della classe.', options: ['il più', 'la più', 'più', 'molto'], correctIndex: 0, explanation: 'Superlativo relativo муж.р.: il più intelligente'),
      ],
      exam: [
        ExamQuestion(question: 'buono → comparativo:', options: ['più buono', 'migliore', 'buonissimo', 'molto buono'], correctIndex: 1, explanation: 'buono → migliore (неправ. сравн.)'),
        ExamQuestion(question: '"Менее быстрый, чем он":', options: ['più veloce di lui', 'tanto veloce quanto lui', 'meno veloce di lui', 'molto veloce'], correctIndex: 2, explanation: 'meno + agg + di'),
        ExamQuestion(question: '"Самый красивый в мире":', options: ['più bello del mondo', 'il più bello del mondo', 'tanto bello del mondo', 'bellissimo del mondo'], correctIndex: 1, explanation: 'il più + agg + del mondo = суперлатив'),
        ExamQuestion(question: 'cattivo → superlativo assoluto:', options: ['il peggiore', 'cattivissimo', 'il più cattivo', 'b e c sono corretti'], correctIndex: 3, explanation: 'cattivo → cattivissimo (assoluto) o il peggiore (relativo)'),
        ExamQuestion(question: '"Такой же умный, как она":', options: ['più intelligente di lei', 'tanto intelligente quanto lei', 'meno intelligente di lei', 'molto intelligente'], correctIndex: 1, explanation: 'tanto ... quanto = такой же ... как'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_07', title: 'Tecnologia e internet', subtitle: 'Технологии', emoji: '💻',
      level: LanguageLevel.b1, order: 7, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Технологии', content: 'internet — интернет\nun\'app — приложение\nun sito web — веб-сайт\nlo smartphone — смартфон\nl\'IA (Intelligenza Artificiale) — ИИ\nscaricare — скачивать\ncaricare — загружать', examples: ['Scarico l\'app.', 'L\'IA diventa sempre più importante.', 'Mandami il link del sito.']),
        TheorySection(title: 'Онлайн', content: 'mandare un\'e-mail — отправить email\ncondividere una foto — поделиться фото\nseguire qualcuno — подписаться\nuna pubblicazione — публикация\ni social media — соцсети', examples: ['Mando un\'e-mail al capo.', 'Hai ricevuto il mio messaggio?', 'Lei si è loggata.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Скачивать" по-итальянски:', options: ['caricare', 'scaricare', 'installare', 'salvare'], correctIndex: 1, explanation: 'scaricare = скачивать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я отправил email":', options: ['Ho ricevuto un\'e-mail.', 'Ho mandato un\'e-mail.', 'Ho letto un\'e-mail.', 'Ho scritto un\'e-mail.'], correctIndex: 1, explanation: 'mandare: ho mandato'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'I social ___ sono molto popolari.', options: ['media', 'rete', 'siti', 'app'], correctIndex: 0, explanation: 'i social media = социальные сети'),
      ],
      exam: [
        ExamQuestion(question: '"Приложение" по-итальянски:', options: ['sito web', 'app', 'programma', 'software'], correctIndex: 1, explanation: 'un\'app = приложение'),
        ExamQuestion(question: '"Поделиться фото":', options: ['scaricare una foto', 'condividere una foto', 'mandare una foto', 'cercare una foto'], correctIndex: 1, explanation: 'condividere = делиться'),
        ExamQuestion(question: 'IA = Intelligenza ___:', options: ['Automatica', 'Artificiale', 'Avanzata', 'Applicata'], correctIndex: 1, explanation: 'IA = Intelligenza Artificiale'),
        ExamQuestion(question: '"Подписаться" (на аккаунт):', options: ['condividere', 'scaricare', 'seguire', 'mettere like'], correctIndex: 2, explanation: 'seguire qualcuno = подписаться'),
        ExamQuestion(question: '"Смартфон" по-итальянски:', options: ['computer', 'tablet', 'smartphone', 'telefono fisso'], correctIndex: 2, explanation: 'lo smartphone = смартфон'),
      ],
    ),

    CourseChapter(
      id: 'it_b1_08', title: 'Salute e medicina', subtitle: 'Здоровье и медицина', emoji: '🏥',
      level: LanguageLevel.b1, order: 8, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Медицина', content: 'il raffreddore — насморк\nla febbre — температура\nla tosse — кашель\nl\'allergia — аллергия\nla ricetta — рецепт\nla farmacia — аптека\nil medicinale — лекарство', examples: ['Ho un raffreddore da ieri.', 'Ho bisogno di una ricetta.', 'Prendo questo medicinale.']),
        TheorySection(title: 'У врача', content: 'Non mi sento bene. — Мне нехорошо.\nDa quando ha dolore? — С каких пор болит?\nLe prescrivo ... — Я вам назначаю ...\nPrenda le compresse 3 volte al giorno.', examples: ['Non mi sento bene da stamattina.', 'Il medico mi prescrive antibiotici.', 'Tre volte al giorno con acqua.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Насморк" по-итальянски:', options: ['tosse', 'febbre', 'raffreddore', 'allergia'], correctIndex: 2, explanation: 'il raffreddore = насморк/простуда'),
        CourseExercise(type: ExerciseType.translation, question: '"Мне нехорошо":', options: ['Sono malato.', 'Non mi sento bene.', 'Mi fa male.', 'Sono stanco.'], correctIndex: 1, explanation: 'non sentirsi bene = чувствовать себя нехорошо'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Prenda le ___ tre volte al giorno.', options: ['ricette', 'medicinali', 'compresse', 'iniezioni'], correctIndex: 2, explanation: 'le compresse = таблетки'),
      ],
      exam: [
        ExamQuestion(question: '"Аптека" по-итальянски:', options: ['ospedale', 'clinica', 'farmacia', 'ambulatorio'], correctIndex: 2, explanation: 'la farmacia = аптека'),
        ExamQuestion(question: '"Кашель" по-итальянски:', options: ['raffreddore', 'febbre', 'tosse', 'dolore'], correctIndex: 2, explanation: 'la tosse = кашель'),
        ExamQuestion(question: 'Non mi ___ bene.', options: ['sono', 'sento', 'faccio', 'vado'], correctIndex: 1, explanation: 'sentirsi: mi sento'),
        ExamQuestion(question: '"Рецепт" по-итальянски:', options: ['medicinale', 'ricetta', 'compressa', 'trattamento'], correctIndex: 1, explanation: 'la ricetta = рецепт'),
        ExamQuestion(question: 'Da quando ___ dolore?', options: ['è', 'ha', 'fa', 'sente'], correctIndex: 1, explanation: 'avere dolore: lei ha dolore'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'it_b2_01', title: 'Condizionale', subtitle: 'Условное наклонение', emoji: '💭',
      level: LanguageLevel.b2, order: 1, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Condizionale presente', content: 'Образование: futuro-основа + -ei, -esti, -ebbe, -emmo, -este, -ebbero\nparlare: parlerei, parleresti...\nessere: sarei; avere: avrei\nandare: andrei; fare: farei', examples: ['Vorrei un caffè.', 'Lui sarebbe contento.', 'Ci piacerebbe vivere qui.']),
        TheorySection(title: 'Условные предложения', content: 'Тип 2: se + congiuntivo imperfetto, ... condizionale presente\nSe avessi tempo, viaggerei.\nТип 3: se + congiuntivo trapassato, ... condizionale passato\nSe avessi avuto tempo, avrei viaggiato.', examples: ['Se fossi ricco, comprerei una villa.', 'Se avessi studiato, avrei superato l\'esame.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'io ___ (parlare, condizionale)', options: ['parlerò', 'parlerei', 'parlavo', 'parli'], correctIndex: 1, explanation: 'condizionale: parlerei'),
        CourseExercise(type: ExerciseType.translation, question: '"Если бы у меня было время, я бы путешествовал":', options: ['Se ho tempo, viaggio.', 'Se avevo tempo, viaggiavo.', 'Se avessi tempo, viaggerei.', 'Se avessi tempo, viaggiassi.'], correctIndex: 2, explanation: 'Se + cong. imperfetto → condizionale presente (тип 2)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'essere → condizionale (lei):', options: ['sarà', 'sarebbe', 'era', 'sia'], correctIndex: 1, explanation: 'essere condizionale: sarebbe'),
      ],
      exam: [
        ExamQuestion(question: 'avere → condizionale (io):', options: ['avrò', 'avrei', 'avevo', 'abbia'], correctIndex: 1, explanation: 'avere condizionale: avrei'),
        ExamQuestion(question: 'Se + cong. imperfetto → ...:', options: ['futuro', 'condizionale presente', 'congiuntivo', 'passato prossimo'], correctIndex: 1, explanation: 'Тип 2: se + cong. imp. + condizionale pres.'),
        ExamQuestion(question: 'andare → condizionale (noi):', options: ['andiamo', 'andremmo', 'andavamo', 'andassimo'], correctIndex: 1, explanation: 'andare → andremmo'),
        ExamQuestion(question: '"Если бы ты учился, ты бы сдал" (тип 3):', options: ['Se studiassi, supereresti.', 'Se avessi studiato, avresti superato.', 'Se hai studiato, hai superato.', 'Se studi, superi.'], correctIndex: 1, explanation: 'Se + cong. trapassato → condizionale passato'),
        ExamQuestion(question: 'volere → condizionale (lui):', options: ['vorrà', 'vorrebbe', 'voleva', 'voglia'], correctIndex: 1, explanation: 'volere → lui vorrebbe'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_02', title: 'Gerundio e participio', subtitle: 'Деепричастие и причастие', emoji: '🎓',
      level: LanguageLevel.b2, order: 2, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Gerundio', content: '-are → -ando (parlando)\n-ere/-ire → -endo (leggendo, dormendo)\nStare + gerundio = продолженное действие\nEssendo stanco... = будучи уставшим', examples: ['Sto mangiando.', 'Parlando con lui, ho capito.', 'Essendo stanco, è andato a letto.']),
        TheorySection(title: 'Participio presente e passato', content: 'Participio presente: -ante/-ente (parlante, leggente)\nUsato come aggettivo\nParticipion passato: придаточное причастное\nArrivato a casa, ha mangiato.', examples: ['La persona parlante.', 'Arrivato a casa, ha mangiato.', 'Finito il lavoro, è uscita.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'mangiare → gerundio:', options: ['mangiato', 'mangiando', 'mangia', 'mangiare'], correctIndex: 1, explanation: 'gerundio: mangiando'),
        CourseExercise(type: ExerciseType.translation, question: '"Он ест, слушая музыку" (gerundio):', options: ['Lui mangia e ascolta la musica.', 'Lui mangia ascoltando la musica.', 'Ascoltando, lui mangia la musica.', 'Lui mangia durante la musica.'], correctIndex: 1, explanation: 'gerundio: mangiando / ascoltando'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ stanco, è andato a letto.', options: ['Stando', 'Essendo', 'Avendo', 'Finendo'], correctIndex: 1, explanation: 'essere → essendo (gerundio)'),
      ],
      exam: [
        ExamQuestion(question: 'parlare → gerundio:', options: ['parlato', 'parlare', 'parlando', 'parla'], correctIndex: 2, explanation: 'gerundio: parlando'),
        ExamQuestion(question: 'avere → gerundio:', options: ['avendo', 'avuto', 'avere', 'abbia'], correctIndex: 0, explanation: 'avere → avendo'),
        ExamQuestion(question: 'Stare + gerundio = ?', options: ['прошедшее', 'будущее', 'продолженное настоящее', 'пассив'], correctIndex: 2, explanation: 'stare + gerundio = azione in corso'),
        ExamQuestion(question: '"Придя домой, он поел":', options: ['Arrivando a casa, ha mangiato.', 'Arrivato a casa, ha mangiato.', 'Essendo arrivato, ha mangiato.', 'b e c sono corretti'], correctIndex: 3, explanation: 'Participio passato assoluto: Arrivato a casa...'),
        ExamQuestion(question: 'essere → gerundio:', options: ['avendo', 'essendo', 'stato', 'sendo'], correctIndex: 1, explanation: 'essere → essendo'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_03', title: 'Italiano degli affari', subtitle: 'Деловой итальянский', emoji: '📊',
      level: LanguageLevel.b2, order: 3, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Деловое письмо', content: 'Gentile Sig./Sig.ra ... — Уважаемый/ая\nMi permetto di contattarLa — Позвольте связаться с вами\nIn allegato troverà ... — В приложении найдёте ...\nIn attesa di Sua risposta — В ожидании вашего ответа\nCordialmente / Distinti saluti — С уважением', examples: ['Gentile Sig. Rossi,', 'In allegato troverà il mio CV.', 'In attesa di Sua risposta, cordialmente.']),
        TheorySection(title: 'Переговоры', content: 'Propongo di ... — Предлагаю ...\nCosa pensa di ...? — Что вы думаете о ...?\nÈ fattibile. — Это осуществимо.\nPurtroppo non è possibile. — К сожалению, невозможно.', examples: ['Propongo una riunione lunedì.', 'Cosa pensa di questa proposta?', 'Purtroppo non rientra nel nostro budget.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Стандартное завершение письма:', options: ['Ciao', 'A presto', 'Cordialmente', 'Con affetto'], correctIndex: 2, explanation: 'Cordialmente = с уважением (официально)'),
        CourseExercise(type: ExerciseType.translation, question: '"В приложении найдёте мой CV":', options: ['Ti mando il CV.', 'In allegato troverà il mio CV.', 'Ecco il CV.', 'Guarda il mio CV.'], correctIndex: 1, explanation: 'In allegato troverà = стандартная деловая фраза'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mi ___ di contattarLa.', options: ['vado', 'permetto', 'chiamo', 'scrivo'], correctIndex: 1, explanation: 'permettersi di = позволить себе'),
      ],
      exam: [
        ExamQuestion(question: '"В ожидании вашего ответа":', options: ['Grazie per la risposta.', 'In attesa di Sua risposta.', 'Aspetto la risposta.', 'Voglio la Sua risposta.'], correctIndex: 1, explanation: 'In attesa di Sua risposta = стандартная фраза'),
        ExamQuestion(question: '"К сожалению, невозможно":', options: ['È possibile.', 'Purtroppo non è possibile.', 'No, grazie.', 'Non va bene.'], correctIndex: 1, explanation: 'Purtroppo = к сожалению'),
        ExamQuestion(question: 'Обращение в официальном письме:', options: ['Ciao,', 'Buongiorno,', 'Gentile Sig./Sig.ra,', 'Caro amico,'], correctIndex: 2, explanation: 'Gentile Sig./Sig.ra = официальное обращение'),
        ExamQuestion(question: '"Предлагаю встречу":', options: ['Voglio una riunione.', 'Propongo una riunione.', 'Andiamo a una riunione.', 'La riunione è fissata.'], correctIndex: 1, explanation: 'proporre = предлагать'),
        ExamQuestion(question: 'In allegato = ?', options: ['здесь', 'в приложении', 'выше', 'ниже'], correctIndex: 1, explanation: 'in allegato = в приложении'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_04', title: 'Modi di dire', subtitle: 'Идиомы', emoji: '🎭',
      level: LanguageLevel.b2, order: 4, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Идиомы', content: 'Costare un occhio della testa — стоить целое состояние\nNon c\'è due senza tre. — Бог троицу любит.\nMettere i piedi in fallo — сделать ошибку\nNon avere peli sulla lingua — говорить прямо\nUn lavoro da quattro soldi — мизерная работа', examples: ['Questa macchina costa un occhio della testa!', 'Ha messo i piedi in fallo.', 'Non ha peli sulla lingua!']),
        TheorySection(title: 'Ещё идиомы', content: 'Avere la testa fra le nuvole — витать в облаках\nPiovere a catinelle — лить как из ведра\nIn bocca al lupo! — Ни пуха ни пера!\nCrepi il lupo! — К чёрту! (ответ)', examples: ['È sempre con la testa fra le nuvole.', 'Piove a catinelle!', 'In bocca al lupo! — Crepi!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Лить как из ведра" по-итальянски:', options: ['Piove tanto.', 'Piove a catinelle.', 'Fa molto umido.', 'C\'è un temporale.'], correctIndex: 1, explanation: 'Piove a catinelle. = льёт как из ведра'),
        CourseExercise(type: ExerciseType.translation, question: '"Стоить целое состояние":', options: ['È caro.', 'Costa molto.', 'Costa un occhio della testa.', 'Vale molto.'], correctIndex: 2, explanation: 'costare un occhio della testa = очень дорого'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'In bocca al ___! (Ни пуха ни пера!)', options: ['gatto', 'cane', 'lupo', 'orso'], correctIndex: 2, explanation: 'In bocca al lupo! = ни пуха ни пера!'),
      ],
      exam: [
        ExamQuestion(question: '"Витать в облаках" (идиома):', options: ['Essere distratto', 'Avere la testa fra le nuvole', 'Non prestare attenzione', 'Sognare'], correctIndex: 1, explanation: 'avere la testa fra le nuvole = витать в облаках'),
        ExamQuestion(question: '"Сделать ошибку" (идиома):', options: ['Mettere i piedi in fallo', 'Fare un errore', 'Sbagliare', 'Fallire'], correctIndex: 0, explanation: 'mettere i piedi in fallo = ошибиться'),
        ExamQuestion(question: 'Ответ на "In bocca al lupo!":', options: ['Grazie!', 'Crepi!', 'Prego!', 'Di niente!'], correctIndex: 1, explanation: 'Crepi (il lupo)! = ответ на "ни пуха ни пера"'),
        ExamQuestion(question: '"Говорить прямо" (идиома):', options: ['Parlare chiaro', 'Non avere peli sulla lingua', 'Dire la verità', 'Essere onesto'], correctIndex: 1, explanation: 'non avere peli sulla lingua = говорить без обиняков'),
        ExamQuestion(question: '"Бог троицу любит":', options: ['Tutto va bene.', 'Non c\'è due senza tre.', 'Le cose vanno sempre a tre.', 'Tre è il numero perfetto.'], correctIndex: 1, explanation: 'Non c\'è due senza tre. = не бывает двух без трёх'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_05', title: 'Cultura italiana', subtitle: 'Итальянская культура', emoji: '🏛️',
      level: LanguageLevel.b2, order: 5, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Страна и язык', content: 'Italia — Италия (60 млн)\nSvizzera (parte) — Швейцария (часть)\nSan Marino, Vaticano — микрогосударства\nItaliano — 5-й по числу изучающих в мире\nDialetti — диалекты (сицилийский, венецианский...)', examples: ['Roma è la capitale d\'Italia.', 'L\'italiano si parla in molti paesi.', 'I dialetti italiani sono molto diversi.']),
        TheorySection(title: 'Культура', content: 'La cucina italiana — итальянская кухня (ЮНЕСКО)\nLa moda — мода (Milano)\nL\'opera — опера\nIl Rinascimento — Возрождение\nLa dolce vita — сладкая жизнь', examples: ['La pizza è un patrimonio culturale.', 'Milano è la capitale della moda.', 'La dolce vita è uno stile italiano.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Столица Италии:', options: ['Milano', 'Venezia', 'Roma', 'Napoli'], correctIndex: 2, explanation: 'Roma = столица Италии'),
        CourseExercise(type: ExerciseType.translation, question: '"Итальянская кухня — объект наследия ЮНЕСКО":', options: ['La cucina italiana è famosa.', 'La cucina italiana è un patrimonio ЮНЕСКО.', 'La cucina italiana è buona.', 'La cucina italiana è del mondo.'], correctIndex: 1, explanation: 'patrimonio UNESCO = объект наследия ЮНЕСКО'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Milano è la capitale della ___. (мода)', options: ['cucina', 'musica', 'moda', 'arte'], correctIndex: 2, explanation: 'la moda = мода'),
      ],
      exam: [
        ExamQuestion(question: '"Возрождение" по-итальянски:', options: ['Rivoluzione', 'Rinascimento', 'Risorgimento', 'Rinnovamento'], correctIndex: 1, explanation: 'il Rinascimento = Возрождение (XIV–XVI вв.)'),
        ExamQuestion(question: '"Опера" по-итальянски:', options: ['opera', 'musica', 'teatro', 'spettacolo'], correctIndex: 0, explanation: 'l\'opera = опера (муз. жанр)'),
        ExamQuestion(question: 'Столица моды Италии:', options: ['Roma', 'Napoli', 'Firenze', 'Milano'], correctIndex: 3, explanation: 'Milano = столица итальянской моды'),
        ExamQuestion(question: '"Сладкая жизнь" по-итальянски:', options: ['bella vita', 'dolce vita', 'vita italiana', 'vita mia'], correctIndex: 1, explanation: 'la dolce vita = сладкая жизнь'),
        ExamQuestion(question: 'Диалекты Италии:', options: ['не существуют', 'очень похожи', 'очень разнообразны', 'один диалект'], correctIndex: 2, explanation: 'I dialetti italiani sono molto diversi tra loro'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_06', title: 'Opinione e argomentazione', subtitle: 'Мнение и аргументы', emoji: '📰',
      level: LanguageLevel.b2, order: 6, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Выражение мнения', content: 'A mio avviso / Secondo me — По моему мнению\nMi sembra che (+ cong.) — Мне кажется, что\nSono convinto/a che (+ cong.) — Я убеждён/а, что\nDa un lato ... dall\'altro — С одной ... с другой стороны\nIn conclusione — В заключение', examples: ['A mio avviso, è una buona idea.', 'Mi sembra che ci sbagliamo.', 'Da un lato è caro, dall\'altro è utile.']),
        TheorySection(title: 'Связки', content: 'In primo luogo — Во-первых\nInoltre / Inoltre — Кроме того\nTuttavia / Nonostante — Однако\nPerciò / Quindi — Поэтому\nIn definitiva — В конечном счёте', examples: ['In primo luogo, l\'economia migliora.', 'Tuttavia, la disoccupazione rimane alta.', 'Quindi possiamo concludere.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"По моему мнению" по-итальянски:', options: ['Penso,', 'A mio avviso,', 'Secondo lui,', 'Mi sembra'], correctIndex: 1, explanation: 'A mio avviso = по моему мнению'),
        CourseExercise(type: ExerciseType.translation, question: '"Однако проблема остaётся":', options: ['Il problema rimane.', 'Tuttavia, il problema rimane.', 'Ma, il problema rimane.', 'Anche il problema rimane.'], correctIndex: 1, explanation: 'Tuttavia = однако (формально)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ un lato è caro, dall\'altro è utile.', options: ['Da', 'Di', 'In', 'Per'], correctIndex: 0, explanation: 'Da un lato ... dall\'altro = с одной ... с другой стороны'),
      ],
      exam: [
        ExamQuestion(question: '"В заключение" по-итальянски:', options: ['In primo luogo', 'Inoltre', 'In conclusione', 'Tuttavia'], correctIndex: 2, explanation: 'In conclusione = в заключение'),
        ExamQuestion(question: '"Мне кажется, что" (+ конъюнктив):', options: ['Sono sicuro che', 'Mi sembra che', 'A mio avviso', 'Penso'], correctIndex: 1, explanation: 'Mi sembra che + congiuntivo = мне кажется'),
        ExamQuestion(question: '"Кроме того" (формально):', options: ['Tuttavia', 'Inoltre', 'Quindi', 'In conclusione'], correctIndex: 1, explanation: 'Inoltre = кроме того'),
        ExamQuestion(question: '"Поэтому":', options: ['Tuttavia', 'Inoltre', 'Quindi/Perciò', 'In primo luogo'], correctIndex: 2, explanation: 'Quindi / Perciò = поэтому/следовательно'),
        ExamQuestion(question: '"Я убеждён, что" (+ конъюнктив):', options: ['Mi sembra che', 'Penso che', 'Sono convinto che', 'A mio avviso'], correctIndex: 2, explanation: 'Sono convinto/a che + congiuntivo'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_07', title: 'Grammatica avanzata', subtitle: 'Продвинутая грамматика', emoji: '🔬',
      level: LanguageLevel.b2, order: 7, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Pronomi relativi', content: 'che — который (без предлога)\ncui — который (с предлогом)\nil quale / la quale — который/которая (фор.)\nIl libro di cui parlo.\nLa persona con cui lavoro.', examples: ['Il film che guardo è bello.', 'La città di cui parli è Venezia.', 'L\'amico con il quale lavoro.']),
        TheorySection(title: 'Nominalizzazione', content: 'Превращение глагола в существительное:\npartire → la partenza\narrivare → l\'arrivo\nlavorare → il lavoro\nforte → la forza\nrapido → la rapidità', examples: ['La partenza è alle 10.', 'Il suo arrivo ci ha sorpreso.', 'La rapidità è importante.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Il libro ___ leggo è interessante.', options: ['di cui', 'con cui', 'che', 'il quale'], correctIndex: 2, explanation: 'che = который (без предлога, прямой объект)'),
        CourseExercise(type: ExerciseType.translation, question: '"Человек, с которым работаю":', options: ['La persona che lavoro.', 'La persona di cui lavoro.', 'La persona con cui lavoro.', 'La persona quale lavoro.'], correctIndex: 2, explanation: 'con + cui = con cui (предлог + cui)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'partire → la ___', options: ['partita', 'partire', 'partenza', 'partita'], correctIndex: 2, explanation: 'partire → la partenza (номинализация)'),
      ],
      exam: [
        ExamQuestion(question: 'La città ___ parli è Roma.', options: ['che', 'con cui', 'di cui', 'il quale'], correctIndex: 2, explanation: 'parlare di → di cui'),
        ExamQuestion(question: 'arrivare → nominalizzazione:', options: ['arrivaggio', 'arrivo', 'arrivante', 'arrivato'], correctIndex: 1, explanation: 'arrivare → l\'arrivo'),
        ExamQuestion(question: '"Проблема, о которой говоришь" (parlare di):', options: ['il problema che parli', 'il problema di cui parli', 'il problema cui parli', 'b e c'], correctIndex: 1, explanation: 'parlare di → di cui'),
        ExamQuestion(question: 'forte → nominalizzazione:', options: ['fortemente', 'fortezza', 'forza', 'fortitudine'], correctIndex: 2, explanation: 'forte → la forza'),
        ExamQuestion(question: 'cui si usa con:', options: ['без предлога', 'с предлогом', 'как подлежащее', 'как прямое дополнение'], correctIndex: 1, explanation: 'cui используется с предлогами: di cui, con cui...'),
      ],
    ),

    CourseChapter(
      id: 'it_b2_08', title: 'Esame finale', subtitle: 'Финальный экзамен', emoji: '🏆',
      level: LanguageLevel.b2, order: 8, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Повторение A1–B1', content: 'A1: Приветствия, числа, семья, еда, тело, время, природа, глаголы\nA2: Неправильные глаголы, транспорт, погода, одежда, описание, futuro\nB1: Passato prossimo, Imperfetto, Congiuntivo, Passivo, Discorso indiretto', examples: ['Lei è andata al cinema.', 'Quando ero piccolo, giocavo.', 'È necessario che tu venga.']),
        TheorySection(title: 'Повторение B2', content: 'B2: Condizionale, Gerundio, Italiano degli affari, Modi di dire, Cultura, Pronomi relativi\nSe avessi tempo, viaggerei.\nA mio avviso, è essenziale.\nIn allegato troverà...', examples: ['Costa un occhio della testa!', 'La persona con cui lavoro.', 'Sto mangiando la pizza.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Se avessi tempo, ___ (viaggiare, condiz.)', options: ['viaggio', 'viaggerò', 'viaggerei', 'viaggiassi'], correctIndex: 2, explanation: 'Condizionale: viaggerei'),
        CourseExercise(type: ExerciseType.translation, question: '"Лить как из ведра" по-итальянски:', options: ['Piove molto.', 'Piove a catinelle.', 'C\'è un temporale.', 'Fa brutto tempo.'], correctIndex: 1, explanation: 'Piove a catinelle. = льёт как из ведра'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'A mio ___, è una buona idea.', options: ['pensiero', 'avviso', 'senso', 'opinione'], correctIndex: 1, explanation: 'A mio avviso = по моему мнению'),
      ],
      exam: [
        ExamQuestion(question: 'Passato prossimo от "andare" (lei):', options: ['ha andata', 'è andata', 'era andata', 'andava'], correctIndex: 1, explanation: 'andare = essere: è andata'),
        ExamQuestion(question: 'Piove a catinelle = ?', options: ['немного дождь', 'льёт как из ведра', 'туман', 'облачно'], correctIndex: 1, explanation: 'Piove a catinelle = льёт как из ведра'),
        ExamQuestion(question: 'Gerundio — образование:', options: ['-ato/-ito', '-ando/-endo', '-ante/-ente', '-ai/-ei'], correctIndex: 1, explanation: 'Gerundio: -ando (are), -endo (ere/ire)'),
        ExamQuestion(question: 'Condizionale тип 3: se + cong. trapassato → ...', options: ['condizionale presente', 'condizionale passato', 'congiuntivo', 'futuro anteriore'], correctIndex: 1, explanation: 'Se + cong. trapassato → condizionale passato'),
        ExamQuestion(question: '"In bocca al lupo!" — ответ:', options: ['Grazie!', 'Crepi!', 'Prego!', 'Di niente!'], correctIndex: 1, explanation: 'Crepi (il lupo)! = ответ на пожелание удачи'),
      ],
    ),
  ],
);
