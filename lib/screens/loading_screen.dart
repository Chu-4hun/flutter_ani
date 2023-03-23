import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/screens/login_screen.dart';
import 'package:flutter_ani/screens/user_screen.dart';
import 'package:get/get.dart';

import '../http.dart';
import '../utils/auth_interceptor.dart';
import '../utils/token.dart';
import '../utils/url.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Loading",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 40,
            ),
            CircularProgressIndicator(),
          ],
        ),
        // color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}

Future changeScreen() async {
  if (await isAuthenticated()) {
    Get.off(UserScreen());
  } else {
    Get.off(LoginScreen());
  }
}

Future<bool> isAuthenticated() async {
  final token = Token(TokenType.refresh).read();

  if (token == '') return false;

  try {
    final response = await dio.get(URL.accessToken.value,
        options: Options(
            headers: <String, String>{'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200) {
      Token(TokenType.access).store(response.data);
      return true;
    }
  } on DioError catch (e) {
    return false;
  }

  return false;
}
