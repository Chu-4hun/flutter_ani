import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../models/release.dart';
import '../utils/url.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search_releases(String request) async {
    emit(SearchLoading());
    try {
      final response = await dio.get(URL.searchReleases.value + request);
      List<Release> releases;
      if (response.statusCode == 202) {
        releases =
            (response.data as List).map((i) => Release.fromJson(i)).toList();
        emit(SearchSucces<Release>(releases));
      }
    } on DioError catch (e) {
      emit(SearchError("No releases found ( ´･･)ﾉ(._.`)"));
    }
  }

  Future<void> get_popular(int cursor) async {
    emit(SearchLoading());
    try {
      final response =
          await dio.get("${URL.getAllReleases.value}?cursor=$cursor");
      List<Release> releases;
      if (response.statusCode == 202) {
        releases =
            (response.data as List).map((i) => Release.fromJson(i)).toList();
        if (releases.isEmpty) emit(EmptySearch());

        emit(GetPopularSucces<Release>(releases));
      }
    } on DioError catch (e) {
      emit(SearchError("No releases found ( ´･･)ﾉ(._.`)"));
    }
  }
}
