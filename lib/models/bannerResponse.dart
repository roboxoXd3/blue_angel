// To parse this JSON data, do
//
//     final bannerResponse = bannerResponseFromJson(jsonString);

import 'dart:convert';

BannerResponse bannerResponseFromJson(String str) =>
    BannerResponse.fromJson(json.decode(str));

String bannerResponseToJson(BannerResponse data) => json.encode(data.toJson());

class BannerResponse {
  BannerResponse({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory BannerResponse.fromJson(Map<String, dynamic> json) => BannerResponse(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.dashboardImage,
    this.contactEmail,
    this.contactNumber,
  });

  String dashboardImage;
  String contactEmail;
  String contactNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dashboardImage: json["dashboard_image"],
        contactEmail: json["contact_email"],
        contactNumber: json["contact_number"],
      );

  Map<String, dynamic> toJson() => {
        "dashboard_image": dashboardImage,
        "contact_email": contactEmail,
        "contact_number": contactNumber,
      };
}
