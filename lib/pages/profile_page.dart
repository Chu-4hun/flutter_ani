import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/models/user_info.dart';
import 'package:flutter_ani/pages/settings_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

import '../cubit/history_cubit.dart';
import '../http.dart';
import '../models/history.dart';
import '../models/release.dart';
import '../screens/release_screen.dart';
import '../utils/UI/movie_tile.dart';
import '../utils/token.dart';
import '../utils/url.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String? accesToken = Token(TokenType.access).read();

  UserInfo? userInfo;
  List<History> history = List.empty();
  History? selectedHistory;

  @override
  void initState() {
    super.initState();
    getUserProfile(accesToken!).then((value) {
      userInfo = value;
      context.read<HistoryCubit>().getHistory(userInfo!.id);
    });
  }

  Future<void> _pullRefresh() async {
    getUserProfile(accesToken!).then((value) {
      userInfo = value;
      context.read<HistoryCubit>().getHistory(userInfo!.id);
    });
    setState(() {
      
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
          if (state is HistoryReleaseSucces) {
            Release rel = state.result;
            Get.to(ReleaseView(
              episodePosition: selectedHistory?.position,
              dubId: selectedHistory?.dubId,
              duration: selectedHistory?.duration,
              release: rel,
            ));
          }
        },
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height / 30,
                  ),
                  userInfo?.avatar != null
                      ? CircleAvatar(
                          radius: Get.height / 5 / 2,
                          backgroundImage:
                              NetworkImage(userInfo?.avatar ?? ""),
                        )
                      : CircleAvatar(
                          radius: Get.height / 5 / 2,
                          backgroundImage:
                              const AssetImage("res/loading.gif"),
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
                    height: Get.height / 80,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                  "Friends: 1000")), //TODO add network friends
                        ),
                      ),
                      Card(
                        color:
                            Theme.of(context).colorScheme.secondaryContainer,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                              child: Text(
                                  "Comments: 99")), //TODO add network friends
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height / 80,
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "История:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            decorationStyle: TextDecorationStyle.wavy),
                      ),
                    ),
                  ),
                  if (history.isNotEmpty)
                    RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: ListView.builder(
                        clipBehavior: Clip.antiAlias,
                        shrinkWrap: true,
                        itemCount: history.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MovieTileWithPlay(
                              img: history[index].img,
                              title: history[index].releaseName,
                              description: history[index].description,
                              episode: history[index].position,
                              duration: history[index].duration,
                              height: Get.height / 4,
                              onClick: () {
                                selectedHistory = history[index];
                                context
                                    .read<HistoryCubit>()
                                    .getReleaseByEpisodeId(
                                        history[index].episodeId);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  SizedBox(
                    height: Get.height / 10,
                  )
                ],
              ),
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
  } on DioError {
    return null;
  }
  return null;
}
