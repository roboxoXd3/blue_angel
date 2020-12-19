// To parse this JSON data, do
//
//     final aboutUsResponse = aboutUsResponseFromJson(jsonString);

import 'dart:convert';

AboutUsResponse aboutUsResponseFromJson(String str) =>
    AboutUsResponse.fromJson(json.decode(str));

String aboutUsResponseToJson(AboutUsResponse data) =>
    json.encode(data.toJson());

class AboutUsResponse {
  AboutUsResponse({
    this.status,
    this.image,
    this.content,
  });

  String status;
  String image;
  String content;

  factory AboutUsResponse.fromJson(Map<String, dynamic> json) =>
      AboutUsResponse(
        status: json["status"],
        image: json["image"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "image": image,
        "content": content,
      };
}
