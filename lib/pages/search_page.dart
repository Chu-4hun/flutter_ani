import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/utils/UI/movie_card.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../http.dart';
import '../models/release.dart';
import '../utils/url.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Release>? releases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            title: Container(
              alignment: Alignment.center,
              height: 45,
              child: TextField(
                controller: _searchController,
                onEditingComplete: () async {
                  releases = await makeSearch(_searchController.text);
                  setState(() {});
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  labelText: "Search",
                  hintText: 'Enter a search term',
                ),
              ),
            ),
          ),
        ],
        body: ResponsiveGridList(
          horizontalGridMargin: 10,
          verticalGridMargin: 10,
          minItemWidth: 150,
          maxItemsPerRow: 4,
          children: List.generate(
              releases?.length ?? 0,
              (index) => MovieCard(
                  onTap: () {},
                  img: releases![index].img == null
                      ? Image.asset("res/loading.gif", fit: BoxFit.cover)
                      : Image.network(releases![index].img, fit: BoxFit.cover),
                  title: releases![index].releaseName,
                  rating: releases![index].rating.toString())),
        ),
      ),
    );
  }
}

Future<List<Release>?> makeSearch(String request) async {
  try {
    final response = await dio.get(URL.searchReleases.value + request);
    List<Release> myModels;
    if (response.statusCode == 202) {
      myModels =
          (response.data as List).map((i) => Release.fromJson(i)).toList();
      return myModels;
    }
  } on DioError catch (e) {
    return null;
  }
}
