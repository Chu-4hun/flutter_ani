import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_adaptive_navigation/flutter_adaptive_navigation.dart';
import 'package:flutter_ani/pages/bookmarks_page.dart';
import 'package:line_icons/line_icons.dart';

import '../http.dart';
import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/search_page.dart';
import '../utils/auth_interceptor.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const Text(
      'Likes',
      style: optionStyle,
    ),
    SearchPage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dio.interceptors.addAll([
      AuthInterceptor(dio), // add this line before LogInterceptor
      LogInterceptor(),
    ]);

    return FlutterAdaptiveNavigationScaffold(
      labelDisplayType: LabelDisplayType
          .all, // Optional. Determines which labels to display on Tablets and Mobile screens. Ignored on desktops. Defaults to showing only the selected labels.
      destinations: [
        NavigationElement(
            icon: const Icon(LineIcons.home),
            label: 'Home',
            builder: () => const HomePage()),
        NavigationElement(
          icon: const Icon(LineIcons.book),
          label: 'Bookmarks',
          builder: () => const BookmarksPage()
        ),
        // NavigationElement(
        //     icon: const Icon(LineIcons.search),
        //     label: 'Search',
        //     builder: () => SearchPage()),
        NavigationElement(
            icon: const Icon(LineIcons.user),
            label: 'Profile',
            builder: () => const ProfilePage()),
      ], // Required. The list of destinations for the navigation in the app. Should have atleast 1 element.
    );
  }
}
