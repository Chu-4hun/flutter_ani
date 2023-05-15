import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../http.dart';
import '../utils/url.dart';

Future<UpdateStatus> addBookmark(int release_id, String name) async {
  try {
    final response =
        await dio.post("${URL.addBookmark.value}release_id=$release_id&name=$name");
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
