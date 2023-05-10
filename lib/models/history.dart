import 'dart:convert';

class History {
    int id;
    int userFk;
    int episode;
    DateTime dateWatched;
    double duration;

    History({
        required this.id,
        required this.userFk,
        required this.episode,
        required this.dateWatched,
        required this.duration,
    });

    factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userFk: json["user_fk"],
        episode: json["episode"],
        dateWatched: DateTime.parse(json["date_watched"]),
        duration: json["duration"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_fk": userFk,
        "episode": episode,
        "date_watched": dateWatched.toIso8601String(),
        "duration": duration,
    };
}
