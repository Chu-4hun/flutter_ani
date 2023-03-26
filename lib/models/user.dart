import 'dart:convert';

class User {
    User({
        required this.login,
        required this.password,
        required this.email,
    });

    String login;
    String password;
    String email;

    factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory User.fromJson(Map<String, dynamic> json) => User(
        login: json["login"],
        password: json["password"],
        email: json["email"],
    );

    Map<String, dynamic> toJson() => {
        "login": login,
        "password": password,
        "email": email,
    };
}
