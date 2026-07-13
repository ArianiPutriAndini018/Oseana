import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/services/supabase_service.dart';

import 'core/controllers/audio_controller.dart';
import 'core/routes/app_routes.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await SupabaseService.initialize();
  await AudioController.instance.init();

  runApp(const OseanaApp());
}

class OseanaApp extends StatelessWidget {
  const OseanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Oseana Quest',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      home: SplashScreen(),
    );
  }
}
