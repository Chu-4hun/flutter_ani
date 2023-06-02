import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../cubit/search_cubit.dart';
import '../models/release.dart';
import '../screens/release_screen.dart';
import '../utils/UI/movie_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();

  List<Release> releases = List.empty();
  List<Widget>? titles;

  int cursor = 0;
  bool _isNeedsToLoadMore = true;

  _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.offset &&
        _searchController.text.isEmpty) {
      if (!_isNeedsToLoadMore) return;
      print("LOAD");
      cursor += 20;
      print("PAGE NUMBER $cursor");
      context.read<SearchCubit>().get_popular(cursor);
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    context.read<SearchCubit>().get_popular(cursor);
  }

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
            _isNeedsToLoadMore = true;
          }
          if (state is GetPopularSucces) {
            releases += state.result.cast<Release>();
            _isNeedsToLoadMore = true;
          }
          if (state is EmptySearch) {
            _isNeedsToLoadMore = false;
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
                    onEditingComplete: () async {
                      if (_searchController.text == "") {
                        cursor = 0;
                        _isNeedsToLoadMore = true;
                      } else {
                        cursor = 0;
                        _isNeedsToLoadMore = false;
                        await context
                            .read<SearchCubit>()
                            .search_releases(_searchController.text);
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      enabledBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                          width: 1.5,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(
                            width: 1.5,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      labelText: "Search",
                      hintText: 'Enter a search term',
                    ),
                  ),
                ),
              ),
            ],
            body: ListView(
              controller: _scrollController,
              children: [
                ResponsiveGridList(
                    horizontalGridMargin: 10,
                    verticalGridMargin: 10,
                    minItemWidth: 150,
                    maxItemsPerRow: 4,
                    listViewBuilderOptions:
                        ListViewBuilderOptions(shrinkWrap: true),
                    children: List<Widget>.generate(
                      releases.length,
                      (index) => MovieCard(
                        onTap: () {
                          Get.to(ReleaseView(
                              release: releases[index],
                              herotag: "release_$index"));
                        },
                        img: Hero(
                          tag: "release_$index",
                          child: Image.network(
                            releases[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: releases[index].releaseName,
                        rating: releases[index].rating.toString(),
                      ),
                    )),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(r"Дальше пусто ¯\_(ツ)_/¯"),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
