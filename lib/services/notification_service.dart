import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tzData;

// ═══════════════════════════════════════════════════════════════
//  NotificationService — локальные push-уведомления
//  Ежедневное напоминание в 19:00 + предупреждение о стрике
// ═══════════════════════════════════════════════════════════════
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  static const _channelId = 'synapse_main';
  static const _channelName = 'SYNAPSE Уведомления';

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

    // Запрашиваем разрешение на Android 13+
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

  // ── Ежедневное напоминание в 19:00 ─────────────────────────
  Future<void> scheduleDailyReminder() async {
    await init();
    await _plugin.cancelAll();

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      19, // 19:00
      0,
    );
    // Если 19:00 уже прошло — ставим на завтра
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      1,
      'SYNAPSE 🧠',
      'Не забудь про урок! Твой стрик ждёт тебя 🔥',
      scheduled,
      _details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // ── Предупреждение о сгорании стрика ───────────────────────
  // Вызывать если пользователь не заходил 23 часа
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
