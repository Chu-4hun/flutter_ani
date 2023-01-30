import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appinio Video Player Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings();

  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
      CustomVideoPlayerWebSettings(
    src: longVideo,
  );

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      longVideo,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(video240);
    _videoPlayerController3 = VideoPlayerController.network(video480);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "240p": _videoPlayerController2,
        "480p": _videoPlayerController3,
        "720p": _videoPlayerController,
      },
    );

    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            kIsWeb
                ? Expanded(
                    child: CustomVideoPlayer(
                      customVideoPlayerController: _customVideoPlayerController,
                    ),
                  )
                : CustomVideoPlayer(
                    customVideoPlayerController: _customVideoPlayerController,
                  ),
            // CupertinoButton(
            //   child: const Text("Play Fullscreen"),
            //   onPressed: () {
            //     if (kIsWeb) {
            //       _customVideoPlayerWebController.setFullscreen(true);
            //       _customVideoPlayerWebController.play();
            //     } else {
            //       _customVideoPlayerController.setFullscreen(true);
            //       _customVideoPlayerController.videoPlayerController.play();
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

String videoUrlLandscape =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
String videoUrlPortrait =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
String longVideo =
    "https://cloud.kodik-storage.com/useruploads/51d1e776-db30-4384-8db4-bf9ec74477dd/ec4533b01ee7c276af38235cbf71755a:2023013100/360.mp4:hls:manifest.m3u8";

String video720 =
    "https://baator.cloud.kodik-storage.com/useruploads/51d1e776-db30-4384-8db4-bf9ec74477dd/ec4533b01ee7c276af38235cbf71755a:2023013100/480.mp4:hls:manifest.m3u8";

String video480 =
    "https://cloud.kodik-storage.com/useruploads/51d1e776-db30-4384-8db4-bf9ec74477dd/ec4533b01ee7c276af38235cbf71755a:2023013100/360.mp4:hls:manifest.m3u8";

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";
