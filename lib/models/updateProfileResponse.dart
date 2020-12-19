// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) =>
    json.encode(data.toJson());

// class UpdateProfileResponse {
//   UpdateProfileResponse({
//     this.status,
//     this.message,
//     this.data,
//     this.token,
//   });

//   String status;
//   String message;
//   Data data;
//   String token;

//   factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
//       UpdateProfileResponse(
//         status: json["status"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//         token: json["token"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "message": message,
//         "data": data.toJson(),
//         "token": token,
//       };
// }

// class Data {
//   Data({
//     this.userType,
//     this.active,
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.gender,
//     this.dob,
//     this.fatherName,
//     this.address1,
//     this.village,
//     this.postOffice,
//     this.thana,
//     this.country,
//     this.state,
//     this.district,
//     this.pincode,
//     this.occupation,
//     this.identity,
//     this.document,
//     this.mobile,
//     this.createdDate,
//     this.profileImage,
//   });

//   int userType;
//   int active;
//   String id;
//   String firstName;
//   String lastName;
//   String gender;
//   String dob;
//   String fatherName;
//   String address1;
//   String village;
//   String postOffice;
//   String thana;
//   dynamic country;
//   String state;
//   String district;
//   String pincode;
//   String occupation;
//   String identity;
//   String document;
//   String mobile;
//   DateTime createdDate;
//   String profileImage;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         userType: json["user_type"],
//         active: json["active"],
//         id: json["_id"],
//         firstName: json["first_name"],
//         lastName: json["last_name"],
//         gender: json["gender"],
//         dob: json["dob"],
//         fatherName: json["father_name"],
//         address1: json["address1"],
//         village: json["village"],
//         postOffice: json["post_office"],
//         thana: json["thana"],
//         country: json["country"],
//         state: json["state"],
//         district: json["district"],
//         pincode: json["pincode"],
//         occupation: json["occupation"],
//         identity: json["identity"],
//         document: json["document"],
//         mobile: json["mobile"],
//         createdDate: DateTime.parse(json["created_date"]),
//         profileImage: json["profile_image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_type": userType,
//         "active": active,
//         "_id": id,
//         "first_name": firstName,
//         "last_name": lastName,
//         "gender": gender,
//         "dob": dob,
//         "father_name": fatherName,
//         "address1": address1,
//         "village": village,
//         "post_office": postOffice,
//         "thana": thana,
//         "country": country,
//         "state": state,
//         "district": district,
//         "pincode": pincode,
//         "occupation": occupation,
//         "identity": identity,
//         "document": document,
//         "mobile": mobile,
//         "created_date": createdDate.toIso8601String(),
//         "profile_image": profileImage,
//       };
// }
class UpdateProfileResponse {
  String status;
  String message;
  Data data;
  String token;

  UpdateProfileResponse({this.status, this.message, this.data, this.token});

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int userType;
  int active;
  String sId;
  String firstName;
  String lastName;
  String gender;
  String dob;
  String fatherName;
  String address1;
  String village;
  String postOffice;
  String thana;
  Null country;
  String state;
  String district;
  String pincode;
  String occupation;
  String identity;
  String document;
  String mobile;
  String createdDate;
  String profileImage;

  Data(
      {this.userType,
      this.active,
      this.sId,
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
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    active = json['active'];
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    gender = json['gender'];
    dob = json['dob'];
    fatherName = json['father_name'];
    address1 = json['address1'];
    village = json['village'];
    postOffice = json['post_office'];
    thana = json['thana'];
    country = json['country'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    occupation = json['occupation'];
    identity = json['identity'];
    document = json['document'];
    mobile = json['mobile'];
    createdDate = json['created_date'];
    profileImage = json['profile_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['father_name'] = this.fatherName;
    data['address1'] = this.address1;
    data['village'] = this.village;
    data['post_office'] = this.postOffice;
    data['thana'] = this.thana;
    data['country'] = this.country;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['occupation'] = this.occupation;
    data['identity'] = this.identity;
    data['document'] = this.document;
    data['mobile'] = this.mobile;
    data['created_date'] = this.createdDate;
    data['profile_image'] = this.profileImage;
    return data;
  }
}
