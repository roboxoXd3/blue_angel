// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.status,
    this.otp,
    this.message,
  });

  String status;
  int otp;
  String message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        status: json["status"],
        otp: json["OTP"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "OTP": otp,
        "message": message,
      };
}
