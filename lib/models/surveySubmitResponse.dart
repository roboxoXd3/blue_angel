// To parse this JSON data, do
//
//     final surveySubmitResponse = surveySubmitResponseFromJson(jsonString);

import 'dart:convert';

SurveySubmitResponse surveySubmitResponseFromJson(String str) =>
    SurveySubmitResponse.fromJson(json.decode(str));

String surveySubmitResponseToJson(SurveySubmitResponse data) =>
    json.encode(data.toJson());

class SurveySubmitResponse {
  SurveySubmitResponse({
    this.status,
    this.token,
    this.message,
  });

  String status;
  String token;
  String message;

  factory SurveySubmitResponse.fromJson(Map<String, dynamic> json) =>
      SurveySubmitResponse(
        status: json["status"],
        token: json["token"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "message": message,
      };
}
