import 'dart:convert';

Review reviewFromJson(String str) => Review.fromJson(json.decode(str));

String reviewToJson(Review data) => json.encode(data.toJson());

class Review {
    int id;
    int userFk;
    String reviewText;
    DateTime revData;
    int rating;
    int releaseFk;
    String login;
    String avatar;

    Review({
        required this.id,
        required this.userFk,
        required this.reviewText,
        required this.revData,
        required this.rating,
        required this.releaseFk,
        required this.login,
        required this.avatar,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userFk: json["user_fk"],
        reviewText: json["review_text"],
        revData: DateTime.parse(json["rev_data"]),
        rating: json["rating"],
        releaseFk: json["release_fk"],
        login: json["login"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_fk": userFk,
        "review_text": reviewText,
        "rev_data": revData.toIso8601String(),
        "rating": rating,
        "release_fk": releaseFk,
        "login": login,
        "avatar": avatar,
    };
}

SimpleReview simpleReviewFromJson(String str) => SimpleReview.fromJson(json.decode(str));

String simpleReviewToJson(SimpleReview data) => json.encode(data.toJson());

class SimpleReview {
    String reviewText;
    int rating;
    int releaseFk;

    SimpleReview({
        required this.reviewText,
        required this.rating,
        required this.releaseFk,
    });

    factory SimpleReview.fromJson(Map<String, dynamic> json) => SimpleReview(
        reviewText: json["review_text"],
        rating: json["rating"],
        releaseFk: json["release_fk"],
    );

    Map<String, dynamic> toJson() => {
        "review_text": reviewText,
        "rating": rating,
        "release_fk": releaseFk,
    };
}
