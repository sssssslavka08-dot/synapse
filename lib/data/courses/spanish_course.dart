import '../courses/course_structure.dart';

const spanishCourse = LanguageCourse(
  langCode: 'es',
  langName: 'Испанский',
  nativeName: 'Español',
  flag: '🇪🇸',
  chapters: [
    // ── A1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'es_a1_01', title: '¡Hola!', subtitle: 'Приветствия', emoji: '👋',
      level: LanguageLevel.a1, order: 1, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Приветствия', content: 'Hola — Привет\nBuenos días — Доброе утро\nBuenas tardes — Добрый день\nBuenas noches — Добрый вечер\nAdiós — До свидания\nHasta luego — До скорого\nGracias — Спасибо\nPor favor — Пожалуйста', examples: ['Hola, ¿cómo te llamas?', 'Buenos días, señor.', 'Adiós, hasta mañana.']),
        TheorySection(title: 'Знакомство', content: '¿Cómo te llamas? — Как тебя зовут?\nMe llamo ... — Меня зовут ...\n¿De dónde eres? — Откуда ты?\nSoy de ... — Я из ...\nEncantado/a — Приятно познакомиться', examples: ['Me llamo Carlos.', 'Soy de Rusia.', '¡Encantado!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Доброе утро" по-испански:', options: ['Buenas noches', 'Buenas tardes', 'Buenos días', 'Hola'], correctIndex: 2, explanation: 'Buenos días = доброе утро'),
        CourseExercise(type: ExerciseType.translation, question: '"Как тебя зовут?":', options: ['¿Cómo estás?', '¿Cómo te llamas?', '¿De dónde eres?', '¿Qué haces?'], correctIndex: 1, explanation: 'llamarse = называться; ¿Cómo te llamas?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me ___ Ana.', options: ['soy', 'llamo', 'hablo', 'vivo'], correctIndex: 1, explanation: 'llamarse: me llamo'),
      ],
      exam: [
        ExamQuestion(question: '"Спасибо" по-испански:', options: ['Por favor', 'Perdón', 'Gracias', 'De nada'], correctIndex: 2, explanation: 'Gracias = спасибо'),
        ExamQuestion(question: 'Soy de Rusia = ?', options: ['Я из России', 'Я русский', 'Я живу в России', 'Я еду в Россию'], correctIndex: 0, explanation: 'ser de = быть из; soy de Rusia = я из России'),
        ExamQuestion(question: '"До свидания" по-испански:', options: ['Hola', 'Gracias', 'Por favor', 'Adiós'], correctIndex: 3, explanation: 'Adiós = до свидания'),
        ExamQuestion(question: '"Добрый вечер" по-испански:', options: ['Buenos días', 'Buenas tardes', 'Buenas noches', 'Hola'], correctIndex: 2, explanation: 'Buenas noches = добрый вечер/ночь'),
        ExamQuestion(question: '"Приятно познакомиться":', options: ['Gracias', 'Por favor', 'Encantado', 'Hola'], correctIndex: 2, explanation: 'Encantado/a = приятно познакомиться'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_02', title: 'Números y colores', subtitle: 'Числа и цвета', emoji: '🔢',
      level: LanguageLevel.a1, order: 2, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Числа 1–20', content: '1-uno, 2-dos, 3-tres, 4-cuatro, 5-cinco\n6-seis, 7-siete, 8-ocho, 9-nueve, 10-diez\n11-once, 12-doce, 13-trece, 20-veinte', examples: ['Tengo veinte años.', 'Son las cinco.', 'Número uno.']),
        TheorySection(title: 'Цвета', content: 'rojo — красный\nazul — синий\nverde — зелёный\namarillo — жёлтый\nblanco — белый\nnegro — чёрный\nnaranja — оранжевый', examples: ['El cielo es azul.', 'La manzana es roja.', 'Me gusta el negro.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Синий" по-испански:', options: ['rojo', 'verde', 'azul', 'amarillo'], correctIndex: 2, explanation: 'azul = синий'),
        CourseExercise(type: ExerciseType.translation, question: '7 по-испански:', options: ['seis', 'siete', 'ocho', 'nueve'], correctIndex: 1, explanation: 'siete = 7'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'El cielo es ___. (синий)', options: ['rojo', 'verde', 'azul', 'negro'], correctIndex: 2, explanation: 'El cielo (небо) es azul'),
      ],
      exam: [
        ExamQuestion(question: '12 по-испански:', options: ['once', 'doce', 'trece', 'catorce'], correctIndex: 1, explanation: 'doce = 12'),
        ExamQuestion(question: '"Зелёный" по-испански:', options: ['rojo', 'azul', 'verde', 'amarillo'], correctIndex: 2, explanation: 'verde = зелёный'),
        ExamQuestion(question: '20 по-испански:', options: ['diez', 'quince', 'veinte', 'treinta'], correctIndex: 2, explanation: 'veinte = 20'),
        ExamQuestion(question: '"Чёрный" по-испански:', options: ['blanco', 'gris', 'marrón', 'negro'], correctIndex: 3, explanation: 'negro = чёрный'),
        ExamQuestion(question: '5 по-испански:', options: ['cuatro', 'cinco', 'seis', 'siete'], correctIndex: 1, explanation: 'cinco = 5'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_03', title: 'Familia y casa', subtitle: 'Семья и дом', emoji: '🏠',
      level: LanguageLevel.a1, order: 3, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Семья', content: 'la madre — мама\nel padre — папа\nla hermana — сестра\nel hermano — брат\nla abuela — бабушка\nel abuelo — дедушка\nlos hijos — дети', examples: ['Mi madre se llama María.', 'Tengo dos hermanos.', 'Mi padre trabaja.']),
        TheorySection(title: 'Артикли', content: 'el (муж.р.) — el padre, el hermano\nla (жен.р.) — la madre, la hermana\nlos/las (мн.ч.) — los hijos, las hermanas\nun/una — неопределённый артикль', examples: ['el libro — книга', 'la casa — дом', 'los niños — дети']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Сестра" по-испански:', options: ['hermano', 'hermana', 'hija', 'mujer'], correctIndex: 1, explanation: 'la hermana = сестра'),
        CourseExercise(type: ExerciseType.translation, question: '"Мой папа работает":', options: ['Mi padre come.', 'Mi padre trabaja.', 'Mi padre duerme.', 'Mi padre habla.'], correctIndex: 1, explanation: 'trabajar = работать; él trabaja'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Tengo ___ hermano.', options: ['una', 'el', 'un', 'los'], correctIndex: 2, explanation: 'un = неопр.арт. муж.р.'),
      ],
      exam: [
        ExamQuestion(question: '"Дедушка" по-испански:', options: ['abuela', 'abuelo', 'padre', 'tío'], correctIndex: 1, explanation: 'el abuelo = дедушка'),
        ExamQuestion(question: 'Артикль "casa" (дом):', options: ['el', 'la', 'los', 'un'], correctIndex: 1, explanation: 'la casa — женский род'),
        ExamQuestion(question: '"Дети" по-испански:', options: ['niñas', 'niños/hijos', 'bebés', 'chicos'], correctIndex: 1, explanation: 'los hijos = дети (сыновья/дочери) или los niños = дети'),
        ExamQuestion(question: '"Брат" по-испански:', options: ['padre', 'hijo', 'hermano', 'tío'], correctIndex: 2, explanation: 'el hermano = брат'),
        ExamQuestion(question: 'Mi madre ___ María.', options: ['es', 'llama', 'se llama', 'tiene'], correctIndex: 2, explanation: 'llamarse: se llama'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_04', title: 'Comida y bebida', subtitle: 'Еда и напитки', emoji: '🥘',
      level: LanguageLevel.a1, order: 4, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Еда', content: 'el pan — хлеб\nel queso — сыр\nla carne — мясо\nlas verduras — овощи\nlas frutas — фрукты\nla sopa — суп\nel arroz — рис\nla paella — паэлья', examples: ['Como pan con queso.', 'Me gustan las frutas.', 'La paella es española.']),
        TheorySection(title: 'Напитки', content: 'el agua — вода\nel café — кофе\nel té — чай\nla leche — молоко\nel zumo — сок\nla cerveza — пиво', examples: ['Bebo café por la mañana.', '¿Quieres té o café?', 'Un vaso de agua, por favor.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Хлеб" по-испански:', options: ['queso', 'pan', 'carne', 'arroz'], correctIndex: 1, explanation: 'el pan = хлеб'),
        CourseExercise(type: ExerciseType.translation, question: '"Я пью кофе":', options: ['Como café.', 'Bebo café.', 'Tomo café.', 'b y c son correctos'], correctIndex: 3, explanation: 'beber/tomar = пить; оба верны'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me ___ las frutas. (нравятся)', options: ['gusta', 'gustan', 'gusto', 'gustas'], correctIndex: 1, explanation: 'gustar: me gustan (мн.ч.)'),
      ],
      exam: [
        ExamQuestion(question: '"Молоко" по-испански:', options: ['agua', 'zumo', 'leche', 'cerveza'], correctIndex: 2, explanation: 'la leche = молоко'),
        ExamQuestion(question: '"Овощи" по-испански:', options: ['frutas', 'verduras', 'carne', 'pan'], correctIndex: 1, explanation: 'las verduras = овощи'),
        ExamQuestion(question: '¿Quieres té ___ café?', options: ['y', 'o', 'pero', 'que'], correctIndex: 1, explanation: 'o = или (в вопросе)'),
        ExamQuestion(question: '"Сок" по-испански:', options: ['agua', 'leche', 'zumo', 'té'], correctIndex: 2, explanation: 'el zumo = сок'),
        ExamQuestion(question: '"Рис" по-испански:', options: ['pan', 'queso', 'arroz', 'pasta'], correctIndex: 2, explanation: 'el arroz = рис'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_05', title: 'Cuerpo y salud', subtitle: 'Тело и здоровье', emoji: '💪',
      level: LanguageLevel.a1, order: 5, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Части тела', content: 'la cabeza — голова\nel ojo — глаз\nla nariz — нос\nla boca — рот\nel brazo — рука\nla mano — кисть\nla pierna — нога\nel pie — ступня', examples: ['Me duele la cabeza.', 'Tengo los ojos azules.', 'Me duele la mano.']),
        TheorySection(title: 'Самочувствие', content: '¿Cómo estás? — Как ты?\nEstoy bien. — Я в порядке.\nEstoy enfermo/a. — Я болен/больна.\nMe duele ... — У меня болит ...\nTengo fiebre. — У меня температура.', examples: ['Estoy muy bien, gracias.', 'Me duele la espalda.', 'Él está enfermo hoy.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Голова" по-испански:', options: ['mano', 'pierna', 'cabeza', 'brazo'], correctIndex: 2, explanation: 'la cabeza = голова'),
        CourseExercise(type: ExerciseType.translation, question: '"Я болен":', options: ['Estoy bien.', 'Estoy enfermo.', 'Me duele.', 'Tengo frío.'], correctIndex: 1, explanation: 'enfermo/a = больной/больная'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me duele ___ cabeza.', options: ['el', 'la', 'mi', 'un'], correctIndex: 1, explanation: 'la cabeza (жен.р.) → me duele la cabeza'),
      ],
      exam: [
        ExamQuestion(question: '"Нога" по-испански:', options: ['brazo', 'mano', 'pie', 'pierna'], correctIndex: 3, explanation: 'la pierna = нога; el pie = ступня'),
        ExamQuestion(question: '¿Cómo estás? = ?', options: ['Как вас зовут?', 'Откуда вы?', 'Как вы?', 'Что вы делаете?'], correctIndex: 2, explanation: '¿Cómo estás? = Как ты?/Как поживаешь?'),
        ExamQuestion(question: '"Температура" по-испански:', options: ['dolor', 'fiebre', 'resfriado', 'tos'], correctIndex: 1, explanation: 'la fiebre = температура/жар'),
        ExamQuestion(question: '"Нос" по-испански:', options: ['ojo', 'boca', 'nariz', 'oreja'], correctIndex: 2, explanation: 'la nariz = нос'),
        ExamQuestion(question: 'Estoy ___. (в порядке)', options: ['malo', 'enfermo', 'bien', 'cansado'], correctIndex: 2, explanation: 'bien = хорошо/в порядке'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_06', title: 'Tiempo y calendario', subtitle: 'Время и календарь', emoji: '🕐',
      level: LanguageLevel.a1, order: 6, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Дни недели', content: 'lunes — понедельник\nmartes — вторник\nmiércoles — среда\njueves — четверг\nviernes — пятница\nsábado — суббота\ndomingo — воскресенье', examples: ['Hoy es lunes.', 'El viernes tengo clase.', 'El domingo descanso.']),
        TheorySection(title: 'Время', content: '¿Qué hora es? — Который час?\nSon las ... — Сейчас ...\nEs la una. — Сейчас час.\npor la mañana — утром\npor la tarde — после полудня\npor la noche — вечером/ночью', examples: ['Son las nueve.', 'Por la mañana bebo café.', 'Por la noche leo.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Пятница" по-испански:', options: ['jueves', 'viernes', 'sábado', 'domingo'], correctIndex: 1, explanation: 'viernes = пятница'),
        CourseExercise(type: ExerciseType.translation, question: '"Который час?":', options: ['¿Qué día es?', '¿Qué hora es?', '¿Cuándo vas?', '¿A qué hora?'], correctIndex: 1, explanation: '¿Qué hora es? = Который час?'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Hoy ___ miércoles.', options: ['estoy', 'hay', 'es', 'está'], correctIndex: 2, explanation: 'ser: hoy es (дни недели с ser)'),
      ],
      exam: [
        ExamQuestion(question: '"Воскресенье" по-испански:', options: ['sábado', 'domingo', 'viernes', 'lunes'], correctIndex: 1, explanation: 'domingo = воскресенье'),
        ExamQuestion(question: 'Son las ___. (9 часов)', options: ['siete', 'ocho', 'nueve', 'diez'], correctIndex: 2, explanation: 'nueve = 9'),
        ExamQuestion(question: '"Вечером" по-испански:', options: ['por la mañana', 'por la tarde', 'por la noche', 'al mediodía'], correctIndex: 2, explanation: 'por la noche = вечером/ночью'),
        ExamQuestion(question: '"Понедельник" по-испански:', options: ['martes', 'lunes', 'miércoles', 'jueves'], correctIndex: 1, explanation: 'lunes = понедельник'),
        ExamQuestion(question: 'Es ___ una. (один час)', options: ['las', 'la', 'los', 'el'], correctIndex: 1, explanation: 'Es la una — только для 1 часа; остальное son las ...'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_07', title: 'Animales y naturaleza', subtitle: 'Животные и природа', emoji: '🐾',
      level: LanguageLevel.a1, order: 7, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Животные', content: 'el perro — собака\nel gato — кошка\nel caballo — лошадь\nel pájaro — птица\nel pez — рыба\nel toro — бык\nel oso — медведь', examples: ['Tengo un perro.', 'El gato es pequeño.', 'El caballo es grande.']),
        TheorySection(title: 'Природа', content: 'el árbol — дерево\nla flor — цветок\nel mar — море\nla montaña — гора\nel río — река\nel bosque — лес\nel cielo — небо', examples: ['El mar es azul.', 'La flor es rosa.', 'El bosque es verde.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Кошка" по-испански:', options: ['perro', 'gato', 'caballo', 'pájaro'], correctIndex: 1, explanation: 'el gato = кот/кошка'),
        CourseExercise(type: ExerciseType.translation, question: '"Лес" по-испански:', options: ['mar', 'montaña', 'bosque', 'río'], correctIndex: 2, explanation: 'el bosque = лес'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'El ___ es azul. (море)', options: ['bosque', 'río', 'mar', 'lago'], correctIndex: 2, explanation: 'el mar = море'),
      ],
      exam: [
        ExamQuestion(question: '"Птица" по-испански:', options: ['pez', 'pájaro', 'gato', 'toro'], correctIndex: 1, explanation: 'el pájaro = птица'),
        ExamQuestion(question: '"Цветок" по-испански:', options: ['árbol', 'flor', 'hierba', 'hoja'], correctIndex: 1, explanation: 'la flor = цветок'),
        ExamQuestion(question: 'Артикль "perro" (собака):', options: ['la', 'el', 'los', 'un'], correctIndex: 1, explanation: 'el perro = собака (муж.р.)'),
        ExamQuestion(question: '"Небо" по-испански:', options: ['tierra', 'mar', 'cielo', 'nube'], correctIndex: 2, explanation: 'el cielo = небо'),
        ExamQuestion(question: '"Гора" по-испански:', options: ['río', 'bosque', 'mar', 'montaña'], correctIndex: 3, explanation: 'la montaña = гора'),
      ],
    ),

    CourseChapter(
      id: 'es_a1_08', title: 'Verbos esenciales', subtitle: 'Основные глаголы', emoji: '⚡',
      level: LanguageLevel.a1, order: 8, coinsReward: 30, xpReward: 20,
      theory: [
        TheorySection(title: 'Спряжение -ar глаголов', content: 'yo -o, tú -as, él/ella -a\nnosotros -amos, vosotros -áis, ellos -an\nhablar: hablo, hablas, habla\nhablamos, habláis, hablan', examples: ['Yo hablo español.', 'Tú trabajas mucho.', 'Nosotros vivimos en Madrid.']),
        TheorySection(title: 'Ser y Estar', content: 'ser (постоянное): soy, eres, es, somos\nestar (временное): estoy, estás, está, estamos\nSer: профессия, национальность, характер\nEstar: состояние, местоположение', examples: ['Soy estudiante.', 'Estoy cansado.', 'Madrid está en España.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'él ___ (hablar)', options: ['hablo', 'hablas', 'habla', 'hablan'], correctIndex: 2, explanation: 'hablar: él habla'),
        CourseExercise(type: ExerciseType.translation, question: '"Я студент":', options: ['Estoy estudiante.', 'Soy estudiante.', 'Tengo estudiante.', 'Hago estudiante.'], correctIndex: 1, explanation: 'ser: soy (постоянная характеристика)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Madrid ___ en España.', options: ['es', 'está', 'estoy', 'son'], correctIndex: 1, explanation: 'estar: местоположение → está'),
      ],
      exam: [
        ExamQuestion(question: 'yo ___ (estar)', options: ['es', 'estoy', 'soy', 'estás'], correctIndex: 1, explanation: 'estar: yo estoy'),
        ExamQuestion(question: 'ellos ___ (hablar)', options: ['habla', 'hablamos', 'hablan', 'habláis'], correctIndex: 2, explanation: 'hablar: ellos hablan'),
        ExamQuestion(question: '"Говорить" по-испански:', options: ['trabajar', 'vivir', 'hablar', 'comer'], correctIndex: 2, explanation: 'hablar = говорить'),
        ExamQuestion(question: 'nosotros ___ (ser)', options: ['son', 'somos', 'soy', 'eres'], correctIndex: 1, explanation: 'ser: nosotros somos'),
        ExamQuestion(question: 'Я устал — какой глагол?', options: ['ser', 'estar', 'tener', 'hacer'], correctIndex: 1, explanation: 'Усталость = временное состояние → estar: estoy cansado'),
      ],
    ),

    // ── A2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'es_a2_01', title: 'Presente irregular', subtitle: 'Неправильное настоящее', emoji: '📝',
      level: LanguageLevel.a2, order: 1, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Неправильные глаголы', content: 'ir: voy, vas, va, vamos, vais, van\ntener: tengo, tienes, tiene, tenemos\npoder: puedo, puedes, puede\nquerer: quiero, quieres, quiere\nvenir: vengo, vienes, viene', examples: ['Voy al cine.', 'Tengo dos hermanos.', 'Quiero aprender español.']),
        TheorySection(title: 'Рефлексивные глаголы', content: 'levantarse — вставать: me levanto\nllamarse — называться: me llamo\nacostarse — ложиться: me acuesto\nlavarse — мыться: me lavo', examples: ['Me levanto a las siete.', 'Él se acuesta tarde.', 'Nos lavamos por la mañana.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'él ___ (ir)', options: ['vay', 'va', 'vas', 'vamos'], correctIndex: 1, explanation: 'ir: él va'),
        CourseExercise(type: ExerciseType.translation, question: '"Я хочу учить испанский":', options: ['Puedo aprender español.', 'Quiero aprender español.', 'Tengo que aprender español.', 'Voy a aprender español.'], correctIndex: 1, explanation: 'querer = хотеть: quiero'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me ___ a las siete. (levantarse)', options: ['levanta', 'levanto', 'levantas', 'levantamos'], correctIndex: 1, explanation: 'levantarse: me levanto'),
      ],
      exam: [
        ExamQuestion(question: 'yo ___ (tener)', options: ['tienes', 'tiene', 'tengo', 'tenemos'], correctIndex: 2, explanation: 'tener: yo tengo'),
        ExamQuestion(question: 'tú ___ (poder)', options: ['puede', 'puedes', 'podemos', 'puedo'], correctIndex: 1, explanation: 'poder: tú puedes'),
        ExamQuestion(question: '"Ложиться спать" по-испански:', options: ['levantarse', 'acostarse', 'lavarse', 'vestirse'], correctIndex: 1, explanation: 'acostarse = ложиться спать'),
        ExamQuestion(question: 'ellos ___ (venir)', options: ['vengo', 'viene', 'vienen', 'venís'], correctIndex: 2, explanation: 'venir: ellos vienen'),
        ExamQuestion(question: 'nosotros ___ (ir)', options: ['vamos', 'van', 'vas', 'voy'], correctIndex: 0, explanation: 'ir: nosotros vamos'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_02', title: 'Transporte y viajes', subtitle: 'Транспорт', emoji: '✈️',
      level: LanguageLevel.a2, order: 2, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Транспорт', content: 'el coche/carro — машина\nel autobús — автобус\nel metro — метро\nel tren — поезд\nel avión — самолёт\nla bicicleta — велосипед\na pie — пешком', examples: ['Voy en autobús.', 'El tren llega a las diez.', 'Volamos a Madrid.']),
        TheorySection(title: 'Предлоги транспорта', content: 'en + транспорт: en coche, en avión\nа pie — пешком\nir a/en — ехать в/на\n¿A qué hora sale/llega? — В котором часу отправляется/прибывает?', examples: ['Voy en coche.', 'Vamos a Madrid en avión.', '¿A qué hora sale el tren?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Самолёт" по-испански:', options: ['tren', 'barco', 'avión', 'autobús'], correctIndex: 2, explanation: 'el avión = самолёт'),
        CourseExercise(type: ExerciseType.translation, question: '"Я еду на машине":', options: ['Voy a pie.', 'Voy en autobús.', 'Voy en coche.', 'Tomo el tren.'], correctIndex: 2, explanation: 'en coche = на машине'),
        CourseExercise(type: ExerciseType.fillBlank, question: '¿A qué hora ___ el tren?', options: ['viene', 'llega', 'entra', 'pasa'], correctIndex: 1, explanation: 'llegar = прибывать'),
      ],
      exam: [
        ExamQuestion(question: '"Велосипед" по-испански:', options: ['moto', 'bicicleta', 'coche', 'autobús'], correctIndex: 1, explanation: 'la bicicleta = велосипед'),
        ExamQuestion(question: 'Voy ___ coche.', options: ['a', 'en', 'con', 'por'], correctIndex: 1, explanation: 'en coche = на машине'),
        ExamQuestion(question: '"Метро" по-испански:', options: ['tranvía', 'metro', 'tren', 'autobús'], correctIndex: 1, explanation: 'el metro = метро'),
        ExamQuestion(question: '"Пешком" по-испански:', options: ['en coche', 'a pie', 'en bus', 'en bici'], correctIndex: 1, explanation: 'a pie = пешком'),
        ExamQuestion(question: 'El tren ___ a las diez.', options: ['sale', 'llega', 'viene', 'pasa'], correctIndex: 1, explanation: 'llegar = прибывать'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_03', title: 'El tiempo', subtitle: 'Погода', emoji: '☀️',
      level: LanguageLevel.a2, order: 3, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Погода', content: 'Hace sol. — Солнечно.\nHace calor/frío. — Жарко/Холодно.\nLlueve. — Идёт дождь.\nNieva. — Идёт снег.\nHay viento. — Ветрено.\nEstá nublado. — Облачно.', examples: ['Hoy hace mucho sol.', 'En invierno nieva mucho.', 'Hay mucho viento hoy.']),
        TheorySection(title: 'Сезоны', content: 'la primavera — весна\nel verano — лето\nel otoño — осень\nel invierno — зима\nen primavera — весной\nen verano — летом', examples: ['En verano hace calor.', 'En invierno hace frío.', 'En otoño llueve mucho.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Идёт снег" по-испански:', options: ['Llueve.', 'Nieva.', 'Hace frío.', 'Hay viento.'], correctIndex: 1, explanation: 'Nieva. = идёт снег (nevar)'),
        CourseExercise(type: ExerciseType.translation, question: '"Зима" по-испански:', options: ['primavera', 'otoño', 'invierno', 'verano'], correctIndex: 2, explanation: 'el invierno = зима'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ verano hace calor.', options: ['Al', 'En', 'A', 'Por'], correctIndex: 1, explanation: 'en verano = летом'),
      ],
      exam: [
        ExamQuestion(question: '"Весна" по-испански:', options: ['invierno', 'otoño', 'primavera', 'verano'], correctIndex: 2, explanation: 'la primavera = весна'),
        ExamQuestion(question: 'Hoy ___ mucho sol.', options: ['hay', 'hace', 'está', 'es'], correctIndex: 1, explanation: 'hacer sol = быть солнечным; hace sol'),
        ExamQuestion(question: '"Облачно" по-испански:', options: ['Hay viento.', 'Hace frío.', 'Está nublado.', 'Llueve.'], correctIndex: 2, explanation: 'Está nublado. = облачно'),
        ExamQuestion(question: '"Осень" по-испански:', options: ['primavera', 'verano', 'otoño', 'invierno'], correctIndex: 2, explanation: 'el otoño = осень'),
        ExamQuestion(question: '"Жарко" по-испански:', options: ['Hace frío.', 'Hace calor.', 'Hace viento.', 'Hay nubes.'], correctIndex: 1, explanation: 'Hace calor. = жарко'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_04', title: 'Ropa y compras', subtitle: 'Одежда и покупки', emoji: '👗',
      level: LanguageLevel.a2, order: 4, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Одежда', content: 'la camisa — рубашка\nlos pantalones — брюки\nla falda — юбка\nel vestido — платье\nel abrigo — пальто\nlos zapatos — обувь\nel jersey — свитер', examples: ['Llevo un vestido rojo.', 'Él compra un abrigo.', 'Estos zapatos son caros.']),
        TheorySection(title: 'Покупки', content: '¿Cuánto cuesta? — Сколько стоит?\nCuesta ... euros. — Стоит ... евро.\nQuisiera ... — Я бы хотел/а ...\n¿Tiene esto en talla ...? — Есть это в размере ...?', examples: ['¿Cuánto cuesta este vestido?', 'Quisiera probarme este abrigo.', '¿Tiene esto en talla M?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Платье" по-испански:', options: ['falda', 'vestido', 'camisa', 'jersey'], correctIndex: 1, explanation: 'el vestido = платье'),
        CourseExercise(type: ExerciseType.translation, question: '"Сколько стоит?":', options: ['¿Qué es esto?', '¿Cuánto cuesta?', '¿Cómo es esto?', '¿Cuál es?'], correctIndex: 1, explanation: 'costar: ¿Cuánto cuesta?'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ probarme este jersey.', options: ['Quiero', 'Quisiera', 'Puedo', 'Debo'], correctIndex: 1, explanation: 'Quisiera = хотел бы (вежливо)'),
      ],
      exam: [
        ExamQuestion(question: '"Брюки" по-испански:', options: ['falda', 'vestido', 'pantalones', 'camisa'], correctIndex: 2, explanation: 'los pantalones = брюки'),
        ExamQuestion(question: '¿Cuánto ___? (стоит)', options: ['es', 'cuesta', 'vale', 'b y c son correctos'], correctIndex: 3, explanation: 'costar y valer = стоить; оба верны'),
        ExamQuestion(question: '"Пальто" по-испански:', options: ['chaqueta', 'abrigo', 'jersey', 'cazadora'], correctIndex: 1, explanation: 'el abrigo = пальто'),
        ExamQuestion(question: '"Размер" по-испански:', options: ['color', 'precio', 'talla', 'estilo'], correctIndex: 2, explanation: 'la talla = размер одежды'),
        ExamQuestion(question: '"Обувь" по-испански:', options: ['calcetines', 'zapatos', 'botas', 'zapatillas'], correctIndex: 1, explanation: 'los zapatos = туфли/обувь (общее)'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_05', title: 'Aficiones y deportes', subtitle: 'Хобби и спорт', emoji: '⚽',
      level: LanguageLevel.a2, order: 5, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Хобби', content: 'leer — читать\nescuchar música — слушать музыку\nviajar — путешествовать\ncocinar — готовить\npintar — рисовать\njugar a videojuegos — играть в игры', examples: ['Me gusta leer novelas.', 'Ella escucha música por la noche.', 'Viajamos cada verano.']),
        TheorySection(title: 'Спорт', content: 'jugar al fútbol — играть в футбол\nnadar — плавать\ncorrer — бегать\nandar en bicicleta — кататься на велосипеде\nesquiar — кататься на лыжах\nhacer yoga — заниматься йогой', examples: ['Él juega al tenis.', 'Nado los domingos.', 'Ella hace yoga cada día.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Плавать" по-испански:', options: ['correr', 'nadar', 'saltar', 'caminar'], correctIndex: 1, explanation: 'nadar = плавать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я играю в футбол":', options: ['Miro el fútbol.', 'Juego al fútbol.', 'Hago fútbol.', 'Me gusta el fútbol.'], correctIndex: 1, explanation: 'jugar al fútbol = играть в футбол'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me gusta ___ música. (слушать)', options: ['jugar', 'escuchar', 'hacer', 'ver'], correctIndex: 1, explanation: 'escuchar música = слушать музыку'),
      ],
      exam: [
        ExamQuestion(question: '"Готовить" по-испански:', options: ['comer', 'cocinar', 'servir', 'probar'], correctIndex: 1, explanation: 'cocinar = готовить'),
        ExamQuestion(question: 'Juego ___ tenis.', options: ['de', 'al', 'con', 'el'], correctIndex: 1, explanation: 'jugar al (вид спорта) = играть в'),
        ExamQuestion(question: '"Читать" по-испански:', options: ['escribir', 'hablar', 'leer', 'aprender'], correctIndex: 2, explanation: 'leer = читать'),
        ExamQuestion(question: '"Путешествовать" по-испански:', options: ['caminar', 'viajar', 'salir', 'explorar'], correctIndex: 1, explanation: 'viajar = путешествовать'),
        ExamQuestion(question: '"Бегать" по-испански:', options: ['caminar', 'nadar', 'correr', 'saltar'], correctIndex: 2, explanation: 'correr = бегать'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_06', title: 'Trabajo y estudios', subtitle: 'Работа и учёба', emoji: '💼',
      level: LanguageLevel.a2, order: 6, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Профессии', content: 'el médico/la médica — врач\nel profesor/la profesora — учитель\nel ingeniero — инженер\nel cocinero — повар\nel programador — программист\nel abogado — адвокат', examples: ['Soy médico.', 'Ella es profesora.', 'Trabaja como ingeniero.']),
        TheorySection(title: 'Учёба', content: 'la escuela — школа\nla universidad — университет\naprender — учиться/узнавать\nestudiar — изучать\nel examen — экзамен\nla asignatura — предмет', examples: ['Aprendo español.', 'Estudia medicina.', 'Mañana tengo un examen.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Учитель" (жен.) по-испански:', options: ['médica', 'abogada', 'profesora', 'ingeniera'], correctIndex: 2, explanation: 'la profesora = учительница'),
        CourseExercise(type: ExerciseType.translation, question: '"Она изучает медицину":', options: ['Es médica.', 'Estudia medicina.', 'Aprende medicina.', 'Trabaja de médica.'], correctIndex: 1, explanation: 'estudiar = изучать'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Mañana tengo ___ examen.', options: ['la', 'el', 'un', 'una'], correctIndex: 2, explanation: 'un examen (муж.р., неопр.арт.)'),
      ],
      exam: [
        ExamQuestion(question: '"Программист" по-испански:', options: ['médico', 'abogado', 'programador', 'ingeniero'], correctIndex: 2, explanation: 'el programador = программист'),
        ExamQuestion(question: 'Aprendo ___. (испанский)', options: ['español', 'espańol', 'hispanico', 'castellano'], correctIndex: 0, explanation: 'español = испанский язык'),
        ExamQuestion(question: '"Предмет" (школьный) по-испански:', options: ['libro', 'clase', 'asignatura', 'lección'], correctIndex: 2, explanation: 'la asignatura = учебный предмет'),
        ExamQuestion(question: '"Адвокат" по-испански:', options: ['médico', 'juez', 'abogado', 'notario'], correctIndex: 2, explanation: 'el abogado = адвокат'),
        ExamQuestion(question: 'Trabaja ___ ingeniero.', options: ['como', 'de', 'por', 'a y b son correctos'], correctIndex: 3, explanation: 'trabajar como/de = работать в качестве'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_07', title: 'Describir personas', subtitle: 'Описание людей', emoji: '🧑',
      level: LanguageLevel.a2, order: 7, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Внешность', content: 'alto/bajo — высокий/низкий\ngordo/delgado — полный/худой\nrubio — светловолосый\nmoreno — темноволосый\nojos azules — голубые глаза\njoven/viejo — молодой/старый', examples: ['Es alto y tiene los ojos azules.', 'Ella es rubia.', 'Mi abuelo es viejo pero activo.']),
        TheorySection(title: 'Характер', content: 'simpático — симпатичный\ndivertido — весёлый\ntranquilo — спокойный\ntrabajador — трудолюбивый\ninteligente — умный\namable — любезный', examples: ['Mi profesora es muy simpática.', 'Él es divertido y amable.', 'Es trabajadora e inteligente.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Высокий" по-испански:', options: ['bajo', 'delgado', 'alto', 'gordo'], correctIndex: 2, explanation: 'alto = высокий'),
        CourseExercise(type: ExerciseType.translation, question: '"Он весёлый и умный":', options: ['Es tranquilo e inteligente.', 'Es divertido e inteligente.', 'Es simpático y amable.', 'Es trabajador y alto.'], correctIndex: 1, explanation: 'divertido = весёлый; inteligente = умный'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Ella tiene el pelo ___. (тёмный)', options: ['rubio', 'rojo', 'moreno', 'largo'], correctIndex: 2, explanation: 'moreno/a = темноволосый/темноволосая'),
      ],
      exam: [
        ExamQuestion(question: '"Трудолюбивый" по-испански:', options: ['divertido', 'tranquilo', 'trabajador', 'simpático'], correctIndex: 2, explanation: 'trabajador = трудолюбивый'),
        ExamQuestion(question: '"Худой/стройный" по-испански:', options: ['gordo', 'bajo', 'alto', 'delgado'], correctIndex: 3, explanation: 'delgado = стройный/худой'),
        ExamQuestion(question: 'Tiene los ojos ___. (голубые)', options: ['verdes', 'marrones', 'azules', 'negros'], correctIndex: 2, explanation: 'los ojos azules = голубые глаза'),
        ExamQuestion(question: '"Спокойный" по-испански:', options: ['divertido', 'inteligente', 'tranquilo', 'simpático'], correctIndex: 2, explanation: 'tranquilo = спокойный'),
        ExamQuestion(question: '"Молодой" по-испански:', options: ['viejo', 'nuevo', 'joven', 'moderno'], correctIndex: 2, explanation: 'joven = молодой'),
      ],
    ),

    CourseChapter(
      id: 'es_a2_08', title: 'Futuro', subtitle: 'Будущее время', emoji: '🔮',
      level: LanguageLevel.a2, order: 8, coinsReward: 40, xpReward: 25,
      theory: [
        TheorySection(title: 'Ir a + Infinitivo', content: 'ir a + Infinitivo = ближайшее будущее\nVoy a comer. — Я собираюсь поесть.\nVas a ir. — Ты собираешься идти.\nVa a llover. — Собирается дождь.', examples: ['Voy a estudiar mañana.', 'Vamos a visitar Madrid.', '¿Qué vas a hacer este fin de semana?']),
        TheorySection(title: 'Futuro simple', content: 'Infinitivo + -é, -ás, -á, -emos, -éis, -án\nhablar: hablaré, hablarás, hablará\nser: seré\nir: iré\ntener: tendré (неправ.)', examples: ['Mañana hablaré con el director.', 'Ella será médica.', 'Iremos a España.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Я собираюсь поехать" (ir a):', options: ['Salgo.', 'Voy a salir.', 'Saldré.', 'He salido.'], correctIndex: 1, explanation: 'ir a + Infinitivo = ближайшее будущее'),
        CourseExercise(type: ExerciseType.translation, question: '"Завтра она будет врачом" (futuro):', options: ['Ella es médica.', 'Ella va a ser médica.', 'Ella será médica.', 'Ella era médica.'], correctIndex: 2, explanation: 'ser futuro: ella será'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Iremos ___ España. (futuro)', options: ['a', 'en', 'de', 'para'], correctIndex: 0, explanation: 'ir a + lugar'),
      ],
      exam: [
        ExamQuestion(question: 'yo ___ (hablar, futuro)', options: ['hablo', 'hablaba', 'hablaré', 'hablara'], correctIndex: 2, explanation: 'futuro: yo hablaré'),
        ExamQuestion(question: '"Пойдёт дождь" (ir a):', options: ['Llueve.', 'Va a llover.', 'Lloverá.', 'Ha llovido.'], correctIndex: 1, explanation: 'ir a + llover = ближайшее будущее'),
        ExamQuestion(question: 'tener → futuro (yo): yo ___', options: ['teneré', 'tendré', 'tendré', 'teneré'], correctIndex: 1, explanation: 'tener → tendré (неправильный futuro)'),
        ExamQuestion(question: '"Завтра" по-испански:', options: ['ayer', 'hoy', 'mañana', 'pronto'], correctIndex: 2, explanation: 'mañana = завтра'),
        ExamQuestion(question: 'ser → futuro (ella):', options: ['es', 'era', 'será', 'sea'], correctIndex: 2, explanation: 'ser futuro: ella será'),
      ],
    ),

    // ── B1 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'es_b1_01', title: 'Pretérito indefinido', subtitle: 'Прошедшее завершённое', emoji: '📚',
      level: LanguageLevel.b1, order: 1, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование', content: '-ar: -é, -aste, -ó, -amos, -asteis, -aron\n-er/-ir: -í, -iste, -ió, -imos, -isteis, -ieron\nhablé, hablaste, habló\ncomí, comiste, comió', examples: ['Ayer comí pizza.', 'Él llegó tarde.', 'Viajamos a España el año pasado.']),
        TheorySection(title: 'Неправильные глаголы', content: 'ser/ir: fui, fuiste, fue, fuimos\ntener: tuve, tuviste, tuvo\nhacer: hice, hiciste, hizo\nir: fui (= ser в прошлом)', examples: ['Fui al médico ayer.', 'Él tuvo un accidente.', '¿Qué hiciste el sábado?']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'yo ___ (hablar, pretérito)', options: ['hablé', 'habló', 'hablaba', 'hablara'], correctIndex: 0, explanation: 'hablar pretérito: yo hablé'),
        CourseExercise(type: ExerciseType.translation, question: '"Вчера я ел пиццу":', options: ['Ayer como pizza.', 'Ayer comí pizza.', 'Ayer he comido pizza.', 'Ayer comía pizza.'], correctIndex: 1, explanation: 'Конкретное действие в прошлом = pretérito indefinido'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Él ___ al médico ayer. (ir)', options: ['iba', 'va', 'fue', 'irá'], correctIndex: 2, explanation: 'ir/ser pretérito: fue'),
      ],
      exam: [
        ExamQuestion(question: 'comer → pretérito (él):', options: ['comió', 'comía', 'come', 'coma'], correctIndex: 0, explanation: 'comer pretérito: él comió'),
        ExamQuestion(question: 'hacer → pretérito (yo):', options: ['hací', 'hacé', 'hice', 'hació'], correctIndex: 2, explanation: 'hacer pretérito: yo hice'),
        ExamQuestion(question: 'tener → pretérito (nosotros):', options: ['tenemos', 'tuvimos', 'teníamos', 'tendremos'], correctIndex: 1, explanation: 'tener pretérito: nosotros tuvimos'),
        ExamQuestion(question: 'ser → pretérito (ella):', options: ['era', 'fue', 'será', 'sea'], correctIndex: 1, explanation: 'ser/ir pretérito: ella fue'),
        ExamQuestion(question: '¿Qué ___ el sábado? (hacer, tú)', options: ['haces', 'hiciste', 'hacías', 'harías'], correctIndex: 1, explanation: 'hacer pretérito: tú hiciste'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_02', title: 'Pretérito imperfecto', subtitle: 'Незаконченное прошедшее', emoji: '⏪',
      level: LanguageLevel.b1, order: 2, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование', content: '-ar: -aba, -abas, -aba, -ábamos, -abais, -aban\n-er/-ir: -ía, -ías, -ía, -íamos, -íais, -ían\nhablaba, comía\nsер: era; ir: iba', examples: ['Cuando era niño, jugaba.', 'Todos los días comía pizza.', 'Iba al parque cada domingo.']),
        TheorySection(title: 'Употребление', content: 'Imperfecto = фон, привычка, незаконченное\nIndefinido = конкретный факт, событие\nCuando era pequeño (фон), conocí a María (событие).', examples: ['Leía cuando llegó.', 'Cada verano, viajábamos.', 'Llovía cuando salí.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'hablar → imperfecto (yo):', options: ['hablé', 'hablaba', 'hablaré', 'hablara'], correctIndex: 1, explanation: 'imperfecto: yo hablaba'),
        CourseExercise(type: ExerciseType.translation, question: '"Когда я был маленьким, я играл" (привычка):', options: ['Cuando fui niño, jugué.', 'Cuando era niño, jugaba.', 'Cuando soy niño, juego.', 'Cuando era niño, jugué.'], correctIndex: 1, explanation: 'Привычка в прошлом = imperfecto'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Llovía cuando ___ (salir, yo, indefinido)', options: ['salía', 'salgo', 'salí', 'saldré'], correctIndex: 2, explanation: 'Событие = indefinido: salí'),
      ],
      exam: [
        ExamQuestion(question: 'comer → imperfecto (ella):', options: ['comió', 'comía', 'come', 'coma'], correctIndex: 1, explanation: 'imperfecto: ella comía'),
        ExamQuestion(question: 'Imperfecto используется для:', options: ['конкретного события', 'привычки в прошлом', 'ближайшего будущего', 'команды'], correctIndex: 1, explanation: 'Imperfecto = повторяющееся/фоновое действие'),
        ExamQuestion(question: 'ser → imperfecto (yo):', options: ['fui', 'era', 'seré', 'sea'], correctIndex: 1, explanation: 'ser imperfecto: yo era'),
        ExamQuestion(question: 'Leía cuando él ___ (llegar, indefinido)', options: ['llegaba', 'llega', 'llegó', 'llegará'], correctIndex: 2, explanation: 'Событие прервало фон = indefinido: llegó'),
        ExamQuestion(question: 'ir → imperfecto (nosotros):', options: ['fuimos', 'íbamos', 'vamos', 'iremos'], correctIndex: 1, explanation: 'ir imperfecto: nosotros íbamos'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_03', title: 'Subjuntivo presente', subtitle: 'Сослагательное наклонение', emoji: '🎯',
      level: LanguageLevel.b1, order: 3, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Образование', content: '-ar → -e (hable, hables, hable, hablemos)\n-er/-ir → -a (coma, comas, coma, comamos)\nser: sea; estar: esté; ir: vaya; haber: haya', examples: ['Espero que vengas.', 'Quiero que hables.', 'Es importante que estudies.']),
        TheorySection(title: 'После каких слов', content: 'После желания, необходимости, эмоций:\nquerer que, esperar que, es importante que\ntener miedo de que, aunque (хотя, если неизвестно)', examples: ['Quiero que ella sea feliz.', 'Es necesario que vengas.', 'Aunque llueva, iré.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'ser → subjuntivo (ella):', options: ['es', 'era', 'sea', 'sería'], correctIndex: 2, explanation: 'ser subjuntivo: que ella sea'),
        CourseExercise(type: ExerciseType.translation, question: '"Нужно, чтобы ты пришёл":', options: ['Tienes que venir.', 'Es necesario que vengas.', 'Es necesario venir.', 'Debes venir.'], correctIndex: 1, explanation: 'es necesario que + subjuntivo'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Quiero que ella ___ (hablar, subj.)', options: ['habla', 'hable', 'hablará', 'hablaba'], correctIndex: 1, explanation: 'hablar subjuntivo: que ella hable'),
      ],
      exam: [
        ExamQuestion(question: 'ir → subjuntivo (yo):', options: ['voy', 'fui', 'vaya', 'iré'], correctIndex: 2, explanation: 'ir subjuntivo: que yo vaya'),
        ExamQuestion(question: 'haber → subjuntivo: haya (перев.):', options: ['есть', 'было', 'будет', 'есть/было/будет (сослаг.)'], correctIndex: 3, explanation: 'haya = subjuntivo от haber'),
        ExamQuestion(question: 'Subjuntivo используется после:', options: ['porque', 'cuando (прошлое)', 'querer que', 'si'], correctIndex: 2, explanation: 'querer que + subjuntivo'),
        ExamQuestion(question: 'Aunque ___ (llover), iré.', options: ['llueve', 'llueva', 'llovía', 'llovió'], correctIndex: 1, explanation: 'aunque + subjuntivo = хотя (неизвестно)'),
        ExamQuestion(question: 'comer → subjuntivo (tú):', options: ['comes', 'comas', 'comías', 'comerás'], correctIndex: 1, explanation: 'comer subjuntivo: que tú comas'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_04', title: 'Pasiva', subtitle: 'Пассивный залог', emoji: '🔄',
      level: LanguageLevel.b1, order: 4, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Пассив с ser', content: 'ser + participio (согласован с подлежащим)\nEl libro es leído. — Книга читается.\nLa casa fue construida. — Дом был построен.\npor + агент', examples: ['Esta novela es leída por todos.', 'La carta fue escrita por María.', 'Los coches son reparados aquí.']),
        TheorySection(title: 'Пассив se', content: 'Se + глагол — безличный пассив\nSe habla español. — Говорят по-испански.\nSe venden coches. — Продаются машины.\nЧасто используется в объявлениях', examples: ['Se alquila piso.', 'Se habla inglés.', 'Se busca programador.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Книга читается" (pasiva ser):', options: ['El libro lee.', 'El libro es leído.', 'El libro ha leído.', 'Se lee el libro.'], correctIndex: 1, explanation: 'Pasiva: ser + participio'),
        CourseExercise(type: ExerciseType.translation, question: '"Говорят по-испански":', options: ['Hablan español.', 'Se habla español.', 'Es hablado español.', 'Ellos hablan español.'], correctIndex: 1, explanation: 'Pasiva refleja: se habla = hablan en general'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'La carta ___ escrita por María.', options: ['es', 'está', 'fue', 'ha'], correctIndex: 2, explanation: 'Pasiva pretérito: fue escrita'),
      ],
      exam: [
        ExamQuestion(question: 'leer → participio:', options: ['leyendo', 'leído', 'lee', 'leer'], correctIndex: 1, explanation: 'leer → leído'),
        ExamQuestion(question: '"Продаются машины" (pasiva se):', options: ['Los coches venden.', 'Se venden coches.', 'Son vendidos coches.', 'Coches son vendidos.'], correctIndex: 1, explanation: 'Se venden coches = pasiva refleja'),
        ExamQuestion(question: 'escribir → participio:', options: ['escribiendo', 'escribito', 'escrito', 'escribido'], correctIndex: 2, explanation: 'escribir → escrito (неправильный)'),
        ExamQuestion(question: '"Сдаётся квартира" (объявление):', options: ['La casa es alquilada.', 'Se alquila piso.', 'Alquilan piso.', 'Piso alquilado.'], correctIndex: 1, explanation: 'Se alquila = сдаётся (объявление)'),
        ExamQuestion(question: 'hacer → participio:', options: ['haciendo', 'hacido', 'hecho', 'hace'], correctIndex: 2, explanation: 'hacer → hecho (неправильный)'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_05', title: 'Estilo indirecto', subtitle: 'Косвенная речь', emoji: '💬',
      level: LanguageLevel.b1, order: 5, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Косвенная речь', content: 'Dice que ... — Он говорит, что ...\nDijo que ... — Он сказал, что ...\nСдвиг времён:\npresente → imperfecto\nfuturo → condicional\npretérito perfecto → pluscuamperfecto', examples: ['Dice: "Estoy cansado." → Dice que está cansado.', 'Dijo: "Estoy cansado." → Dijo que estaba cansado.', 'Dijo que vendría.']),
        TheorySection(title: 'Косвенные вопросы', content: 'Да/нет: preguntar si + ...\nСпециальные: preguntar dónde/cuándo/qué + ...\nПорядок слов как в утверждении', examples: ['Pregunta si vienes.', 'Pregunta dónde vives.', 'Quiero saber por qué va.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Dice: Estoy enfermo" → estilo indirecto:', options: ['Dice que está enfermo.', 'Dice que estaba enfermo.', 'Dice que estará enfermo.', 'Dice él está enfermo.'], correctIndex: 0, explanation: 'decir presente: no сдвиг — está'),
        CourseExercise(type: ExerciseType.translation, question: '"Он спрашивает, придёшь ли ты":', options: ['Pregunta si vienes.', 'Pregunta que vienes.', 'Pregunta si vengas.', 'Quiere saber vienes.'], correctIndex: 0, explanation: 'preguntar si = спрашивать (да/нет)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Dijo que ___ cansado. (estar, сдвиг)', options: ['está', 'estaba', 'estuvo', 'estará'], correctIndex: 1, explanation: 'dijo (прошлое) → сдвиг: estaba'),
      ],
      exam: [
        ExamQuestion(question: 'Сдвиг presente → ? (при dijo):', options: ['futuro', 'imperfecto', 'subjuntivo', 'condicional'], correctIndex: 1, explanation: 'presente → imperfecto в косвенной речи'),
        ExamQuestion(question: '"Dijo: Vendré" → estilo indirecto:', options: ['Dijo que vendrá.', 'Dijo que vendría.', 'Dijo que viene.', 'Dijo que venía.'], correctIndex: 1, explanation: 'futuro → condicional: vendría'),
        ExamQuestion(question: 'Косвенный вопрос "¿Dónde vives?":', options: ['Pregunta dónde vives.', 'Pregunta dónde vives?', 'Pregunta si vives.', 'Pregunta que vives.'], correctIndex: 0, explanation: 'Без инверсии и без вопросительного знака'),
        ExamQuestion(question: 'Сдвиг futuro → ? (при dijo):', options: ['imperfecto', 'subjuntivo', 'condicional', 'presente'], correctIndex: 2, explanation: 'futuro → condicional в косвенной речи'),
        ExamQuestion(question: 'Pregunta ___ vas. (куда)', options: ['que', 'si', 'adónde', 'donde'], correctIndex: 2, explanation: 'adónde = куда (для движения)'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_06', title: 'Comparativos y superlativos', subtitle: 'Сравнения', emoji: '📊',
      level: LanguageLevel.b1, order: 6, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Comparativo', content: 'más + adj + que — более ... чем\nmenos + adj + que — менее ... чем\ntan + adj + como — такой же ... как\nbueno → mejor; malo → peor', examples: ['Él es más alto que yo.', 'Este libro es menos aburrido que ese.', 'Es tan inteligente como su hermano.']),
        TheorySection(title: 'Superlativo', content: 'el/la/los/las más + adj — самый ...\nel/la/los/las menos + adj — наименее ...\nbueno → el mejor; malo → el peor\nde + grupo', examples: ['Es la ciudad más bonita del mundo.', 'Él es el más inteligente de la clase.', 'Es el mejor restaurante aquí.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Он выше меня":', options: ['Es tan alto como yo.', 'Es más alto que yo.', 'Es menos alto que yo.', 'Es el más alto.'], correctIndex: 1, explanation: 'más + adj + que = más alto que'),
        CourseExercise(type: ExerciseType.translation, question: '"Это лучший ресторан":', options: ['Es un buen restaurante.', 'Es el mejor restaurante.', 'Es más bueno.', 'Es muy bueno.'], correctIndex: 1, explanation: 'bueno → el mejor (суперлатив неправ.)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Es ___ inteligente de la clase.', options: ['el más', 'la más', 'más', 'muy'], correctIndex: 0, explanation: 'Superlatif муж.р.: el más inteligente'),
      ],
      exam: [
        ExamQuestion(question: 'bueno → comparativo:', options: ['más bueno', 'mejor', 'buenísimo', 'muy bueno'], correctIndex: 1, explanation: 'bueno → mejor (неправ. сравн.)'),
        ExamQuestion(question: '"Менее быстрый, чем он":', options: ['más rápido que él', 'tan rápido como él', 'menos rápido que él', 'muy rápido'], correctIndex: 2, explanation: 'menos + adj + que'),
        ExamQuestion(question: '"Самый красивый в мире":', options: ['más bonito del mundo', 'el más bonito del mundo', 'tan bonito del mundo', 'muy bonito del mundo'], correctIndex: 1, explanation: 'el más + adj + de = суперлатив'),
        ExamQuestion(question: 'malo → superlativo:', options: ['el más malo / el peor', 'menos malo', 'el mejor', 'más malo'], correctIndex: 0, explanation: 'malo → el peor (или el más malo)'),
        ExamQuestion(question: '"Такой же умный, как она":', options: ['más inteligente que ella', 'tan inteligente como ella', 'menos inteligente que ella', 'muy inteligente'], correctIndex: 1, explanation: 'tan + adj + como = такой же ... как'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_07', title: 'Tecnología e internet', subtitle: 'Технологии', emoji: '💻',
      level: LanguageLevel.b1, order: 7, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Технологии', content: 'internet — интернет\nla aplicación — приложение\nel sitio web — веб-сайт\nel teléfono inteligente — смартфон\nla IA (Inteligencia Artificial) — ИИ\ndescargar — скачивать\nsubir — загружать', examples: ['Descargo la aplicación.', 'La IA es cada vez más importante.', 'Envíame el enlace del sitio web.']),
        TheorySection(title: 'Онлайн общение', content: 'enviar un correo electrónico — отправить email\ncompartir una foto — поделиться фото\nseguir a alguien — подписаться\nuna publicación — публикация\nlas redes sociales — соцсети', examples: ['Mando un correo al jefe.', '¿Has recibido mi mensaje?', 'Ella ha iniciado sesión.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Скачивать" по-испански:', options: ['subir', 'descargar', 'instalar', 'guardar'], correctIndex: 1, explanation: 'descargar = скачивать'),
        CourseExercise(type: ExerciseType.translation, question: '"Я отправил email":', options: ['He recibido un correo.', 'He enviado un correo.', 'He leído un correo.', 'He escrito un correo.'], correctIndex: 1, explanation: 'enviar: he enviado'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Las ___ sociales son muy populares.', options: ['medios', 'redes', 'sitios', 'aplicaciones'], correctIndex: 1, explanation: 'las redes sociales = социальные сети'),
      ],
      exam: [
        ExamQuestion(question: '"Приложение" по-испански:', options: ['sitio web', 'aplicación', 'programa', 'software'], correctIndex: 1, explanation: 'la aplicación = приложение'),
        ExamQuestion(question: '"Поделиться фото":', options: ['descargar una foto', 'compartir una foto', 'enviar una foto', 'buscar una foto'], correctIndex: 1, explanation: 'compartir = делиться'),
        ExamQuestion(question: 'IA = Inteligencia ___:', options: ['Automatizada', 'Artificial', 'Avanzada', 'Aplicada'], correctIndex: 1, explanation: 'IA = Inteligencia Artificial'),
        ExamQuestion(question: '"Подписаться" (на аккаунт):', options: ['compartir', 'descargar', 'seguir', 'likear'], correctIndex: 2, explanation: 'seguir a alguien = подписаться'),
        ExamQuestion(question: '"Смартфон" по-испански:', options: ['ordenador', 'tableta', 'teléfono inteligente', 'teléfono fijo'], correctIndex: 2, explanation: 'el teléfono inteligente = смартфон'),
      ],
    ),

    CourseChapter(
      id: 'es_b1_08', title: 'Salud y medicina', subtitle: 'Здоровье и медицина', emoji: '🏥',
      level: LanguageLevel.b1, order: 8, coinsReward: 50, xpReward: 35,
      theory: [
        TheorySection(title: 'Медицина', content: 'el resfriado — насморк\nla fiebre — температура\nla tos — кашель\nla alergia — аллергия\nla receta — рецепт\nla farmacia — аптека\nel medicamento — лекарство', examples: ['Tengo un resfriado desde ayer.', 'Necesito una receta.', 'Tomo este medicamento.']),
        TheorySection(title: 'У врача', content: 'No me siento bien. — Мне нехорошо.\n¿Desde cuándo le duele? — С каких пор болит?\nLe receto ... — Я вам выписываю ...\nTome las pastillas 3 veces al día.', examples: ['No me siento bien desde esta mañana.', 'El médico me receta antibióticos.', 'Tres veces al día con agua.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Насморк" по-испански:', options: ['tos', 'fiebre', 'resfriado', 'alergia'], correctIndex: 2, explanation: 'el resfriado = насморк/простуда'),
        CourseExercise(type: ExerciseType.translation, question: '"Мне нехорошо":', options: ['Estoy enfermo.', 'No me siento bien.', 'Me duele.', 'Estoy cansado.'], correctIndex: 1, explanation: 'no sentirse bien = чувствовать себя нехорошо'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Tome las ___ tres veces al día.', options: ['recetas', 'medicamentos', 'pastillas', 'jarabes'], correctIndex: 2, explanation: 'las pastillas = таблетки'),
      ],
      exam: [
        ExamQuestion(question: '"Аптека" по-испански:', options: ['hospital', 'clínica', 'farmacia', 'consultorio'], correctIndex: 2, explanation: 'la farmacia = аптека'),
        ExamQuestion(question: '"Кашель" по-испански:', options: ['resfriado', 'fiebre', 'tos', 'dolor'], correctIndex: 2, explanation: 'la tos = кашель'),
        ExamQuestion(question: 'No me ___ bien.', options: ['soy', 'siento', 'estoy', 'voy'], correctIndex: 1, explanation: 'sentirse: me siento'),
        ExamQuestion(question: '"Рецепт" по-испански:', options: ['medicamento', 'receta', 'pastilla', 'tratamiento'], correctIndex: 1, explanation: 'la receta = рецепт'),
        ExamQuestion(question: '¿Desde ___ le duele?', options: ['dónde', 'cómo', 'cuándo', 'qué'], correctIndex: 2, explanation: '¿Desde cuándo? = С каких пор?'),
      ],
    ),

    // ── B2 ──────────────────────────────────────────────────────────
    CourseChapter(
      id: 'es_b2_01', title: 'Condicional', subtitle: 'Условное наклонение', emoji: '💭',
      level: LanguageLevel.b2, order: 1, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Condicional simple', content: 'Infinitivo + -ía, -ías, -ía, -íamos, -íais, -ían\nhablar: hablaría, hablarías...\ntener: tendría (неправ.)\nsalir: saldría', examples: ['Me gustaría viajar.', 'Él estaría contento.', 'Nos gustaría vivir aquí.']),
        TheorySection(title: 'Условные предложения', content: 'Тип 2 (нереальное): si + imperfecto subj., ... condicional\nSi tuviera tiempo, viajaría.\nТип 3 (прошлое нереальное): si + pluscuamperfecto subj., ... condicional perfecto\nSi hubiera tenido tiempo, habría viajado.', examples: ['Si fuera rico, compraría una villa.', 'Si hubiera estudiado, habría aprobado.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'yo ___ (hablar, condicional)', options: ['hablaré', 'hablaría', 'hablaba', 'hable'], correctIndex: 1, explanation: 'condicional: yo hablaría'),
        CourseExercise(type: ExerciseType.translation, question: '"Если бы у меня было время, я бы путешествовал":', options: ['Si tengo tiempo, viajo.', 'Si tenía tiempo, viajaba.', 'Si tuviera tiempo, viajaría.', 'Si tuviera tiempo, viajara.'], correctIndex: 2, explanation: 'Si + imperfecto subj. → condicional (тип 2)'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'ser → condicional (ella):', options: ['será', 'sería', 'era', 'sea'], correctIndex: 1, explanation: 'ser condicional: ella sería'),
      ],
      exam: [
        ExamQuestion(question: 'tener → condicional (yo):', options: ['tendré', 'tendría', 'tenía', 'tuviera'], correctIndex: 1, explanation: 'tener condicional: yo tendría'),
        ExamQuestion(question: 'Si + imperfecto subj. → ...', options: ['futuro', 'condicional', 'subjuntivo', 'presente'], correctIndex: 1, explanation: 'Tipo 2: si + imperfecto subj. + condicional'),
        ExamQuestion(question: 'salir → condicional (nosotros):', options: ['salimos', 'saldríamos', 'salíamos', 'salgamos'], correctIndex: 1, explanation: 'salir → saldríamos'),
        ExamQuestion(question: '"Если бы ты учился, ты бы сдал" (тип 3):', options: ['Si estudiaras, aprobarías.', 'Si hubieras estudiado, habrías aprobado.', 'Si has estudiado, has aprobado.', 'Si estudias, apruebas.'], correctIndex: 1, explanation: 'Si + PPS → condicional perfecto (тип 3)'),
        ExamQuestion(question: 'querer → condicional (él):', options: ['querrá', 'querría', 'quería', 'quiera'], correctIndex: 1, explanation: 'querer → él querría'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_02', title: 'Oraciones complejas', subtitle: 'Сложные предложения', emoji: '🔗',
      level: LanguageLevel.b2, order: 2, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Подчинительные союзы', content: 'aunque + subjuntivo — хотя (неизвестно)\naunque + indicativo — хотя (факт)\npara que + subjuntivo — чтобы\na menos que — если только не\nsiempre que — при условии что', examples: ['Aunque llueva, iré.', 'Aunque llueve, voy.', 'Habla despacio para que te entienda.']),
        TheorySection(title: 'Относительные предложения', content: 'que — который\ndonde — где\ncuyo/a — чей\nel que / la que — тот, кто\nlo que — то, что', examples: ['El hombre que vino.', 'La ciudad donde nació.', 'El libro cuyo autor es famoso.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Aunque ___ (llover, subj., неизвестно), iré.', options: ['llueve', 'llueva', 'llovía', 'llovió'], correctIndex: 1, explanation: 'aunque + subjuntivo = хотя (гипотетически)'),
        CourseExercise(type: ExerciseType.translation, question: '"Говори медленно, чтобы я понял":', options: ['Habla despacio y te entiendo.', 'Habla despacio para que te entienda.', 'Habla despacio porque te entiendo.', 'Habla despacio si te entiendo.'], correctIndex: 1, explanation: 'para que + subjuntivo = чтобы'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'El libro ___ autor es famoso.', options: ['que', 'donde', 'cuyo', 'cual'], correctIndex: 2, explanation: 'cuyo/a = чей (согласуется с существительным)'),
      ],
      exam: [
        ExamQuestion(question: '"Чтобы ты понял":', options: ['para que entiendas', 'para que entiendes', 'para entender', 'para que entendiste'], correctIndex: 0, explanation: 'para que + subjuntivo'),
        ExamQuestion(question: '"Если только не придёт он":', options: ['si no viene', 'a menos que venga', 'aunque venga', 'siempre que venga'], correctIndex: 1, explanation: 'a menos que = если только не (+ subjuntivo)'),
        ExamQuestion(question: 'La ciudad ___ nació es Madrid.', options: ['que', 'donde', 'cuya', 'cuando'], correctIndex: 1, explanation: 'donde = где (место)'),
        ExamQuestion(question: '"То, что ты говоришь" = lo ___', options: ['que hablas', 'que dices', 'cual dices', 'que digas'], correctIndex: 1, explanation: 'lo que = то, что'),
        ExamQuestion(question: '"При условии что придёшь":', options: ['aunque vengas', 'siempre que vengas', 'para que vengas', 'a menos que vengas'], correctIndex: 1, explanation: 'siempre que = при условии что (+ subjuntivo)'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_03', title: 'Español de negocios', subtitle: 'Деловой испанский', emoji: '📊',
      level: LanguageLevel.b2, order: 3, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Деловая переписка', content: 'Estimado/a Sr./Sra. ... — Уважаемый/ая\nMe dirijo a usted para ... — Обращаюсь к вам ...\nAdjunto encontrará ... — В приложении найдёте ...\nEn espera de su respuesta — В ожидании вашего ответа\nAtentamente / Un cordial saludo — С уважением', examples: ['Estimado Sr. García:', 'Adjunto encontrará mi currículum.', 'En espera de su respuesta, atentamente.']),
        TheorySection(title: 'Переговоры', content: 'Propongo que ... — Предлагаю ...\n¿Qué le parece si ...? — Как вам, если ...?\nEs viable. — Это осуществимо.\nLamentablemente, no es posible. — К сожалению, невозможно.', examples: ['Propongo una reunión el lunes.', '¿Qué le parece si nos vemos el martes?', 'Lamentablemente, no está en nuestro presupuesto.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Стандартное завершение делового письма:', options: ['Chao', 'Hasta luego', 'Atentamente', 'Con cariño'], correctIndex: 2, explanation: 'Atentamente = с уважением (официально)'),
        CourseExercise(type: ExerciseType.translation, question: '"В приложении найдёте мой CV":', options: ['Te mando mi CV.', 'Adjunto encontrará mi currículum.', 'Aquí está mi CV.', 'Mira mi CV.'], correctIndex: 1, explanation: 'Adjunto encontrará = стандартная деловая фраза'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'Me ___ a usted para solicitar información.', options: ['voy', 'dirijo', 'llamo', 'escribo'], correctIndex: 1, explanation: 'dirigirse a = обращаться к'),
      ],
      exam: [
        ExamQuestion(question: '"В ожидании вашего ответа":', options: ['Gracias por su respuesta.', 'En espera de su respuesta.', 'Espero que responda.', 'Quiero su respuesta.'], correctIndex: 1, explanation: 'En espera de su respuesta = стандартная фраза'),
        ExamQuestion(question: '"К сожалению, невозможно":', options: ['Es posible.', 'Lamentablemente, no es posible.', 'No, gracias.', 'Esto no va.'], correctIndex: 1, explanation: 'Lamentablemente = к сожалению'),
        ExamQuestion(question: 'Обращение в официальном письме:', options: ['Hola,', 'Buenos días,', 'Estimado Sr./Sra.,', 'Querido amigo,'], correctIndex: 2, explanation: 'Estimado/a Sr./Sra. = официальное обращение'),
        ExamQuestion(question: '"Предлагаю встречу":', options: ['Quiero una reunión.', 'Propongo una reunión.', 'Vamos a una reunión.', 'La reunión está fijada.'], correctIndex: 1, explanation: 'proponer = предлагать'),
        ExamQuestion(question: 'Adjunto = ?', options: ['здесь', 'в приложении', 'выше', 'ниже'], correctIndex: 1, explanation: 'adjunto = в приложении/прилагается'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_04', title: 'Expresiones idiomáticas', subtitle: 'Идиомы', emoji: '🎭',
      level: LanguageLevel.b2, order: 4, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Идиомы', content: 'Costar un ojo de la cara — стоить целое состояние\nNo hay mal que por bien no venga. — Нет худа без добра.\nMeter la pata — облажаться/сказать лишнее\nNo tener pelos en la lengua — говорить прямо\nSer pan comido — плёвое дело', examples: ['Este coche cuesta un ojo de la cara.', '¡Metí la pata en la reunión!', 'Eso es pan comido.']),
        TheorySection(title: 'Ещё идиомы', content: 'Estar en las nubes — быть в облаках\nLlueve a cántaros. — Льёт как из ведра.\nNo es lo que parece. — Не всё так, как кажется.\nDar en el clavo — попасть в точку', examples: ['Siempre estás en las nubes.', 'Llueve a cántaros hoy.', '¡Has dado en el clavo!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"Льёт как из ведра" по-испански:', options: ['Hay mucha lluvia.', 'Llueve mucho.', 'Llueve a cántaros.', 'Hace mal tiempo.'], correctIndex: 2, explanation: 'Llueve a cántaros. = льёт как из ведра'),
        CourseExercise(type: ExerciseType.translation, question: '"Стоить целое состояние":', options: ['Es caro.', 'Cuesta mucho.', 'Cuesta un ojo de la cara.', 'Vale mucho dinero.'], correctIndex: 2, explanation: 'costar un ojo de la cara = стоить как глаз (очень дорого)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '¡Has dado en el ___! (попал в точку)', options: ['blanco', 'clavo', 'centro', 'punto'], correctIndex: 1, explanation: 'dar en el clavo = попасть в точку'),
      ],
      exam: [
        ExamQuestion(question: '"Быть в облаках" (идиома):', options: ['Estar confundido', 'Estar en las nubes', 'Tener la cabeza llena', 'No prestar atención'], correctIndex: 1, explanation: 'estar en las nubes = витать в облаках'),
        ExamQuestion(question: '"Облажаться/сказать лишнее" (идиома):', options: ['Meter la pata', 'Abrir la boca', 'Decir algo', 'Cometer un error'], correctIndex: 0, explanation: 'meter la pata = сказать/сделать что-то неловкое'),
        ExamQuestion(question: '"Плёвое дело" по-испански:', options: ['Es difícil.', 'No hay problema.', 'Es pan comido.', 'Es fácil.'], correctIndex: 2, explanation: 'ser pan comido = быть как съеденный хлеб = плёвое дело'),
        ExamQuestion(question: '"Говорить прямо" (идиома):', options: ['Hablar claro', 'No tener pelos en la lengua', 'Decir la verdad', 'Ser honesto'], correctIndex: 1, explanation: 'no tener pelos en la lengua = говорить без прикрас'),
        ExamQuestion(question: '"Нет худа без добра":', options: ['Todo es malo.', 'No hay mal que por bien no venga.', 'Las cosas malas siempre pasan.', 'No es tan malo.'], correctIndex: 1, explanation: 'No hay mal que por bien no venga. = нет худа без добра'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_05', title: 'Cultura hispanohablante', subtitle: 'Испаноязычный мир', emoji: '🏛️',
      level: LanguageLevel.b2, order: 5, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Испаноязычные страны', content: 'España — Испания\nMéxico — Мексика (130 млн)\nArgentina, Colombia, Venezuela, Peru...\nTotal: 20 стран, ~500 млн носителей\nEl español — 2-й язык в мире по числу носителей', examples: ['México tiene la mayor población hispanohablante.', 'El español se habla en 20 países.', 'La RAE regula el español.']),
        TheorySection(title: 'Культура', content: 'El flamenco — фламенко (Испания)\nLa siesta — сиеста\nLa fiesta — праздник/вечеринка\nEl fútbol — футбол (страсть)\nLa paella, los tacos, el mate — еда\nLa corrida — коррида', examples: ['La siesta es costumbre española.', 'El flamenco es Patrimonio de la Humanidad.', '¡Viva España!']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Столица Испании:', options: ['Barcelona', 'Valencia', 'Madrid', 'Sevilla'], correctIndex: 2, explanation: 'Madrid = столица Испании'),
        CourseExercise(type: ExerciseType.translation, question: '"Испанский — 2-й язык по числу носителей":', options: ['El español es el primer idioma.', 'El español es el segundo idioma del mundo por hablantes nativos.', 'El español es un idioma importante.', 'Hay muchos hispanohablantes.'], correctIndex: 1, explanation: 'el segundo idioma = второй язык'),
        CourseExercise(type: ExerciseType.fillBlank, question: 'El flamenco es ___ de la Humanidad.', options: ['Arte', 'Cultura', 'Patrimonio', 'Tradición'], correctIndex: 2, explanation: 'Patrimonio de la Humanidad = объект ЮНЕСКО'),
      ],
      exam: [
        ExamQuestion(question: 'Сколько стран говорит по-испански?', options: ['10', '15', '20', '25'], correctIndex: 2, explanation: 'Около 20 стран — официальный язык'),
        ExamQuestion(question: '"Сиеста" — это:', options: ['праздник', 'танец', 'дневной сон', 'блюдо'], correctIndex: 2, explanation: 'la siesta = послеобеденный отдых'),
        ExamQuestion(question: 'Страна с наибольшим числом испаноязычных:', options: ['Испания', 'Аргентина', 'Мексика', 'Колумбия'], correctIndex: 2, explanation: 'México tiene ~130 млн носителей'),
        ExamQuestion(question: 'RAE = Real Academia ___:', options: ['Española', 'Española de España', 'Española', 'Española de la Lengua'], correctIndex: 0, explanation: 'RAE = Real Academia Española'),
        ExamQuestion(question: '"Фламенко" — танец из:', options: ['Мексики', 'Аргентины', 'Испании', 'Кубы'], correctIndex: 2, explanation: 'El flamenco es originario de España (Andalucía)'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_06', title: 'Opinión y argumentación', subtitle: 'Мнение и аргументы', emoji: '📰',
      level: LanguageLevel.b2, order: 6, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Выражение мнения', content: 'En mi opinión / A mi juicio — По моему мнению\nMe parece que — Мне кажется, что\nEstoy convencido/a de que — Я убеждён/а, что\nPor un lado ... por otro — С одной ... с другой стороны\nEn conclusión — В заключение', examples: ['En mi opinión, es una buena idea.', 'Me parece que nos equivocamos.', 'Por un lado es caro, por otro es útil.']),
        TheorySection(title: 'Связки', content: 'En primer lugar — Во-первых\nAdemás / Asimismo — Кроме того\nSin embargo / No obstante — Однако\nPor lo tanto / Por consiguiente — Следовательно\nEn definitiva — В конечном счёте', examples: ['En primer lugar, la economía mejora.', 'Sin embargo, el desempleo sigue alto.', 'Por lo tanto, concluimos que...']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: '"По моему мнению" по-испански:', options: ['Creo,', 'En mi opinión,', 'Según él,', 'Me parece'], correctIndex: 1, explanation: 'En mi opinión = по моему мнению'),
        CourseExercise(type: ExerciseType.translation, question: '"Однако проблема остаётся":', options: ['El problema queda.', 'Sin embargo, el problema persiste.', 'Pero, el problema queda.', 'También el problema queda.'], correctIndex: 1, explanation: 'Sin embargo = однако (формально)'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ un lado es caro, por otro es útil.', options: ['Por', 'De', 'En', 'A'], correctIndex: 0, explanation: 'Por un lado ... por otro = с одной ... с другой стороны'),
      ],
      exam: [
        ExamQuestion(question: '"В заключение" по-испански:', options: ['En primer lugar', 'Además', 'En conclusión', 'Sin embargo'], correctIndex: 2, explanation: 'En conclusión = в заключение'),
        ExamQuestion(question: '"Мне кажется, что":', options: ['Estoy seguro de que', 'Me parece que', 'En mi opinión', 'Creo'], correctIndex: 1, explanation: 'Me parece que = мне кажется, что'),
        ExamQuestion(question: '"Кроме того" (формально):', options: ['Sin embargo', 'Además', 'Por lo tanto', 'En conclusión'], correctIndex: 1, explanation: 'Además = кроме того/помимо этого'),
        ExamQuestion(question: '"Следовательно":', options: ['Sin embargo', 'Además', 'Por lo tanto', 'En primer lugar'], correctIndex: 2, explanation: 'Por lo tanto = следовательно'),
        ExamQuestion(question: '"Я убеждён, что":', options: ['Me parece que', 'Creo que', 'Estoy convencido de que', 'En mi opinión'], correctIndex: 2, explanation: 'Estoy convencido/a de que = я убеждён/а'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_07', title: 'Gramática avanzada', subtitle: 'Продвинутая грамматика', emoji: '🔬',
      level: LanguageLevel.b2, order: 7, coinsReward: 60, xpReward: 40,
      theory: [
        TheorySection(title: 'Infinitivo, gerundio, participio', content: 'Infinitivo: nombre del verbo (hablar)\nGerundio: acción en progreso (hablando)\nParticipio: completado/adjetivo (hablado)\nEstar + gerundio = estar hablando\nHaber + participio = haber hablado', examples: ['Estoy comiendo.', 'Habiendo terminado, salió.', 'El libro leído era bueno.']),
        TheorySection(title: 'Perífrasis verbales', content: 'ir a + Inf — собираться\nestar + ger — быть в процессе\ntener que + Inf — должен\ndeber + Inf — должен (нравственно)\nacabar de + Inf — только что\ndejar de + Inf — перестать', examples: ['Acabo de llegar.', 'Debes estudiar más.', 'Deja de hacer eso.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Gerundio от "comer":', options: ['comido', 'comiendo', 'come', 'comer'], correctIndex: 1, explanation: 'gerundio: comiendo'),
        CourseExercise(type: ExerciseType.translation, question: '"Я только что приехал":', options: ['Acabo de llegar.', 'Llegué ahora.', 'He llegado.', 'Estoy llegando.'], correctIndex: 0, explanation: 'acabar de + Inf = только что'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ terminado, salió.', options: ['Estando', 'Habiendo', 'Siendo', 'Teniendo'], correctIndex: 1, explanation: 'Habiendo + participio = perfect gerund'),
      ],
      exam: [
        ExamQuestion(question: 'hablar → gerundio:', options: ['hablado', 'hablar', 'hablando', 'hable'], correctIndex: 2, explanation: 'gerundio: hablando'),
        ExamQuestion(question: '"Только что" — конструкция:', options: ['ir a + Inf', 'acabar de + Inf', 'dejar de + Inf', 'tener que + Inf'], correctIndex: 1, explanation: 'acabar de + Inf = только что'),
        ExamQuestion(question: '"Перестать" — конструкция:', options: ['ir a + Inf', 'acabar de + Inf', 'dejar de + Inf', 'tener que + Inf'], correctIndex: 2, explanation: 'dejar de + Inf = перестать'),
        ExamQuestion(question: 'Estoy ___. (comer, proceso)', options: ['comido', 'como', 'comiendo', 'comer'], correctIndex: 2, explanation: 'estar + gerundio = proceso: estoy comiendo'),
        ExamQuestion(question: '"Должен" (моральное обязательство):', options: ['ir a', 'tener que', 'deber', 'querer'], correctIndex: 2, explanation: 'deber + Inf = нравственный долг'),
      ],
    ),

    CourseChapter(
      id: 'es_b2_08', title: 'Examen final', subtitle: 'Финальный экзамен', emoji: '🏆',
      level: LanguageLevel.b2, order: 8, coinsReward: 100, xpReward: 70,
      theory: [
        TheorySection(title: 'Повторение A1–B1', content: 'A1: Приветствия, числа, семья, еда, тело, время, природа, глаголы\nA2: Неправ. глаголы, транспорт, погода, одежда, описание, futuro\nB1: Pretérito indefinido/imperfecto, Subjuntivo, Pasiva, Estilo indirecto', examples: ['Ayer comí pizza.', 'Cuando era niño, jugaba.', 'Se habla español.']),
        TheorySection(title: 'Повторение B2', content: 'B2: Condicional, Oraciones complejas, Negocios, Idiomas, Cultura, Gramática avanzada\nSi tuviera tiempo, viajaría.\nEn mi opinión, es esencial.\nAcabo de llegar.', examples: ['Cuesta un ojo de la cara.', 'Habiendo terminado, salió.', 'En espera de su respuesta, atentamente.']),
      ],
      exercises: [
        CourseExercise(type: ExerciseType.multipleChoice, question: 'Si tuviera tiempo, ___ (viajar, cond.)', options: ['viajo', 'viajaré', 'viajaría', 'viajara'], correctIndex: 2, explanation: 'Condicional: viajaría'),
        CourseExercise(type: ExerciseType.translation, question: '"Льёт как из ведра" по-испански:', options: ['Llueve mucho.', 'Llueve a cántaros.', 'Hay tormenta.', 'Hace mal tiempo.'], correctIndex: 1, explanation: 'Llueve a cántaros = льёт как из ведра'),
        CourseExercise(type: ExerciseType.fillBlank, question: '___ de llegar. (только что)', options: ['Voy', 'Acabo', 'Debo', 'Quiero'], correctIndex: 1, explanation: 'acabar de + Inf = только что'),
      ],
      exam: [
        ExamQuestion(question: 'Pretérito indefinido от "hacer" (yo):', options: ['hacía', 'hice', 'haré', 'haga'], correctIndex: 1, explanation: 'hacer pretérito: yo hice'),
        ExamQuestion(question: '"Плёвое дело" по-испански:', options: ['Es difícil.', 'Es fácil.', 'Es pan comido.', 'No hay problema.'], correctIndex: 2, explanation: 'ser pan comido = плёвое дело'),
        ExamQuestion(question: 'Gerundio hablar → estar ___ :',  options: ['hablado', 'hablar', 'hablando', 'hable'], correctIndex: 2, explanation: 'estar hablando = быть в процессе разговора'),
        ExamQuestion(question: '"Если бы он учился, он бы сдал" (тип 3):', options: ['Si estudiara, aprobaría.', 'Si hubiera estudiado, habría aprobado.', 'Si ha estudiado, ha aprobado.', 'Si estudia, aprueba.'], correctIndex: 1, explanation: 'Si + PPS → condicional perfecto'),
        ExamQuestion(question: 'RAE = Real Academia ___:', options: ['Española', 'de España', 'Española de España', 'Español'], correctIndex: 0, explanation: 'RAE = Real Academia Española'),
      ],
    ),
  ],
);
