import '../courses/course_structure.dart';

const frenchCourse = LanguageCourse(
  langCode: 'fr',
  langName: 'Французский',
  nativeName: 'Français',
  flag: '🇫🇷',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'fr_a1_01', title: 'Bonjour!', subtitle: 'Приветствия и знакомство', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Bonjour — Добрый день/Привет\nBonsoir — Добрый вечер\nSalut — Привет (неформально)\nAu revoir — До свидания\nÀ bientôt — До скорого\nMerci — Спасибо\nS\'il vous plaît — Пожалуйста', examples: ['Bonjour! Comment vous appelez-vous?', 'Salut! Ça va?', 'Au revoir, à demain!']),
        TheorySection(title: 'Знакомство', content: 'Comment vous appelez-vous? — Как вас зовут? (формально)\nComment tu t\'appelles? — Как тебя зовут? (неформально)\nJe m\'appelle ... — Меня зовут ...\nD\'où venez-vous? — Откуда вы?\nJe viens de ... — Я из ...', examples: ['Je m\'appelle Marie.', 'Je viens de Russie.', 'Enchanté(e)! — Приятно познакомиться!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Добрый вечер" по-французски:', options: ['Bonjour', 'Bonsoir', 'Bonne nuit', 'Salut'], correctIndex: 1, explanation: 'Bonsoir = добрый вечер (soir = вечер)'),
        CourseExercise(type: ExerciseType.translation, question: '"Как тебя зовут?" (неформально):', options: ['Comment vous appelez-vous?', 'Comment tu t\'appelles?', 'Qui êtes-vous?', 'Quel est ton nom?'], correctIndex: 1, explanation: 'Comment tu t\'appelles? — неформальная форма'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Je ___ de Russie.', options: ['suis', 'viens', 'appelle', 'habite'], correctIndex: 1, explanation: 'venir de = быть из; je viens de'),
      ],
      exam: [
        ExamQuestion(question: '"Привет" (неформально) по-французски:', options: ['Bonjour', 'Bonsoir', 'Salut', 'Merci'], correctIndex: 2, explanation: 'Salut = привет (неформально)'),
        ExamQuestion(question: 'Je m\'appelle = ?', options: ['Я из', 'Меня зовут', 'Я живу', 'Я иду'], correctIndex: 1, explanation: 'Je m\'appelle = меня зовут (s\'appeler)'),
        ExamQuestion(question: '"До свидания" по-французски:', options: ['Merci', 'Bonjour', 'Au revoir', 'S\'il vous plaît'], correctIndex: 2, explanation: 'Au revoir = до свидания'),
        ExamQuestion(question: '"Пожалуйста" по-французски:', options: ['Merci', 'Bonjour', 'Pardon', 'S\'il vous plaît'], correctIndex: 3, explanation: 'S\'il vous plaît = пожалуйста (если вам угодно)'),
        ExamQuestion(question: '"Приятно познакомиться":', options: ['Au revoir', 'Enchanté', 'Merci', 'Bonjour'], correctIndex: 1, explanation: 'Enchanté(e) = очарован/а = приятно познакомиться'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_02', title: 'Nombres et couleurs', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Числа 1–20', content: '1-un/une, 2-deux, 3-trois, 4-quatre, 5-cinq\n6-six, 7-sept, 8-huit, 9-neuf, 10-dix\n11-onze, 12-douze, 13-treize, 20-vingt', examples: ['J\'ai vingt ans.', 'Il y a cinq personnes.', 'C\'est le numéro sept.']),
        TheorySection(title: 'Цвета', content: 'rouge — красный\nbleu — синий\nvert — зелёный\njaune — жёлтый\nblanc/blanche — белый\nnoir/noire — чёрный\norange — оранжевый', examples: ['Le ciel est bleu.', 'La pomme est rouge.', 'J\'aime le noir.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Синий" по-французски:', options: ['rouge', 'vert', 'bleu', 'jaune'], correctIndex: 2, explanation: 'bleu = синий'),
        CourseExercise(type: ExerciseType.translation, question: '12 по-французски:', options: ['onze', 'douze', 'treize', 'quatorze'], correctIndex: 1, explanation: 'douze = 12'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Le ciel est ___. (синее)', options: ['rouge', 'vert', 'bleu', 'noir'], correctIndex: 2, explanation: 'Le ciel (небо) est bleu'),
      ],
      exam: [
        ExamQuestion(question: '7 по-французски:', options: ['six', 'sept', 'huit', 'neuf'], correctIndex: 1, explanation: 'sept = 7'),
        ExamQuestion(question: '"Зелёный" по-французски:', options: ['rouge', 'bleu', 'vert', 'jaune'], correctIndex: 2, explanation: 'vert = зелёный'),
        ExamQuestion(question: '20 по-французски:', options: ['dix', 'quinze', 'vingt', 'trente'], correctIndex: 2, explanation: 'vingt = 20'),
        ExamQuestion(question: '"Чёрный" по-французски:', options: ['blanc', 'gris', 'brun', 'noir'], correctIndex: 3, explanation: 'noir/noire = чёрный/чёрная'),
        ExamQuestion(question: '5 по-французски:', options: ['quatre', 'cinq', 'six', 'trois'], correctIndex: 1, explanation: 'cinq = 5'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_03', title: 'Famille et maison', subtitle: 'Семья и дом', emoji: '🏠',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Семья', content: 'la mère — мама\nle père — папа\nla sœur — сестра\nle frère — брат\nla grand-mère — бабушка\nle grand-père — дедушка\nles enfants — дети', examples: ['Ma mère s\'appelle Anne.', 'J\'ai un frère et une sœur.', 'Mon père travaille.']),
        TheorySection(title: 'Артикли', content: 'le (муж. ед.ч.) — le père, le frère\nla (жен. ед.ч.) — la mère, la sœur\nles (мн.ч.) — les enfants, les parents\nun/une — неопределённый артикль', examples: ['le chat — кот', 'la maison — дом', 'les enfants — дети']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сестра" по-французски:', options: ['frère', 'sœur', 'fille', 'femme'], correctIndex: 1, explanation: 'la sœur = сестра'),
        CourseExercise(type: ExerciseType.translation, question: '"Мой папа работает":', options: ['Mon père mange.', 'Mon père travaille.', 'Mon père dort.', 'Mon père parle.'], correctIndex: 1, explanation: 'travailler = работать; il travaille'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'J\'ai ___ frère. (одного)', options: ['une', 'le', 'un', 'des'], correctIndex: 2, explanation: 'un = неопределённый арт. муж.р. ед.ч.'),
      ],
      exam: [
        ExamQuestion(question: '"Дедушка" по-французски:', options: ['grand-mère', 'grand-père', 'père', 'oncle'], correctIndex: 1, explanation: 'le grand-père = дедушка'),
        ExamQuestion(question: 'Артикль к "maison" (дом):', options: ['le', 'la', 'les', 'un'], correctIndex: 1, explanation: 'la maison — женский род'),
        ExamQuestion(question: '"Дети" по-французски:', options: ['filles', 'garçons', 'enfants', 'bébés'], correctIndex: 2, explanation: 'les enfants = дети'),
        ExamQuestion(question: '"Брат" по-французски:', options: ['père', 'fils', 'frère', 'oncle'], correctIndex: 2, explanation: 'le frère = брат'),
        ExamQuestion(question: 'Ma mère ___ Anne. (зовут)', options: ['est', 'appelle', 's\'appelle', 'nomme'], correctIndex: 2, explanation: 's\'appeler: elle s\'appelle'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_04', title: 'Nourriture et boissons', subtitle: 'Еда и напитки', emoji: '🥐',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'le pain — хлеб\nle fromage — сыр\nla viande — мясо\nles légumes — овощи\nles fruits — фрукты\nla soupe — суп\nle croissant — круассан', examples: ['Je mange du pain.', 'Elle aime le fromage.', 'Nous mangeons des légumes.']),
        TheorySection(title: 'Напитки и артикли с едой', content: 'l\'eau — вода\nle café — кофе\nle thé — чай\nle jus — сок\ndu/de la/des — партитивный артикль\nJe bois du café. — Я пью кофе.', examples: ['Je bois de l\'eau.', 'Vous voulez du thé?', 'Il mange de la viande.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Хлеб" по-французски:', options: ['fromage', 'pain', 'viande', 'beurre'], correctIndex: 1, explanation: 'le pain = хлеб'),
        CourseExercise(type: ExerciseType.translation, question: '"Я пью кофе":', options: ['Je mange du café.', 'Je bois du café.', 'Je prends café.', 'J\'aime café.'], correctIndex: 1, explanation: 'boire = пить; je bois du café'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Je mange ___ viande.', options: ['du', 'de la', 'des', 'le'], correctIndex: 1, explanation: 'viande (жен.р.) → de la viande'),
      ],
      exam: [
        ExamQuestion(question: '"Вода" по-французски:', options: ['jus', 'lait', 'eau', 'thé'], correctIndex: 2, explanation: 'l\'eau = вода (жен.р., начинается с гласной → l\'eau)'),
        ExamQuestion(question: '"Сыр" по-французски:', options: ['pain', 'fromage', 'beurre', 'confiture'], correctIndex: 1, explanation: 'le fromage = сыр'),
        ExamQuestion(question: 'Je bois ___ café.', options: ['de la', 'des', 'du', 'le'], correctIndex: 2, explanation: 'café (муж.р.) → du café (партитивный)'),
        ExamQuestion(question: '"Фрукты" по-французски:', options: ['légumes', 'fruits', 'viande', 'fromage'], correctIndex: 1, explanation: 'les fruits = фрукты'),
        ExamQuestion(question: '"Круассан" по-французски:', options: ['baguette', 'pain', 'croissant', 'tarte'], correctIndex: 2, explanation: 'le croissant = круассан (французский символ)'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_05', title: 'Corps et santé', subtitle: 'Тело и здоровье', emoji: '💪',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Части тела', content: 'la tête — голова\nl\'œil/les yeux — глаз/глаза\nle nez — нос\nla bouche — рот\nle bras — рука\nla main — кисть\nla jambe — нога\nle pied — ступня', examples: ['J\'ai mal à la tête.', 'Il a les yeux bleus.', 'Ma main fait mal.']),
        TheorySection(title: 'Самочувствие', content: 'Comment allez-vous? — Как вы себя чувствуете?\nJe vais bien. — Я в порядке.\nJe suis malade. — Я болен/больна.\nJ\'ai mal à ... — У меня болит ...\nJ\'ai de la fièvre. — У меня температура.', examples: ['Je vais très bien, merci.', 'J\'ai mal au dos.', 'Il est malade aujourd\'hui.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Голова" по-французски:', options: ['main', 'jambe', 'tête', 'bras'], correctIndex: 2, explanation: 'la tête = голова'),
        CourseExercise(type: ExerciseType.translation, question: '"Я болен":', options: ['Je vais bien.', 'Je suis malade.', 'J\'ai mal.', 'Je suis fatigué.'], correctIndex: 1, explanation: 'malade = больной/больная'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'J\'ai mal ___ la tête.', options: ['de', 'à', 'au', 'par'], correctIndex: 1, explanation: 'avoir mal à = болеть; à + la = à la'),
      ],
      exam: [
        ExamQuestion(question: '"Нога" по-французски:', options: ['bras', 'main', 'pied', 'jambe'], correctIndex: 3, explanation: 'la jambe = нога (от колена до бедра); le pied = ступня'),
        ExamQuestion(question: 'Comment allez-vous? = ?', options: ['Как вас зовут?', 'Откуда вы?', 'Как вы себя чувствуете?', 'Что вы делаете?'], correctIndex: 2, explanation: 'Comment allez-vous? = Как вы себя чувствуете?'),
        ExamQuestion(question: '"Температура" по-французски:', options: ['mal', 'fièvre', 'rhume', 'toux'], correctIndex: 1, explanation: 'la fièvre = температура/жар'),
        ExamQuestion(question: '"Глаза" по-французски (мн.ч.):', options: ['œil', 'yeux', 'oreilles', 'nez'], correctIndex: 1, explanation: 'les yeux = глаза (мн.ч. от l\'œil — неправильное)'),
        ExamQuestion(question: 'Je ___ bien. (я в порядке)', options: ['suis', 'vais', 'fais', 'pars'], correctIndex: 1, explanation: 'aller bien: je vais bien'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_06', title: 'Temps et calendrier', subtitle: 'Время и календарь', emoji: '🕐',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'lundi — понедельник\nmardi — вторник\nmercredi — среда\njeudi — четверг\nvendredi — пятница\nsamedi — суббота\ndimanche — воскресенье', examples: ['Aujourd\'hui, c\'est lundi.', 'Le vendredi, je fais du sport.', 'Le dimanche, je me repose.']),
        TheorySection(title: 'Время', content: 'Quelle heure est-il? — Который час?\nIl est ... heures. — Сейчас ... часов.\nIl est midi. — Полдень.\nIl est minuit. — Полночь.\nle matin — утром\nle soir — вечером', examples: ['Il est neuf heures.', 'Le matin, je bois du café.', 'Le soir, je lis.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пятница" по-французски:', options: ['jeudi', 'vendredi', 'samedi', 'dimanche'], correctIndex: 1, explanation: 'vendredi = пятница'),
        CourseExercise(type: ExerciseType.translation, question: '"Который час?":', options: ['Quel jour sommes-nous?', 'Quelle heure est-il?', 'Quand partez-vous?', 'Combien coûte?'], correctIndex: 1, explanation: 'Quelle heure est-il? = Который час?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Aujourd\'hui c\'est ___. (среда)', options: ['mardi', 'mercredi', 'jeudi', 'vendredi'], correctIndex: 1, explanation: 'mercredi = среда'),
      ],
      exam: [
        ExamQuestion(question: '"Воскресенье" по-французски:', options: ['samedi', 'dimanche', 'vendredi', 'lundi'], correctIndex: 1, explanation: 'dimanche = воскресенье'),
        ExamQuestion(question: 'Il est ___ heures. (9 часов)', options: ['sept', 'huit', 'neuf', 'dix'], correctIndex: 2, explanation: 'neuf = 9'),
        ExamQuestion(question: '"Вечером" по-французски:', options: ['le matin', 'l\'après-midi', 'le soir', 'la nuit'], correctIndex: 2, explanation: 'le soir = вечером'),
        ExamQuestion(question: '"Полдень" по-французски:', options: ['minuit', 'midi', 'après-midi', 'matin'], correctIndex: 1, explanation: 'midi = полдень'),
        ExamQuestion(question: '"Понедельник" по-французски:', options: ['dimanche', 'mardi', 'lundi', 'mercredi'], correctIndex: 2, explanation: 'lundi = понедельник'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_07', title: 'Animaux et nature', subtitle: 'Животные и природа', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Животные', content: 'le chien — собака\nle chat — кошка\nle cheval — лошадь\nl\'oiseau — птица\nle poisson — рыба\nle lapin — кролик\nle lion — лев', examples: ['J\'ai un chat et un chien.', 'L\'oiseau chante.', 'Le cheval est grand.']),
        TheorySection(title: 'Природа', content: 'l\'arbre — дерево\nla fleur — цветок\nla mer — море\nla montagne — гора\nla rivière — река\nla forêt — лес\nle ciel — небо', examples: ['La mer est belle.', 'La fleur est rouge.', 'La forêt est verte.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-французски:', options: ['chien', 'chat', 'cheval', 'lapin'], correctIndex: 1, explanation: 'le chat = кот/кошка'),
        CourseExercise(type: ExerciseType.translation, question: '"Лес" по-французски:', options: ['mer', 'montagne', 'forêt', 'rivière'], correctIndex: 2, explanation: 'la forêt = лес'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'La ___ est belle. (море)', options: ['forêt', 'rivière', 'mer', 'montagne'], correctIndex: 2, explanation: 'la mer = море (жен.р.)'),
      ],
      exam: [
        ExamQuestion(question: '"Птица" по-французски:', options: ['poisson', 'oiseau', 'chat', 'lapin'], correctIndex: 1, explanation: 'l\'oiseau = птица'),
        ExamQuestion(question: '"Цветок" по-французски:', options: ['arbre', 'fleur', 'herbe', 'feuille'], correctIndex: 1, explanation: 'la fleur = цветок'),
        ExamQuestion(question: 'Артикль слова "chien" (собака):', options: ['la', 'le', 'les', 'l\''], correctIndex: 1, explanation: 'le chien = собака (муж.р.)'),
        ExamQuestion(question: '"Небо" по-французски:', options: ['terre', 'mer', 'ciel', 'nuage'], correctIndex: 2, explanation: 'le ciel = небо'),
        ExamQuestion(question: '"Гора" по-французски:', options: ['rivière', 'forêt', 'mer', 'montagne'], correctIndex: 3, explanation: 'la montagne = гора'),
      ],
    ),

    CourseChapter(
      id: 'fr_a1_08', title: 'Verbes essentiels', subtitle: 'Базовые глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Спряжение -er глаголов', content: 'je -e, tu -es, il/elle -e\nnous -ons, vous -ez, ils/elles -ent\nParler: je parle, tu parles, il parle\nnous parlons, vous parlez, ils parlent', examples: ['Je parle français.', 'Tu manges une pomme.', 'Nous habitons à Paris.']),
        TheorySection(title: 'Être и avoir', content: 'être (быть): je suis, tu es, il est\nnous sommes, vous êtes, ils sont\navoir (иметь): j\'ai, tu as, il a\nnous avons, vous avez, ils ont', examples: ['Je suis étudiant.', 'Elle est française.', 'J\'ai deux chats.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Il ___ (parler)', options: ['parle', 'parles', 'parlent', 'parlons'], correctIndex: 0, explanation: 'parler: il parle (3-е лицо ед.ч.)'),
        CourseExercise(type: ExerciseType.translation, question: '"Я студент":', options: ['J\'ai étudiant.', 'Je suis étudiant.', 'Je fais étudiant.', 'J\'habite étudiant.'], correctIndex: 1, explanation: 'être: je suis'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nous ___ à Paris. (habiter)', options: ['habitons', 'habitez', 'habitent', 'habite'], correctIndex: 0, explanation: 'habiter: nous habitons'),
      ],
      exam: [
        ExamQuestion(question: 'j\'___ (avoir)', options: ['est', 'ai', 'as', 'avons'], correctIndex: 1, explanation: 'avoir: j\'ai'),
        ExamQuestion(question: 'vous ___ (être)', options: ['sommes', 'êtes', 'sont', 'es'], correctIndex: 1, explanation: 'être: vous êtes'),
        ExamQuestion(question: '"Говорить" по-французски:', options: ['manger', 'habiter', 'parler', 'travailler'], correctIndex: 2, explanation: 'parler = говорить'),
        ExamQuestion(question: 'ils ___ (manger)', options: ['mange', 'manges', 'mangeons', 'mangent'], correctIndex: 3, explanation: 'manger: ils mangent'),
        ExamQuestion(question: 'tu ___ (être)', options: ['est', 'êtes', 'es', 'suis'], correctIndex: 2, explanation: 'être: tu es'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'fr_a2_01', title: 'Présent et verbes irréguliers', subtitle: 'Настоящее время', emoji: '📝',
      level: LanguageLevel.a2, order: 1, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Неправильные глаголы', content: 'aller (идти): je vais, tu vas, il va, nous allons\nvenir (приходить): je viens, tu viens, il vient\nfaire (делать): je fais, tu fais, il fait, nous faisons\nprendre (брать): je prends, tu prends, il prend', examples: ['Je vais au cinéma.', 'Il fait beau aujourd\'hui.', 'Nous prenons le bus.']),
        TheorySection(title: 'Рефлексивные глаголы', content: 'se lever — вставать: je me lève\ns\'appeler — называться: je m\'appelle\nse coucher — ложиться: je me couche\nse laver — мыться: je me lave', examples: ['Je me lève à sept heures.', 'Elle se couche tard.', 'Nous nous lavons le matin.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'il ___ (aller)', options: ['allez', 'allons', 'va', 'vais'], correctIndex: 2, explanation: 'aller: il va'),
        CourseExercise(type: ExerciseType.translation, question: '"Я встаю в 7 часов":', options: ['Je dors à sept heures.', 'Je me lève à sept heures.', 'Je commence à sept heures.', 'Je pars à sept heures.'], correctIndex: 1, explanation: 'se lever: je me lève'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nous ___ le bus. (prendre)', options: ['prenons', 'prends', 'prend', 'prenez'], correctIndex: 0, explanation: 'prendre: nous prenons'),
      ],
      exam: [
        ExamQuestion(question: 'je ___ (faire)', options: ['fais', 'fait', 'faisons', 'faites'], correctIndex: 0, explanation: 'faire: je fais'),
        ExamQuestion(question: 'tu ___ (venir)', options: ['venez', 'viens', 'vient', 'venons'], correctIndex: 1, explanation: 'venir: tu viens'),
        ExamQuestion(question: '"Ложиться спать":', options: ['se lever', 'se coucher', 'se laver', 's\'habiller'], correctIndex: 1, explanation: 'se coucher = ложиться (спать)'),
        ExamQuestion(question: 'ils ___ (aller)', options: ['vont', 'allez', 'allons', 'va'], correctIndex: 0, explanation: 'aller: ils vont'),
        ExamQuestion(question: 'elle ___ (faire)', options: ['faites', 'fais', 'fait', 'font'], correctIndex: 2, explanation: 'faire: elle fait'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_02', title: 'Transport et voyage', subtitle: 'Транспорт и путешествия', emoji: '✈️',
      level: LanguageLevel.a2, order: 2, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Транспорт', content: 'la voiture — машина\nle bus — автобус\nle métro — метро\nle train — поезд\nl\'avion — самолёт\nle vélo — велосипед\nà pied — пешком', examples: ['Je prends le métro.', 'Elle voyage en avion.', 'Nous allons à pied.']),
        TheorySection(title: 'Направления', content: 'en + транспорт (крытый): en voiture, en avion\nà + транспорт (открытый): à vélo, à pied\naller à/au/en + место\nde ... à ... — от ... до ...', examples: ['Je vais en voiture.', 'Il voyage à vélo.', 'De Paris à Lyon en train.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-французски:', options: ['train', 'bateau', 'avion', 'bus'], correctIndex: 2, explanation: 'l\'avion = самолёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Я еду на машине":', options: ['Je vais à pied.', 'Je prends le bus.', 'Je voyage en voiture.', 'Je prends le train.'], correctIndex: 2, explanation: 'en voiture = на машине'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il voyage ___ vélo.', options: ['en', 'avec', 'à', 'par'], correctIndex: 2, explanation: 'à vélo = на велосипеде (открытый транспорт)'),
      ],
      exam: [
        ExamQuestion(question: '"Метро" по-французски:', options: ['bus', 'tram', 'métro', 'train'], correctIndex: 2, explanation: 'le métro = метро'),
        ExamQuestion(question: 'Je vais ___ voiture.', options: ['à', 'en', 'avec', 'par'], correctIndex: 1, explanation: 'en voiture = на машине'),
        ExamQuestion(question: '"Велосипед" по-французски:', options: ['moto', 'vélo', 'scooter', 'trotinette'], correctIndex: 1, explanation: 'le vélo = велосипед'),
        ExamQuestion(question: '"Пешком" по-французски:', options: ['en voiture', 'à pied', 'en bus', 'à vélo'], correctIndex: 1, explanation: 'à pied = пешком'),
        ExamQuestion(question: 'Je prends ___ train.', options: ['la', 'les', 'le', 'un'], correctIndex: 2, explanation: 'le train = поезд (муж.р.)'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_03', title: 'Météo et saisons', subtitle: 'Погода и сезоны', emoji: '☀️',
      level: LanguageLevel.a2, order: 3, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'Il fait beau. — Хорошая погода.\nIl fait chaud/froid. — Жарко/Холодно.\nIl pleut. — Идёт дождь.\nIl neige. — Идёт снег.\nIl y a du vent. — Ветрено.\nIl y a des nuages. — Облачно.', examples: ['Aujourd\'hui il fait beau.', 'En hiver, il neige.', 'Il y a du vent aujourd\'hui.']),
        TheorySection(title: 'Сезоны', content: 'le printemps — весна\nl\'été — лето\nl\'automne — осень\nl\'hiver — зима\nau printemps — весной\nen été/automne/hiver — летом/осенью/зимой', examples: ['En été, il fait chaud.', 'En hiver, il fait froid.', 'Au printemps, les fleurs poussent.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Идёт дождь" по-французски:', options: ['Il neige.', 'Il pleut.', 'Il fait froid.', 'Il y a du vent.'], correctIndex: 1, explanation: 'Il pleut. = идёт дождь (pleuvoir)'),
        CourseExercise(type: ExerciseType.translation, question: '"Зима" по-французски:', options: ['printemps', 'été', 'automne', 'hiver'], correctIndex: 3, explanation: 'l\'hiver = зима'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ été, il fait chaud.', options: ['Au', 'En', 'À', 'Le'], correctIndex: 1, explanation: 'en été = летом (en перед vowel: en été, en automne, en hiver)'),
      ],
      exam: [
        ExamQuestion(question: '"Весна" по-французски:', options: ['hiver', 'automne', 'printemps', 'été'], correctIndex: 2, explanation: 'le printemps = весна'),
        ExamQuestion(question: 'Il ___ aujourd\'hui. (снег)', options: ['pleut', 'neige', 'vente', 'tombe'], correctIndex: 1, explanation: 'neiger: il neige = идёт снег'),
        ExamQuestion(question: '"Холодно" по-французски:', options: ['Il fait beau.', 'Il fait chaud.', 'Il fait froid.', 'Il fait mauvais.'], correctIndex: 2, explanation: 'Il fait froid. = холодно'),
        ExamQuestion(question: '"Осень" по-французски:', options: ['printemps', 'été', 'automne', 'hiver'], correctIndex: 2, explanation: 'l\'automne = осень'),
        ExamQuestion(question: '"Ветрено" по-французски:', options: ['Il pleut.', 'Il y a du vent.', 'Il fait beau.', 'Il neige.'], correctIndex: 1, explanation: 'Il y a du vent. = ветрено'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_04', title: 'Vêtements et shopping', subtitle: 'Одежда и шопинг', emoji: '👗',
      level: LanguageLevel.a2, order: 4, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'la chemise — рубашка\nle pantalon — брюки\nla jupe — юбка\nla robe — платье\nle manteau — пальто\nles chaussures — обувь\nle pull — свитер', examples: ['Je porte une robe rouge.', 'Il achète un manteau.', 'Ces chaussures sont chères.']),
        TheorySection(title: 'Покупки', content: 'Combien ça coûte? — Сколько это стоит?\nÇa coûte ... euros. — Это стоит ... евро.\nJe voudrais ... — Я бы хотел/а ...\nAvez-vous cela en taille ...? — Есть у вас это в размере ...?', examples: ['Combien coûte cette robe?', 'Je voudrais essayer ce manteau.', 'Avez-vous cela en taille 40?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Платье" по-французски:', options: ['jupe', 'robe', 'chemise', 'pull'], correctIndex: 1, explanation: 'la robe = платье'),
        CourseExercise(type: ExerciseType.translation, question: '"Сколько это стоит?":', options: ['Qu\'est-ce que c\'est?', 'Combien ça coûte?', 'Où est-ce?', 'Quelle taille?'], correctIndex: 1, explanation: 'Combien ça coûte? = сколько это стоит?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Je ___ une robe bleue. (хотела бы)', options: ['veux', 'voudrais', 'aime', 'prends'], correctIndex: 1, explanation: 'voudrais = хотел/а бы (условное наклонение)'),
      ],
      exam: [
        ExamQuestion(question: '"Брюки" по-французски:', options: ['jupe', 'robe', 'pantalon', 'short'], correctIndex: 2, explanation: 'le pantalon = брюки'),
        ExamQuestion(question: 'Ça ___ 20 euros.', options: ['coûte', 'coûtent', 'vaut', 'fait'], correctIndex: 0, explanation: 'coûter: ça coûte'),
        ExamQuestion(question: '"Пальто" по-французски:', options: ['veste', 'manteau', 'pull', 'blouson'], correctIndex: 1, explanation: 'le manteau = пальто'),
        ExamQuestion(question: '"Размер" по-французски:', options: ['couleur', 'prix', 'taille', 'style'], correctIndex: 2, explanation: 'la taille = размер (одежды)'),
        ExamQuestion(question: '"Туфли/обувь" по-французски:', options: ['chaussettes', 'chaussures', 'bottes', 'sandales'], correctIndex: 1, explanation: 'les chaussures = обувь (общее слово)'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_05', title: 'Loisirs et sport', subtitle: 'Досуг и спорт', emoji: '⚽',
      level: LanguageLevel.a2, order: 5, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Досуг', content: 'lire — читать\nécouter de la musique — слушать музыку\nvoyager — путешествовать\ncuisiner — готовить\npeindre — рисовать\njouer aux jeux vidéo — играть в видеоигры', examples: ['J\'aime lire des romans.', 'Elle écoute de la musique le soir.', 'Nous voyageons chaque été.']),
        TheorySection(title: 'Спорт', content: 'jouer au football — играть в футбол\nnager — плавать\ncourir — бегать\nfaire du vélo — кататься на велосипеде\nfaire du ski — кататься на лыжах\nfaire de la gym — заниматься гимнастикой', examples: ['Il joue au tennis.', 'Je nage le dimanche.', 'Elle fait du yoga.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Плавать" по-французски:', options: ['courir', 'nager', 'sauter', 'marcher'], correctIndex: 1, explanation: 'nager = плавать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я играю в футбол":', options: ['Je regarde le football.', 'Je joue au football.', 'Je fais du football.', 'J\'aime le football.'], correctIndex: 1, explanation: 'jouer au football = играть в футбол'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'J\'aime ___ de la musique. (слушать)', options: ['jouer', 'écouter', 'faire', 'regarder'], correctIndex: 1, explanation: 'écouter de la musique = слушать музыку'),
      ],
      exam: [
        ExamQuestion(question: '"Готовить" по-французски:', options: ['manger', 'cuisiner', 'servir', 'goûter'], correctIndex: 1, explanation: 'cuisiner = готовить'),
        ExamQuestion(question: 'Je fais ___ vélo. (кататься)', options: ['au', 'du', 'de la', 'le'], correctIndex: 1, explanation: 'faire du vélo = кататься на велосипеде'),
        ExamQuestion(question: '"Читать" по-французски:', options: ['écrire', 'parler', 'lire', 'apprendre'], correctIndex: 2, explanation: 'lire = читать'),
        ExamQuestion(question: 'Il joue ___ tennis.', options: ['du', 'au', 'de la', 'à'], correctIndex: 1, explanation: 'jouer au (sport) = играть в (вид спорта)'),
        ExamQuestion(question: '"Бегать" по-французски:', options: ['marcher', 'nager', 'courir', 'sauter'], correctIndex: 2, explanation: 'courir = бегать'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_06', title: 'Travail et études', subtitle: 'Работа и учёба', emoji: '💼',
      level: LanguageLevel.a2, order: 6, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Профессии', content: 'le médecin — врач\nle professeur — учитель/профессор\nl\'ingénieur — инженер\nle cuisinier — повар\nle programmeur — программист\nl\'avocat — адвокат', examples: ['Je suis médecin.', 'Elle est professeure.', 'Il travaille comme ingénieur.']),
        TheorySection(title: 'Учёба', content: 'l\'école — школа\nl\'université — университет\napprendre — учить/узнавать\nétudier — изучать\nl\'examen — экзамен\nla matière — предмет', examples: ['J\'apprends le français.', 'Elle étudie la médecine.', 'Demain j\'ai un examen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Врач" по-французски:', options: ['avocat', 'médecin', 'ingénieur', 'professeur'], correctIndex: 1, explanation: 'le médecin = врач'),
        CourseExercise(type: ExerciseType.translation, question: '"Она изучает медицину":', options: ['Elle est médecin.', 'Elle étudie la médecine.', 'Elle apprend médecine.', 'Elle travaille comme médecin.'], correctIndex: 1, explanation: 'étudier = изучать (в вузе)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Demain j\'ai ___ examen.', options: ['le', 'la', 'un', 'une'], correctIndex: 2, explanation: 'un examen = экзамен (муж.р., неопр.арт.)'),
      ],
      exam: [
        ExamQuestion(question: '"Программист" по-французски:', options: ['médecin', 'avocat', 'programmeur', 'ingénieur'], correctIndex: 2, explanation: 'le programmeur = программист'),
        ExamQuestion(question: 'J\'___ le français. (учу)', options: ['étudie', 'apprends', 'fais', 'lis'], correctIndex: 1, explanation: 'apprendre = учить/изучать'),
        ExamQuestion(question: '"Предмет" (школьный) по-французски:', options: ['livre', 'classe', 'matière', 'leçon'], correctIndex: 2, explanation: 'la matière = учебный предмет'),
        ExamQuestion(question: '"Адвокат" по-французски:', options: ['médecin', 'juge', 'avocat', 'notaire'], correctIndex: 2, explanation: 'l\'avocat = адвокат'),
        ExamQuestion(question: 'Il travaille ___ ingénieur.', options: ['comme', 'en', 'à', 'pour'], correctIndex: 0, explanation: 'travailler comme = работать как/в качестве'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_07', title: 'Décrire les personnes', subtitle: 'Описание людей', emoji: '🧑',
      level: LanguageLevel.a2, order: 7, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Внешность', content: 'grand(e)/petit(e) — высокий/низкий\ngros(se)/mince — толстый/худой\nles cheveux blonds/bruns — светлые/тёмные волосы\nles yeux bleus/verts — голубые/зелёные глаза\njeune/vieux(vieille) — молодой/старый', examples: ['Il est grand avec les yeux bleus.', 'Elle a les cheveux blonds.', 'Mon ami est jeune et mince.']),
        TheorySection(title: 'Характер', content: 'sympa(thique) — симпатичный/приятный\ndrôle — смешной/весёлый\ncalme — спокойный\ntravailleur(-euse) — трудолюбивый\nintelligent(e) — умный', examples: ['Elle est très sympa.', 'Mon prof est drôle.', 'Il est calme et intelligent.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Высокий" по-французски:', options: ['petit', 'mince', 'grand', 'gros'], correctIndex: 2, explanation: 'grand(e) = большой/высокий'),
        CourseExercise(type: ExerciseType.translation, question: '"Она весёлая и умная":', options: ['Elle est calme et mince.', 'Elle est drôle et intelligente.', 'Elle est sympa et travailleuse.', 'Elle est grande et belle.'], correctIndex: 1, explanation: 'drôle = весёлый/смешной; intelligente = умная (жен.р.)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il a les cheveux ___. (тёмные)', options: ['blonds', 'roux', 'bruns', 'gris'], correctIndex: 2, explanation: 'les cheveux bruns = тёмные волосы'),
      ],
      exam: [
        ExamQuestion(question: '"Трудолюбивый" по-французски:', options: ['drôle', 'calme', 'travailleur', 'sympa'], correctIndex: 2, explanation: 'travailleur(-euse) = трудолюбивый'),
        ExamQuestion(question: '"Худой/стройный" по-французски:', options: ['gros', 'petit', 'grand', 'mince'], correctIndex: 3, explanation: 'mince = тонкий/стройный/худой'),
        ExamQuestion(question: 'Elle a les yeux ___. (голубые)', options: ['verts', 'noirs', 'bleus', 'marron'], correctIndex: 2, explanation: 'les yeux bleus = голубые глаза'),
        ExamQuestion(question: '"Спокойный" по-французски:', options: ['drôle', 'intelligent', 'calme', 'sympa'], correctIndex: 2, explanation: 'calme = спокойный'),
        ExamQuestion(question: '"Молодой" по-французски:', options: ['vieux', 'âgé', 'jeune', 'nouveau'], correctIndex: 2, explanation: 'jeune = молодой'),
      ],
    ),

    CourseChapter(
      id: 'fr_a2_08', title: 'Futur', subtitle: 'Будущее время', emoji: '🔮',
      level: LanguageLevel.a2, order: 8, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Futur proche', content: 'aller + Infinitif = ближайшее будущее\nJe vais manger. — Я собираюсь поесть.\nТу как английское "going to"\nнаиболее употребительно в разговоре', examples: ['Je vais partir demain.', 'Il va pleuvoir.', 'Nous allons visiter Paris.']),
        TheorySection(title: 'Futur simple', content: 'Infinitif + -ai, -as, -a, -ons, -ez, -ont\nparler: je parlerai, tu parleras, il parlera\nêtre: je serai, avoir: j\'aurai\naller: j\'irai, faire: je ferai', examples: ['Demain, je parlerai au directeur.', 'Elle sera médecin.', 'Nous irons en France.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я собираюсь поехать" (futur proche):', options: ['Je pars.', 'Je vais partir.', 'Je partirai.', 'Je suis parti.'], correctIndex: 1, explanation: 'futur proche: aller + Infinitif'),
        CourseExercise(type: ExerciseType.translation, question: '"Завтра она будет врачом" (futur simple):', options: ['Elle est médecin.', 'Elle va être médecin.', 'Elle sera médecin.', 'Elle était médecin.'], correctIndex: 2, explanation: 'être futur: elle sera'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nous ___ en France. (aller, futur simple)', options: ['allons', 'irons', 'allez', 'vont'], correctIndex: 1, explanation: 'aller futur: nous irons (неправ.)'),
      ],
      exam: [
        ExamQuestion(question: 'je ___ (parler, futur simple)', options: ['parle', 'parlais', 'parlerai', 'parlera'], correctIndex: 2, explanation: 'futur simple: je parlerai'),
        ExamQuestion(question: '"Пойдёт дождь" (futur proche):', options: ['Il pleut.', 'Il va pleuvoir.', 'Il pleuvra.', 'Il a plu.'], correctIndex: 1, explanation: 'futur proche: il va pleuvoir'),
        ExamQuestion(question: 'faire → futur simple (je):', options: ['ferai', 'faisais', 'fais', 'fera'], correctIndex: 0, explanation: 'faire → je ferai (неправильное)'),
        ExamQuestion(question: '"Завтра" по-французски:', options: ['hier', 'aujourd\'hui', 'demain', 'bientôt'], correctIndex: 2, explanation: 'demain = завтра'),
        ExamQuestion(question: 'être → futur (elle):', options: ['est', 'était', 'sera', 'soit'], correctIndex: 2, explanation: 'être futur: elle sera'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'fr_b1_01', title: 'Passé composé', subtitle: 'Прошедшее время', emoji: '📚',
      level: LanguageLevel.b1, order: 1, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Passé composé с avoir', content: 'avoir + participe passé\nparler → parlé\nfinir → fini\nprendre → pris\nvoir → vu\nfaire → fait', examples: ['J\'ai mangé une pizza.', 'Elle a fini son travail.', 'Nous avons vu un film.']),
        TheorySection(title: 'Passé composé с être', content: '14 глаголов движения + рефлексивные:\naller → je suis allé(e)\nvenir → je suis venu(e)\nnaître/mourir, partir/arriver, entrer/sortir\nСогласование с субъектом!', examples: ['Elle est allée au cinéma.', 'Ils sont venus hier.', 'Je me suis levé à 7h.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Passé composé от "manger" (j\'ai...):', options: ['mangé', 'mangi', 'mangé', 'manger'], correctIndex: 0, explanation: 'manger → mangé (правильный глагол -er)'),
        CourseExercise(type: ExerciseType.translation, question: '"Она пошла в кино":', options: ['Elle a allé au cinéma.', 'Elle est allée au cinéma.', 'Elle allait au cinéma.', 'Elle va au cinéma.'], correctIndex: 1, explanation: 'aller = être: elle est allée (согласование — е)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Nous ___ vu un film. (avoir)', options: ['sommes', 'avons', 'ont', 'êtes'], correctIndex: 1, explanation: 'voir = avoir: nous avons vu'),
      ],
      exam: [
        ExamQuestion(question: 'faire → participe passé:', options: ['faisant', 'fait', 'faisé', 'faire'], correctIndex: 1, explanation: 'faire → fait'),
        ExamQuestion(question: 'Ils ___ partis hier. (partir)', options: ['ont', 'sont', 'avons', 'êtes'], correctIndex: 1, explanation: 'partir = être: ils sont partis'),
        ExamQuestion(question: 'voir → participe passé:', options: ['voyé', 'vu', 'voir', 'vist'], correctIndex: 1, explanation: 'voir → vu (неправильный)'),
        ExamQuestion(question: 'Elle ___ mangé. (avoir)', options: ['est', 'a', 'ai', 'avons'], correctIndex: 1, explanation: 'avoir: elle a'),
        ExamQuestion(question: 'prendre → participe passé:', options: ['prendu', 'pris', 'prené', 'prend'], correctIndex: 1, explanation: 'prendre → pris (неправильный)'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_02', title: 'Imparfait', subtitle: 'Незаконченное прошедшее', emoji: '⏪',
      level: LanguageLevel.b1, order: 2, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование imparfait', content: 'Основа nous (présent) + окончания:\n-ais, -ais, -ait, -ions, -iez, -aient\nparler: nous parlons → je parlais\nfaire: nous faisons → je faisais', examples: ['Quand j\'étais petit, je jouais.', 'Il faisait beau hier.', 'Nous habitions à Paris.']),
        TheorySection(title: 'Употребление', content: 'Imparfait vs Passé composé:\nImparfait = фон, привычка, незаконченное\nPassé composé = конкретный факт, событие\nQuand j\'étais enfant (фон), j\'ai rencontré Marie (событие).', examples: ['Je lisais quand il est arrivé.', 'Chaque été, nous allions à la mer.', 'Il pleuvait quand elle est sortie.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'parler → imparfait (je):', options: ['parlai', 'parlais', 'parlé', 'parlait'], correctIndex: 1, explanation: 'imparfait: je parlais'),
        CourseExercise(type: ExerciseType.translation, question: '"Когда я был маленьким, я играл" (привычка):', options: ['Quand j\'ai été petit, j\'ai joué.', 'Quand j\'étais petit, je jouais.', 'Quand je suis petit, je joue.', 'Quand j\'étais petit, j\'ai joué.'], correctIndex: 1, explanation: 'Привычка в прошлом = imparfait'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il ___ beau quand je suis sorti. (faire, фон)', options: ['fait', 'faisait', 'a fait', 'fera'], correctIndex: 1, explanation: 'Фон/состояние = imparfait: il faisait'),
      ],
      exam: [
        ExamQuestion(question: 'faire → imparfait (je):', options: ['faisais', 'faisai', 'fassais', 'ferai'], correctIndex: 0, explanation: 'faire → nous faisons → je faisais'),
        ExamQuestion(question: 'Imparfait используется для:', options: ['конкретного события', 'привычки в прошлом', 'ближайшего будущего', 'команды'], correctIndex: 1, explanation: 'Imparfait = повторяющееся действие/фон'),
        ExamQuestion(question: 'être → imparfait (elle):', options: ['était', 'étais', 'est', 'sera'], correctIndex: 0, explanation: 'être → elle était'),
        ExamQuestion(question: 'Je lisais quand il ___ arrivé. (événement)', options: ['était', 'est', 'a', 'avait'], correctIndex: 1, explanation: 'Событие = passé composé: il est arrivé'),
        ExamQuestion(question: 'habiter → imparfait (nous):', options: ['habitons', 'habitions', 'habitions', 'habitiez'], correctIndex: 1, explanation: 'nous habitions (imparfait)'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_03', title: 'Subjonctif présent', subtitle: 'Сослагательное наклонение', emoji: '🎯',
      level: LanguageLevel.b1, order: 3, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование subjonctif', content: 'Основа ils (présent) + -e, -es, -e, -ions, -iez, -ent\nparler: ils parlent → que je parle\nfinir: ils finissent → que je finisse\nêtre: que je sois\navoir: que j\'aie', examples: ['Il faut que tu parles.', 'Je veux qu\'il vienne.', 'Il est important que nous soyons là.']),
        TheorySection(title: 'После каких слов', content: 'После выражений желания, необходимости, чувств:\nvouloir que, falloir que, être important que\naimer que, avoir peur que, bien que (хотя)', examples: ['Je veux que tu sois heureux.', 'Il faut que vous fassiez ça.', 'Bien qu\'il soit fatigué, il travaille.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'être → subjonctif (je):', options: ['sois', 'soit', 'suis', 'serai'], correctIndex: 0, explanation: 'être subjonctif: que je sois'),
        CourseExercise(type: ExerciseType.translation, question: '"Нужно, чтобы ты говорил":', options: ['Tu dois parler.', 'Il faut que tu parles.', 'Il faut tu parles.', 'Tu vas parler.'], correctIndex: 1, explanation: 'Il faut que + subjonctif'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Je veux qu\'il ___. (venir, subj)', options: ['vient', 'vienne', 'viendra', 'venait'], correctIndex: 1, explanation: 'venir subjonctif: qu\'il vienne'),
      ],
      exam: [
        ExamQuestion(question: 'avoir → subjonctif (j\'ai...):', options: ['aie', 'ait', 'ai', 'aurai'], correctIndex: 0, explanation: 'avoir subjonctif: que j\'aie'),
        ExamQuestion(question: 'faire → subjonctif (vous):', options: ['faites', 'fassiez', 'feriez', 'ferez'], correctIndex: 1, explanation: 'faire subjonctif: que vous fassiez'),
        ExamQuestion(question: 'Subjonctif используется после:', options: ['parce que', 'quand', 'il faut que', 'si'], correctIndex: 2, explanation: 'il faut que + subjonctif'),
        ExamQuestion(question: 'Bien qu\'il ___ fatigué, il travaille.', options: ['est', 'soit', 'sera', 'était'], correctIndex: 1, explanation: 'bien que + subjonctif: soit'),
        ExamQuestion(question: 'parler → subjonctif (tu):', options: ['parles', 'parles', 'parlais', 'parleras'], correctIndex: 0, explanation: 'parler subj: que tu parles (= présent)'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_04', title: 'Passif', subtitle: 'Пассивный залог', emoji: '🔄',
      level: LanguageLevel.b1, order: 4, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование пассива', content: 'être + participe passé (согласован с подлежащим)\nLe livre est lu. — Книга читается.\nLa maison est construite. — Дом строится.\nLes enfants sont aimés. — Детей любят.\npar + агент действия', examples: ['Ce roman est lu par tout le monde.', 'La lettre a été écrite par Marie.', 'Les voitures sont réparées ici.']),
        TheorySection(title: 'Пассив в разных временах', content: 'Présent: est + PP\nPassé composé: a été + PP\nImparfait: était + PP\nFutur: sera + PP', examples: ['Le gâteau est mangé.', 'Le gâteau a été mangé.', 'Le gâteau sera mangé demain.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Книга читается" (passif présent):', options: ['Le livre lit.', 'Le livre est lu.', 'Le livre a lu.', 'On lit le livre.'], correctIndex: 1, explanation: 'Passif: être + participe passé'),
        CourseExercise(type: ExerciseType.translation, question: '"Письмо было написано Мари":', options: ['Marie a écrit la lettre.', 'La lettre est écrite.', 'La lettre a été écrite par Marie.', 'La lettre était écrite par Marie.'], correctIndex: 2, explanation: 'Passé composé passif: a été + PP + par'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'La maison ___ construite demain. (futur)', options: ['est', 'était', 'sera', 'a été'], correctIndex: 2, explanation: 'Futur passif: sera construite'),
      ],
      exam: [
        ExamQuestion(question: 'lire → participe passé:', options: ['lisant', 'lu', 'lis', 'liré'], correctIndex: 1, explanation: 'lire → lu'),
        ExamQuestion(question: '"Дома строятся" (passif):', options: ['Les maisons construisent.', 'Les maisons sont construites.', 'On construit les maisons.', 'Les maisons ont construit.'], correctIndex: 1, explanation: 'Passif: les maisons sont construites'),
        ExamQuestion(question: 'écrire → participe passé:', options: ['écrivé', 'écrit', 'écrivent', 'écrire'], correctIndex: 1, explanation: 'écrire → écrit'),
        ExamQuestion(question: 'Le film ___ vu par des millions.', options: ['a', 'est', 'était', 'sera'], correctIndex: 1, explanation: 'Passif présent: est vu'),
        ExamQuestion(question: 'faire → participe passé (для пассива):', options: ['faisant', 'faisé', 'fait', 'faire'], correctIndex: 2, explanation: 'faire → fait'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_05', title: 'Discours indirect', subtitle: 'Косвенная речь', emoji: '💬',
      level: LanguageLevel.b1, order: 5, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Косвенная речь', content: 'Il dit que ... — Он говорит, что ...\nIl a dit que ... — Он сказал, что ...\nСдвиг времён при прошедшем глаголе:\npresent → imparfait\nfutur → conditionnel\npassé composé → plus-que-parfait', examples: ['Il dit: "Je suis fatigué." → Il dit qu\'il est fatigué.', 'Il a dit: "Je suis fatigué." → Il a dit qu\'il était fatigué.', 'Elle a dit qu\'elle viendrait.']),
        TheorySection(title: 'Косвенные вопросы', content: 'Oui/non: demander si + ...\nСпециальные вопросы: demander + qui/quoi/où/quand/comment/pourquoi + ...\nПорядок слов = порядок утверждения!', examples: ['Il demande si tu viens.', 'Elle demande où tu habites.', 'Je veux savoir pourquoi il part.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Il dit: Je suis malade" → discours indirect:', options: ['Il dit qu\'il est malade.', 'Il dit qu\'il était malade.', 'Il a dit qu\'il est malade.', 'Il dit il est malade.'], correctIndex: 0, explanation: 'dire (présent) + que + présent: il dit qu\'il est'),
        CourseExercise(type: ExerciseType.translation, question: '"Он спрашивает, придёшь ли ты":', options: ['Il demande si tu viens.', 'Il demande que tu viennes.', 'Il demande tu viens?', 'Il veut savoir si tu viens.'], correctIndex: 0, explanation: 'demander si = спрашивать, придёт ли'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Il a dit qu\'il ___ fatigué. (être, imparfait)', options: ['est', 'était', 'sera', 'soit'], correctIndex: 1, explanation: 'passé → сдвиг: présent→imparfait'),
      ],
      exam: [
        ExamQuestion(question: 'Сдвиг présent → ? (при passé composé глагола говорения):', options: ['futur', 'imparfait', 'subjonctif', 'conditionnel'], correctIndex: 1, explanation: 'présent → imparfait в косвенной речи при прошедшем'),
        ExamQuestion(question: '"Elle dit: Je viendrai" → indirect (il dit présent):', options: ['Elle dit qu\'elle viendra.', 'Elle dit qu\'elle viendrait.', 'Elle a dit qu\'elle viendrait.', 'Elle dit qu\'elle est venue.'], correctIndex: 0, explanation: 'dire présent: futur остаётся futur'),
        ExamQuestion(question: 'Kosвенный вопрос "Où habites-tu?":', options: ['Il demande où tu habites.', 'Il demande où habites-tu.', 'Il demande si tu habites.', 'Il demande que tu habites.'], correctIndex: 0, explanation: 'Без инверсии в косвенном вопросе'),
        ExamQuestion(question: 'Сдвиг futur → ? (при прошедшем):', options: ['imparfait', 'subjonctif', 'conditionnel', 'présent'], correctIndex: 2, explanation: 'futur → conditionnel в косвенной речи'),
        ExamQuestion(question: 'Il a demandé ___ j\'habitais.', options: ['que', 'si', 'quoi', 'dont'], correctIndex: 1, explanation: 'demander si = спрашивать (да/нет вопрос)'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_06', title: 'Comparatif et superlatif', subtitle: 'Сравнения', emoji: '📊',
      level: LanguageLevel.b1, order: 6, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Comparatif', content: 'plus + adj + que — более ... чем\nmoins + adj + que — менее ... чем\naussi + adj + que — так же ... как\nbien → mieux; mauvais → pire', examples: ['Il est plus grand que moi.', 'Elle parle moins vite que lui.', 'Ce film est aussi bon que l\'autre.']),
        TheorySection(title: 'Superlatif', content: 'le/la/les plus + adj — самый ...\nle/la/les moins + adj — наименее ...\nbien → le mieux; mauvais → le pire\nde + groupe', examples: ['C\'est la plus belle ville du monde.', 'Il est le plus intelligent de la classe.', 'C\'est le meilleur restaurant ici.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Он выше меня":', options: ['Il est aussi grand que moi.', 'Il est plus grand que moi.', 'Il est moins grand que moi.', 'Il est grand comme moi.'], correctIndex: 1, explanation: 'plus + adj + que = более ... чем'),
        CourseExercise(type: ExerciseType.translation, question: '"Это лучший ресторан":', options: ['C\'est un bon restaurant.', 'C\'est le meilleur restaurant.', 'C\'est plus bon restaurant.', 'C\'est très bon restaurant.'], correctIndex: 1, explanation: 'bon → meilleur (superlatif irrégulier)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Elle est ___ intelligente de la classe.', options: ['la plus', 'le plus', 'plus', 'très'], correctIndex: 0, explanation: 'Superlatif жен.р.: la plus intelligente'),
      ],
      exam: [
        ExamQuestion(question: 'bon → comparatif:', options: ['plus bon', 'meilleur', 'mieux', 'le meilleur'], correctIndex: 1, explanation: 'bon → meilleur (неправильное сравнение)'),
        ExamQuestion(question: '"Менее быстро чем он":', options: ['plus vite que lui', 'aussi vite que lui', 'moins vite que lui', 'si vite que lui'], correctIndex: 2, explanation: 'moins + adv + que'),
        ExamQuestion(question: '"Самый красивый в мире":', options: ['plus beau du monde', 'le plus beau du monde', 'aussi beau du monde', 'très beau du monde'], correctIndex: 1, explanation: 'le plus + adj + de = суперлатив'),
        ExamQuestion(question: 'mauvais → superlatif:', options: ['le plus mauvais / le pire', 'moins mauvais', 'le meilleur', 'plus mauvais'], correctIndex: 0, explanation: 'mauvais → le pire (или le plus mauvais)'),
        ExamQuestion(question: '"Так же умный, как она":', options: ['plus intelligent qu\'elle', 'aussi intelligent qu\'elle', 'moins intelligent qu\'elle', 'si intelligent qu\'elle'], correctIndex: 1, explanation: 'aussi + adj + que = так же ... как'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_07', title: 'Technologie et médias', subtitle: 'Технологии и СМИ', emoji: '💻',
      level: LanguageLevel.b1, order: 7, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Цифровой мир', content: 'internet — интернет\nune application — приложение\nun site web — веб-сайт\nun smartphone — смартфон\nl\'IA (Intelligence Artificielle) — ИИ\ntélécharger — скачивать\nse connecter — подключаться', examples: ['Je télécharge l\'application.', 'L\'IA devient de plus en plus importante.', 'Il faut se connecter à internet.']),
        TheorySection(title: 'Общение онлайн', content: 'envoyer un e-mail — отправить email\npartager une photo — поделиться фото\nsuivre quelqu\'un — подписаться на кого-то\nune publication — публикация\nles réseaux sociaux — соцсети', examples: ['J\'envoie un e-mail à mon patron.', 'Elle partage des photos sur Instagram.', 'Je suis 200 personnes sur Twitter.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Скачивать" по-французски:', options: ['envoyer', 'partager', 'télécharger', 'chercher'], correctIndex: 2, explanation: 'télécharger = скачивать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я отправлю email":', options: ['Je reçois un e-mail.', 'J\'enverrai un e-mail.', 'Je lis un e-mail.', 'J\'écris un e-mail.'], correctIndex: 1, explanation: 'envoyer futur: j\'enverrai'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Les ___ sociaux sont très populaires.', options: ['médias', 'réseaux', 'sites', 'applications'], correctIndex: 1, explanation: 'les réseaux sociaux = социальные сети'),
      ],
      exam: [
        ExamQuestion(question: '"Приложение" по-французски:', options: ['site web', 'application', 'logiciel', 'programme'], correctIndex: 1, explanation: 'une application = приложение'),
        ExamQuestion(question: '"Поделиться фото":', options: ['télécharger une photo', 'partager une photo', 'envoyer une photo', 'chercher une photo'], correctIndex: 1, explanation: 'partager = делиться/публиковать'),
        ExamQuestion(question: 'IA = ?', options: ['Internet Avancé', 'Intelligence Artificielle', 'Information Automatique', 'Industrie Algorithmique'], correctIndex: 1, explanation: 'IA = Intelligence Artificielle = Искусственный интеллект'),
        ExamQuestion(question: '"Подписаться" (на аккаунт):', options: ['partager', 'télécharger', 'suivre', 'liker'], correctIndex: 2, explanation: 'suivre quelqu\'un = подписаться на кого-то'),
        ExamQuestion(question: '"Смартфон" по-французски:', options: ['ordinateur', 'tablette', 'smartphone', 'téléphone fixe'], correctIndex: 2, explanation: 'un smartphone = смартфон'),
      ],
    ),

    CourseChapter(
      id: 'fr_b1_08', title: 'Santé et médecine', subtitle: 'Здоровье и медицина', emoji: '🏥',
      level: LanguageLevel.b1, order: 8, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Медицина', content: 'le rhume — насморк/простуда\nla fièvre — температура\nla toux — кашель\nune allergie — аллергия\nune ordonnance — рецепт\nla pharmacie — аптека\nle médicament — лекарство', examples: ['J\'ai un rhume depuis hier.', 'Il a besoin d\'une ordonnance.', 'Je prends ce médicament.']),
        TheorySection(title: 'У врача', content: 'Je ne me sens pas bien. — Мне нехорошо.\nDepuis quand avez-vous mal? — С каких пор болит?\nJe vous prescris ... — Я вам назначаю ...\nPrenez ces comprimés 3 fois par jour. — Принимайте эти таблетки 3 раза в день.', examples: ['Je ne me sens pas bien depuis ce matin.', 'Le médecin me prescrit des antibiotiques.', 'Trois fois par jour avec de l\'eau.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Насморк/простуда" по-французски:', options: ['toux', 'fièvre', 'rhume', 'allergie'], correctIndex: 2, explanation: 'le rhume = насморк/простуда'),
        CourseExercise(type: ExerciseType.translation, question: '"Мне нехорошо":', options: ['Je suis malade.', 'Je ne me sens pas bien.', 'J\'ai mal.', 'Je suis fatigué.'], correctIndex: 1, explanation: 'ne pas se sentir bien = чувствовать себя нехорошо'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Prenez ces ___ trois fois par jour.', options: ['ordonnances', 'médicaments', 'comprimés', 'remèdes'], correctIndex: 2, explanation: 'les comprimés = таблетки'),
      ],
      exam: [
        ExamQuestion(question: '"Аптека" по-французски:', options: ['hôpital', 'clinique', 'pharmacie', 'cabinet'], correctIndex: 2, explanation: 'la pharmacie = аптека'),
        ExamQuestion(question: '"Кашель" по-французски:', options: ['rhume', 'fièvre', 'toux', 'douleur'], correctIndex: 2, explanation: 'la toux = кашель'),
        ExamQuestion(question: 'Je ___ pas bien. (ne me sens)', options: ['suis', 'me sens', 'fais', 'vais'], correctIndex: 1, explanation: 'se sentir: je me sens'),
        ExamQuestion(question: '"Рецепт" по-французски:', options: ['médicament', 'ordonnance', 'comprimé', 'traitement'], correctIndex: 1, explanation: 'une ordonnance = медицинский рецепт'),
        ExamQuestion(question: 'Depuis quand ___ vous mal?', options: ['êtes', 'avez', 'faites', 'allez'], correctIndex: 1, explanation: 'avoir mal: vous avez mal'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'fr_b2_01', title: 'Conditionnel', subtitle: 'Условное наклонение', emoji: '💭',
      level: LanguageLevel.b2, order: 1, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Conditionnel présent', content: 'Futur simple + imparfait endings:\n-ais, -ais, -ait, -ions, -iez, -aient\naimer: j\'aimerais\nêtre: je serais\navoir: j\'aurais\naller: j\'irais', examples: ['Je voudrais un café.', 'Il serait heureux si tu venais.', 'Nous aimerions voyager.']),
        TheorySection(title: 'Условные предложения', content: 'Тип 2 (нереальное): si + imparfait, ... conditionnel\nSi j\'avais le temps, je voyagerais.\nТип 3 (прошедшее нереальное): si + PQP, ... conditionnel passé\nSi j\'avais eu le temps, j\'aurais voyagé.', examples: ['Si j\'étais riche, j\'achèterais une villa.', 'Si tu avais étudié, tu aurais réussi.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'j\'___ (aimer, conditionnel)', options: ['aimerai', 'aimerais', 'aimais', 'aime'], correctIndex: 1, explanation: 'conditionnel: j\'aimerais'),
        CourseExercise(type: ExerciseType.translation, question: '"Если бы у меня было время, я бы путешествовал":', options: ['Si j\'ai le temps, je voyage.', 'Si j\'avais le temps, je voyagerais.', 'Si j\'aurais le temps, je voyagerais.', 'Si j\'avais le temps, je voyageais.'], correctIndex: 1, explanation: 'Si + imparfait → conditionnel (тип 2)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'être → conditionnel (elle):', options: ['sera', 'était', 'serait', 'soit'], correctIndex: 2, explanation: 'être conditionnel: elle serait'),
      ],
      exam: [
        ExamQuestion(question: 'avoir → conditionnel (j\'):', options: ['aurai', 'aurais', 'avais', 'aie'], correctIndex: 1, explanation: 'avoir conditionnel: j\'aurais'),
        ExamQuestion(question: 'Si + imparfait → ... :', options: ['futur', 'conditionnel', 'subjonctif', 'passé composé'], correctIndex: 1, explanation: 'Si + imparfait + conditionnel présent = тип 2'),
        ExamQuestion(question: 'aller → conditionnel (nous):', options: ['allons', 'irions', 'allions', 'irons'], correctIndex: 1, explanation: 'aller → nous irions (conditionnel)'),
        ExamQuestion(question: '"Если бы ты учился, ты бы сдал" (тип 3):', options: ['Si tu étudiais, tu réussirais.', 'Si tu avais étudié, tu aurais réussi.', 'Si tu as étudié, tu as réussi.', 'Si tu étudieras, tu réussiras.'], correctIndex: 1, explanation: 'Si + PQP → conditionnel passé (тип 3)'),
        ExamQuestion(question: 'vouloir → conditionnel (je):', options: ['voudrai', 'voulais', 'voudrais', 'veule'], correctIndex: 2, explanation: 'vouloir conditionnel: je voudrais'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_02', title: 'Participes et gérondif', subtitle: 'Причастия и деепричастие', emoji: '🎓',
      level: LanguageLevel.b2, order: 2, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Participe présent', content: 'Основа nous (présent) + -ant\nparler → parlant\nfinir → finissant\nêtre → étant\navoir → ayant\nМожет заменять придаточное.', examples: ['Une personne parlant français.', 'Étant fatigué, il est parti.', 'Ayant fini, elle est sortie.']),
        TheorySection(title: 'Gérondif', content: 'en + participe présent = деепричастие\nВыражает одновременность, способ:\nEn travaillant, il écoute de la musique.\nEn mangeant moins, tu maigris.', examples: ['Il lit en mangeant.', 'En étudiant chaque jour, tu progresses.', 'Elle sourit en parlant.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'finir → participe présent:', options: ['finissant', 'finant', 'finissé', 'finit'], correctIndex: 0, explanation: 'finir → nous finissons → finissant'),
        CourseExercise(type: ExerciseType.translation, question: '"Он читает, слушая музыку" (gérondif):', options: ['Il lit et il écoute la musique.', 'Il lit en écoutant la musique.', 'En lisant, il écoute la musique.', 'Il lit pendant qu\'il écoute.'], correctIndex: 1, explanation: 'gérondif: en + participe présent'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ fatigué, il est parti tôt.', options: ['Étant', 'Être', 'En étant', 'Ayant'], correctIndex: 0, explanation: 'Participe présent: Étant fatigué'),
      ],
      exam: [
        ExamQuestion(question: 'parler → participe présent:', options: ['parlé', 'parlant', 'parle', 'parlait'], correctIndex: 1, explanation: 'parler → parlant'),
        ExamQuestion(question: 'avoir → participe présent:', options: ['ayant', 'avant', 'avent', 'eu'], correctIndex: 0, explanation: 'avoir → ayant (неправильный)'),
        ExamQuestion(question: 'Gérondif = en + ?', options: ['infinitif', 'participe passé', 'participe présent', 'imparfait'], correctIndex: 2, explanation: 'Gérondif = en + participe présent'),
        ExamQuestion(question: '"Изучая каждый день, прогрессируешь":', options: ['En étudiant chaque jour, tu progresses.', 'Étudiant chaque jour, tu progresses.', 'Si tu études chaque jour, tu progresses.', 'Quand tu étudies, tu progresses.'], correctIndex: 0, explanation: 'Gérondif: en étudiant'),
        ExamQuestion(question: 'être → participe présent:', options: ['ayant', 'être', 'étant', 'été'], correctIndex: 2, explanation: 'être → étant (неправильный)'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_03', title: 'Français des affaires', subtitle: 'Деловой французский', emoji: '📊',
      level: LanguageLevel.b2, order: 3, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Деловая переписка', content: 'Madame, Monsieur — Уважаемые\nJe me permets de vous contacter — Позвольте связаться с вами\nVeuillez trouver ci-joint — Прошу найти в приложении\nDans l\'attente de votre réponse — В ожидании вашего ответа\nCordialement / Bien cordialement — С уважением', examples: ['Je me permets de vous contacter au sujet de...', 'Veuillez trouver ci-joint mon CV.', 'Dans l\'attente de votre réponse, cordialement.']),
        TheorySection(title: 'Переговоры', content: 'Je propose de ... — Я предлагаю ...\nQue pensez-vous de ...? — Что вы думаете о ...?\nC\'est envisageable. — Это возможно.\nMalheureusement, ce n\'est pas possible. — К сожалению, это невозможно.', examples: ['Je propose une réunion lundi.', 'Que pensez-vous de cette offre?', 'Malheureusement, ce n\'est pas dans notre budget.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Стандартное завершение делового письма:', options: ['Salut', 'À bientôt', 'Cordialement', 'Bisous'], correctIndex: 2, explanation: 'Cordialement = с уважением (официально)'),
        CourseExercise(type: ExerciseType.translation, question: '"Прошу найти в приложении мой CV":', options: ['Je vous envoie mon CV.', 'Veuillez trouver ci-joint mon CV.', 'Voilà mon CV.', 'Mon CV est là.'], correctIndex: 1, explanation: 'Veuillez trouver ci-joint = стандартная деловая фраза'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Je me ___ de vous contacter.', options: ['peux', 'permets', 'veux', 'dois'], correctIndex: 1, explanation: 'se permettre de = позволить себе; je me permets de'),
      ],
      exam: [
        ExamQuestion(question: 'ci-joint = ?', options: ['здесь', 'в приложении', 'выше', 'ниже'], correctIndex: 1, explanation: 'ci-joint = в приложении/прилагается'),
        ExamQuestion(question: '"К сожалению, это невозможно":', options: ['C\'est possible.', 'Malheureusement, ce n\'est pas possible.', 'Ce n\'est pas bien.', 'Nous refusons.'], correctIndex: 1, explanation: 'Malheureusement + negation = отказ вежливо'),
        ExamQuestion(question: '"В ожидании вашего ответа" — стандартная фраза:', options: ['Merci de votre réponse.', 'Dans l\'attente de votre réponse.', 'J\'attends votre réponse.', 'Répondez-moi.'], correctIndex: 1, explanation: 'Dans l\'attente de votre réponse = стандартная деловая фраза'),
        ExamQuestion(question: 'Обращение в официальном письме:', options: ['Salut,', 'Bonjour,', 'Madame, Monsieur,', 'Chers amis,'], correctIndex: 2, explanation: 'Madame, Monsieur = официальное обращение к незнакомым'),
        ExamQuestion(question: '"Я предлагаю встречу":', options: ['Je veux une réunion.', 'Je propose une réunion.', 'Allons à la réunion.', 'La réunion est fixée.'], correctIndex: 1, explanation: 'proposer = предлагать'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_04', title: 'Expressions idiomatiques', subtitle: 'Идиомы', emoji: '🎭',
      level: LanguageLevel.b2, order: 4, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Популярные идиомы', content: 'Avoir le cafard — быть в депрессии/тоске\nCasser les pieds — надоедать\nDonner sa langue au chat — сдаться/не знать ответа\nIl pleut des cordes. — Льёт как из ведра.\nManger les pissenlits par la racine — быть мёртвым', examples: ['J\'ai le cafard aujourd\'hui.', 'Tu me casses les pieds!', 'Je donne ma langue au chat.']),
        TheorySection(title: 'Ещё идиомы', content: 'Être dans la lune — быть в облаках/витать\nRevenons à nos moutons. — Вернёмся к делу.\nC\'est la croix et la bannière. — Это очень сложно.\nAvoir le coup de foudre — влюбиться с первого взгляда', examples: ['Il est toujours dans la lune.', 'Revenons à nos moutons!', 'J\'ai eu le coup de foudre.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Льёт как из ведра" по-французски:', options: ['Il y a beaucoup de pluie.', 'Il pleut des cordes.', 'Il fait très humide.', 'Il pleut beaucoup.'], correctIndex: 1, explanation: 'Il pleut des cordes. = льёт как из ведра'),
        CourseExercise(type: ExerciseType.translation, question: '"Я влюбился с первого взгляда":', options: ['Je suis tombé amoureux.', 'J\'ai eu le coup de foudre.', 'Je l\'aime beaucoup.', 'Je suis amoureux.'], correctIndex: 1, explanation: 'avoir le coup de foudre = влюбиться с первого взгляда'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'J\'ai le ___ aujourd\'hui. (депрессия)', options: ['soleil', 'cafard', 'blues', 'malheur'], correctIndex: 1, explanation: 'avoir le cafard = быть в подавленном состоянии'),
      ],
      exam: [
        ExamQuestion(question: '"Быть в облаках" (идиома):', options: ['Avoir la tête dans les nuages', 'Être dans la lune', 'Rêver debout', 'Ne pas être là'], correctIndex: 1, explanation: 'être dans la lune = витать в облаках'),
        ExamQuestion(question: '"Надоедать" (идиома):', options: ['Casser les pieds', 'Faire mal aux pieds', 'Marcher sur les pieds', 'Couper les cheveux'], correctIndex: 0, explanation: 'casser les pieds = надоедать (буквально: ломать ноги)'),
        ExamQuestion(question: '"Вернёмся к делу" (идиома):', options: ['Parlons d\'autre chose.', 'Revenons à nos moutons.', 'Continuons.', 'Retournons au sujet.'], correctIndex: 1, explanation: 'revenons à nos moutons = вернёмся к теме'),
        ExamQuestion(question: '"Сдаться/не знать ответ" (идиома):', options: ['Abandonner', 'Donner sa langue au chat', 'Ne pas savoir', 'Rendre les armes'], correctIndex: 1, explanation: 'donner sa langue au chat = сдаться (в игре)'),
        ExamQuestion(question: 'Avoir le cafard = ?', options: ['иметь таракана', 'быть в тоске', 'быть голодным', 'быть больным'], correctIndex: 1, explanation: 'avoir le cafard = быть в подавленном настроении'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_05', title: 'Culture francophone', subtitle: 'Франкоязычный мир', emoji: '🏛️',
      level: LanguageLevel.b2, order: 5, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Страны франкофонии', content: 'France — Франция (67 млн)\nBelgique — Бельгия (часть)\nSuisse — Швейцария (часть)\nCanada (Québec) — Канада (Квебек)\nAfrique francophone — Африка (29 стран)\nTotal: ~300 млн говорящих', examples: ['Paris est la capitale de la France.', 'Le québécois est un dialecte français.', 'L\'OIF compte 88 États membres.']),
        TheorySection(title: 'Культура', content: 'La gastronomie française — французская кухня (ЮНЕСКО)\nLe cinéma français — французское кино\nLa mode parisienne — парижская мода\nLa Révolution française — Французская революция\nLiberté, Égalité, Fraternité — Свобода, Равенство, Братство', examples: ['Le baguette est un symbole de la France.', 'La Tour Eiffel a été construite en 1889.', 'Vive la France!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Столица Франции:', options: ['Lyon', 'Marseille', 'Paris', 'Bordeaux'], correctIndex: 2, explanation: 'Paris = столица Франции'),
        CourseExercise(type: ExerciseType.translation, question: '"Свобода, Равенство, Братство" — девиз Франции:', options: ['Liberté, Égalité, Fraternité', 'Paix, Amour, Bonheur', 'Force, Honneur, Gloire', 'Unité, Justice, Progrès'], correctIndex: 0, explanation: 'Liberté, Égalité, Fraternité — республиканский девиз'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'La Tour Eiffel ___ construite en 1889.', options: ['est', 'a été', 'était', 'sera'], correctIndex: 1, explanation: 'Passé composé passif: a été construite'),
      ],
      exam: [
        ExamQuestion(question: 'Сколько человек говорит по-французски в мире?', options: ['~100 млн', '~200 млн', '~300 млн', '~500 млн'], correctIndex: 2, explanation: 'Около 300 миллионов носителей и изучающих'),
        ExamQuestion(question: '"Французская революция" по-французски:', options: ['Révolution industrielle', 'Révolution française', 'Révolution culturelle', 'Révolution politique'], correctIndex: 1, explanation: 'la Révolution française = Французская революция (1789)'),
        ExamQuestion(question: 'В Канаде на французском говорят в:', options: ['Онтарио', 'Квебеке', 'Британской Колумбии', 'Альберте'], correctIndex: 1, explanation: 'Le Québec = франкоязычная провинция Канады'),
        ExamQuestion(question: 'Башня Эйфеля построена в:', options: ['1850', '1889', '1900', '1920'], correctIndex: 1, explanation: 'La Tour Eiffel construite en 1889'),
        ExamQuestion(question: 'OIF = Organisation Internationale de la ___:', options: ['France', 'Francophonie', 'Fraternité', 'Formation'], correctIndex: 1, explanation: 'OIF = Organisation Internationale de la Francophonie'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_06', title: 'Argumentation et opinion', subtitle: 'Аргументация и мнение', emoji: '📰',
      level: LanguageLevel.b2, order: 6, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Выражение мнения', content: 'À mon avis / Selon moi — По моему мнению\nIl me semble que — Мне кажется, что\nJe suis convaincu(e) que — Я убеждён/а, что\nD\'un côté ... de l\'autre — С одной ... с другой стороны\nEn somme / En conclusion — В итоге/В заключение', examples: ['À mon avis, c\'est une bonne idée.', 'Il me semble que nous avons tort.', 'D\'un côté c\'est cher, de l\'autre c\'est utile.']),
        TheorySection(title: 'Связки и переходы', content: 'D\'abord / Premièrement — Сначала/Во-первых\nEnsuite / De plus — Затем/Кроме того\nCependant / Néanmoins — Однако/Тем не менее\nEn outre — Более того\nAinsi — Таким образом', examples: ['D\'abord, l\'économie s\'améliore.', 'Cependant, le chômage reste élevé.', 'Ainsi, nous pouvons conclure.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"По моему мнению" по-французски:', options: ['Je pense,', 'À mon avis,', 'Selon lui,', 'Il me semble'], correctIndex: 1, explanation: 'À mon avis = по моему мнению'),
        CourseExercise(type: ExerciseType.translation, question: '"Однако проблема остаётся":', options: ['La problème reste.', 'Cependant, le problème reste.', 'Mais, le problème reste.', 'Aussi, le problème reste.'], correctIndex: 1, explanation: 'Cependant = однако (формально)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ côté c\'est cher, de l\'autre c\'est utile.', options: ['D\'un', 'D\'une', 'D\'un', 'De l\'un'], correctIndex: 0, explanation: 'D\'un côté ... de l\'autre = с одной ... с другой стороны'),
      ],
      exam: [
        ExamQuestion(question: '"В итоге/В заключение":', options: ['D\'abord', 'Ensuite', 'En somme', 'De plus'], correctIndex: 2, explanation: 'En somme / En conclusion = в итоге'),
        ExamQuestion(question: '"Мне кажется, что":', options: ['Je suis sûr que', 'Il me semble que', 'À mon avis', 'Je pense'], correctIndex: 1, explanation: 'Il me semble que = мне кажется, что'),
        ExamQuestion(question: '"Более того/Кроме того" (формально):', options: ['Cependant', 'En outre', 'D\'abord', 'Ainsi'], correctIndex: 1, explanation: 'En outre = более того/помимо этого'),
        ExamQuestion(question: '"Таким образом":', options: ['Ainsi', 'Cependant', 'D\'abord', 'Ensuite'], correctIndex: 0, explanation: 'Ainsi = таким образом'),
        ExamQuestion(question: '"Я убеждён, что":', options: ['Il me semble que', 'Je pense que', 'Je suis convaincu que', 'À mon avis'], correctIndex: 2, explanation: 'Je suis convaincu(e) que = я убеждён/а, что'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_07', title: 'Grammaire avancée', subtitle: 'Продвинутая грамматика', emoji: '🔬',
      level: LanguageLevel.b2, order: 7, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Pronoms relatifs composés', content: 'lequel/laquelle/lesquels/lesquelles — который/которая\nduquel / de laquelle — от которого\nauquel / à laquelle — к которому\nС предлогами кроме de/à используется qui для людей.', examples: ['Le stylo avec lequel j\'écris.', 'La femme à laquelle je pense.', 'Le problème duquel il parle.']),
        TheorySection(title: 'Nominalisation', content: 'Превращение глагола/прилагательного в существительное:\npartir → le départ\narriver → l\'arrivée\ntravailler → le travail\nfort → la force\nrapide → la rapidité', examples: ['Le départ est à 10h.', 'La rapidité est importante.', 'Son arrivée a surpris tout le monde.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Le stylo ___ lequel j\'écris.', options: ['de', 'à', 'avec', 'par'], correctIndex: 2, explanation: 'avec lequel = с которым (préposition + lequel)'),
        CourseExercise(type: ExerciseType.translation, question: '"Женщина, о которой я думаю":', options: ['La femme qui je pense.', 'La femme dont je pense.', 'La femme à laquelle je pense.', 'La femme laquelle je pense.'], correctIndex: 2, explanation: 'penser à → à laquelle (предлог à + laquelle)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'partir → la ___', options: ['partie', 'partir', 'départ', 'partance'], correctIndex: 2, explanation: 'partir → le départ (номинализация)'),
      ],
      exam: [
        ExamQuestion(question: 'La ville ___ laquelle j\'habite.', options: ['de', 'à', 'dans', 'en'], correctIndex: 2, explanation: 'habiter dans → dans laquelle'),
        ExamQuestion(question: 'arriver → nominalisation:', options: ['arrivage', 'arrivée', 'arrivant', 'arrivé'], correctIndex: 1, explanation: 'arriver → l\'arrivée'),
        ExamQuestion(question: '"Проблема, о которой он говорит" (parler de):', options: ['le problème qui il parle', 'le problème dont il parle', 'le problème duquel il parle', 'Оба b и c'], correctIndex: 3, explanation: 'parler de → dont (или duquel формально)'),
        ExamQuestion(question: 'fort → nominalisation:', options: ['fortement', 'forteresse', 'force', 'fortitude'], correctIndex: 2, explanation: 'fort → la force'),
        ExamQuestion(question: 'lequel/laquelle/lesquels согласуются с:', options: ['глаголом', 'существительным-антецедентом', 'подлежащим', 'временем'], correctIndex: 1, explanation: 'Относительные местоимения согласуются с антецедентом'),
      ],
    ),

    CourseChapter(
      id: 'fr_b2_08', title: 'Examen final', subtitle: 'Финальный экзамен', emoji: '🏆',
      level: LanguageLevel.b2, order: 8, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Повторение A1–B1', content: 'A1: Приветствия, числа, семья, еда, тело, время, природа, глаголы\nA2: Иррегулярные глаголы, транспорт, погода, одежда, описание, будущее\nB1: Passé composé, Imparfait, Subjonctif, Passif, Discours indirect, Comparatif', examples: ['Elle est allée au cinéma.', 'Il pleuvait quand je suis sorti.', 'Il faut que tu parles.']),
        TheorySection(title: 'Повторение B2', content: 'B2: Conditionnel, Participes/Gérondif, Français des affaires, Idiomes, Culture francophone, Pronoms relatifs\nSi j\'avais le temps, je voyagerais.\nÀ mon avis, c\'est essentiel.\nDans l\'attente de votre réponse.', examples: ['J\'ai eu le coup de foudre.', 'Le stylo avec lequel j\'écris.', 'En étudiant chaque jour, tu progresses.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Si j\'avais le temps, je ___ (voyager, conditionnel):', options: ['voyage', 'voyagerai', 'voyagerais', 'voyagèrais'], correctIndex: 2, explanation: 'Conditionnel: je voyagerais'),
        CourseExercise(type: ExerciseType.translation, question: '"Он написал письмо, прочитав книгу":', options: ['Il a écrit la lettre, en lisant le livre.', 'Ayant lu le livre, il a écrit la lettre.', 'Après avoir lu le livre, il a écrit la lettre.', 'b et c sont corrects'], correctIndex: 3, explanation: 'Participe passé composé (ayant lu) = après avoir lu'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'À mon ___, c\'est une bonne idée.', options: ['pensée', 'avis', 'sens', 'opinion'], correctIndex: 1, explanation: 'À mon avis = по моему мнению'),
      ],
      exam: [
        ExamQuestion(question: 'Passé composé от "aller" (elle):', options: ['a allé', 'est allée', 'était allée', 'allait'], correctIndex: 1, explanation: 'aller = être: elle est allée'),
        ExamQuestion(question: 'Il pleut des cordes = ?', options: ['немного дождь', 'льёт как из ведра', 'туман', 'облачно'], correctIndex: 1, explanation: 'Il pleut des cordes = льёт как из ведра'),
        ExamQuestion(question: 'Gérondif — образование:', options: ['en + infinitif', 'en + participe passé', 'en + participe présent', 'en + imparfait'], correctIndex: 2, explanation: 'Gérondif = en + participe présent'),
        ExamQuestion(question: 'Conditionnel тип 3: si + PQP → ...', options: ['conditionnel présent', 'conditionnel passé', 'subjonctif', 'futur antérieur'], correctIndex: 1, explanation: 'Si + PQP → conditionnel passé'),
        ExamQuestion(question: '"Coup de foudre" = ?', options: ['удар молнии', 'влюбиться с первого взгляда', 'сильный ветер', 'неожиданность'], correctIndex: 1, explanation: 'avoir le coup de foudre = влюбиться с первого взгляда'),
      ],
    ),
  ],
);
