// To parse this JSON data, do
//
//     final districtListResponse = districtListResponseFromJson(jsonString);

import 'dart:convert';

DistrictListResponse districtListResponseFromJson(String str) =>
    DistrictListResponse.fromJson(json.decode(str));

String districtListResponseToJson(DistrictListResponse data) =>
    json.encode(data.toJson());

class DistrictListResponse {
  DistrictListResponse({
    this.status,
    this.message,
    this.data,
  });

  String status;
  String message;
  List<Datum> data;

  factory DistrictListResponse.fromJson(Map<String, dynamic> json) =>
      DistrictListResponse(
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
    this.state,
    this.name,
    this.pincode,
    this.createdDate,
    this.v,
    this.stateName,
  });

  int active;
  String id;
  String state;
  String name;
  String pincode;
  DateTime createdDate;
  int v;
  String stateName;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        active: json["active"],
        id: json["_id"],
        state: json["state"],
        name: json["name"],
        pincode: json["pincode"],
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
        stateName: json["state_name"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "_id": id,
        "state": state,
        "name": name,
        "pincode": pincode,
        "created_date": createdDate.toIso8601String(),
        "__v": v,
        "state_name": stateName,
      };
}
