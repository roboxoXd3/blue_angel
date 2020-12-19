// To parse this JSON data, do
//
//     final resetPasswordtResponse = resetPasswordtResponseFromJson(jsonString);

import 'dart:convert';

ResetPasswordtResponse resetPasswordtResponseFromJson(String str) =>
    ResetPasswordtResponse.fromJson(json.decode(str));

String resetPasswordtResponseToJson(ResetPasswordtResponse data) =>
    json.encode(data.toJson());

class ResetPasswordtResponse {
  ResetPasswordtResponse({
    this.status,
    this.message,
  });

  String status;
  String message;

  factory ResetPasswordtResponse.fromJson(Map<String, dynamic> json) =>
      ResetPasswordtResponse(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
