import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:honduras_weather/presentation/splash/view/splash_view.dart';
import '/core/binders/dependency_injection.dart';
import '/core/local_storage/local_storage.dart';
import 'core/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final storage = LocalStorage();
  final isDark = await storage.getBool('isDarkMode');
  runApp(
    HondurasWeather(
      themeMode: isDark == true
          ? ThemeMode.dark
          : isDark == false
          ? ThemeMode.light
          : ThemeMode.system,
    ),
  );
}

class HondurasWeather extends StatelessWidget {
  final ThemeMode themeMode;
  const HondurasWeather({super.key, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Honduras Weather',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const SplashView(),
    );
  }
}
