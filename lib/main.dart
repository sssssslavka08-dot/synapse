import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/secrets.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_notifier.dart';
import 'services/notification_service.dart';
import 'presentation/screens/splash_screen.dart';

/// Global route observer — used by CourseDetailScreen to reload progress on pop
final RouteObserver<ModalRoute<void>> appRouteObserver = RouteObserver<ModalRoute<void>>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await appTheme.load();
  try {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    ).timeout(const Duration(seconds: 10));
  } catch (_) {}
  if (!kIsWeb) {
    try {
      await NotificationService.instance.init();
      await NotificationService.instance.scheduleDailyReminder();
      await NotificationService.instance.scheduleMorningReminder();
      NotificationService.instance.recordActivity();
      NotificationService.instance.checkAndScheduleStreakWarning();
    } catch (_) {}
  }
  runApp(const SynapseApp());
}

class SynapseApp extends StatelessWidget {
  const SynapseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: appTheme,
      builder: (_, __) => MaterialApp(
        title: 'SYNAPSE',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('ru'), Locale('en'), Locale('kk')],
        theme: AppTheme.dark,
        navigatorObservers: [appRouteObserver],
        home: const SplashScreen(),
      ),
    );
  }
}
