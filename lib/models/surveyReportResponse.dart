// To parse this JSON data, do
//
//     final surveyReportResponse = surveyReportResponseFromJson(jsonString);

import 'dart:convert';

SurveyReportResponse surveyReportResponseFromJson(String str) =>
    SurveyReportResponse.fromJson(json.decode(str));

String surveyReportResponseToJson(SurveyReportResponse data) =>
    json.encode(data.toJson());

class SurveyReportResponse {
  SurveyReportResponse({
    this.status,
    this.imageBaseUrl,
    this.result,
    this.token,
  });

  String status;
  String imageBaseUrl;
  List<Result> result;
  String token;

  factory SurveyReportResponse.fromJson(Map<String, dynamic> json) =>
      SurveyReportResponse(
        status: json["status"],
        imageBaseUrl: json["image_base_url"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "image_base_url": imageBaseUrl,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "token": token,
      };
}

class Result {
  Result({
    this.id,
    this.lat,
    this.lng,
    this.image,
    this.product,
    this.qty,
    this.survey,
    this.surveyName,
    this.bluAngel,
    this.bluAngelMobile,
    this.customer,
    this.customerData,
    this.formData,
    this.createdDate,
    this.v,
  });

  String id;
  String lat;
  String lng;
  String image;
  String product;
  String qty;
  String survey;
  String surveyName;
  String bluAngel;
  String bluAngelMobile;
  String customer;
  CustomerData customerData;
  Map<String, dynamic> formData;
  DateTime createdDate;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        lat: json["lat"] == null ? null : json["lat"],
        lng: json["lng"] == null ? null : json["lng"],
        image: json["image"] == null ? null : json["image"],
        product: json["product"],
        qty: json["qty"],
        survey: json["survey"],
        surveyName: json["survey_name"],
        bluAngel: json["blu_angel"],
        bluAngelMobile: json["blu_angel_mobile"],
        customer: json["customer"],
        customerData: CustomerData.fromJson(json["customer_data"]),
        formData: json["form_data"],
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
        "image": image == null ? null : image,
        "product": product,
        "qty": qty,
        "survey": survey,
        "survey_name": surveyName,
        "blu_angel": bluAngel,
        "blu_angel_mobile": bluAngelMobile,
        "customer": customer,
        "customer_data": customerData.toJson(),
        "form_data": formData,
        "created_date": createdDate.toIso8601String(),
        "__v": v,
      };
}

class CustomerData {
  CustomerData({
    this.fullName,
    this.address,
    this.village,
    this.postOffice,
    this.thana,
    this.state,
    this.district,
    this.pincode,
    this.mobile,
  });

  String fullName;
  String address;
  String village;
  String postOffice;
  String thana;
  String state;
  String district;
  String pincode;
  String mobile;

  factory CustomerData.fromJson(Map<String, dynamic> json) => CustomerData(
        fullName: json["full_name"],
        address: json["address"],
        village: json["village"],
        postOffice: json["post_office"],
        thana: json["thana"],
        state: json["state"],
        district: json["district"],
        pincode: json["pincode"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "address": address,
        "village": village,
        "post_office": postOffice,
        "thana": thana,
        "state": state,
        "district": district,
        "pincode": pincode,
        "mobile": mobile,
      };
}
