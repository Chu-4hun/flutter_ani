import 'package:dio/dio.dart';
import 'package:flutter_ani/screens/login_screen.dart';
import 'package:flutter_ani/utils/token.dart';
import 'package:flutter_ani/utils/url.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final _localStorage =
      GetStorage(); // helper class to access your local storage

  AuthInterceptor(this._dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      // if the request doesn't need token, then just continue to the next interceptor
      options.headers.remove("requiresToken"); //remove the auxiliary header
      return handler.next(options);
    }

    // get tokens from local storage, you can use Hive or flutter_secure_storage
    final accessToken = Token(TokenType.access).read();
    final refreshToken = Token(TokenType.refresh).read();

    if (accessToken == null || refreshToken == null) {
      _performLogout(_dio);

      // create custom dio error
      options.extra["tokenErrorType"] =
          "tokenNotFound"; // I use enum type, you can chage it to string
      final error =
          DioError(requestOptions: options, type: DioErrorType.cancel);
      return handler.reject(error);
    }

    // check if tokens have already expired or not
    // I use jwt_decoder package
    // Note: ensure your tokens has "exp" claim
    final accessTokenHasExpired = JwtDecoder.isExpired(accessToken);
    final refreshTokenHasExpired = JwtDecoder.isExpired(refreshToken);

    var _refreshed = true;

    if (refreshTokenHasExpired) {
      _performLogout(_dio);

      // create custom dio error
      options.extra["tokenErrorType"] = "refreshTokenHasExpired";
      final error =
          DioError(requestOptions: options, type: DioErrorType.cancel);

      return handler.reject(error);
    } else if (accessTokenHasExpired) {
      // regenerate access token
      _refreshed = await _regenerateAccessToken();
    }

    if (_refreshed) {
      // add access token to the request header
      options.headers["Authorization"] = "Bearer $accessToken";
      return handler.next(options);
    } else {
      // create custom dio error
      options.extra["tokenErrorType"] = "failedToRegenerateAccessToken";
      final error =
          DioError(requestOptions: options, type: DioErrorType.cancel);
      return handler.reject(error);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      // for some reasons the token can be invalidated before it is expired by the backend.
      // then we should navigate the user back to login page

      _performLogout(_dio);

      err.requestOptions.extra["tokenErrorType"] = "invalidAccessToken";
    }

    return handler.next(err);
  }

  void _performLogout(Dio dio) {
    _dio.interceptors.clear();

    Token(TokenType.access).clearAll(); // remove token from local storage

    // back to login page without using context
    // check this https://stackoverflow.com/a/53397266/9101876
    Get.to(LoginScreen());

  }

  /// return true if it is successfully regenerate the access token
  Future<bool> _regenerateAccessToken() async {
    try {
      var dio =
          Dio(); // should create new dio instance because the request interceptor is being locked

      // get refresh token from local storage
      final refreshToken = Token(TokenType.refresh).read();

      // make request to server to get the new access token from server using refresh token
      final response = await dio.post(
        URL.accessToken.value,
        options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newAccessToken = response
            .data["accessToken"]; // parse data based on your JSON structure
        Token(TokenType.access).store(newAccessToken); // save to local storage
        return true;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        // it means your refresh token no longer valid now, it may be revoked by the backend
        _performLogout(_dio);
        return false;
      } else {
        print(response.statusCode);
        return false;
      }
    } on DioError {
      return false;
    } catch (e) {
      return false;
    }
  }
}