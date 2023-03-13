import 'package:flutter/material.dart';
import 'package:flutter_ani/screens/register_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:system_theme/system_theme.dart';

import 'cubit/auth_cubit.dart';
import 'screens/loading_screen.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();

  SystemTheme.fallbackColor = const Color.fromARGB(255, 50, 134, 82);
  await SystemTheme.accentColor.load();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
    ],
    child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          SystemTheme.fallbackColor = Colors.deepPurple;
          return Directionality(
              textDirection: TextDirection.ltr, child: child!);
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
        home: SplashScreen()),
  ));
}
