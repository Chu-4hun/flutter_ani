import 'package:flutter/material.dart';
import 'package:flutter_ani/screens/auth_screen.dart';
import 'package:flutter_ani/screens/user_screen.dart';
import 'package:get/get.dart';
import 'package:system_theme/system_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO Add custom color selector and save from storage
  SystemTheme.fallbackColor = const Color.fromARGB(255, 50, 134, 82);
  await SystemTheme.accentColor.load();

  runApp(GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        SystemTheme.fallbackColor = Colors.deepPurple;
        return Directionality(textDirection: TextDirection.ltr, child: child!);
      },
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: SystemTheme.accentColor.accent,
        // colorSchemeSeed: Colors.blue,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        // colorSchemeSeed: Colors.green,
        colorSchemeSeed: SystemTheme.accentColor.accent,
      ),
      home: AuthScreen()));
}
