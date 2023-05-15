import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../models/bookmark.dart';
import '../utils/url.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitial());

  Future<void> getBookmark() async {
    emit(BookmarkLoading());
    try {
      final response = await dio.get(URL.getBookmark.value);
      List<Bookmark> history;
      if (response.statusCode == 200) {
        history =
            (response.data as List).map((i) => Bookmark.fromJson(i)).toList();
        if (history.isEmpty) {
          emit(BookmarkError("No bookmark records available"));
        }
        emit(BookmarkSucces<Bookmark>(history));
      }
    } on DioError {
      emit(BookmarkError("No bookmark records available."));
    }
  }

  Future<void> getReleaseById(int id) async {
    emit(BookmarkLoading());
    try {
      final response = await dio.get(URL.getReleaseById.value + id.toString());
      
      if (response.statusCode == 200 || response.statusCode == 202) {
        Release release = Release.fromJson(response.data["release"]);
        emit(ReleaseSucces<Release>(release));
      }
    } on DioError {
      emit(BookmarkError("No releases were found records available."));
    }
  }
}
