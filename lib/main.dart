import 'package:flutter/material.dart';
import 'package:flutter_adaptive_navigation/flutter_adaptive_navigation.dart';
import 'package:flutter_ani/pages/home_page.dart';
import 'package:flutter_ani/pages/profile_page.dart';
import 'package:flutter_ani/pages/search_page.dart';
import 'package:flutter_ani/screens/auth_screen.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO Add custom color selector and save from storage
  SystemTheme.fallbackColor = const Color.fromARGB(255, 50, 134, 82);
  await SystemTheme.accentColor.load();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: SystemTheme.accentColor.accent,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: SystemTheme.accentColor.accent,
      ),
      home: AuthScreen()));
}
