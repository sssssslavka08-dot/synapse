import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/courses/course_structure.dart';
import '../../../services/course_service.dart';
import '../../../../main.dart' show appRouteObserver;
import 'theory_screen.dart';
import 'exercise_screen.dart';
import 'exam_screen.dart';
import 'certificate_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final LanguageCourse course;
  final bool isKidsMode;

  const CourseDetailScreen({
    super.key,
    required this.course,
    this.isKidsMode = false,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> with RouteAware {
  Map<String, ChapterProgress> _progress = {};
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appRouteObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    appRouteObserver.unsubscribe(this);
    super.dispose();
  }

  /// Called when a route above this one was popped — reload progress
  @override
  void didPopNext() {
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final p = await CourseService.instance
        .getCourseProgress(widget.course.langCode);
    if (mounted) setState(() { _progress = p; _loading = false; });
  }

  ChapterStatus _getStatus(CourseChapter ch) {
    return _progress[ch.id]?.status ?? ChapterStatus.locked;
  }

  @override
  Widget build(BuildContext context) {
    final isKids = widget.isKidsMode;
    final course = widget.course;

    // Группируем по уровням
    final levelGroups = <LanguageLevel, List<CourseChapter>>{
      LanguageLevel.a1: course.a1Chapters,
      LanguageLevel.a2: course.a2Chapters,
      LanguageLevel.b1: course.b1Chapters,
      LanguageLevel.b2: course.b2Chapters,
    };

    return Scaffold(
      backgroundColor: isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            _buildHeader(context, course, isKids),

            if (_loading)
              const Expanded(child: Center(
                child: CircularProgressIndicator(color: AppColors.tiffany)))
            else
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  children: [
                    // Кнопка сертификата если курс завершён
                    _buildCertificateButton(course, isKids),

                    // По уровням
                    ...levelGroups.entries
                        .where((e) => e.value.isNotEmpty)
                        .map((e) => _buildLevelSection(e.key, e.value, isKids)),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, LanguageCourse course, bool isKids) {
    final completed = _progress.values
        .where((p) => p.status == ChapterStatus.completed)
        .length;
    final total = course.totalChapters;

    // Средний балл по завершённым главам
    final scores = _progress.values
        .where((p) => p.status == ChapterStatus.completed && p.score > 0)
        .map((p) => p.score)
        .toList();
    final avgScore = scores.isEmpty
        ? null
        : (scores.reduce((a, b) => a + b) / scores.length).round();

    final pct = total > 0 ? (completed / total * 100).round() : 0;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      decoration: const BoxDecoration(
        color: AppColors.darkCard,
        border: Border(bottom: BorderSide(color: AppColors.darkBorder)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.darkBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.darkBorder),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 18, color: Color(0xFF4D6766)),
                ),
              ),
              const SizedBox(width: 12),
              Text(course.flag, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      course.langName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '$completed / $total глав • ${course.nativeName}',
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (total > 0) ...[
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: total > 0 ? completed / total : 0,
                backgroundColor: const Color(0xFFE0FAFA),
                valueColor: const AlwaysStoppedAnimation(AppColors.tiffany),
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 10),
            // Статистика
            Row(
              children: [
                _StatChip(
                  icon: '📊',
                  label: '$pct% пройдено',
                  color: AppColors.tiffany,
                ),
                const SizedBox(width: 8),
                if (avgScore != null)
                  _StatChip(
                    icon: '⭐',
                    label: 'Средний балл: $avgScore%',
                    color: const Color(0xFFFFD700),
                  ),
                const SizedBox(width: 8),
                _StatChip(
                  icon: '✅',
                  label: '$completed глав',
                  color: const Color(0xFF4CAF50),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCertificateButton(LanguageCourse course, bool isKids) {
    final allCompleted = course.chapters.isNotEmpty &&
        course.chapters.every((ch) =>
            _progress[ch.id]?.status == ChapterStatus.completed);

    if (!allCompleted) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CertificateScreen(
              course: course,
              isKidsMode: isKids,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFFD700), Color(0xFFFF9800)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('🏆', style: TextStyle(fontSize: 28)),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Курс завершён!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      )),
                  Text('Получить сертификат →',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelSection(
      LanguageLevel level, List<CourseChapter> chapters, bool isKids) {
    final levelColor = Color(level.colorValue);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: levelColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: levelColor.withValues(alpha: 0.3)),
                ),
                child: Text(
                  level.label,
                  style: TextStyle(
                    color: levelColor,
                    fontWeight: FontWeight.w800,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                level.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        ...chapters.map((ch) => _ChapterTile(
              chapter: ch,
              status: _getStatus(ch),
              isKidsMode: isKids,
              onTap: () => _openChapter(ch),
            )),
      ],
    );
  }

  void _openChapter(CourseChapter chapter) {
    final status = _getStatus(chapter);
    if (status == ChapterStatus.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🔒 Сначала пройди предыдущие главы!'),
          backgroundColor: const Color(0xFF64748B),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final progress = _progress[chapter.id];
    final theoryDone = progress?.theoryDone ?? false;
    final exercisesDone = progress?.exercisesDone ?? false;
    final examPassed = progress?.examPassed ?? false;

    if (!theoryDone) {
      _goToTheory(chapter);
    } else if (!exercisesDone) {
      _goToExercises(chapter);
    } else if (!examPassed) {
      _goToExam(chapter);
    } else {
      _goToTheory(chapter);
    }
  }

  void _goToTheory(CourseChapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => TheoryScreen(
          chapter: chapter,
          langCode: widget.course.langCode,
          isKidsMode: widget.isKidsMode,
        ),
      ),
    ).then((_) => _load());
  }

  void _goToExercises(CourseChapter chapter) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseScreen(
          chapter: chapter,
          langCode: widget.course.langCode,
          isKidsMode: widget.isKidsMode,
        ),
      ),
    ).then((_) => _load());
  }

  void _goToExam(CourseChapter chapter) {
    final chapters = widget.course.chapters;
    final idx = chapters.indexWhere((c) => c.id == chapter.id);
    final nextChapterId =
        (idx >= 0 && idx + 1 < chapters.length) ? chapters[idx + 1].id : null;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExamScreen(
          chapter: chapter,
          langCode: widget.course.langCode,
          nextChapterId: nextChapterId,
          isKidsMode: widget.isKidsMode,
        ),
      ),
    ).then((_) => _load());
  }
}

class _ChapterTile extends StatelessWidget {
  final CourseChapter chapter;
  final ChapterStatus status;
  final bool isKidsMode;
  final VoidCallback onTap;

  const _ChapterTile({
    required this.chapter,
    required this.status,
    required this.isKidsMode,
    required this.onTap,
  });

  Color get _statusColor {
    switch (status) {
      case ChapterStatus.completed: return const Color(0xFF4CAF50);
      case ChapterStatus.inProgress: return AppColors.tiffany;
      case ChapterStatus.available: return AppColors.tiffany;
      case ChapterStatus.locked: return const Color(0xFFCBD5E1);
    }
  }

  IconData get _statusIcon {
    switch (status) {
      case ChapterStatus.completed: return Icons.check_circle_rounded;
      case ChapterStatus.inProgress: return Icons.play_circle_rounded;
      case ChapterStatus.available: return Icons.lock_open_rounded;
      case ChapterStatus.locked: return Icons.lock_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locked = status == ChapterStatus.locked;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: locked ? AppColors.darkSurface : AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: locked
                ? AppColors.darkBorder
                : _statusColor.withValues(alpha: 0.3),
            width: status == ChapterStatus.inProgress ? 2 : 1.5,
          ),
          boxShadow: locked
              ? null
              : [
                  BoxShadow(
                    color: _statusColor.withValues(alpha: 0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  )
                ],
        ),
        child: Row(
          children: [
            Text(
              chapter.emoji,
              style: TextStyle(fontSize: locked ? 22 : 26),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter.title,
                    style: TextStyle(
                      fontSize: isKidsMode ? 15 : 14,
                      fontWeight: FontWeight.w700,
                      color: locked
                          ? const Color(0xFFCBD5E1)
                          : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    chapter.subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: locked
                          ? const Color(0xFFCBD5E1)
                          : AppColors.textSecondary,
                    ),
                  ),
                  if (!locked) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _StepDot(
                          done: false,
                          label: 'Теория',
                          color: _statusColor,
                        ),
                        const SizedBox(width: 8),
                        _StepDot(
                          done: false,
                          label: 'Упражнения',
                          color: _statusColor,
                        ),
                        const SizedBox(width: 8),
                        _StepDot(
                          done: false,
                          label: 'Экзамен',
                          color: _statusColor,
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                Icon(_statusIcon, color: _statusColor, size: 22),
                if (!locked) ...[
                  const SizedBox(height: 4),
                  Text(
                    '${chapter.coinsReward}🪙',
                    style: const TextStyle(
                        fontSize: 10, color: AppColors.textSecondary),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String icon;
  final String label;
  final Color color;
  const _StatChip({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: const TextStyle(fontSize: 11)),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool done;
  final String label;
  final Color color;
  const _StepDot({required this.done, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: done ? color : color.withValues(alpha: 0.3),
          ),
        ),
        const SizedBox(width: 3),
        Text(label,
            style: TextStyle(
                fontSize: 9,
                color: done ? color : color.withValues(alpha: 0.5))),
      ],
    );
  }
}
