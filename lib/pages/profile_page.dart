import 'package:flutter/material.dart';
import 'package:flutter_ani/pages/settings_page.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        foregroundColor: Get.isDarkMode ? Colors.white : Colors.black,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        onPressed: () {
          Get.to(SettingsPage());
        },
        child:  Icon(LineIcons.cog),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: Get.height / 10,
            ),
            CircleAvatar(
              radius: (Get.height * Get.width) / 5000,
              backgroundImage: const NetworkImage(
                  "https://randomuser.me/api/portraits/lego/6.jpg"),
                   ),
            SizedBox(
              height: Get.height / 50,
            ),
            const Text(
              "Pedro288",
              style: TextStyle(fontSize: 20, decorationStyle: TextDecorationStyle.wavy),
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
