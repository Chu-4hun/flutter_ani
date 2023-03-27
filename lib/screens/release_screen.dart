import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/models/dub.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../cubit/release_cubit.dart';

class ReleaseView extends StatefulWidget {
  ReleaseView({super.key, required this.release, this.herotag});

  final Release release;
  final String? herotag;

  @override
  State<ReleaseView> createState() => _ReleaseViewState();
}

class _ReleaseViewState extends State<ReleaseView> {
  List<Dub> dubs = List.empty();

  @override
  void initState() {
    context.read<ReleaseCubit>().getDubs(widget.release.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            Get.snackbar('ура', state.result.toString());
            // Get.off(() => UserScreen());
          }
        },
        builder: (context, state) {
          return ListView(
            padding: EdgeInsets.all(20),
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
                  header: Text("Описание"),
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
                  ((index) => ActionChip(
                      onPressed: () {}, label: Text(dubs[index].name))),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
