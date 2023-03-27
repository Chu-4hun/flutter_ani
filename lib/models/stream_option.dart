import 'dart:convert';

class StreamOption {
  StreamOption({
    required this.src,
    required this.type,
    this.name,
  });

  String src;
  String type;
  String? name;

  factory StreamOption.fromRawJson(String str) =>
      StreamOption.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StreamOption.fromJson(Map<String, dynamic> json) => StreamOption(
        src: json["src"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "src": src,
        "type": type,
      };
}
