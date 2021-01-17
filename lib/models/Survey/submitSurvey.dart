import 'dart:convert';

import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/network/api_constants.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SubmtiSurevy {
  String status;
  String token;
  String message;

  SubmtiSurevy({this.status, this.token, this.message});

  SubmtiSurevy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

Future<SubmtiSurevy> submitSurevy({
  // String token,
  String surveyid,
  // String userid,
  // String transporter,
  String full_name,
  String address,
  String village,
  String postOffice,
  String thana,
  String country,
  Map<String, dynamic> formData,
  String state,
  String district,
  String pincode,
  String mobile,
  // String gender,
  String product,
  // String productid,
  String qntity,
  String image,
  String lal,
  String long,
}) async {
  var header = {'authorization': ApiCall.token};
  print(header);
  var body = jsonEncode({
    "surveys": surveyid,
    "blu_angel": ApiCall.tokenCall,
    "full_name": full_name,
    "address": address,
    "village": village,
    "post_office": postOffice,
    "thana": thana,
    "country": country,
    "form_data": formData,
    "state": state,
    "district": district,
    "pincode": pincode,
    "mobile": mobile,
    "product": product,
    "qty": qntity,
    "image": "data:image/png;base64, $image",
    "lat": lal,
    "lng": long
  });
  print('formData => ' + formData.toString());
  print('API Body => ' + body.toString());
  print("API Body image => data:image/png;base64, $image");
  final response =
      await http.post(AppConstants.surveySubmit, body: body, headers: header);
  print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return SubmtiSurevy.fromJson(json.decode(response.body));
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
