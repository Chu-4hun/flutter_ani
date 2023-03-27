import 'dart:convert';

class FriendRequest {
    FriendRequest({
        required this.usr,
        required this.friend,
        required this.requestStatus,
    });

    int usr;
    int friend;
    String requestStatus;

    factory FriendRequest.fromRawJson(String str) => FriendRequest.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory FriendRequest.fromJson(Map<String, dynamic> json) => FriendRequest(
        usr: json["usr"],
        friend: json["friend"],
        requestStatus: json["request_status"],
    );

    Map<String, dynamic> toJson() => {
        "usr": usr,
        "friend": friend,
        "request_status": requestStatus,
    };
}
