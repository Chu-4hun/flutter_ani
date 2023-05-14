import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../http.dart';
import '../utils/url.dart';

Future<UpdateStatus> updateHistory(int episodeId, String duration) async {
  try {
    final response =
        await dio.put("${URL.addHistory.value}episode_id=$episodeId&duration=$duration");
    if (response.statusCode == 200) {
      return UpdateStatus.succes;
    }
  } on DioError catch (e) {
    Logger()..e(e.message);
    return UpdateStatus.error;
  }
  return UpdateStatus.error;
}

enum UpdateStatus { succes, error }
