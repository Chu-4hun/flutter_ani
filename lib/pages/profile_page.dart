import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/models/user_info.dart';
import 'package:flutter_ani/pages/settings_page.dart';
import 'package:flutter_ani/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import '../http.dart';
import '../utils/token.dart';
import '../utils/url.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String? accesToken = Token(TokenType.access).read();

  UserInfo? userInfo;

  @override
  void initState() {
    super.initState();
    getUserProfile(accesToken!).then((value) {
      userInfo = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () {
          Get.to(SettingsPage());
        },
        child: Icon(LineIcons.cog),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 10,
            ),
            userInfo?.avatar != null
                ? CircleAvatar(
                    radius: Get.height / 5 / 2,
                    backgroundImage: NetworkImage(userInfo?.avatar ?? ""),
                  )
                : CircleAvatar(
                    radius: Get.height / 5 / 2,
                    backgroundImage: AssetImage("res/loading.gif"),
                  ),
            SizedBox(
              height: Get.height / 50,
            ),
            const Text(
              "Pedro288",
              style: TextStyle(
                  fontSize: 20, decorationStyle: TextDecorationStyle.wavy),
            ),
            SizedBox(
              height: Get.height / 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child:
                            Text("Friends: 1000")), //TODO add network friends
                  ),
                ),
                Card(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text("Comments: 99")), //TODO add network friends
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

Future<UserInfo?> getUserProfile(String token) async {
  int id = JwtDecoder.decode(token)["id"];
  try {
    final response = await dio.get(URL.profile.value + id.toString(),
        options: Options(
            headers: <String, String>{'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200 || response.statusCode == 202) {
      return UserInfo.fromJson(response.data);
    }
  } on DioError catch (e) {
    return null;
  }
  return null;
}
