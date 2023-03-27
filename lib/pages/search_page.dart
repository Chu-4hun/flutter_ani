import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ani/cubit/search_cubit.dart';
import 'package:flutter_ani/utils/UI/movie_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../http.dart';
import '../models/release.dart';
import '../utils/url.dart';


class SearchPage extends StatelessWidget {

 final TextEditingController _searchController = TextEditingController();

  List<Release>? releases;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {
          if (state is SearchError) {
            Get.snackbar('Ошибка', state.error);
          }
          if (state is SearchSucces) {
            releases = state.result.cast<Release>();
          }
        },
        builder: (context, state) {
          return NestedScrollView(
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
                    onEditingComplete: () async {await context
                          .read<SearchCubit>()
                          .search_releases(_searchController.text);
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
                          : Image.network(releases![index].img,
                              fit: BoxFit.cover),
                      title: releases![index].releaseName,
                      rating: releases![index].rating.toString())),
            ),
          );
        },
      ),
    );
  }
}
