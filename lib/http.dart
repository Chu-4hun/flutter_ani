import 'package:dio/dio.dart';

import 'utils/url.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: Duration(seconds: 3),
    baseUrl: BASE_URL,
  ),
);