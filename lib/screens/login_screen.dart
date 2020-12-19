import 'dart:async';
import 'dart:io' show Platform;
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/loginResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/HomeScreen.dart';
import 'sign_up.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String mobilenumber, status, otp, tokenCall;
  String response;
  Map<String, dynamic> verify;
  bool isLoading;
  String accessToken;
  // getDataFromSharedPrefs() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     accessToken = sharedPreferences.getString("access_token");
  //   });
  // }
  bool nameChange;
  @override
  void initState() {
    isLoading = true;
    mobilenumber = '';
    nameChange = true;
    status = '';
    verify = {};
    // otp = '';
    super.initState();
  }

  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                      title: Text('Are you sure you want to quit?'),
                      actions: <Widget>[
                        RaisedButton(
                            child: Text('exit'),
                            onPressed: () => SystemNavigator.pop()),
                        RaisedButton(
                            child: Text('cancel'),
                            onPressed: () => Navigator.of(context).pop(false)),
                      ])),
          child: Stack(
            children: [
              ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  CustomView.buildContainerBackgroundImage(
                    context: context,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              // margin: const EdgeInsets.only(top: 10),
                              child: CustomView.buildContainerWithImage(
                                h: 100,
                                w: 55,
                                imagePath: 'assets/images/Mascot-01.png',
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: CustomView.buildContainerCardUI(
                                h: 100,
                                w: MediaQuery.of(context).size.width / 3.0,
                                color: Colors.transparent,
                                context: context,
                                child: CustomView.buildLargeContainer(
                                  margin: 0.0,
                                  color: Color(0xFF8fe9ff),
                                  color1: Colors.transparent,
                                  listColor: ksubBg,
                                  child: ListView(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    // crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        margin: const EdgeInsets.only(
                                            top: 20, left: 20.0),
                                        child: Text(
                                          'LOGIN',
                                          style: kheadingStyle.apply(
                                              color: Color(0xff2b1f75),
                                              fontSizeFactor: 2,
                                              fontWeightDelta: 4),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(top: 20, left: 20),
                                        child: Text(
                                          'MOBILE NUMBER',
                                          style: kheadingStyle.apply(
                                            fontWeightDelta: 3,
                                            fontSizeFactor: 1.2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: CustomView.editTextField(
                                            fn: (input) {
                                              setState(() {
                                                mobilenumber = input.toString();
                                              });
                                            },
                                            color: Colors.red,
                                            keyborad: TextInputType.number,
                                            // labelText: '+91-1010101010',
                                            lengthLimiting: 10),
                                      ),
                                      Container(
                                        margin:
                                        const EdgeInsets.only(top: 20, left: 20),
                                        child: Text(
                                          'OTP',
                                          style: kheadingStyle.apply(
                                            fontWeightDelta: 3,
                                            fontSizeFactor: 1.2,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: CustomView.editTextField(
                                          fn: (input) {
                                            otp = input.toString();
                                          },

                                          color: Colors.transparent,
                                          keyborad: TextInputType.number,
                                          // labelText: 'OTP',
                                          lengthLimiting: 6,
                                        ),
                                      ),
                                      Container(
                                        // alignment: Alignment.bottomRight,
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: CustomView.button(
                                          circularRadius: 5,
                                          isCircular: true,
                                          buttonColor: Color(0xffb3e0f7),
                                          buttonName: nameChange
                                              ? 'GENERATE OTP'
                                              : 'RESEND OTP',
                                          color: kfontColorBlue4,
                                          function: () async {
                                            setState(() {
                                              isLoading = !isLoading;
                                            });
                                            final LoginResponse loginResponse =
                                            await ApiCall.postLogin(
                                              mobileNumber: mobilenumber,
                                            );

                                            if (mobilenumber == null) {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Mobile Number is Empty!",
                                                      () {
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      isLoading = !isLoading;
                                                    });
                                                  });
                                            } else if (mobilenumber.length <
                                                10) {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Mobile Number is atleast 10 digits",
                                                      () {
                                                    Navigator.of(context).pop();
                                                    setState(() {
                                                      isLoading = !isLoading;
                                                    });
                                                  });
                                            } else if (loginResponse.status ==
                                                "error" &&
                                                loginResponse.message ==
                                                    "Invalid mobile/passwordd") {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Invalid Mobile Number", () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = !isLoading;
                                                });
                                              });
                                            } else if (loginResponse.status ==
                                                "error" &&
                                                loginResponse.message ==
                                                    "Account is inactive") {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Account is inactive", () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = !isLoading;
                                                });
                                              });
                                            } else {
                                              if (loginResponse.status ==
                                                  "success") {
                                                // isLoading = !isLoading;
                                                setState(() {
                                                  isLoading = !isLoading;
                                                  nameChange = !nameChange;
                                                  response =
                                                      loginResponse.status;
                                                  // otp = loginResponse.otp.toString();

                                                  print(loginResponse.otp
                                                      .toString());
                                                });
                                              }
                                            }

                                            // print(loginResponse.otp.toString());
                                          },
                                          height: 50,
                                          width: 180,
                                          textSize: 20,
                                        ),
                                      ),
                                      Container(
                                        height: 50,
                                        width: 250,
                                        // alignment: Alignment.bottomRight,
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: AbsorbPointer(
                                          absorbing: false,
                                          ignoringSemantics: true,
                                          child: RaisedButton(
                                            color: Colors.blue[900],
                                            child: Text(
                                              'ENTER',
                                              style: kheadingStyle.apply(
                                                color: Colors.white,
                                                fontWeightDelta: 4,
                                              ),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(30),
                                            ),
                                            onPressed: () async {
                                              // callback(context);
                                              if (mobilenumber == null) {
                                                CustomView.showInDialog(
                                                    context,
                                                    "Error",
                                                    "Mobile Number is Empty!",
                                                        () {
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        isLoading = !isLoading;
                                                      });
                                                    });
                                              } else if (mobilenumber.length <
                                                  10) {
                                                CustomView.showInDialog(
                                                    context,
                                                    "Error",
                                                    "Mobile Number is atleast 10 digits",
                                                        () {
                                                      Navigator.of(context).pop();
                                                      setState(() {
                                                        isLoading = !isLoading;
                                                      });
                                                    });
                                              } else {
                                                if (response == null) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Please generate otp first",
                                                          () {
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          isLoading = !isLoading;
                                                        });
                                                      });
                                                } else if (otp == null) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Please generate otp first",
                                                          () {
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          isLoading = !isLoading;
                                                        });
                                                      });
                                                } else if (otp.length < 6) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "OTP at least 6 digits",
                                                          () {
                                                        Navigator.of(context).pop();
                                                        setState(() {
                                                          isLoading = !isLoading;
                                                        });
                                                      });
                                                } else if (response ==
                                                    "success") {
                                                  setState(() {
                                                    isLoading = !isLoading;
                                                  });
                                                  VerifyResponse
                                                  verifyResponse =
                                                  await ApiCall.postVerify(
                                                    mobileNumber: mobilenumber,
                                                    otp: otp,
                                                  );

                                                  if (verifyResponse.status ==
                                                      "success") {
                                                    print(
                                                        verifyResponse.status);
                                                    print('otp is: $otp');
                                                    SharedPreferences
                                                    sharedPreferences =
                                                    await SharedPreferences
                                                        .getInstance();
                                                    sharedPreferences.setString(
                                                        "accessToken",
                                                        verifyResponse.token);
                                                    sharedPreferences.setString(
                                                        "tokenCall",
                                                        verifyResponse.result.id.toString());


                                                    sharedPreferences.setString(
                                                        "tokenCall",
                                                        verifyResponse.result.id.toString());

                                                    sharedPreferences.setString(
                                                        "firstName",
                                                        verifyResponse.result.firstName.toString());

                                                    sharedPreferences.setString(
                                                        "lastName",
                                                        verifyResponse.result.lastName.toString());


                                                    sharedPreferences.setString(
                                                        "dob",
                                                        verifyResponse.result.dob.toString());


                                                    sharedPreferences.setString(
                                                        "gender",
                                                        verifyResponse.result.gender.toString());

                                                    sharedPreferences.setBool(
                                                        "isSigned", true);
                                                    setState(() {
                                                      ApiCall.token =
                                                          verifyResponse.token;
                                                      print(
                                                          verifyResponse.token);
                                                      ApiCall.tokenCall =
                                                          verifyResponse
                                                              .result.id
                                                              .toString();
                                                      print(verifyResponse
                                                          .result.id
                                                          .toString());
                                                      CustomView.firstName =
                                                          verifyResponse
                                                              .result.firstName;
                                                      CustomView.lastName =
                                                          verifyResponse
                                                              .result.lastName;
                                                      CustomView.dob =
                                                          verifyResponse
                                                              .result.dob;
                                                      CustomView.gender =
                                                          verifyResponse
                                                              .result.gender;
                                                      isLoading = !isLoading;
                                                    });
                                                    final BannerResponse
                                                    bannerResponse =
                                                    await ApiCall
                                                        .getBanner();
                                                    if (bannerResponse.status ==
                                                        "success") {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomeScreen(
                                                                bannerResponse:
                                                                bannerResponse,
                                                              ),
                                                        ),
                                                      );
                                                    }
                                                  } else if (verifyResponse
                                                      .status ==
                                                      "validation_error") {
                                                    print(
                                                        verifyResponse.status);
                                                    CustomView.showInDialog(
                                                        context,
                                                        "Error",
                                                        "Invalid otp", () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        isLoading = !isLoading;
                                                      });
                                                    });
                                                  }
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      new Container(
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          bottom: 10.0,
                                        ),
                                        child: new FlatButton(
                                          onPressed: () async {
                                            // print('jo');
                                            // ApiCall.getSwData();

                                            final StateListResponse
                                            stateListResponse =
                                            await ApiCall.postState();
                                            if (stateListResponse.status ==
                                                "success") {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) => SignUp(
                                                    // listData: ApiCall.listData,
                                                    stateListResponse:
                                                    stateListResponse,
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: Text(
                                            'REGISTRATION',
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 5,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: !isLoading,
                child:Align(
                alignment: Alignment.center,
                child: Container(
                  decoration:BoxDecoration(
                    color:Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16))
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: CircularProgressIndicator()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 16) ,child: Text("Please wait..."))
                    ],
                  ),
                ),
              )
              )
            ],
          )

        ),
      ),
    );
  }

  void showInDialog(BuildContext context, String title, String value) async {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text(title),
        content: Text(value),
        actions: [
          new FlatButton(
            child: const Text("Ok"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}