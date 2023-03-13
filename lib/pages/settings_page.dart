import 'package:flutter/material.dart';
import 'package:flutter_ani/screens/login_screen.dart';
import 'package:flutter_ani/utils/token.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = !isDarkMode;
                });
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
              },
            ),
          ),
          ListTile(
            title: const Text('Language'),
            trailing: DropdownButton(
              value: 'English',
              items: [
                DropdownMenuItem(
                  child: const Text('English'),
                  value: 'English',
                ),
                DropdownMenuItem(
                  child: const Text('Spanish'),
                  value: 'Spanish',
                ),
                DropdownMenuItem(
                  child: const Text('French'),
                  value: 'French',
                ),
              ],
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: const Text('Location'),
            trailing: Switch(
              value: true,
              onChanged: (value) {},
            ),
          ),
          ListTile(
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Theme.of(context).colorScheme.error,
            title: Text(
              "Log Out",
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onTap: () {
              Token(TokenType.access).clearAll();
              Get.off(LoginScreen());
            },
          )
        ],
      ),
    );
  }
}
