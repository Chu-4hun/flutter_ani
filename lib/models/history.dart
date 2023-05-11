import 'dart:convert';

class History {
    String releaseName;
    String description;
    String img;
    int episode;
    double duration;
    DateTime dateWatched;

    History({
        required this.releaseName,
        required this.description,
        required this.img,
        required this.episode,
        required this.duration,
        required this.dateWatched,
    });

    factory History.fromRawJson(String str) => History.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory History.fromJson(Map<String, dynamic> json) => History(
        releaseName: json["release_name"],
        description: json["description"],
        img: json["img"],
        episode: json["episode"],
        duration: json["duration"],
        dateWatched: DateTime.parse(json["date_watched"]),
    );

    Map<String, dynamic> toJson() => {
        "release_name": releaseName,
        "description": description,
        "img": img,
        "episode": episode,
        "duration": duration,
        "date_watched": dateWatched.toIso8601String(),
    };
}
