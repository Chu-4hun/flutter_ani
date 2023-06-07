import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ani/models/episodes.dart';

import '../models/stream_option.dart';
import '../utils/url.dart';

Future<List<StreamOption>?> getStreamOptions(Episode episode) async {
  List<String> pathSegments = Uri.parse(episode.url).pathSegments;
  var dio = Dio();
  try {
    var formData = FormData.fromMap({
      'type': pathSegments[0],
      'id': pathSegments[1],
      'hash': pathSegments[2]
    });
    var url = "${HOST_URL}kodik/gvi";
    final response = await dio.post(
      url,
      data: formData,
    );
    if (response.statusCode == 202 || response.statusCode == 200) {
      List<StreamOption> streams = List.empty(growable: true);
      for (var key in response.data["links"].keys) {
        for (var res in response.data["links"].values) {
          var stream = StreamOption.fromJson(res[0]);
          stream.name = key.toString();
          streams.add(stream);
        }
      }

      for (var stream in streams) {
        stream.src = decodeKodikSrc(stream.src);
      }
      return streams;
    }
  } on DioError catch (e) {
    if (e.response?.statusCode == 400) {
      print("error");
    } else {
      return null;
    }
  }
  return null;
}

String decodeKodikSrc(String str) {
  final zCharCode = 'Z'.codeUnitAt(0);

  String modifiedStr = utf8.decode(base64.decode(
      base64.normalize(str.replaceAllMapped(RegExp(r'[a-zA-Z]'), (match) {
    int eCharCode = match.group(0)!.codeUnitAt(0);
    int newCharCode =
        (eCharCode <= zCharCode ? 90 : 122) >= (eCharCode = eCharCode + 13)
            ? eCharCode
            : eCharCode - 26;

    return String.fromCharCode(newCharCode);
  }))));

  return "https:$modifiedStr";
}
