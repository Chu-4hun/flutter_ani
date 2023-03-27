import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_ani/models/episodes.dart';
import 'package:get_storage/get_storage.dart';

import '../models/stream_option.dart';

Future<List<StreamOption>?> getStreamOptions(Episode episode) async {
  List<String> pathSegments = Uri.parse(episode.url).pathSegments;
  var dio = Dio();
  try {
    var formData = FormData.fromMap({
      'type': pathSegments[0],
      'id': pathSegments[1],
      'hash': pathSegments[2]
    });
    final response = await dio.post(
      "https://kodik.cc/gvi",
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

String decodeKodikSrc(String input) {
  input = input.split('').reversed.join();
  if (input.length % 4 > 0) {
    input += '=' * (4 - input.length % 4); // as suggested by Albert221
  }
  return "https:${utf8.decode(base64.decode(input))}";
}
