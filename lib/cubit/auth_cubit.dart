import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ani/models/user.dart';
import 'package:flutter_ani/utils/token.dart';
import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

import 'package:flutter_ani/http.dart';

import '../utils/url.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final logger = Logger();

  Future<void> login(String login, String password) async {
    emit(AuthLoading());

    var auth = 'Basic ${base64Encode(utf8.encode('$login:$password'))}';

    try {
      final response = await dio.get(URL.login.value,
          options: Options(headers: <String, String>{'authorization': auth}));
      logger.d('${response.statusCode}\n ${response.data}');

      if (response.statusCode == 200) {
        Token(TokenType.refresh).store(response.data);
        emit(AuthSucces());
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        emit(AuthError(e.response?.data));
      } else {
        emit(AuthError('Something went wrong login'));
      }
    }
  }

  Future<void> getAccessToken(String login, String password) async {
    emit(AuthLoading());
    final token = Token(TokenType.refresh).read();

    try {
      final response = await dio.get(URL.accessToken.value,
          options: Options(
              headers: <String, String>{'Authorization': 'Bearer $token'}));
      logger.d('${response.statusCode}\n ${response.data}');

      if (response.statusCode == 200) {
        Token(TokenType.access).store(response.data);
        emit(AuthSucces());
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        emit(AuthError(e.response?.data));
      } else {
        emit(AuthError('Something went wrong access'));
      }
    }
  }

  Future<void> register(User user) async {
    emit(AuthLoading());

    try {
      final response = await dio.post(URL.register.value, data: user.toJson());
      logger.d('${response.statusCode}\n ${response.data}');
      if (response.statusCode == 200) {
        emit(AuthSucces());
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        emit(AuthError(e.response?.data));
      } else {
        emit(AuthError('Something went wrong'));
      }
    }
  }
}
