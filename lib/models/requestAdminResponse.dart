// To parse this JSON data, do
//
//     final requestAdminResponse = requestAdminResponseFromJson(jsonString);

import 'dart:convert';

RequestAdminResponse requestAdminResponseFromJson(String str) =>
    RequestAdminResponse.fromJson(json.decode(str));

String requestAdminResponseToJson(RequestAdminResponse data) =>
    json.encode(data.toJson());

class RequestAdminResponse {
  RequestAdminResponse({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory RequestAdminResponse.fromJson(Map<String, dynamic> json) =>
      RequestAdminResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
