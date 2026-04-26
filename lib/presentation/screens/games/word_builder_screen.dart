import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../services/words_service.dart';
import '../../../services/supabase_service.dart';
import '../../../services/daily_tasks_service.dart';
import '../../widgets/task_completed_overlay.dart';

// ═══════════════════════════════════════════════════════════════
//  WordBuilderScreen — Детская игра: собери слово из букв
//  Показывается перевод → нужно нажать буквы в правильном порядке
// ═══════════════════════════════════════════════════════════════
class WordBuilderScreen extends StatefulWidget {
  final String language;
  const WordBuilderScreen({super.key, this.language = 'en'});

  @override
  State<WordBuilderScreen> createState() => _WordBuilderScreenState();
}

class _WordBuilderScreenState extends State<WordBuilderScreen>
    with TickerProviderStateMixin {
  List<LessonWord> _words = [];
  bool _loading = true;
  int _index = 0;
  int _score = 0;
  int _xp = 0;

  // Текущее слово
  List<_LetterTile> _tiles = [];
  List<String?> _answer = []; // null = пустое место
  bool _checking = false;
  bool _correct = false;
  String _feedback = '';

  late AnimationController _successCtrl;
  late AnimationController _shakeCtrl;
  late Animation<double> _shakeAnim;
  late FlutterTts _tts;

  static const _ttsLocales = {
    'en': 'en-US',
    'kz': 'kk-KZ',
    'ru': 'ru-RU',
    'de': 'de-DE',
    'fr': 'fr-FR',
    'zh': 'zh-CN',
  };

  @override
  void initState() {
    super.initState();
    _successCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _shakeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _shakeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeCtrl, curve: Curves.elasticIn),
    );
    _initTts();
    _loadWords();
  }

  Future<void> _initTts() async {
    _tts = FlutterTts();
    await _tts.setLanguage(_ttsLocales[widget.language] ?? 'en-US');
    await _tts.setSpeechRate(0.4);
  }

  Future<void> _loadWords() async {
    final words = await WordsService.instance.getWordsForLesson(
      language: widget.language,
      count: 8,
    );
    // Фильтруем: только слова до 10 букв без пробелов
    final filtered =
        words.where((w) => w.word.length <= 10 && !w.word.contains(' ')).toList();

    if (filtered.isEmpty) {
      setState(() => _loading = false);
      return;
    }
    setState(() {
      _words = filtered;
      _loading = false;
    });
    _setupWord(filtered[0]);
  }

  void _setupWord(LessonWord word) {
    final letters = word.word.toUpperCase().split('');
    // Добавляем 2-3 лишних буквы для сложности
    final extra = _extraLetters(letters);
    final allTiles = [...letters, ...extra]
        .asMap()
        .entries
        .map((e) => _LetterTile(id: e.key, letter: e.value))
        .toList()
      ..shuffle();

    setState(() {
      _tiles = allTiles;
      _answer = List.filled(letters.length, null);
      _checking = false;
      _correct = false;
      _feedback = '';
    });
  }

  List<String> _extraLetters(List<String> original) {
    const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final used = original.toSet();
    final extra = alphabet.split('').where((l) => !used.contains(l)).toList()
      ..shuffle();
    final count = original.length <= 4 ? 2 : 3;
    return extra.take(count).toList();
  }

  // Нажатие на букву из пула
  void _pickLetter(_LetterTile tile) {
    if (tile.used || _checking) return;
    final emptyIdx = _answer.indexWhere((a) => a == null);
    if (emptyIdx == -1) return;

    setState(() {
      _tiles.firstWhere((t) => t.id == tile.id).used = true;
      _answer[emptyIdx] = tile.letter;
    });
    _checkIfComplete();
  }

  // Нажатие на заполненную ячейку → возвращаем букву в пул
  void _removeLetter(int idx) {
    if (_checking) return;
    final letter = _answer[idx];
    if (letter == null) return;

    // Находим нужную плитку (первую с такой же буквой и used=true)
    final tile = _tiles.firstWhere(
      (t) => t.letter == letter && t.used,
      orElse: () => _LetterTile(id: -1, letter: ''),
    );

    setState(() {
      if (tile.id != -1) tile.used = false;
      _answer[idx] = null;
    });
  }

  void _checkIfComplete() {
    if (_answer.contains(null)) return;
    // Все ячейки заполнены
    final built = _answer.join();
    final target = _words[_index].word.toUpperCase();

    setState(() => _checking = true);

    if (built == target) {
      _correct = true;
      _feedback = '🎉 Правильно!';
      _score++;
      _xp += 20;
      _successCtrl.forward(from: 0);
      _tts.speak(_words[_index].word);
      SupabaseService.instance.reviewWord(
          wordId: _words[_index].id, quality: 5);
    } else {
      _correct = false;
      _feedback = '❌ Попробуй ещё';
      _shakeCtrl.forward(from: 0).then((_) => _shakeCtrl.reverse());
      SupabaseService.instance.reviewWord(
          wordId: _words[_index].id, quality: 1);
      // Через 1 сек сбрасываем
      Future.delayed(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        _setupWord(_words[_index]);
      });
      return;
    }

    // Следующее слово через 1.5 сек
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      if (_index < _words.length - 1) {
        setState(() => _index++);
        _setupWord(_words[_index]);
      } else {
        _showResult();
      }
    });
  }

  void _showResult() async {
    final completedPlay = await DailyTasksService.updateProgress(
      taskType: 'play_game',
      count: 1,
    );
    List<Map<String, dynamic>> completedAnswers = [];
    if (_score > 0) {
      completedAnswers = await DailyTasksService.updateProgress(
        taskType: 'correct_answers',
        count: _score,
      );
    }
    if (!mounted) return;
    final all = [...completedPlay, ...completedAnswers];
    if (all.isNotEmpty) {
      TaskCompletedOverlay.showAll(context, all);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('🏆', style: TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              const Text('Молодец!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F1F1E))),
              const SizedBox(height: 8),
              Text('Слов собрано: $_score / ${_words.length}',
                  style: const TextStyle(
                      color: Color(0xFF4D6766), fontSize: 15)),
              Text('+$_xp XP ⚡',
                  style: const TextStyle(
                      color: Color(0xFF0ABDB9),
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0ABDB9),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('На главную',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _successCtrl.dispose();
    _shakeCtrl.dispose();
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF0ABDB9)))
            : _words.isEmpty
                ? Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('😕',
                        style: TextStyle(fontSize: 48)),
                    const SizedBox(height: 12),
                    const Text('Нет подходящих слов',
                        style: TextStyle(color: Color(0xFF8EAEAC))),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0ABDB9),
                          foregroundColor: Colors.white),
                      child: const Text('Назад'),
                    ),
                  ]))
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ── Шапка ──────────────────────────
                        Row(children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: const Color(0xFFD6F5F4)),
                              ),
                              child: const Icon(Icons.close,
                                  size: 20, color: Color(0xFF4D6766)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (_index + 1) / _words.length,
                                backgroundColor: const Color(0xFFD6F5F4),
                                valueColor: const AlwaysStoppedAnimation(
                                    Color(0xFF0ABDB9)),
                                minHeight: 8,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text('⚡ $_xp',
                              style: const TextStyle(
                                color: Color(0xFF0ABDB9),
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              )),
                        ]),

                        const SizedBox(height: 28),

                        // ── Эмодзи и подсказка ─────────────
                        Text(_words[_index].emoji,
                            style: const TextStyle(fontSize: 64)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                                color: const Color(0xFFD6F5F4)),
                          ),
                          child: Text(
                            _words[_index].translation,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0F1F1E),
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          '${_index + 1} / ${_words.length}',
                          style: const TextStyle(
                              color: Color(0xFF8EAEAC), fontSize: 13),
                        ),

                        const SizedBox(height: 24),

                        // ── Ячейки ответа ───────────────────
                        AnimatedBuilder(
                          animation: _shakeCtrl,
                          builder: (_, child) {
                            final offset = _shakeAnim.value *
                                10 *
                                (0.5 - _shakeAnim.value).sign;
                            return Transform.translate(
                              offset: Offset(offset, 0),
                              child: child,
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              _answer.length,
                              (i) {
                                final letter = _answer[i];
                                Color borderColor = _checking && _correct
                                    ? const Color(0xFF22C55E)
                                    : _checking && !_correct
                                        ? const Color(0xFFEF4444)
                                        : const Color(0xFF0ABDB9);

                                return GestureDetector(
                                  onTap: () => _removeLetter(i),
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    width: 42,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: letter != null
                                          ? const Color(0xFF0ABDB9)
                                              .withValues(alpha: 0.1)
                                          : Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      border: Border.all(
                                        color: letter != null
                                            ? borderColor
                                            : const Color(0xFFD6F5F4),
                                        width: 2,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        letter ?? '',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800,
                                          color: borderColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // Фидбек
                        const SizedBox(height: 12),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: _feedback.isNotEmpty
                              ? Text(
                                  _feedback,
                                  key: ValueKey(_feedback),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: _correct
                                        ? const Color(0xFF22C55E)
                                        : const Color(0xFFEF4444),
                                  ),
                                )
                              : const SizedBox(height: 20),
                        ),

                        const SizedBox(height: 24),

                        // ── Пул букв ────────────────────────
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          alignment: WrapAlignment.center,
                          children: _tiles.map((tile) {
                            return GestureDetector(
                              onTap: () => _pickLetter(tile),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 46,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: tile.used
                                      ? const Color(0xFFF0F0F0)
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(12),
                                  border: Border.all(
                                    color: tile.used
                                        ? const Color(0xFFE0E0E0)
                                        : const Color(0xFF0ABDB9),
                                    width: 1.5,
                                  ),
                                  boxShadow: tile.used
                                      ? null
                                      : [
                                          BoxShadow(
                                            color: const Color(0xFF0ABDB9)
                                                .withValues(alpha: 0.15),
                                            blurRadius: 6,
                                            offset: const Offset(0, 3),
                                          )
                                        ],
                                ),
                                child: Center(
                                  child: Text(
                                    tile.letter,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: tile.used
                                          ? const Color(0xFFCCCCCC)
                                          : const Color(0xFF0F1F1E),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const Spacer(),

                        // ── Кнопка сброса ───────────────────
                        TextButton.icon(
                          onPressed: () => _setupWord(_words[_index]),
                          icon: const Icon(Icons.refresh_rounded,
                              color: Color(0xFF8EAEAC), size: 18),
                          label: const Text('Сбросить',
                              style: TextStyle(
                                  color: Color(0xFF8EAEAC), fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}

class _LetterTile {
  final int id;
  final String letter;
  bool used;
  _LetterTile({required this.id, required this.letter}) : used = false;
}
