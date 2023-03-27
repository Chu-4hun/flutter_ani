import 'package:flutter/material.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:get/get.dart';

class ReleaseView extends StatelessWidget {
  const ReleaseView({super.key, required this.release, this.herotag});

  final Release release;
  final String? herotag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(release.releaseName),
      ),
      body: Center(
        child: Container(
          height: Get.height / 4,
          child: Stack(textDirection: TextDirection.ltr, children: [
            Hero(
              tag: herotag ?? "release",
              child: Image.network(release.img, fit: BoxFit.cover),
            ),
            Text(release.releaseName),
          ]),
        ),
      ),
    );
  }
}
