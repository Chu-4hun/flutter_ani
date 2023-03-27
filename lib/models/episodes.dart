
import 'dart:convert';

class Episode {
    Episode({
        required this.id,
        required this.releaseFk,
        required this.dubFk,
        required this.epName,
        required this.url,
        required this.position,
    });

    int id;
    int releaseFk;
    int dubFk;
    String epName;
    String url;
    int position;

    factory Episode.fromRawJson(String str) => Episode.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Episode.fromJson(Map<String, dynamic> json) => Episode(
        id: json["id"],
        releaseFk: json["release_fk"],
        dubFk: json["dub_fk"],
        epName: json["ep_name"],
        url: json["url"],
        position: json["position"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "release_fk": releaseFk,
        "dub_fk": dubFk,
        "ep_name": epName,
        "url": url,
        "position": position,
    };
}
