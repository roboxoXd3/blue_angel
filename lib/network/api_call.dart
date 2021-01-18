import 'dart:async';
import 'package:blue_angel/models/aboutUsResponse.dart';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/districtListResponse.dart';
import 'package:blue_angel/models/getLevelResponse.dart';
import 'package:blue_angel/models/loginResponse.dart';
import 'package:blue_angel/models/requestAdminResponse.dart';
import 'package:blue_angel/models/signUpResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/models/surveySubmitResponse.dart';
import 'package:blue_angel/models/updateProfileResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'api_constants.dart';

class ApiCall {
  static Map<String, dynamic> verifyData;

  static String token, tokenCall;
  static Map<String, dynamic> stateData;
  static List<dynamic> stateList;
  static List<String> listData = [];
  static Map<String, dynamic> loginData;
  static String otpByLogin, statusData;
  static List districData;
  static List<String> districtList = [];
  static Map<String, dynamic> aboutData;
  // BuildContext context;
  // int timeout = 5;
  // state list api

  // about page api
  static Future<AboutUsResponse> getAboutPage() async {
    final response = await http.post(
      AppConstants.aboutPage,
      headers: {
        "accept": "application/json",
        "authorization": "$token",
      },
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("About us page info" + responseString);
      return aboutUsResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  static Future<SurveyListResponse> getSurveyList(String authtoken , String blueAngel) async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.surveyList),
      headers: {
        "accept": "application/json",
        "authorization": "$authtoken",
      },
      body: json.encode({
        "blu_angel": blueAngel,
      }),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      SurveyListResponse surveyListResponse = SurveyListResponse();
      // print('response $response');
      // print('response ${response.statusCode}');
      // print('responseString $responseString');
      // return surveyListResponseFromJson(responseString);
      return surveyListResponse;
    } else {

      return null;
    }
  }

  // survey report api
  static Future<SurveyReportResponse> getSurveyReport({
    @required String startDate,
    @required String endDate,
    @required surveyId,

  }) async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.surveyReport),
      headers: {
        "accept": "application/json",
        "authorization": "$token",
      },
      body: json.encode({
        "start_date": startDate,
        "end_date": endDate,
        "blu_angel": tokenCall,
        "survey_id": 'surveyId',
      }),
    );
    if (response.statusCode == 200) {
      print("Inside survey report");
      final String responseString = response.body;
      return surveyReportResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // survey submit api
  static Future<SurveySubmitResponse> getSurveySubmit({
    @required String accesstoken,
    @required String surveyId,
    @required String blue_angel,
    @required String fullName,
    @required String address,
    @required String village,
    @required String postOffice,
    @required String thana,
    @required String country,
    @required String state,
    @required String district,
    @required String pincode,
    @required String mobileNumber,
    @required Map<String, dynamic> formData,
    @required String products,
    @required String qty,
    @required String lng,
    @required String lat,
    @required String image,
  }) async {
    final response = await http.post(
      Uri.encodeFull('http://139.59.75.40:4000/app/survey-submit'),
      headers: {
        "accept": "application/json",
        "authorization": "$accesstoken",
      },
      body: json.encode({
        "surveys": surveyId,
        "blu_angel": blue_angel,
        "full_name": fullName,
        "address": address,
        "village": village,
        "post_office": postOffice,
        "thana": thana,
        "country": country,
        "state": state,
        "district": district,
        "pincode": pincode,
        "mobile": mobileNumber,
        "form_data": formData,
        "product": "null",
        "qty": "1",
        "image": image,
        "lat": lat,
        "lng": lng,
      }),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return surveySubmitResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // update profile api
  static Future<UpdateProfileResponse> getUpdateProfile({
    @required String firstname,
    @required String lastname,
    @required String gender,
    @required String dob,
    @required String profileImage,
    @required sid,
    // @required String id,
  }) async {
    final response = await http.post(Uri.encodeFull(AppConstants.updateProfile),
        headers: {
          "accept": "application/json",
          "authorization": "$token",
        },
        body: json.encode({
          "first_name": firstname,
          "last_name": lastname,
          "gender": gender,
          "dob": dob,
          "profile_image": profileImage,
          "id": sid,
        }));
    print(response);
    if (response.statusCode == 200) {
      print(response.statusCode);
      final String responseString = response.body;
      return UpdateProfileResponse.fromJson(json.decode(responseString));
    } else {
      return null;
    }
  }

  // level api
  static Future<GetLevelResponse> getLevel() async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.getLevel),
      headers: {
        "accept": "application/json",
        "authorization": "$token",
      },
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return getLevelResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // admin with request api
  static Future<RequestAdminResponse> getRequestAdmin(
      {@required String id, @required String content}) async {
    final response = await http.post(Uri.encodeFull(AppConstants.getLevel),
        headers: {
          "accept": "application/json",
          "authorization": "$token",
        },
        body: json.encode({
          "blu_angel": id,
          "content": content,
        }));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return requestAdminResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // login reponse api
  static Future<LoginResponse> postLogin({
    @required String mobileNumber,
  }) async {
    final response = await http
        .post(Uri.encodeFull(AppConstants.login),
            headers: {
              "accept": "application/json",
              // "authorization": "$token",
            },
            body: json.encode({
              "mobile": mobileNumber,
            }))
        .timeout(
          Duration(seconds: 5),
        );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return loginResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // verify api
  static Future<VerifyResponse> postVerify(
      {@required String mobileNumber, @required String otp}) async {
    final response = await http.post(Uri.encodeFull(AppConstants.verify),
        headers: {
          "accept": "application/json",
          "authorization": "$token",
        },
        body: json.encode({
          "mobile": mobileNumber,
          "otp": otp,
        }));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return verifyResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // sign up api
  static Future<SignUpResponse> postSignUp({
    // @required int userType,
    @required String firstName,
    @required String lastName,
    @required String gender,
    @required String dob,
    @required String fatherName,
    @required String address1,
    @required String village,
    @required String postOffice,
    @required String thana,
    @required String country,
    @required String state,
    @required String district,
    @required String pincode,
    @required String occupation,
    @required String identity,
    @required String mobile,
    @required String document,
    // @required File image,
  }) async {
    // var base64String = base64Encode(document.readAsBytesSync());
    // var base64String = base64UrlEncode(image.readAsBytesSync());
    // print(base64String);
    final response = await http.post(
      Uri.encodeFull(AppConstants.signUp),
      headers: {
        "accept": "text/plain",
        // "authorization": "$token",
      },
      body: json.encode({
        // 'user_type': userType,
        'first_name': firstName,
        'last_name': lastName,
        'gender': gender,
        'dob': dob,
        'father_name': fatherName,
        'address1': address1,
        'village': village,
        'post_office': postOffice,
        'thana': thana,
        'country': country,
        'state': state,
        'district': district,
        'pincode': pincode,
        'occupation': occupation,
        'identity': identity,
        'mobile': mobile,
        "document": document,
        // "user_type": "user_type",
        // 'document': CustomView.base64String(image.readAsBytesSync()),
        // 'document': image.path,
      }),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print(responseString);
      // print(base64String);
      // print(CustomView.base64String(document.readAsBytesSync()));
      try {
        return signUpResponseFromJson(responseString);
      } catch (e) {
        print(e);
        return SignUpResponse(
            status: "error", message: "Mobile already exists!");
      }
    } else {
      print(response.statusCode);
      return SignUpResponse(
          status: "api_error", message: "Mobile already exists!");
      return null;
    }
  }

  // state list api
  static Future<StateListResponse> getState() async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.stateList),
      headers: {
        "accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return stateListResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  // district api
  static Future<DistrictListResponse> posttDistrictData(String id) async {
    final response = await http.post(Uri.encodeFull(AppConstants.districtList),
        headers: {
          "accept": "application/json",
        },
        body: json.encode({
          "id": id,
        }));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return districtListResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  static Future<BannerResponse> getBanner() async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.banner),
      headers: {
        "accept": "application/json",
        "authorization": "$token",
      },
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return bannerResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  static Future<StateListResponse> postState() async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.stateList),
      headers: {
        "accept": "application/json",
      },
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("Response string value is: " + responseString);
      return stateListResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  static Future<DistrictListResponse> postDistrict(String id) async {
    final response = await http.post(Uri.encodeFull(AppConstants.districtList),
        headers: {
          "accept": "application/json",
        },
        body: json.encode({
          "id": id,
        }));
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return districtListResponseFromJson(responseString);
    } else {
      return null;
    }
  }

  static var uri = AppConstants.baseUrl;

  static BaseOptions options = BaseOptions(
      baseUrl: uri,
      responseType: ResponseType.plain,
      connectTimeout: 30000,
      receiveTimeout: 30000,
      validateStatus: (code) {
        if (code >= 200) {
          return true;
        } else {
          return false;
        }
      });

  static Dio dio = Dio(options);

  // static Future<SignUpResponse> signUP({
  //   @required String firstName,
  //   @required String lastName,
  //   @required String gender,
  //   @required String dob,
  //   @required String fatherName,
  //   @required String address1,
  //   @required String village,
  //   @required String postOffice,
  //   @required String thana,
  //   @required String country,
  //   @required String state,
  //   @required String district,
  //   @required String pincode,
  //   @required String occupation,
  //   @required String identity,
  //   @required String mobile,
  //   @required String document,
  // }) async {
  //   try {
  //     Options options = Options(
  //       contentType: 'application/json',
  //     );
  //     // var base64String = base64Encode(document.readAsBytesSync());
  //     FormData formData = new FormData.fromMap({
  //       "first_name": firstName,
  //       "last_name": lastName,
  //       "gender": gender,
  //       "dob": dob,
  //       "father_name": fatherName,
  //       "address1": address1,
  //       "village": village,
  //       "post_office": postOffice,
  //       "thana": thana,
  //       "country": country,
  //       "state": state,
  //       "district": district,
  //       "pincode": pincode,
  //       "occupation": occupation,
  //       "identity": identity,
  //       "mobile": mobile,
  //       "document": document,
  //     });
  //     // print(await MultipartFile.fromFile(document.path,
  //     //     filename: document.path.split('/').last));
  //     var response =
  //         await dio.post('register', data: formData, options: options);

  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       // var responseJson = json.decode(response.data);
  //       var responseJson = response.data;
  //       return signUpResponseFromJson(responseJson);
  //     } else {
  //       print('response.statusCode ${response.statusCode}');
  //     }
  //   } on DioError catch (exception) {
  //     if (exception == null ||
  //         exception.toString().contains('SocketException')) {
  //       print("Error Network Error");
  //     } else if (exception.type == DioErrorType.RECEIVE_TIMEOUT ||
  //         exception.type == DioErrorType.CONNECT_TIMEOUT) {
  //       print(
  //           "Error Could'nt connect, please ensure you have a stable network.");
  //     } else {
  //       return null;
  //     }
  //   }
  // }
}
