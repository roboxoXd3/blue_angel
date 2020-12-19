// To parse this JSON data, do
//
//     final stateListResponse = stateListResponseFromJson(jsonString);

import 'dart:convert';

StateListResponse stateListResponseFromJson(String str) =>
    StateListResponse.fromJson(json.decode(str));

String stateListResponseToJson(StateListResponse data) =>
    json.encode(data.toJson());

class StateListResponse {
  StateListResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory StateListResponse.fromJson(Map<String, dynamic> json) =>
      StateListResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.active,
    this.id,
    this.name,
    this.createdDate,
    this.v,
  });

  int active;
  String id;
  String name;
  DateTime createdDate;
  int v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        active: json["active"],
        id: json["_id"],
        name: json["name"],
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "_id": id,
        "name": name,
        "created_date": createdDate.toIso8601String(),
        "__v": v,
      };
}
