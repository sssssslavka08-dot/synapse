import 'dart:math';

/// Маскоты-роботы с лендинга (без иконки APK и сертификата).
class SplashAssets {
  SplashAssets._();

  static const robots = [
    'assets/images/splash/robot-happy.png',
    'assets/images/splash/robot-thumbsup.png',
    'assets/images/splash/robot-main.png',
    'assets/images/splash/robot-serious.png',
  ];

  static String randomPath() {
    final i = Random().nextInt(robots.length);
    return robots[i];
  }
}
