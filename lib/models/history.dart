// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
    String releaseName;
    String description;
    String img;
    int episodeId;
    double duration;
    DateTime dateWatched;
    int dubId;
    int position;

    History({
        required this.releaseName,
        required this.description,
        required this.img,
        required this.episodeId,
        required this.duration,
        required this.dateWatched,
        required this.dubId,
        required this.position,
    });

    factory History.fromJson(Map<String, dynamic> json) => History(
        releaseName: json["release_name"],
        description: json["description"],
        img: json["img"],
        episodeId: json["episode_id"],
        duration: json["duration"],
        dateWatched: DateTime.parse(json["date_watched"]),
        dubId: json["dub_id"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "release_name": releaseName,
        "description": description,
        "img": img,
        "episode_id": episodeId,
        "duration": duration,
        "date_watched": dateWatched.toIso8601String(),
        "dub_id": dubId,
        "position": position,
    };
}
