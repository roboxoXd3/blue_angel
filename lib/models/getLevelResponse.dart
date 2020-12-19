// To parse this JSON data, do
//
//     final getLevelResponse = getLevelResponseFromJson(jsonString);

import 'dart:convert';

GetLevelResponse getLevelResponseFromJson(String str) =>
    GetLevelResponse.fromJson(json.decode(str));

String getLevelResponseToJson(GetLevelResponse data) =>
    json.encode(data.toJson());

class GetLevelResponse {
  GetLevelResponse({
    this.status,
    this.token,
    this.result,
  });

  String status;
  String token;
  List<Result> result;

  factory GetLevelResponse.fromJson(Map<String, dynamic> json) =>
      GetLevelResponse(
        status: json["status"],
        token: json["token"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.number,
    this.content,
    this.v,
  });

  String id;
  String name;
  String number;
  String content;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        number: json["number"],
        content: json["content"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "number": number,
        "content": content,
        "__v": v,
      };
}
