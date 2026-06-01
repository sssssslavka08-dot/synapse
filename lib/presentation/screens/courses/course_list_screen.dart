import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/courses/all_courses.dart';
import '../../../data/courses/course_structure.dart';
import '../../../services/course_service.dart';
import '../../../services/supabase_service.dart';
import 'course_detail_screen.dart';
import '../subscription/subscription_screen.dart';

class CourseListScreen extends StatefulWidget {
  final bool isKidsMode;
  const CourseListScreen({super.key, this.isKidsMode = false});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  final Map<String, Map<String, ChapterProgress>> _allProgress = {};
  String _subscription = 'free';
  String _selectedLang = '';
  List<String> _proLangs = [];
  String _userName = '';
  int _userAge = 13;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    final profile = await SupabaseService.instance.getProfile();
    _subscription = profile?['subscription_type'] as String? ?? 'free';
    _selectedLang = profile?['selected_language'] as String? ?? '';
    _userName = profile?['name'] as String? ?? '';
    _userAge = profile?['age'] as int? ?? 13;
    final proRaw = profile?['pro_languages'] as String? ?? '';
    _proLangs = proRaw.isEmpty ? [] : proRaw.split(',').where((s) => s.isNotEmpty).toList();

    final unlocked = _unlockedCodes;
    await Future.wait(
      unlocked.map((code) async {
        final p = await CourseService.instance.getCourseProgress(code);
        _allProgress[code] = p;
      }),
    );
    if (mounted) setState(() => _loading = false);
  }

  Set<String> get _unlockedCodes {
    if (_subscription == 'legenda') {
      return allCourses.map((c) => c.langCode).toSet();
    }
    if (_subscription == 'pro') {
      return {_selectedLang, ..._proLangs}.where((s) => s.isNotEmpty).toSet();
    }
    return {if (_selectedLang.isNotEmpty) _selectedLang};
  }

  int _completedChapters(LanguageCourse course) {
    final p = _allProgress[course.langCode] ?? {};
    return p.values.where((v) => v.status == ChapterStatus.completed).length;
  }

  void _onLockedTap(LanguageCourse course) {
    if (_subscription == 'pro' && _proLangs.length < 2) {
      _showProLanguagePicker(course);
    } else {
      _showUpgradeDialog(course);
    }
  }

  void _showProLanguagePicker(LanguageCourse tappedCourse) {
    final availableToAdd = allCourses
        .where((c) => c.langCode != _selectedLang && !_proLangs.contains(c.langCode))
        .toList();
    final slotsLeft = 2 - _proLangs.length;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => _ProLanguagePickerSheet(
        available: availableToAdd,
        slotsLeft: slotsLeft,
        preselected: tappedCourse.langCode,
        onConfirm: (selected) async {
          final newList = [..._proLangs, ...selected];
          await SupabaseService.instance.updateProLanguages(newList);
          setState(() => _proLangs = newList);
        },
      ),
    );
  }

  void _showUpgradeDialog(LanguageCourse course) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [
          Text(course.flag, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              course.langName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _subscription == 'free'
                  ? 'С бесплатным планом доступен только 1 язык.\nОбновись до PRO — выбери 3 языка, до LEGENDA — все 12!'
                  : 'Ты уже выбрал 3 языка для PRO.\nОбновись до LEGENDA — открой все 12 языков!',
              style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Позже',
                style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.tiffany,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SubscriptionScreen(
                            name: _userName,
                            age: _userAge,
                          )));
            },
            child: const Text('Обновить'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isKids = widget.isKidsMode;
    final unlocked = _unlockedCodes;

    return Scaffold(
      backgroundColor:
          isKids ? const Color(0xFFFFF9F0) : AppColors.darkBg,
      body: SafeArea(
        child: Column(
          children: [
            // Шапка
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isKids ? Colors.white : AppColors.darkCard,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isKids
                              ? const Color(0xFFE8E0D8)
                              : AppColors.darkBorder,
                        ),
                      ),
                      child: Icon(Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: isKids
                              ? AppColors.onLightSecondary
                              : AppColors.textSecondary),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isKids ? '🌍 Языки мира!' : '🌍 Курсы языков',
                          style: TextStyle(
                            fontSize: isKids ? 22 : 20,
                            fontWeight: FontWeight.w800,
                            color: isKids
                                ? AppColors.onLight
                                : AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'A1 → B2 · Теория · Тесты · Экзамен',
                          style: TextStyle(
                            fontSize: 12,
                            color: isKids
                                ? const Color(0xFFFF6B35)
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Subscription badge
                  _SubBadge(plan: _subscription),
                ],
              ),
            ),

            // Список языков
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.tiffany))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                      itemCount: allCourses.length,
                      itemBuilder: (_, i) {
                        final course = allCourses[i];
                        final isUnlocked = unlocked.contains(course.langCode);
                        final completed = _completedChapters(course);
                        final total = course.totalChapters;
                        final pct = total > 0 ? completed / total : 0.0;

                        return _CourseCard(
                          course: course,
                          completed: completed,
                          total: total,
                          progress: pct,
                          isKidsMode: isKids,
                          isLocked: !isUnlocked,
                          onTap: isUnlocked
                              ? () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CourseDetailScreen(
                                        course: course,
                                        isKidsMode: isKids,
                                      ),
                                    ),
                                  ).then((_) => _loadAll())
                              : () => _onLockedTap(course),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Subscription badge ──────────────────────────────────────
class _SubBadge extends StatelessWidget {
  final String plan;
  const _SubBadge({required this.plan});

  @override
  Widget build(BuildContext context) {
    if (plan == 'free') return const SizedBox.shrink();
    final isLegenda = plan == 'legenda';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLegenda
              ? [const Color(0xFF9B59B6), const Color(0xFF6C3483)]
              : [AppColors.tiffany, const Color(0xFF0891B2)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isLegenda ? '👑 LEGENDA' : '⚡ PRO',
        style: const TextStyle(
            color: Colors.white, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}

// ─── PRO language picker bottom sheet ───────────────────────
class _ProLanguagePickerSheet extends StatefulWidget {
  final List<LanguageCourse> available;
  final int slotsLeft;
  final String preselected;
  final Future<void> Function(List<String>) onConfirm;

  const _ProLanguagePickerSheet({
    required this.available,
    required this.slotsLeft,
    required this.preselected,
    required this.onConfirm,
  });

  @override
  State<_ProLanguagePickerSheet> createState() =>
      _ProLanguagePickerSheetState();
}

class _ProLanguagePickerSheetState extends State<_ProLanguagePickerSheet> {
  late Set<String> _selected;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _selected = {widget.preselected};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.darkBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Выбери ещё ${widget.slotsLeft} ${widget.slotsLeft == 1 ? "язык" : "языка"} для PRO',
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Эти языки будут доступны тебе в рамках PRO подписки',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.4,
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.available.length,
              itemBuilder: (_, i) {
                final c = widget.available[i];
                final isOn = _selected.contains(c.langCode);
                final canAdd = _selected.length < widget.slotsLeft;
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.tiffany.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                        child: Text(c.flag,
                            style: const TextStyle(fontSize: 22))),
                  ),
                  title: Text(c.langName,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(c.nativeName,
                      style: const TextStyle(fontSize: 12)),
                  trailing: Checkbox(
                    value: isOn,
                    activeColor: AppColors.tiffany,
                    onChanged: (canAdd || isOn)
                        ? (v) {
                            setState(() {
                              if (v == true) {
                                _selected.add(c.langCode);
                              } else {
                                _selected.remove(c.langCode);
                              }
                            });
                          }
                        : null,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.tiffany,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _selected.isEmpty || _saving
                  ? null
                  : () async {
                      setState(() => _saving = true);
                      await widget.onConfirm(_selected.toList());
                      if (context.mounted) Navigator.pop(context);
                    },
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white))
                  : Text(
                      'Добавить ${_selected.length} ${_selected.length == 1 ? "язык" : "языка"} →',
                      style: const TextStyle(fontWeight: FontWeight.w700)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Course card ─────────────────────────────────────────────
class _CourseCard extends StatelessWidget {
  final LanguageCourse course;
  final int completed;
  final int total;
  final double progress;
  final bool isKidsMode;
  final bool isLocked;
  final VoidCallback onTap;

  const _CourseCard({
    required this.course,
    required this.completed,
    required this.total,
    required this.progress,
    required this.isKidsMode,
    required this.isLocked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final started = completed > 0;
    final accent = isKidsMode
        ? const Color(0xFFFF6B35)
        : AppColors.tiffany;

    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isLocked ? 0.65 : 1.0,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.darkCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isLocked
                  ? AppColors.darkBorder
                  : started
                      ? accent.withValues(alpha: 0.4)
                      : AppColors.darkBorder,
              width: started && !isLocked ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              // Флаг
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: isLocked
                      ? AppColors.darkSurface
                      : accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    course.flag,
                    style: TextStyle(fontSize: isLocked ? 24 : 30),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Инфо
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          course.langName,
                          style: TextStyle(
                            fontSize: isKidsMode ? 16 : 15,
                            fontWeight: FontWeight.w700,
                            color: isLocked
                                ? AppColors.textSecondary
                                : AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          course.nativeName,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (isLocked)
                      Row(children: [
                        const Icon(Icons.lock_rounded,
                            size: 12, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        const Text(
                          'Нужна подписка',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ])
                    else
                      Text(
                        started
                            ? '$completed / $total глав пройдено'
                            : '$total глав · A1 → B2',
                        style: TextStyle(
                          fontSize: 12,
                          color: started ? accent : AppColors.textSecondary,
                          fontWeight: started
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    if (started && !isLocked) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor:
                              accent.withValues(alpha: 0.12),
                          valueColor: AlwaysStoppedAnimation(accent),
                          minHeight: 5,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 8),
              Icon(
                isLocked
                    ? Icons.lock_rounded
                    : (completed == total && total > 0
                        ? Icons.emoji_events_rounded
                        : Icons.chevron_right_rounded),
                color: isLocked
                    ? AppColors.darkBorder
                    : (completed == total && total > 0
                        ? const Color(0xFFFFD700)
                        : AppColors.textSecondary),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
