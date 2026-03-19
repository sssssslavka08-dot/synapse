class WordModel {
  final String id;
  final String kz;
  final String ru;
  final String en;
  final String category;
  final String emoji;
  final int difficulty;

  const WordModel({
    required this.id,
    required this.kz,
    required this.ru,
    required this.en,
    required this.category,
    required this.emoji,
    this.difficulty = 1,
  });
}

// База слов — потом будет грузиться из Firestore
final List<WordModel> sampleWords = [
  WordModel(
      id: '1',
      kz: 'Мысық',
      ru: 'Кошка',
      en: 'Cat',
      category: 'animals',
      emoji: '🐱'),
  WordModel(
      id: '2',
      kz: 'Ит',
      ru: 'Собака',
      en: 'Dog',
      category: 'animals',
      emoji: '🐶'),
  WordModel(
      id: '3', kz: 'Үй', ru: 'Дом', en: 'House', category: 'home', emoji: '🏠'),
  WordModel(
      id: '4',
      kz: 'Су',
      ru: 'Вода',
      en: 'Water',
      category: 'nature',
      emoji: '💧'),
  WordModel(
      id: '5',
      kz: 'Нан',
      ru: 'Хлеб',
      en: 'Bread',
      category: 'food',
      emoji: '🍞'),
  WordModel(
      id: '6',
      kz: 'Кітап',
      ru: 'Книга',
      en: 'Book',
      category: 'education',
      emoji: '📚'),
  WordModel(
      id: '7',
      kz: 'Мектеп',
      ru: 'Школа',
      en: 'School',
      category: 'education',
      emoji: '🏫'),
  WordModel(
      id: '8',
      kz: 'Достар',
      ru: 'Друзья',
      en: 'Friends',
      category: 'people',
      emoji: '👫'),
  WordModel(
      id: '9',
      kz: 'Күн',
      ru: 'Солнце',
      en: 'Sun',
      category: 'nature',
      emoji: '☀️'),
  WordModel(
      id: '10',
      kz: 'Түн',
      ru: 'Ночь',
      en: 'Night',
      category: 'nature',
      emoji: '🌙'),
];
