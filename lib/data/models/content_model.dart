import 'dart:convert';

Content contentFromJson(String str) => Content.fromJson(json.decode(str));

String contentToJson(Content data) => json.encode(data.toJson());

class Content {
  Content({
    required this.id,
    required this.module,
    required this.contentLink,
    required this.name,
  });

  String id;
  String module;
  String contentLink;
  String name;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        module: json["module"],
        contentLink: json["contentLink"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "module": module,
        "contentLink": contentLink,
        "name": name,
      };
}
