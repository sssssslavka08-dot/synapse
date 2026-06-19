import 'dart:math';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/kids_theme.dart';
import '../../../../core/utils/level_system.dart';
import '../../courses/course_list_screen.dart';
import '../../courses/course_detail_screen.dart';
import '../../lesson/lesson_screen.dart';
import '../../games/survival_screen.dart';
import '../../games/word_builder_screen.dart';
import '../../games/feed_neuron_screen.dart';
import '../../games/neuron_jet_screen.dart';
import '../../../../data/courses/all_courses.dart';
import '../../../../data/courses/course_structure.dart';
import '../../../../services/course_service.dart';
import '../../../../services/user_store.dart';

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
  String _subscription = 'free';
  List<String> _proLangs = [];
  int _xp = 0;
  int _chaptersDone = 0;
  int _chaptersTotal = 32;
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
    UserStore.instance.addListener(_onWalletUpdate);
  }

  void _onWalletUpdate() {
    if (!mounted) return;
    setState(() => _xp = UserStore.instance.xp);
  }

  @override
  void dispose() {
    _pieceCtrl.dispose();
    _floatCtrl.dispose();
    UserStore.instance.removeListener(_onWalletUpdate);
    super.dispose();
  }

  Future<void> _loadProfile() async {
    final uid = Supabase.instance.client.auth.currentUser?.id;
    if (uid == null) { setState(() => _loading = false); return; }
    try {
      final data = await Supabase.instance.client
          .from('users')
          .select('selected_language, xp, subscription_type, pro_languages')
          .eq('id', uid)
          .maybeSingle();
      if (mounted && data != null) {
        final lang = data['selected_language'] as String? ?? 'en';
        final proRaw = data['pro_languages'] as String? ?? '';
        final langCode = lang.isNotEmpty ? lang : 'en';
        final course = getCourseByLang(langCode);
        var done = 0;
        var total = course?.totalChapters ?? 32;
        try {
          final progress =
              await CourseService.instance.getCourseProgress(langCode);
          done = progress.values
              .where(CourseService.instance.isChapterFinished)
              .length;
        } catch (_) {}
        setState(() {
          if (lang.isNotEmpty) _language = lang;
          _xp = (data['xp'] ?? 0) as int;
          _subscription = data['subscription_type'] as String? ?? 'free';
          _proLangs = proRaw.isEmpty ? [] : proRaw.split(',').where((s) => s.isNotEmpty).toList();
          _chaptersDone = done;
          _chaptersTotal = total;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _startLesson() {
    if (_subscription == 'legenda') {
      _showLanguagePicker(allCourses);
    } else if (_subscription == 'pro') {
      final codes = {_language, ..._proLangs}.where((s) => s.isNotEmpty).toSet();
      final courses = allCourses.where((c) => codes.contains(c.langCode)).toList();
      if (courses.length <= 1) {
        _openCourse(_language);
      } else {
        _showLanguagePicker(courses);
      }
    } else {
      _openCourse(_language);
    }
  }

  void _openCourse(String langCode) {
    final course = allCourses.firstWhere(
      (c) => c.langCode == langCode,
      orElse: () => allCourses.first,
    );
    Navigator.push(context, MaterialPageRoute(
      builder: (_) => CourseDetailScreen(
        course: course,
        isKidsMode: widget.isKids,
      ),
    )).then((_) => _loadProfile());
  }

  void _openWordsLesson() {
    if (widget.isKids) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NeuronJetScreen(language: _language),
        ),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LessonScreen(
          isKidsMode: widget.isKids,
          language: _language,
          name: widget.name,
          age: widget.age,
        ),
      ),
    );
  }

  void _openMiniGame() {
    final route = widget.isKids
        ? FeedNeuronScreen(language: _language)
        : (widget.age <= 12
            ? WordBuilderScreen(language: _language)
            : SurvivalScreen(language: _language));
    Navigator.push(context, MaterialPageRoute(builder: (_) => route));
  }

  void _showLanguagePicker(List<LanguageCourse> courses) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        decoration: const BoxDecoration(
          color: AppColors.darkSurface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.darkBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Выбери язык для урока',
              style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: courses.length,
                itemBuilder: (ctx, i) {
                  final c = courses[i];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 44, height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.tiffany.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Text(c.flag, style: const TextStyle(fontSize: 22))),
                    ),
                    title: Text(c.langName,
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    subtitle: Text(c.nativeName,
                      style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                    trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textSecondary),
                    onTap: () {
                      Navigator.pop(ctx);
                      _openCourse(c.langCode);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        backgroundColor: AppColors.darkBg,
        body: Center(child: CircularProgressIndicator(color: AppColors.tiffany)),
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
    // Прогресс по реальному курсу (главы), fallback — модули
    final doneLessons = _chaptersDone > 0
        ? _chaptersDone
        : _modules.fold<int>(0, (s, m) => s + (m['completed'] as int));
    final totalLessons = _chaptersTotal > 0
        ? _chaptersTotal
        : _modules.fold<int>(0, (s, m) => s + (m['lessons'] as int));
    final pieceCellIdx =
        (doneLessons / max(1, totalLessons) * (totalCells - 1)).round();

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
      backgroundColor: AppColors.darkBg,
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (_) => CourseListScreen(isKidsMode: true),
                        )),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: Colors.white38),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('📚', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 6),
                              Text('Курсы',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
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
                        backgroundColor: AppColors.darkCard,
                        valueColor: const AlwaysStoppedAnimation(
                            AppColors.tiffany),
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
                                              ? AppColors.tiffany
                                              : AppColors.textPrimary)),
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(4),
                                    child: LinearProgressIndicator(
                                      value: done / max(1, total),
                                      minHeight: 5,
                                      backgroundColor:
                                          AppColors.darkCard,
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
                                    color: AppColors.textSecondary)),
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
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            // Шапка: приветствие на всю ширину, кнопки ниже (иначе текст сжимается в узкую колонку)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Привет, ${widget.name}!',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(
                          builder: (_) =>
                              CourseListScreen(isKidsMode: false),
                        )),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A3332),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: const Color(0xFF0ABDB9)
                                    .withValues(alpha: 0.3)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('📚', style: TextStyle(fontSize: 16)),
                              SizedBox(width: 6),
                              Text('Курсы',
                                  style: TextStyle(
                                      color: Color(0xFF0ABDB9),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13)),
                            ],
                          ),
                        ),
                      ),
                      _PathActionChip(
                        label: widget.isKids ? 'Истребитель' : 'Слова',
                        icon: widget.isKids
                            ? Icons.rocket_launch_rounded
                            : Icons.menu_book_rounded,
                        onTap: _openWordsLesson,
                      ),
                      _PathActionChip(
                        label: 'Игра',
                        icon: Icons.sports_esports_rounded,
                        filled: true,
                        onTap: _openMiniGame,
                      ),
                      _PathActionChip(
                        label: 'Урок',
                        icon: Icons.play_arrow_rounded,
                        filled: true,
                        onTap: _startLesson,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            _buildNeuronMascot(progress, level, title),
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

  Widget _buildNeuronMascot(double progress, int level, String title) {
    final msgs = [
      'Сегодня отличный день учиться!',
      'Каждый этаж — новая сила!',
      'Нейрончик верит в тебя!',
      'Ещё немного XP — и новый этаж!',
    ];
    final msg = msgs[DateTime.now().day % msgs.length];
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1A3332),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFF0ABDB9).withValues(alpha: 0.25),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Opacity(
                    opacity: 0.18,
                    child: Image.asset(
                      'assets/images/splash/robot-happy.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  ClipRect(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      heightFactor: progress.clamp(0.08, 1.0),
                      child: Image.asset(
                        'assets/images/splash/robot-happy.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Нейрончик · $title',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    msg,
                    style: const TextStyle(
                      color: Color(0xFF8EAEAC),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: const Color(0xFF0D2423),
                      color: const Color(0xFF0ABDB9),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Этаж $level',
                    style: const TextStyle(
                      color: Color(0xFF5A7A78),
                      fontSize: 10,
                    ),
                  ),
                ],
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
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/splash/robot-happy.png',
                      fit: BoxFit.cover,
                    ),
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

class _PathActionChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool filled;

  const _PathActionChip({
    required this.label,
    required this.icon,
    required this.onTap,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: filled ? const Color(0xFF0ABDB9) : const Color(0xFF1A3332),
          borderRadius: BorderRadius.circular(16),
          border: filled
              ? null
              : Border.all(
                  color: const Color(0xFF0ABDB9).withValues(alpha: 0.3)),
          boxShadow: filled
              ? [
                  BoxShadow(
                    color: const Color(0xFF0ABDB9).withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: filled ? Colors.white : const Color(0xFF0ABDB9)),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: filled ? Colors.white : const Color(0xFF0ABDB9),
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
