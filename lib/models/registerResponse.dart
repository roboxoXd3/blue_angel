// To parse this JSON data, do
//
//     final registerResponse = registerResponseFromJson(jsonString);

import 'dart:convert';

RegisterResponse registerResponseFromJson(String str) =>
    RegisterResponse.fromJson(json.decode(str));

String registerResponseToJson(RegisterResponse data) =>
    json.encode(data.toJson());

class RegisterResponse {
  RegisterResponse({
    this.status,
    this.message,
    this.data,
    this.otp,
  });

  String status;
  String message;
  Data data;
  int otp;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      RegisterResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        otp: json["OTP"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
        "OTP": otp,
      };
}

class Data {
  Data({
    this.userType,
    this.active,
    this.otp,
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.fatherName,
    this.address1,
    this.village,
    this.postOffice,
    this.thana,
    this.country,
    this.state,
    this.district,
    this.pincode,
    this.occupation,
    this.identity,
    this.document,
    this.mobile,
    this.createdDate,
    this.v,
  });

  int userType;
  int active;
  int otp;
  String id;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String fatherName;
  String address1;
  String village;
  String postOffice;
  String thana;
  String country;
  String state;
  String district;
  String pincode;
  String occupation;
  String identity;
  String document;
  String mobile;
  DateTime createdDate;
  int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userType: json["user_type"],
        active: json["active"],
        otp: json["otp"],
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        dob: json["dob"],
        fatherName: json["father_name"],
        address1: json["address1"],
        village: json["village"],
        postOffice: json["post_office"],
        thana: json["thana"],
        country: json["country"],
        state: json["state"],
        district: json["district"],
        pincode: json["pincode"],
        occupation: json["occupation"],
        identity: json["identity"],
        document: json["document"],
        mobile: json["mobile"],
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user_type": userType,
        "active": active,
        "otp": otp,
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "dob": dob,
        "father_name": fatherName,
        "address1": address1,
        "village": village,
        "post_office": postOffice,
        "thana": thana,
        "country": country,
        "state": state,
        "district": district,
        "pincode": pincode,
        "occupation": occupation,
        "identity": identity,
        "document": document,
        "mobile": mobile,
        "created_date": createdDate.toIso8601String(),
        "__v": v,
      };
}
