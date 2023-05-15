import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ani/models/release.dart';
import 'package:flutter_ani/models/review.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../models/history.dart';
import '../utils/url.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> getHistory(int id) async {
    emit(HistoryLoading());
    try {
      final response = await dio.get("${URL.getHistoryById.value}$id");
      List<History> history;
      if (response.statusCode == 200) {
        history =
            (response.data as List).map((i) => History.fromJson(i)).toList();
        if (history.isEmpty) {
          emit(HistoryError("No history records available"));
        }
        emit(HistorySucces<History>(history));
      }
    } on DioError {
      emit(HistoryError("No history records available."));
    }
  }

  Future<void> getReleaseByEpisodeId(int id) async {
    try {
      final response = await dio.get("${URL.getReleaseByEpisodeId.value}$id");
      if (response.statusCode == 200) {
        var release = Release.fromJson(response.data);
        if (release == null) {
          emit(HistoryError("Cannot restore release"));
        }
        emit(HistoryReleaseSucces<Release>(release));
      }
    } on DioError catch (e) {
      emit(HistoryError("No history records available.$e"));
    }
  }

  
}
