import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../models/history.dart';
import '../utils/url.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  Future<void> get_history(int id) async {
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
    } on DioError catch (e) {
      emit(HistoryError("No history records available."));
    }
  }
}
