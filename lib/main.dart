import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ani/cubit/search_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meedu_videoplayer/init_meedu_player.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:system_theme/system_theme.dart';

import 'cubit/auth_cubit.dart';
import 'cubit/history_cubit.dart';
import 'cubit/release_cubit.dart';
import 'screens/loading_screen.dart';


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() async {
  await GetStorage.init();
  initMeeduPlayer();
 HttpOverrides.global =  new MyHttpOverrides();
  SystemTheme.fallbackColor = const Color.fromARGB(255, 50, 134, 82);
  await SystemTheme.accentColor.load();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => AuthCubit(),
      ),
      BlocProvider(
        create: (context) => SearchCubit(),
      ),
      BlocProvider(
        create: (context) => ReleaseCubit(),
      ),
      BlocProvider(
        create: (context) => HistoryCubit(),
      ),
    ],
    child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: SystemTheme.accentColor.accent,
          // colorSchemeSeed: Colors.red,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          // colorSchemeSeed: Colors.red,
          colorSchemeSeed: SystemTheme.accentColor.accent,
        ),
        home: const SplashScreen()),
  ));
}
