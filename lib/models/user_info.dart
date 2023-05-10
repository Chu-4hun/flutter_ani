// To parse this JSON data, do
//
//     final userInfo = userInfoFromJson(jsonString);

import 'dart:convert';

class UserInfo {
    int id;
    String status;
    String avatar;
    String login;
    DateTime registerDate;

    UserInfo({
        required this.id,
        required this.status,
        required this.avatar,
        required this.login,
        required this.registerDate,
    });

    factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        status: json["status"],
        avatar: json["avatar"],
        login: json["login"],
        registerDate: DateTime.parse(json["register_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "avatar": avatar,
        "login": login,
        "register_date": registerDate.toIso8601String(),
    };
}
