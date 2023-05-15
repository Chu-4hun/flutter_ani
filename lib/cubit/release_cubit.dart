import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ani/models/dub.dart';
import 'package:flutter_ani/models/episodes.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import '../http.dart';
import '../models/review.dart';
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

  Future<void> getReviewsByRelease(int id, int? page) async {
    page ?? 0;
    try {
      final response =
          await dio.get("${URL.getReviewsWithPagination.value}$id/$page");
      if (response.statusCode == 200) {
        var reviews =
            (response.data as List).map((i) => Review.fromJson(i)).toList();
        emit(ReviewSucces<Review>(reviews));
      }
    } on DioError catch (e) {
      emit(ReleaseError("No reviews records available.$e"));
    }
  }

  Future<void> sendReview(SimpleReview review) async {
    try {
      final response =
          await dio.put(URL.sendReview.value, data: review.toJson());
      if (response.statusCode == 200) {
        emit(ReviewSucces<Review>([]));
      }
    } on DioError catch (e) {
      emit(ReleaseError("Cant send review. $e , ${e.response?.statusCode}"));
    }
  }
}
