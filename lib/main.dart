import 'package:flutter/material.dart';

import 'core/controllers/audio_controller.dart';
import 'core/routes/app_routes.dart';
import 'core/utils/responsive_util.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AudioController.instance.init();

  runApp(const OseanaApp());
}

class OseanaApp extends StatelessWidget {
  const OseanaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            ResponsiveUtil().init(constraints, orientation);
            return const MaterialApp(
              title: 'Oseana Quest',
              debugShowCheckedModeBanner: false,
              onGenerateRoute: AppRoutes.onGenerateRoute,
              home: SplashScreen(),
            );
          },
        );
      },
    );
  }
}
