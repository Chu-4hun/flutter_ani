import 'dart:convert';

class Dub {
    Dub({
        required this.id,
        required this.name,
    });

    int id;
    String name;

    factory Dub.fromRawJson(String str) => Dub.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Dub.fromJson(Map<String, dynamic> json) => Dub(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
