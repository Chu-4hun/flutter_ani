import 'package:flutter/material.dart';
import 'package:flutter_ani/models/bookmark.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:flutter_ani/pages/profile_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

import '../cubit/bookmark_cubit.dart';
import '../models/user_info.dart';
import '../screens/release_screen.dart';
import '../utils/UI/movie_card.dart';
import '../utils/token.dart';

class BookmarksPage extends StatefulWidget {
  const BookmarksPage({super.key});

  @override
  State<BookmarksPage> createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  final String? accesToken = Token(TokenType.access).read();

  UserInfo? userInfo;
  List<Bookmark> bookmarks = List.empty(growable: true);
  Release? release;

  @override
  void initState() {
    super.initState();
    getUserProfile(accesToken!).then((value) {
      userInfo = value;
      context.read<BookmarkCubit>().getBookmark();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: BlocConsumer<BookmarkCubit, BookmarkState>(
          listener: (context, state) {
            if (state is BookmarkError) {
              Get.snackbar('Ошибка', state.error);
            }
            if (state is BookmarkSucces) {
              bookmarks = state.result.cast<Bookmark>();
            }
            if (state is ReleaseSucces) {
              release = state.result;
              int id = bookmarks
                  .indexWhere((element) => element.releaseFk == release!.id);

              Get.to(ReleaseView(release: release!, herotag: "release_$id"));
            }
          },
          builder: (context, state) {
            return ListView(
              children: [
                ResponsiveGridList(
                    horizontalGridMargin: 10,
                    verticalGridMargin: 10,
                    minItemWidth: 150,
                    maxItemsPerRow: 4,
                    listViewBuilderOptions:
                        ListViewBuilderOptions(shrinkWrap: true),
                    children: List<Widget>.generate(
                      bookmarks.length,
                      (index) => MovieCard(
                        onTap: () {
                          context
                              .read<BookmarkCubit>()
                              .getReleaseById(bookmarks[index].releaseFk);
                        },
                        img: Hero(
                          tag: "release_$index",
                          child: Image.network(
                            bookmarks[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: bookmarks[index].releaseName,
                        rating: bookmarks[index].rating.toString(),
                      ),
                    )),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(r"Дальше пусто ¯\_(ツ)_/¯"),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
