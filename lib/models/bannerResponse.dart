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
    this.dashboard_image2,
    this.contactEmail,
    this.contactNumber,
    this.side_nav,
    this.top_nav,
  });

  String dashboardImage;
  String dashboard_image2;
  String contactEmail;
  String contactNumber;
  String top_nav;
  String side_nav;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        dashboardImage: json["dashboard_image"],
    dashboard_image2:json["dashboard_image2"],
        contactEmail: json["contact_email"],
        contactNumber: json["contact_number"],
        top_nav: json['top_nav'],
        side_nav: json['side_nav'],
      );

  Map<String, dynamic> toJson() => {
        "dashboard_image": dashboardImage,
    "dashboard_image2":dashboard_image2,
        "contact_email": contactEmail,
        "contact_number": contactNumber,
        "top_nav": top_nav,
        "side_nav": side_nav,
      };
}
