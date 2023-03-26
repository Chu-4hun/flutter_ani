import 'dart:convert';

class UserInfo {
    UserInfo({
        required this.id,
        required this.status,
        required this.avatar,
        required this.registerDate,
    });

    int id;
    String status;
    String avatar;
    DateTime registerDate;

    factory UserInfo.fromRawJson(String str) => UserInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: json["id"],
        status: json["status"],
        avatar: json["avatar"],
        registerDate: DateTime.parse(json["register_date"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "avatar": avatar,
        "register_date": registerDate.toIso8601String(),
    };
}
