import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/models/user_info.dart';
import 'package:flutter_ani/pages/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import '../cubit/history_cubit.dart';
import '../http.dart';
import '../models/history.dart';
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
  List<History> history = List.empty();

  @override
  void initState() {
    super.initState();
    getUserProfile(accesToken!).then((value) {
      userInfo = value;
      context.read<HistoryCubit>().get_history(userInfo!.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () {
          Get.to(const SettingsPage());
        },
        child: const Icon(LineIcons.cog),
      ),
      body: BlocConsumer<HistoryCubit, HistoryState>(
        listener: (context, state) {
          if (state is HistoryError) {
            Get.snackbar('Ошибка', state.error);
          }
          if (state is HistorySucces) {
            history = state.result.cast<History>();
          }
        },
        builder: (context, state) {
          return Center(
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
                Text(
                  userInfo?.login ?? "Pedro288",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      decorationStyle: TextDecorationStyle.wavy),
                ),
                Text(
                  userInfo?.status ?? "Pedro288",
                  style: const TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 15,
                      decorationStyle: TextDecorationStyle.wavy),
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
                            child: Text(
                                "Friends: 1000")), //TODO add network friends
                      ),
                    ),
                    Card(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                                "Comments: 99")), //TODO add network friends
                      ),
                    )
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: history.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 3,
                        color: Theme.of(context).colorScheme.background,
                        child: Center(
                            child: Text(formatDate(history[index].dateWatched,
                                [d, ' ', MM, ' ', yyyy],
                                locale: RussianDateLocale()))),
                      );
                    })
              ],
            ),
          );
        },
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
