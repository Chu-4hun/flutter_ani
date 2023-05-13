import 'package:dio/dio.dart';

import 'utils/url.dart';

final dio = Dio(
  BaseOptions(
    connectTimeout: const Duration(seconds: 3),
    baseUrl: BASE_URL,
  ),
);
