import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../http.dart';
import '../models/release.dart';
import '../utils/token.dart';
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
                    backgroundColor:
                        Theme.of(context).colorScheme.secondaryContainer,
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
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
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
            body: ListView.builder(
                itemCount: releases?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  // access element from list using index
                  // you can create and return a widget of your choice
                  return ListTile(
                    title: Text('Item ${releases![index].releaseName}'),
                  );
                  ;
                })));
  }
}

Future<List<Release>?> makeSearch(String request) async {
  try {
    final response = await dio.get(URL.searchReleases.value + request);
    List<Release> myModels;
    if (response.statusCode == 202) {
      myModels = (json.decode(response.data.toString()) as List)
          .map((i) => Release.fromJson(i))
          .toList();
      return myModels;
    }
  } on DioError catch (e) {
    return null;
  }
}
