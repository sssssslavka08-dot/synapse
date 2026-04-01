import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/utils/level_system.dart';
import '../../lesson/lesson_screen.dart';

class PathTab extends StatefulWidget {
  final String name;
  final bool isKids;
  final int age;
  const PathTab({super.key, required this.name, required this.isKids, this.age = 13});

  @override
  State<PathTab> createState() => _PathTabState();
}

class _PathTabState extends State<PathTab>
    with TickerProviderStateMixin {
  String _language = 'en';
  int _xp = 0;
  bool _loading = true;

  // Анимация шашки (дети)
  late AnimationController _pieceCtrl;
  late Animation<double> _pieceBounce;

  // Анимация парящего здания (взрослые)
  late AnimationController _floatCtrl;
  late Animation<double> _floatAnim;

  static const _modules = [
    {'title': 'Основы',       'emoji': '🌱', 'color': Color(0xFF0ABDB9), 'lessons': 5,  'completed': 3},
    {'title': 'Животные',     'emoji': '🐾', 'color': Color(0xFF9B59B6), 'lessons': 8,  'completed': 1},
    {'title': 'Еда и напитки','emoji': '🍎', 'color': Color(0xFF3498DB), 'lessons': 6,  'completed': 0},
    {'title': 'Числа',        'emoji': '🔢', 'color': Color(0xFFFF6B35), 'lessons': 7,  'completed': 0},
    {'title': 'Семья',        'emoji': '👨‍👩‍👧', 'color': Color(0xFFFFBB33), 'lessons': 5,  'completed': 0},
    {'title': 'Финал',        'emoji': '🏆', 'color': Color(0xFFFFD700), 'lessons': 1,  'completed': 0},
  ];

  @override
  void initState() {
    super.initState();
    _pieceCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 700));
    _pieceBounce = Tween<double>(begin: 0, end: -12).animate(
        CurvedAnimation(parent: _pieceCtrl, curve: Curves.easeInOut));
    _pieceCtrl.repeat(reverse: true);

    _floatCtrl = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2000));
    _floatAnim = Tween<double>(begin: 0, end: 8).animate(
        CurvedAnimation(parent: _floatCtrl, curve: Curves.easeInOut));
    _floatCtrl.repeat(reverse: true);

    _loadProfile();
  }

  @override
  void dispose() {
    _pieceCtrl.dispose();
    _floatCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) { setState(() => _loading = false); return; }
    try {
      final data = await Supabase.instance.client
          .from('users')
          .select('selected_language, xp')
          .eq('id', uid)
          .maybeSingle();
      if (mounted && data != null) {
        final lang = data['selected_language'] as String? ?? 'en';
        setState(() {
          if (lang.isNotEmpty) _language = lang;
          _xp = (data['xp'] ?? 0) as int;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _startLesson() {
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => LessonScreen(
        isKidsMode: widget.isKids,
        language: _language,
        name: widget.name,
        age: widget.age,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: Color(0xFFF4FEFE),
        body: Center(child: CircularProgressIndicator(color: Color(0xFF0ABDB9))),
      );
    }
    return widget.isKids ? _buildKidsBoard() : _buildAdultFloors();
  }

  // ════════════════════════════════════════════════════════════
  //  ДЕТИ — шашечная доска с анимированной фишкой
  // ════════════════════════════════════════════════════════════
  Widget _buildKidsBoard() {
    const cellColors = [Color(0xFF0ABDB9), Color(0xFF3FCFCC)];
    const boardSize = 5; // 5×5
    final totalCells = boardSize * boardSize;
    // Считаем прогресс: сколько модульных уроков завершено
    final doneLessons = _modules.fold<int>(
        0, (s, m) => s + (m['completed'] as int));
    final totalLessons = _modules.fold<int>(
        0, (s, m) => s + (m['lessons'] as int));
    final pieceCellIdx = (doneLessons / max(1, totalLessons) * (totalCells - 1)).round();

    // Маршрут змейки: чётные строки слева→право, нечётные справа→лево
    List<int> snakePath = [];
    for (int row = boardSize - 1; row >= 0; row--) {
      final rowCells = List.generate(boardSize, (c) => row * boardSize + c);
      snakePath.addAll(row % 2 == 0 ? rowCells : rowCells.reversed);
    }

    final kidsEmojis = ['🐶','🐱','🐸','🦊','🐼','🐨','🦁','🐯','🐻','🦄',
                        '🐙','🦋','🐠','🐢','🦕','🦖','🦩','🦚','🦜','🐝',
                        '🌟','⭐','🏆','🎯','🎪'];

    return Scaffold(
      backgroundColor: const Color(0xFFF4FEFE),
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Привет, ${widget.name}! 👋',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 13)),
                        const Text('Путь знаний 🎮',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                        const SizedBox(height: 4),
                        Text('$doneLessons / $totalLessons уроков',
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _startLesson,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('▶️', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 6),
                          Text('Играть!',
                              style: TextStyle(
                                  color: Color(0xFF0ABDB9),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Доска
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Прогресс-бар
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: doneLessons / max(1, totalLessons),
                        minHeight: 10,
                        backgroundColor: const Color(0xFFD6F5F4),
                        valueColor: const AlwaysStoppedAnimation(
                            Color(0xFF0ABDB9)),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Нейрончик — помощник для детей
                    _Neironchik(name: widget.name, xp: _xp),
                    const SizedBox(height: 16),

                    // Сетка 5×5
                    AspectRatio(
                      aspectRatio: 1,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: boardSize,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                        ),
                        itemCount: totalCells,
                        itemBuilder: (_, gridIdx) {
                          final pathIdx = snakePath.indexOf(gridIdx);
                          final isPiece = pathIdx == pieceCellIdx;
                          final isDone = pathIdx < pieceCellIdx;
                          final isNext = pathIdx == pieceCellIdx + 1;
                          final cellEmoji = pathIdx < kidsEmojis.length
                              ? kidsEmojis[pathIdx]
                              : '⭐';
                          final bg = isDone
                              ? cellColors[gridIdx % 2]
                                  .withValues(alpha: 0.9)
                              : cellColors[gridIdx % 2]
                                  .withValues(alpha: 0.25);

                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            decoration: BoxDecoration(
                              color: bg,
                              borderRadius: BorderRadius.circular(12),
                              border: isNext
                                  ? Border.all(
                                      color: const Color(0xFFFFD700),
                                      width: 2.5)
                                  : null,
                              boxShadow: isPiece
                                  ? [
                                      BoxShadow(
                                        color: const Color(0xFF0ABDB9)
                                            .withValues(alpha: 0.5),
                                        blurRadius: 12,
                                        spreadRadius: 2,
                                      )
                                    ]
                                  : null,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Text(isDone || isPiece ? cellEmoji : '❓',
                                    style: TextStyle(
                                        fontSize:
                                            isPiece ? 10 : 18)),
                                if (isPiece)
                                  AnimatedBuilder(
                                    animation: _pieceBounce,
                                    builder: (_, __) => Transform.translate(
                                      offset: Offset(0, _pieceBounce.value),
                                      child: const Text('🎯',
                                          style:
                                              TextStyle(fontSize: 26)),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Легенда модулей
                    ..._modules.asMap().entries.map((e) {
                      final m = e.value;
                      final done = (m['completed'] as int);
                      final total = (m['lessons'] as int);
                      final isComplete = done >= total;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            Text(m['emoji'] as String,
                                style: const TextStyle(fontSize: 20)),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(m['title'] as String,
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: isComplete
                                              ? const Color(0xFF0ABDB9)
                                              : const Color(0xFF0F1F1E))),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: done / max(1, total),
                                      minHeight: 5,
                                      backgroundColor:
                                          const Color(0xFFD6F5F4),
                                      valueColor:
                                          AlwaysStoppedAnimation(
                                              m['color'] as Color),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text('$done/$total',
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF8EAEAC))),
                            if (isComplete)
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text('✅',
                                    style: TextStyle(fontSize: 14)),
                              ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ════════════════════════════════════════════════════════════
  //  ВЗРОСЛЫЕ — здание с этажами, уровень = этаж
  // ════════════════════════════════════════════════════════════
  Widget _buildAdultFloors() {
    final level = LevelSystem.levelFromXp(_xp);
    final progress = LevelSystem.progressInLevel(_xp);
    final xpNext = LevelSystem.xpToNextLevel(_xp);
    final title = LevelSystem.titleForLevel(level);
    final maxLevel = LevelSystem.maxLevel;

    return Scaffold(
      backgroundColor: const Color(0xFF0F1F1E),
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Привет, ${widget.name}!',
                            style: const TextStyle(
                                color: Color(0xFF5A7A78), fontSize: 13)),
                        Text('Ты на этаже $level',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5)),
                        Text(title,
                            style: const TextStyle(
                                color: Color(0xFF0ABDB9),
                                fontSize: 14,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _startLesson,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0ABDB9),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color:
                                const Color(0xFF0ABDB9).withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          )
                        ],
                      ),
                      child: const Text('Урок',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14)),
                    ),
                  ),
                ],
              ),
            ),

            // XP прогресс
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$_xp XP',
                          style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w600)),
                      if (level < maxLevel)
                        Text('ещё $xpNext XP до этажа ${level + 1}',
                            style: const TextStyle(
                                color: Color(0xFF5A7A78), fontSize: 11))
                      else
                        const Text('Максимальный уровень! 🏆',
                            style: TextStyle(
                                color: Color(0xFFFFD700), fontSize: 11)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: const Color(0xFF1A3332),
                      valueColor: const AlwaysStoppedAnimation(
                          Color(0xFF0ABDB9)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Здание
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                reverse: true,
                child: Column(
                  children: [
                    // Основание
                    Container(
                      height: 16,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2A4A48),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    ...List.generate(maxLevel, (i) {
                      final floorNum = i + 1;
                      final isCurrentFloor = floorNum == level;
                      final isCompleted = floorNum < level;
                      final isLocked = floorNum > level;
                      final floorTitle =
                          LevelSystem.titleForLevel(floorNum);
                      final floorEmoji =
                          LevelSystem.emojiForLevel(floorNum);
                      final xpNeeded = LevelSystem.xpForLevel(floorNum);

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        margin: const EdgeInsets.only(bottom: 3),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? const Color(0xFF1A3332)
                                    : isCurrentFloor
                                        ? const Color(0xFF0ABDB9)
                                            .withValues(alpha: 0.15)
                                        : const Color(0xFF122120),
                                border: Border(
                                  left: BorderSide(
                                    color: isCurrentFloor
                                        ? const Color(0xFF0ABDB9)
                                        : isCompleted
                                            ? const Color(0xFF2A4A48)
                                            : const Color(0xFF1A2F2E),
                                    width: isCurrentFloor ? 3 : 1,
                                  ),
                                  top: BorderSide(
                                    color: isCurrentFloor
                                        ? const Color(0xFF0ABDB9)
                                            .withValues(alpha: 0.3)
                                        : Colors.transparent,
                                  ),
                                  bottom: BorderSide(
                                    color: isCurrentFloor
                                        ? const Color(0xFF0ABDB9)
                                            .withValues(alpha: 0.3)
                                        : Colors.transparent,
                                  ),
                                  right: BorderSide(
                                    color: isCurrentFloor
                                        ? const Color(0xFF0ABDB9)
                                            .withValues(alpha: 0.3)
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  // Номер этажа
                                  SizedBox(
                                    width: 28,
                                    child: Text(
                                      '$floorNum',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800,
                                        color: isCurrentFloor
                                            ? const Color(0xFF0ABDB9)
                                            : isCompleted
                                                ? const Color(0xFF5A7A78)
                                                : const Color(0xFF2A4A48),
                                      ),
                                    ),
                                  ),
                                  // Эмодзи
                                  Text(
                                    isLocked ? '🔒' : floorEmoji,
                                    style: TextStyle(
                                        fontSize: isCurrentFloor ? 22 : 18),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Этаж $floorNum · $floorTitle',
                                          style: TextStyle(
                                            fontSize:
                                                isCurrentFloor ? 14 : 13,
                                            fontWeight: isCurrentFloor
                                                ? FontWeight.w800
                                                : FontWeight.w600,
                                            color: isCurrentFloor
                                                ? Colors.white
                                                : isCompleted
                                                    ? const Color(0xFF8EAEAC)
                                                    : const Color(0xFF2A4A48),
                                          ),
                                        ),
                                        Text(
                                          '$xpNeeded XP',
                                          style: TextStyle(
                                            fontSize: 11,
                                            color: isCurrentFloor
                                                ? const Color(0xFF0ABDB9)
                                                : const Color(0xFF3A5A58),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (isCompleted)
                                    const Icon(Icons.check_circle_rounded,
                                        color: Color(0xFF0ABDB9), size: 20),
                                  if (isCurrentFloor)
                                    AnimatedBuilder(
                                      animation: _floatAnim,
                                      builder: (_, __) => Transform.translate(
                                        offset: Offset(0, -_floatAnim.value),
                                        child: const Text('⬆️',
                                            style:
                                                TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
//  Нейрончик — анимированный помощник для детей
// ════════════════════════════════════════════════════════════
class _Neironchik extends StatefulWidget {
  final String name;
  final int xp;
  const _Neironchik({required this.name, required this.xp});

  @override
  State<_Neironchik> createState() => _NeironchikState();
}

class _NeironchikState extends State<_Neironchik>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _bounce;
  int _phraseIdx = 0;

  static const _phrases = [
    'Привет! Я Нейрончик! 🧠\nГотов учиться?',
    'Ты молодец! Продолжай! 💪',
    'Каждый урок делает тебя умнее! ⚡',
    'Сегодня отличный день для учёбы! 🌟',
    'Нажми «Играть» — начнём урок! 🎮',
  ];

  @override
  void initState() {
    super.initState();
    _phraseIdx = widget.xp % _phrases.length;
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _bounce = Tween<double>(begin: 0, end: -8).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    _ctrl.repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _phraseIdx = (_phraseIdx + 1) % _phrases.length),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0ABDB9), Color(0xFF3FCFCC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0ABDB9).withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            AnimatedBuilder(
              animation: _bounce,
              builder: (_, __) => Transform.translate(
                offset: Offset(0, _bounce.value),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('🧠', style: TextStyle(fontSize: 36)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Нейрончик',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    _phrases[_phraseIdx],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.touch_app_rounded,
                color: Colors.white54, size: 18),
          ],
        ),
      ),
    );
  }
}
