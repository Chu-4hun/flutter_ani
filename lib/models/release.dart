
import 'dart:convert';

class Release {
    Release({
        required this.id,
        required this.releaseType,
        required this.releaseName,
         this.releaseDate,
        required this.rating,
        required this.minAge,
        required this.director,
        required this.author,
        required this.studio,
        required this.description,
        required this.img,
        required this.externalId,
    });

    int id;
    String releaseType;
    String releaseName;
    String? releaseDate;
    double rating;
    int minAge;
    String director;
    String author;
    String studio;
    String description;
    String img;
    String externalId;

    factory Release.fromRawJson(String str) => Release.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Release.fromJson(Map<String, dynamic> json) => Release(
        id: json["id"],
        releaseType: json["release_type"],
        releaseName: json["release_name"],
        releaseDate: json["release_date"],
        rating: json["rating"],
        minAge: json["min_age"],
        director: json["director"],
        author: json["author"],
        studio: json["studio"],
        description: json["description"],
        img: json["img"],
        externalId: json["external_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "release_type": releaseType,
        "release_name": releaseName,
        "release_date": releaseDate,
        "rating": rating,
        "min_age": minAge,
        "director": director,
        "author": author,
        "studio": studio,
        "description": description,
        "img": img,
        "external_id": externalId,
    };
}
