import 'package:get_storage/get_storage.dart';

enum TokenType {
  refresh,
  access;
}

class Token {
  final TokenType token;
  final _storage = GetStorage();

  Token(this.token);

  void store(String value) {
    switch (token) {
      case TokenType.access:
        _storage.write("access", value);
        break;
      case TokenType.refresh:
        _storage.write("refresh", value);
        break;
    }
  }

  String get() {
    switch (token) {
      case TokenType.access:
        return _storage.read("access");

      case TokenType.refresh:
        return _storage.read("refresh");
    }
  }

}
