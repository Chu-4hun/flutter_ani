import 'package:flutter/material.dart';
import 'package:flutter_expandable_text/flutter_expandable_text.dart';
import 'package:get/get.dart';

import '../models/release.dart';

class ReleaseScreen extends StatelessWidget {
  ReleaseScreen({super.key, required this.release});

  final Release release;
  final bool isFullscreen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullscreen
          ? null
          : AppBar(
              title: Text(
                release.releaseName,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
            ),
      body: Column(children: [
        Flexible(
          flex: 4,
          child: Row(
            children: [
              // Title Image

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    children: [
                      //TODO make expadable descriprion
                      ExpandableText(
                        release.description,
                        trimType: TrimType.lines,
                        trim: 3,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium, // trims if text exceeds 20 characters
                      ),
                    ],
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 7 / 9,
                child: Container(
                  width: Get.width / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(release.img),
                      )),
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Row(
            children: [Placeholder()],
          ),
        ),
        Flexible(
          flex: 2,
          child: Placeholder(),
        )
      ]),
    );
  }
}
