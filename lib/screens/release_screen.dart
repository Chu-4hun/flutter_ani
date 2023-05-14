import 'dart:async';

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ani/controllers/video_options_for_episode_controller.dart';
import 'package:flutter_ani/models/dub.dart';
import 'package:flutter_ani/models/episodes.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:flutter_ani/models/stream_option.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_meedu_videoplayer/meedu_player.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';
import 'dart:io' show Platform;

import '../cubit/release_cubit.dart';

class ReleaseView extends StatefulWidget {
  ReleaseView(
      {super.key,
      required this.release,
      this.herotag,
      this.episodeId,
      this.dubId,
      this.duration});

  final Release release;
  final String? herotag;
  int? episodeId;
  int? dubId;
  final double? duration;

  @override
  State<ReleaseView> createState() => _ReleaseViewState();
}

class _ReleaseViewState extends State<ReleaseView> {
  final MeeduPlayerController _meeduPlayerController = MeeduPlayerController(
    enabledButtons: EnabledButtons(rewindAndfastForward: false),
    screenManager:
        const ScreenManager(forceLandScapeInFullscreen: false, orientations: [
      DeviceOrientation.portraitUp,
    ]),
  );

  List<Dub> dubs = List.empty(growable: true);
  List<Episode> episodes = List.empty(growable: true);
  List<StreamOption> streamOptions = List.empty(growable: true);

  StreamOption? selectedStreamOption;
  String streamURL = "";

  bool isFullscreen = false;
  int dubIndex = 0;
  int episodeIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ReleaseCubit>().getDubs(widget.release.id);

    if (!Platform.isLinux) {
      Wakelock.enable();
    }
    bool isFirstOpened = true;
    _meeduPlayerController.onDataStatusChanged.listen((event) {
      if (event == DataStatus.loaded &&
          widget.duration != null &&
          isFirstOpened) {
        int seconds = (widget.duration! * 60).toInt();
        _meeduPlayerController.seekTo(Duration(seconds: seconds));
        isFirstOpened = false;
      }
    });
    _meeduPlayerController.onFullscreenChanged.listen(
      (bool isFullScr) {
        if (isFullScr) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeRight,
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
        setState(() {
          isFullscreen = isFullScr;
        });
      },
    );
  }

  @override
  void dispose() {
    _meeduPlayerController.dispose();
    if (!Platform.isLinux) {
      Wakelock.disable();
    }

    super.dispose();
  }

  Future<void> _setDataSource() async {
    await _meeduPlayerController.setDataSource(
      DataSource(
        type: DataSourceType.network,
        source: streamURL,
      ),
      autoplay: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullscreen
          ? null
          : AppBar(
              title: Text(widget.release.releaseName),
            ),
      body: BlocConsumer<ReleaseCubit, ReleaseState>(
        listener: (context, state) async {
          if (state is ReleaseInfo) {
            dubs = state.dubs;
            if (widget.dubId != null) {
              int selectedIndex =
                  dubs.indexWhere((dub) => dub.id == widget.dubId);
              dubIndex = selectedIndex;
              context
                  .read<ReleaseCubit>()
                  .getEpisodesByDub(widget.release.id, dubs[selectedIndex].id);
            }
            setState(() {});
          }
          if (state is ReleaseError) {
            Get.snackbar('Ошибка', state.error);
          }
          if (state is ReleaseSucces) {
            episodes = state.result.cast<Episode>();
            if (widget.episodeId != null && episodes.isNotEmpty) {
              int selectedEpisodeIndex = episodes
                  .indexWhere((episode) => episode.id == widget.episodeId);
              episodeIndex = selectedEpisodeIndex;
              updateSources(episodes[selectedEpisodeIndex]);

              // context.read<ReleaseCubit>().getEpisodeById(widget.episodeId ?? 0);
            }
          }
        },
        builder: (context, state) {
          return ListView(
            padding: isFullscreen ? null : const EdgeInsets.all(20),
            shrinkWrap: true,
            children: [
              Hero(
                tag: widget.herotag ?? "release",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    widget.release.img,
                    fit: BoxFit.cover,
                    height: Get.height / 3,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ExpandablePanel(
                  header: const Text("Описание"),
                  collapsed: Text(
                    widget.release.description,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: SelectableText(
                    widget.release.description,
                  ),
                  theme: ExpandableThemeData(
                      tapBodyToExpand: true,
                      // tapBodyToCollapse: true,
                      iconColor: Theme.of(context).colorScheme.primary),
                ),
              ),
              Row(
                children: [
                  dubs.length >= 2
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (DropdownButton<String>(
                            isExpanded: false,
                            value: dubIndex.toString(),
                            items: List.generate(
                                dubs.length,
                                (index) => DropdownMenuItem<String>(
                                      value: index.toString(),
                                      child: Text(dubs[index].name),
                                    )),
                            onChanged: (String? val) {
                              dubIndex = int.parse(val ?? "0");
                              widget.dubId = dubs[dubIndex].id;
                              context.read<ReleaseCubit>().getEpisodesByDub(
                                  widget.release.id, dubs[dubIndex].id);
                              setState(() {});
                            },
                          )),
                        )
                      : Text(dubs.isEmpty ? "" : dubs.last.name),
                  episodes.length >= 2
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: (DropdownButton<String>(
                            isExpanded: false,
                            value: episodeIndex.toString(),
                            items: List.generate(
                                episodes.length,
                                (index) => DropdownMenuItem<String>(
                                      value: index.toString(),
                                      child: Text(episodes[index].epName),
                                    )),
                            onChanged: (String? val) async {
                              episodeIndex = int.parse(val ?? "0");
                              widget.episodeId = episodes[episodeIndex].id;
                              await updateSources(episodes[episodeIndex]);
                            },
                          )),
                        )
                      : Text(episodes.isEmpty ? "" : episodes.last.epName),
                ],
              ),
              AspectRatio(
                aspectRatio: 16 / 9,
                child: MeeduVideoPlayer(
                  controller: _meeduPlayerController,
                  bottomRight: (context, controller, responsive) {
                    return ActionChip(
                      label: Text(selectedStreamOption?.name ?? "none"),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> updateSources(Episode episode) async {
    var options = await getStreamOptions(episodes[episodeIndex]);
    streamOptions = options ?? List.empty(growable: true);
    selectedStreamOption = streamOptions[0];
    streamURL = streamOptions[0].src;
    _setDataSource();
    //TODO
    setState(() {});
  }
}
