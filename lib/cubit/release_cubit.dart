import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ani/models/dub.dart';
import 'package:flutter_ani/models/episodes.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../utils/url.dart';

part 'release_state.dart';

class ReleaseCubit extends Cubit<ReleaseState> {
  ReleaseCubit() : super(ReleaseInitial());

  final logger = Logger();

  Future<void> getDubs(int id) async {
    emit(ReleaseLoading());
    try {
      final response =
          await dio.get(URL.getAllDubOptionsForRelease.value + id.toString());
      logger.d('${response.statusCode}\n ${response.data}');
      if (response.statusCode == 202) {
        List<Dub> dubs = (response.data["dubs"] as List)
            .map((i) => Dub.fromJson(i))
            .toList();
        emit(ReleaseInfo(dubs));
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        emit(ReleaseError(e.response?.data));
      } else {
        emit(ReleaseError('Something went wrong'));
      }
    }
  }

  Future<void> getEpisodesByDub(int release_id, int dub_id) async {
    emit(ReleaseLoading());
    try {
      final response = await dio.get("${URL.getAllDubOptionsForRelease.value}$release_id/$dub_id");
      logger.d('${response.statusCode}\n ${response.data}');
      if (response.statusCode == 200) {
        List<Episode> episodes = (response.data as List)
            .map((i) => Episode.fromJson(i))
            .toList();
        emit(ReleaseSucces<Episode>(episodes));
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        emit(ReleaseError(e.response?.data));
      } else {
        emit(ReleaseError('Something went wrong'));
      }
    }
  }
}
