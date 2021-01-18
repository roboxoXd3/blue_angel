import 'dart:async';
import 'dart:io' show Platform;
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/loginResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/Registration.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/Dialog.dart';
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
  String activationMessage = '';
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Wait"),
          content: new Text(activationMessage),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                // setState(() {
                //   isLoading = !isLoading;
                // });
                Navigator.of(_keyLoader.currentContext, rootNavigator: true)
                    .pop();
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return LoginScreen();
                // }));
              },
            ),
          ],
        );
      },
    );
  }

  // BannerResponse bannerResponse;
  String mobilenumber, status, otp, tokenCall;
  String response;
  Map<String, dynamic> verify;
  // bool isLoading;
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
    // isLoading = true;
    mobilenumber = '';
    nameChange = true;
    status = '';
    verify = {};
    // otp = '';
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                                  child: Form(
                                    key: _formKey,
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
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20),
                                          child: Text(
                                            'MOBILE NUMBER',
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 3,
                                              fontSizeFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: CustomView.editTextField(
                                              validator: (value) {
                                                if (value.toString().isEmpty) {
                                                  return "Enter a valid number";
                                                } else if (value
                                                        .toString()
                                                        .characters
                                                        .length <
                                                    10) {
                                                  return "Length should be 10";
                                                }
                                                return null;
                                              },
                                              fn: (input) {
                                                setState(() {
                                                  mobilenumber =
                                                      input.toString();
                                                });
                                              },
                                              color: Colors.red,
                                              keyborad: TextInputType.number,
                                              // labelText: '+91-1010101010',
                                              lengthLimiting: 10),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20),
                                          child: Text(
                                            'OTP',
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 3,
                                              fontSizeFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin:
                                              const EdgeInsets.only(top: 20),
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
                                              Dialogs.showLoadingDialog(
                                                  context, _keyLoader);
                                              setState(() {
                                                // isLoading = !isLoading;
                                              });

                                              if (_formKey.currentState
                                                  .validate()) {
                                                final LoginResponse
                                                    loginResponse =
                                                    await ApiCall.postLogin(
                                                  mobileNumber: mobilenumber,
                                                );

                                                print(loginResponse.message);

                                                setState(() {
                                                  activationMessage =
                                                      loginResponse.message;
                                                });
                                                _showDialog();
                                                setState(() {
                                                  // isLoading = !isLoading;
                                                });
                                                // Navigator.of(context).pop();

                                                if (mobilenumber.length == 0) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Mobile Number is Empty!",
                                                      () {
                                                    // Navigator.of(context).pop();
                                                    Navigator.of(
                                                            _keyLoader
                                                                .currentContext,
                                                            rootNavigator: true)
                                                        .pop();
                                                  });
                                                } else if (mobilenumber.length <
                                                    10) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Mobile Number is atleast 10 digits",
                                                      () {
                                                    // Navigator.of(context).pop();
                                                    Navigator.of(
                                                            _keyLoader
                                                                .currentContext,
                                                            rootNavigator: true)
                                                        .pop();
                                                  });
                                                } else {
                                                  if (loginResponse.status ==
                                                      "success") {
                                                    Navigator.of(context).pop();
                                                    // isLoading = !isLoading;
                                                    Navigator.of(
                                                            _keyLoader
                                                                .currentContext,
                                                            rootNavigator: true)
                                                        .pop();
                                                    setState(() {
                                                      // isLoading = !isLoading;
                                                      nameChange = !nameChange;
                                                      response =
                                                          loginResponse.status;
                                                      // otp = loginResponse.otp.toString();

                                                      print(loginResponse.otp
                                                          .toString());
                                                    });
                                                  }
                                                }
                                              } else {
                                                Navigator.of(context).pop();
                                                Navigator.of(
                                                        _keyLoader
                                                            .currentContext,
                                                        rootNavigator: true)
                                                    .pop();
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
                                              Dialogs.showLoadingDialog(
                                                  context, _keyLoader);
                                              if (mobilenumber == null) {
                                                CustomView.showInDialog(
                                                    context,
                                                    "Error",
                                                    "Mobile Number is Empty!",
                                                    () {
                                                  Navigator.of(context).pop();
                                                  Navigator.of(
                                                          _keyLoader
                                                              .currentContext,
                                                          rootNavigator: true)
                                                      .pop();
                                                  setState(() {
                                                    // isLoading = false;
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
                                                  Navigator.of(
                                                          _keyLoader
                                                              .currentContext,
                                                          rootNavigator: true)
                                                      .pop();
                                                  setState(() {
                                                    // isLoading = false;
                                                  });
                                                });
                                              } else {
                                                if (response == null) {
                                                  // _showDialog();
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Please generate otp first",
                                                      () {
                                                    Navigator.of(context).pop();
                                                    Navigator.of(
                                                            _keyLoader
                                                                .currentContext,
                                                            rootNavigator: true)
                                                        .pop();
                                                    setState(() {
                                                      // isLoading = false;
                                                    });
                                                  });
                                                } else if (otp == null) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "Please generate otp first",
                                                      () {
                                                    Navigator.of(context).pop();
                                                    // Navigator.of(
                                                    //         _keyLoader
                                                    //             .currentContext,
                                                    //         rootNavigator: true)
                                                    //     .pop();
                                                    setState(() {
                                                      // isLoading = false;
                                                    });
                                                  });
                                                } else if (otp.length < 6) {
                                                  CustomView.showInDialog(
                                                      context,
                                                      "Error",
                                                      "OTP at least 6 digits",
                                                      () {
                                                    Navigator.of(context).pop();
                                                    // Navigator.of(
                                                    //         _keyLoader
                                                    //             .currentContext,
                                                    //         rootNavigator: true)
                                                    //     .pop();
                                                    setState(() {
                                                      // isLoading = false;
                                                    });
                                                  });
                                                } else if (response ==
                                                    "success") {
                                                  Navigator.of(context).pop();
                                                  // Navigator.of(
                                                  //         _keyLoader
                                                  //             .currentContext,
                                                  //         rootNavigator: true)
                                                  //     .pop();
                                                  setState(() {
                                                    //   isLoading = false;
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
                                                    // sharedPreferences.setString(
                                                    //     "accessToken",
                                                    //     verifyResponse.token);

                                                    // sharedPreferences
                                                    //     .setString(
                                                    //         "tokenCall",
                                                    //         verifyResponse
                                                    //             .result.id
                                                    //             .toString());

                                                    sharedPreferences.setString(
                                                        "tokenCall",
                                                        verifyResponse.result.id
                                                            .toString());

                                                    sharedPreferences.setString(
                                                        "firstName",
                                                        verifyResponse
                                                            .result.firstName
                                                            .toString());

                                                    sharedPreferences.setString(
                                                        "lastName",
                                                        verifyResponse
                                                            .result.lastName
                                                            .toString());

                                                    sharedPreferences.setString(
                                                        "dob",
                                                        verifyResponse
                                                            .result.dob
                                                            .toString());

                                                    sharedPreferences.setString(
                                                        "gender",
                                                        verifyResponse
                                                            .result.gender
                                                            .toString());

                                                    sharedPreferences.setBool(
                                                        "isSigned", true);
                                                    setState(() {
                                                      ApiCall.token =
                                                          verifyResponse.token;
                                                      print("access token is:"+
                                                          verifyResponse.token);
                                                      sharedPreferences.setString("accessToken", verifyResponse.token
                                                          .toString());
                                                      ApiCall.tokenCall =
                                                          verifyResponse
                                                              .result.id
                                                              .toString();
                                                      sharedPreferences.setString("user_id", verifyResponse
                                                          .result.id
                                                          .toString());
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
                                                      // isLoading = !isLoading;
                                                    });
                                                    final BannerResponse
                                                        bannerResponse =
                                                        await ApiCall
                                                            .getBanner();
                                                    if (bannerResponse.status ==
                                                        "success") {
                                                      sharedPreferences
                                                          .setString(
                                                              "top_nav",
                                                              bannerResponse
                                                                  .data.top_nav
                                                                  .toString());
                                                      sharedPreferences.setString(
                                                          "backendS",
                                                          bannerResponse.data
                                                              .blu_app_version
                                                              .toString());

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
                                                      "error") {
                                                    print(
                                                        verifyResponse.status);
                                                    CustomView.showInDialog(
                                                        context,
                                                        "Error",
                                                        verifyResponse.message,
                                                        () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      setState(() {
                                                        // isLoading = !isLoading;
                                                      });
                                                    });
                                                  }
                                                }
                                              }
                                            },
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
                                                    builder: (context) =>
                                                        Registration(),
                                                    //     SignUp(
                                                    //   // listData: ApiCall.listData,
                                                    //   stateListResponse:
                                                    //       stateListResponse,
                                                    // ),
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Visibility(
              //     visible: true,
              //     child: Align(
              //       alignment: Alignment.center,
              //       child: Container(
              //         decoration: BoxDecoration(
              //             color: Colors.white,
              //             borderRadius: BorderRadius.all(Radius.circular(16))),
              //         margin: EdgeInsets.symmetric(horizontal: 16),
              //         height: MediaQuery.of(context).size.height * 0.15,
              //         width: MediaQuery.of(context).size.width,
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.center,
              //           children: [
              //             Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 16),
              //                 child: CircularProgressIndicator()),
              //             Padding(
              //                 padding: EdgeInsets.symmetric(horizontal: 16),
              //                 child: Text("Please wait..."))
              //           ],
              //         ),
              //       ),
              //     ))
            ],
          )),
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
