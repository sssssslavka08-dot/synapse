import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config/secrets.dart';
import 'core/theme/theme_notifier.dart';
import 'services/notification_service.dart';
import 'presentation/screens/splash_screen.dart';

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
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: appTheme.primary,
            primary: appTheme.primary,
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
