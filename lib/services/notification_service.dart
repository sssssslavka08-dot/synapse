import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzData;

// ═══════════════════════════════════════════════════════════════
//  NotificationService — локальные push-уведомления
//  Ежедневное напоминание + стрик-предупреждение + отслеживание активности
// ═══════════════════════════════════════════════════════════════
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'synapse_main';
  static const _channelName = 'SYNAPSE Уведомления';
  static const _keyLastActivity = 'last_activity_ts';

  // ── Инициализация ──────────────────────────────────────────
  Future<void> init() async {
    if (_initialized) return;

    tzData.initializeTimeZones();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    _initialized = true;
  }

  // ── Канал уведомлений ──────────────────────────────────────
  NotificationDetails get _details => const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

  // ── Записать активность пользователя ─────────────────────
  Future<void> recordActivity() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(
          _keyLastActivity, DateTime.now().millisecondsSinceEpoch);
    } catch (_) {}
  }

  // ── Проверить стрик и запланировать предупреждение ────────
  Future<void> checkAndScheduleStreakWarning() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastTs = prefs.getInt(_keyLastActivity);
      if (lastTs == null) return;

      final lastActivity =
          DateTime.fromMillisecondsSinceEpoch(lastTs);
      final now = DateTime.now();
      final hoursSince =
          now.difference(lastActivity).inHours;

      // Если не заходил 20+ часов — предупреждение через 1 час
      if (hoursSince >= 20 && hoursSince < 24) {
        await scheduleStreakWarning();
      }
    } catch (_) {}
  }

  // ── Ежедневное напоминание в 19:00 ─────────────────────────
  Future<void> scheduleDailyReminder() async {
    await init();

    final messages = [
      'Не забудь про урок! Твой стрик ждёт тебя 🔥',
      'Один урок в день — и ты станешь полиглотом 🧠',
      'Твои слова скучают. Зайди на 5 минут! ⚡',
      'Сегодня отличный день учить новое! 📚',
    ];
    final msg = messages[DateTime.now().weekday % messages.length];

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, 19, 0,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      1,
      'SYNAPSE 🧠',
      msg,
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ── Дополнительное утреннее напоминание в 09:00 ───────────
  Future<void> scheduleMorningReminder() async {
    await init();

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local, now.year, now.month, now.day, 9, 0,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      3,
      'Доброе утро! ☀️',
      'Начни день с урока — 5 минут языка заряжают мозг!',
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ── Предупреждение о сгорании стрика ───────────────────────
  Future<void> scheduleStreakWarning() async {
    await init();
    final scheduled =
        tz.TZDateTime.now(tz.local).add(const Duration(hours: 1));

    await _plugin.zonedSchedule(
      2,
      'Стрик сгорает! 🔥',
      'Твоя серия сгорит через час. Зайди на 1 минуту! ⚡',
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // ── Уведомление о разблокировке новой главы ───────────────
  Future<void> notifyChapterUnlocked(String chapterTitle) async {
    if (kIsWeb) return;
    await init();
    await _plugin.show(
      4,
      '🔓 Новая глава открыта!',
      'Глава "$chapterTitle" теперь доступна',
      _details,
    );
  }

  // ── Уведомление о завершении курса ────────────────────────
  Future<void> notifyCourseCompleted(String langName) async {
    if (kIsWeb) return;
    await init();
    await _plugin.show(
      5,
      '🏆 Курс завершён!',
      'Ты прошёл курс $langName! Получи сертификат 🎓',
      _details,
    );
  }

  // ── Немедленное уведомление (тест) ─────────────────────────
  Future<void> showNow({
    required String title,
    required String body,
  }) async {
    await init();
    await _plugin.show(0, title, body, _details);
  }

  // ── Отменить все ───────────────────────────────────────────
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
