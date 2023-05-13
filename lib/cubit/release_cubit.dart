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
      logger.d('${response.statusCode}');
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

  Future<void> getEpisodesByDub(int releaseId, int dubId) async {
    emit(ReleaseLoading());
    try {
      final response = await dio
          .get("${URL.getAllDubOptionsForRelease.value}$releaseId/$dubId");
      logger.d('${response.statusCode}');
      if (response.statusCode == 202) {
        List<Episode> episodes =
            (response.data as List).map((i) => Episode.fromJson(i)).toList();
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

  Future<void> getEpisodeById(int id) async {
    try {
      final response = await dio.get("${URL.geByEpisodeById.value}$id");
      if (response.statusCode == 200) {
        var episode = Episode.fromJson(response.data);
        if (episode == null) {
          emit(ReleaseError("Cannot get episode"));
        }
        emit(ReleaseEpisodeSucces<Episode>(episode));
      }
    } on DioError {
      emit(ReleaseError("Something went wrong."));
    }
  }
}
