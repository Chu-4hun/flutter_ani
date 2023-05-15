import 'dart:convert';

Bookmark bookmarkFromJson(String str) => Bookmark.fromJson(json.decode(str));

String bookmarkToJson(Bookmark data) => json.encode(data.toJson());

class Bookmark {
    int id;
    int userFk;
    String bookmarkName;
    int releaseFk;
    String releaseName;
    String img;
    double rating;

    Bookmark({
        required this.id,
        required this.userFk,
        required this.bookmarkName,
        required this.releaseFk,
        required this.releaseName,
        required this.img,
        required this.rating,
    });

    factory Bookmark.fromJson(Map<String, dynamic> json) => Bookmark(
        id: json["id"],
        userFk: json["user_fk"],
        bookmarkName: json["bookmark_name"],
        releaseFk: json["release_fk"],
        releaseName: json["release_name"],
        img: json["img"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_fk": userFk,
        "bookmark_name": bookmarkName,
        "release_fk": releaseFk,
        "release_name": releaseName,
        "img": img,
        "rating": rating,
    };
}
