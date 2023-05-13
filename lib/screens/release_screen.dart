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
  ReleaseView({super.key, required this.release, this.herotag, this.episodeId,this.dubId});

  final Release release;
  final String? herotag;
  int? episodeId = 0;
  int? dubId = 0;

  @override
  State<ReleaseView> createState() => _ReleaseViewState();
}

class _ReleaseViewState extends State<ReleaseView> {
  final MeeduPlayerController _meeduPlayerController = MeeduPlayerController(
    enabledButtons: EnabledButtons(rewindAndfastForward: false),
    // controlsStyle: ControlsStyle(),
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

  @override
  void initState() {
    super.initState();
    context.read<ReleaseCubit>().getDubs(widget.release.id);
    if (widget.episodeId != null) {
      context.read<ReleaseCubit>().getEpisodeById(widget.episodeId ?? 0);
    }
    if (!Platform.isLinux) {
      Wakelock.enable();
    }
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
            setState(() {});
          }
          if (state is ReleaseError) {
            Get.snackbar('Ошибка', state.error);
          }
          if (state is ReleaseSucces) {
            episodes = state.result.cast<Episode>();
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
              Wrap(
                spacing: 10,
                runSpacing: 10,
                direction: Axis.horizontal,
                children: List.generate(
                  dubs.length,
                  ((index) => ChoiceChip(
                        onSelected: (bool isSelected) {
                          widget.dubId = dubs[index].id;
                          context.read<ReleaseCubit>().getEpisodesByDub(
                              widget.release.id, dubs[index].id);
                        },
                        label: Text(dubs[index].name),
                        selected: dubs[index].id == widget.dubId,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                direction: Axis.horizontal,
                children: List.generate(
                  episodes.length,
                  ((index) => ChoiceChip(
                        pressElevation: 5,
                        selectedShadowColor:
                            Theme.of(context).colorScheme.primary,
                        onSelected: (bool isSelected) async {
                          widget.episodeId = episodes[index].id;
                          var options = await getStreamOptions(episodes[index]);
                          streamOptions = options ?? List.empty(growable: true);
                          selectedStreamOption = streamOptions[0];
                          streamURL = streamOptions[0].src;
                          _setDataSource();
                          //TODO
                          setState(() {});
                        },
                        label: Text(episodes[index].epName),
                        selected: episodes[index].id == widget.episodeId,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  height: 1,
                  color: Theme.of(context).colorScheme.secondary,
                ),
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
}
