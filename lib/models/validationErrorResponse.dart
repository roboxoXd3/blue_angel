// To parse this JSON data, do
//
//     final vaidationerrorResoponse = vaidationerrorResoponseFromJson(jsonString);

import 'dart:convert';

VaidationerrorResoponse vaidationerrorResoponseFromJson(String str) =>
    VaidationerrorResoponse.fromJson(json.decode(str));

String vaidationerrorResoponseToJson(VaidationerrorResoponse data) =>
    json.encode(data.toJson());

class VaidationerrorResoponse {
  VaidationerrorResoponse({
    this.status,
    this.errors,
  });

  String status;
  List<Error> errors;

  factory VaidationerrorResoponse.fromJson(Map<String, dynamic> json) =>
      VaidationerrorResoponse(
        status: json["status"],
        errors: List<Error>.from(json["errors"].map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "errors": List<dynamic>.from(errors.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.value,
    this.msg,
    this.param,
    this.location,
  });

  String value;
  String msg;
  String param;
  String location;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        value: json["value"],
        msg: json["msg"],
        param: json["param"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "msg": msg,
        "param": param,
        "location": location,
      };
}
