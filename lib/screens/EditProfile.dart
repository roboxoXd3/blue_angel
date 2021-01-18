import 'dart:convert';
import 'dart:io';

import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/updateProfileResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io' as Io;

import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  final BannerResponse bannerResponse;
  EditProfile({@required this.bannerResponse});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lasttNameController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController thanaController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController identityController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postOfficeController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  String mobile;
  String gender;
  String firstName;
  String lastName;
  String dob;
  File imgPath;
  // String bytes;
  String img64;
  List<int> bytes;
  int top_nav;

  VerifyResponse verifyResponse;

  File _image;
  Future getImage(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: SizedBox(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    "Camera",
                    style: TextStyle(fontSize: 26),
                  ),
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                    );

                    setState(() {
                      _image = image;
                      print(_image);
                      List<int> bytes = Io.File(_image.path.split('/').last)
                          .readAsBytesSync();
                      img64 = base64UrlEncode(bytes);

                      print('img64 $img64');

                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  child: Text(
                    "Gallery",
                    style: TextStyle(fontSize: 26),
                  ),
                  onPressed: () async {
                    var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );
                    // var image = await ImagePicker()
                    //     .getImage(source: ImageSource.gallery);
                    setState(() {
                      _image = image;
                      // print(_image.uri.toString());
                      List<int> bytes = Io.File(_image.path).readAsBytesSync();
                      img64 = base64UrlEncode(bytes);
                      print('img64 : $img64');
                      print('bytes $bytes');
                      // print('base64Image : $img64');
                      // base64String = base64Encode(_image.readAsBytesSync());
                      // print('document $img64');
                      // print('base64String $base64String');
                      print('image1 : $_image');
                      Navigator.pop(context);
                    });
                  },
                ),
                _image != null
                    ? FlatButton(
                        child: Text(
                          "Remove Profile",
                          style: TextStyle(fontSize: 26),
                        ),
                        onPressed: () async {
                          setState(() {
                            _image = null;
                            Navigator.pop(context);
                          });
                        },
                      )
                    : Text(
                        "",
                      ),
              ],
            ),
          ));
        });
  }

  final format = DateFormat("dd.MM.yyyy");
  bool isUpdate;
  List<String> genderList = List();

  @override
  void initState() {
    getDataFromSharedPrefs();
    // print("First name: " + firstName);

    genderList = <String>['Male', 'Female'];
    isUpdate = false;
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    firstName = CustomView.firstName;
    lastName = CustomView.lastName;
    dob = CustomView.dob;
    gender = CustomView.gender;
    //  gender CustomView.

    super.initState();
  }

  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
      // firstName = sharedPreferences.getString("firstName");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomView.appBarCustom('Arrow-Icon-02', 'Bt-Close-01', () {
        // _scaffoldKey.currentState.openDrawer();
        Navigator.of(context).pop();
      }, () {
        // Navigator.of(context).pop();
      },
          isLeading: true,
          isAction: false,
          title: 'edit profile',
          top_nav: top_nav),
      body: SingleChildScrollView(
        child: CustomView.buildContainerBackgroundImage(
          context: context,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              CustomView.buildContainerWithImage(
                h: 50,
                w: 200,
                imagePath: 'assets/images/LogoWithMascot-01.png',
              ),
              CustomView.buildContainerCardUI(
                h: MediaQuery.of(context).size.height / 2.8,
                w: MediaQuery.of(context).size.width / 10,
                color: Colors.transparent,
                context: context,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: BorderSide(
                        width: 4.0,
                        style: BorderStyle.solid,
                        color: Colors.white,
                      )),
                  shadowColor: Colors.black87,
                  borderOnForeground: true,
                  clipBehavior: Clip.antiAlias,
                  child: ListView(
                    children: <Widget>[
                      isUpdate
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      children: [
                                        CustomView.buildImageWithText(
                                            context,
                                            'Upload-Icon',
                                            'UPLOAD IMAGE',
                                            kfontColorBlue4,
                                            0, () {
                                          getImage(context);
                                        })
                                      ],
                                    )),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'First NAME',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: CustomView.editTextField(
                                      // prefilledText: "First name",
                                      labelText: firstName,
                                      controller: firstNameController,
                                      onChanged: (input) {
                                        setState(() {
                                          firstName = input;
                                          // CustomView.firstName = input;
                                        });
                                      },
                                      color: Colors.red,
                                      keyborad: TextInputType.text,
                                      // labelText: 'NAME',
                                      lengthLimiting: 20),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'LAST NAME',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: CustomView.editTextField(
                                      labelText: lastName,
                                      // prefilledText:
                                      //     CustomView.lastName.toUpperCase(),
                                      controller: lasttNameController,
                                      onChanged: (input) {
                                        setState(() {
                                          lastName = input;
                                          // CustomView.lastName = input;
                                        });
                                      },
                                      color: Colors.red,
                                      keyborad: TextInputType.text,
                                      // labelText: 'LAST NAME',
                                      lengthLimiting: 20),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'GENDER',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                CustomView.buildDropDown(
                                    text: gender,
                                    context: context,
                                    inputValue: gender,
                                    list: genderList,
                                    onchanged: (input) {
                                      setState(() {
                                        gender = input.toString();
                                        // CustomView.gender = input.toString();
                                      });
                                    }),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'DATE OF BIRTH',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 60,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 15.0),
                                  margin: const EdgeInsets.only(
                                      top: 20, left: 20, right: 20),
                                  width: MediaQuery.of(context).size.width,
                                  // padding: EdgeInsets.only(left: 3, right: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xffbdd5f1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6.0)),
                                    // border: Border.all(
                                    //     color: Colors.blue, width: 1),
                                  ),
                                  child: DateTimeField(
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 5,
                                      fontSizeFactor: 1.0,
                                      color: Color(0xff2d1f76),
                                    ),
                                    decoration: InputDecoration(
                                      suffixIcon: SizedBox(
                                        height: 15.0,
                                        width: 15.0,
                                        child: Image.asset(
                                          'assets/icons/Calender-Icon-01.png',
                                          fit: BoxFit.fill,
                                          height: 10.0,
                                          width: 10.0,
                                        ),
                                      ),
                                      // labelText: 'Date of Birth',
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                    ),
                                    format: format,
                                    controller: dobController,
                                    onChanged: (input) {
                                      setState(() {
                                        dob = input.toString();
                                        // CustomView.dob = input.toString();
                                      });
                                    },
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'First NAME : ${CustomView.firstName.toUpperCase()}',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin:
                                //       const EdgeInsets.only(top: 20, left: 20),
                                //   child: Text(
                                //     CustomView.firstName,
                                //     style: kheadingStyle.apply(
                                //       fontWeightDelta: 3,
                                //       fontSizeFactor: 1.2,
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'LAST NAME : ${CustomView.lastName.toUpperCase()}',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin:
                                //       const EdgeInsets.only(top: 20, left: 20),
                                //   child: Text(
                                //     CustomView.lastName,
                                //     style: kheadingStyle.apply(
                                //       fontWeightDelta: 3,
                                //       fontSizeFactor: 1.2,
                                //     ),
                                //   ),
                                // ),
                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'GENDER : ${CustomView.gender.toUpperCase()}',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),

                                Container(
                                  margin:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text(
                                    'DATE OF BIRTH : ${CustomView.dob.split(' ')[0]}',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.2,
                                    ),
                                  ),
                                ),
                                // Container(
                                //   margin:
                                //       const EdgeInsets.only(top: 20, left: 20),
                                //   child: Text(
                                //     CustomView.dob,
                                //     style: kheadingStyle.apply(
                                //       fontWeightDelta: 3,
                                //       fontSizeFactor: 1.2,
                                //     ),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  alignment: Alignment.bottomRight,
                                  child: CustomView.button(
                                      height: 50,
                                      isCircular: true,
                                      textSize: 20,
                                      width: 200,
                                      buttonColor: kfontColorBlue4,
                                      buttonName: 'UPDATE PROFILE',
                                      circularRadius: 30,
                                      color: Colors.white,
                                      function: () {
                                        setState(() {
                                          isUpdate = true;
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: 50,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
              isUpdate
                  ? Container(
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child: CustomView.button(
                        buttonColor: kfontColorBlue4,
                        buttonName: 'SUBMIT',
                        circularRadius: 30,
                        color: Colors.white,
                        function: () async {
                          print('update');
                          final UpdateProfileResponse updateProfileResponse =
                              await ApiCall.getUpdateProfile(
                            firstname: firstName,
                            lastname: lastName,
                            dob: dob.toString(),
                            gender: gender,
                            profileImage: 'data:image/png;base64, $img64',
                            sid: ApiCall.tokenCall,
                          );
                          print('update2');
                          if (updateProfileResponse.status == "success") {
                            print(updateProfileResponse);
                            var response = updateProfileResponse;
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();
                            sharedPreferences.setString(
                                "accessToken", updateProfileResponse.token);
                            setState(() {
                              ApiCall.token = updateProfileResponse.token;
                              CustomView.firstName = response.data.firstName;
                              CustomView.lastName = response.data.lastName;
                              CustomView.gender = response.data.gender;
                              CustomView.dob = response.data.dob;
                            });
                            print(updateProfileResponse.status);
                            final BannerResponse bannerResponse =
                                await ApiCall.getBanner();
                            if (bannerResponse.status == "success") {
                              CustomView.showInDialog(
                                context,
                                '',
                                updateProfileResponse.message,
                                () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        bannerResponse: bannerResponse,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            print('update3');
                          } else {
                            print(updateProfileResponse.message);
                            print(updateProfileResponse.status);
                          }
                        },
                        height: 50,
                        isCircular: true,
                        textSize: 20,
                        width: 150,
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
