// To parse this JSON data, do
//
//     final surveyListResponse = surveyListResponseFromJson(jsonString);

import 'dart:convert';

SurveyListResponse surveyListResponseFromJson(String str) =>
    SurveyListResponse.fromJson(json.decode(str));

String surveyListResponseToJson(SurveyListResponse data) =>
    json.encode(data.toJson());

class SurveyListResponse {
  SurveyListResponse({
    this.status,
    this.products,
    this.result,
    this.token,
  });

  String status;
  List<Product> products;
  List<Result> result;
  String token;

  factory SurveyListResponse.fromJson(Map<String, dynamic> json) =>
      SurveyListResponse(
        status: json["status"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "token": token,
      };
}

class Product {
  Product({
    this.id,
    this.name,
  });

  String id;
  String name;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class Result {
  Result({
    this.active,
    this.id,
    this.user,
    this.firstName,
    this.lastName,
    this.mobile,
    this.survey,
    this.surveyName,
    this.createdDate,
    this.v,
  });

  int active;
  String id;
  String user;
  String firstName;
  String lastName;
  String mobile;
  Survey survey;
  String surveyName;
  DateTime createdDate;
  int v;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        active: json["active"],
        id: json["_id"],
        user: json["user"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        survey: Survey.fromJson(json["survey"]),
        surveyName: json["survey_name"],
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "_id": id,
        "user": user,
        "first_name": firstName,
        "last_name": lastName,
        "mobile": mobile,
        "survey": survey.toJson(),
        "survey_name": surveyName,
        "created_date": createdDate.toIso8601String(),
        "__v": v,
      };
}

class Survey {
  Survey({
    this.active,
    this.id,
    this.name,
    this.fields,
    this.createdDate,
    this.v,
  });

  int active;
  String id;
  String name;
  List<Field> fields;
  DateTime createdDate;
  int v;

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
        active: json["active"],
        id: json["_id"],
        name: json["name"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
        createdDate: DateTime.parse(json["created_date"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "active": active,
        "_id": id,
        "name": name,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
        "created_date": createdDate.toIso8601String(),
        "__v": v,
      };
}

class Field {
  Field({
    this.filedName,
    this.filedType,
    this.filedValue,
    this.filedRequired,
    this.formValuesComma,
  });

  String filedName;
  String filedType;
  String filedValue;
  String filedRequired;
  List<String> formValuesComma;

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        filedName: json["filed_name"],
        filedType: json["filed_type"],
        filedValue: json["filed_value"],
        filedRequired: json["filed_required"],
        formValuesComma: json["form_values_comma"] == null
            ? null
            : List<String>.from(json["form_values_comma"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "filed_name": filedName,
        "filed_type": filedType,
        "filed_value": filedValue,
        "filed_required": filedRequired,
        "form_values_comma": formValuesComma == null
            ? null
            : List<dynamic>.from(formValuesComma.map((x) => x)),
      };
}
