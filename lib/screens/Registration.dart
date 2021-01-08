// import 'dart:collection';
// import 'dart:io';
// import 'dart:io' as Io;
// import 'dart:convert';

import 'dart:collection';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:convert';

import 'package:blue_angel/models/districtListResponse.dart';
import 'package:blue_angel/models/loginResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/login_screen.dart';
import 'package:blue_angel/screens/varifyOtp.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/Dialog.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List<String> genders = ['Male', 'Female', 'Rather not say'];
  List<String> countryList = ['India'];
  List<String> identityList = <String>[
    'VOTER ID',
    'PASSPORT',
    'BANK ACCOUNT NO.',
    'RATION CARD',
    'AADHAAR CARD',
    'DRIVING LICENSE',
    'PAN CARD',
  ];
  StateListResponse _stateListResponse;
  DistrictListResponse _districtListResponse;
  List<String> stateIds;
  String selectedGender;
  String selectedState;
  String selectedStateId;
  String selectedDistrict;
  HashMap<String, String> stateId;
  bool stateChange = true;
  final _formKey = GlobalKey<FormState>();
  String firstName,
      lastName,
      guardianName,
      dob,
      country,
      address1,
      village,
      postOffice,
      thana,
      pincode,
      state,
      occupation,
      mobile,
      otp,
      identity;

  File _image;
  String img64;
  DateTime selectedDate = DateTime.now();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  void initState() {
    stateId = new HashMap<String, String>();
    ApiCall.postState().then((value) => setState(() {
          _stateListResponse = value;
          setState(() {
            for (dynamic e in _stateListResponse.data) {
              print('In For Loop');
              stateId.putIfAbsent(e.name, () => e.id);
            }
          });
        }));
    super.initState();
  }

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
                    var image = await ImagePicker().getImage(
                      source: ImageSource.camera,
                    );
                    // var image = await ImagePicker()
                    //     .getImage(source: ImageSource.camera);
                    setState(() {
                      // _image = image;
                      _image = File(image.path);
                      print(_image);
                      List<int> bytes = Io.File(_image.path).readAsBytesSync();
                      img64 = base64UrlEncode(bytes);
                      // var base64String =
                      //     base64UrlEncode(_image.readAsBytesSync());
                      // base64String = base64Encode(_image.readAsBytesSync());
                      print('document $img64');
                      // print('base64String $base64String');
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
                    var image = await ImagePicker().getImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                    );
                    // var image = await ImagePicker()
                    //     .getImage(source: ImageSource.gallery);
                    setState(() {
                      _image = File(image.path);
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
                            img64 = null;
                            Navigator.pop(context);
                          });
                        },
                      )
                    : Text(""),
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/Sub-BG-Active.png',
                  ),
                ),
              ),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        height: 100,
                        width: 55,
                        child: Image.asset(
                          'assets/images/Mascot-01.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.95,
                          // width: MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    Text(
                                      "REGISTRATION",
                                      style: kheadingStyle.apply(
                                          color: Color(0xff2b1f75),
                                          fontSizeFactor: 1.8,
                                          fontWeightDelta: 4),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "FIRST NAME",
                                        onSaved: (value) {
                                          setState(() {
                                            firstName = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "LAST NAME",
                                        onSaved: (value) {
                                          setState(() {
                                            lastName = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "FATHER/HUSBAND NAME",
                                        onSaved: (value) {
                                          setState(() {
                                            guardianName = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    Text(
                                      "Gender",
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                    Container(
                                      decoration:
                                          kSurveyFormContainerDecoration,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<String>(
                                          items: genders.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: kheadingStyle.apply(
                                                  fontWeightDelta: 3,
                                                  fontSizeFactor: 1.2,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              this.selectedGender = value;
                                            });
                                          },
                                          value: selectedGender,
                                          hint: Text(
                                            "Select Genders",
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 3,
                                              fontSizeFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    InkWell(
                                      onTap: () => _selectDate(context),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "DATE OF BIRTH",
                                              style: kheadingStyle.apply(
                                                fontWeightDelta: 3,
                                                fontSizeFactor: 1.2,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              // height: 45,
                                              decoration:
                                                  kSurveyFormContainerDecoration,
                                              margin: const EdgeInsets.only(
                                                  top: 20, right: 10),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.75,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${selectedDate.toLocal()}"
                                                          .split(' ')[0],
                                                      style:
                                                          kheadingStyle.apply(
                                                        fontWeightDelta: 3,
                                                        fontSizeFactor: 1.2,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "COUNTRY",
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration:
                                          kSurveyFormContainerDecoration,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<String>(
                                          items: countryList.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: kheadingStyle.apply(
                                                  fontWeightDelta: 3,
                                                  fontSizeFactor: 1.2,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              this.country = value;
                                            });
                                          },
                                          value: country,
                                          hint: Text(
                                            "Select County",
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 3,
                                              fontSizeFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "ADDRESS1",
                                        onSaved: (value) {
                                          setState(() {
                                            address1 = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "VILLAGE",
                                        onSaved: (value) {
                                          setState(() {
                                            village = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "POST OFFICE",
                                        onSaved: (value) {
                                          setState(() {
                                            postOffice = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "THANA",
                                        onSaved: (value) {
                                          setState(() {
                                            thana = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        maxlength: 6,
                                        textInputType: TextInputType.number,
                                        labeltext: "PINCODE",
                                        onSaved: (value) {
                                          setState(() {
                                            pincode = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    Text(
                                      "STATE",
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration:
                                          kSurveyFormContainerDecoration,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: _stateListResponse == null
                                            ? InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      ApiCall.postState().then(
                                                          (value) =>
                                                              setState(() {
                                                                _stateListResponse =
                                                                    value;
                                                                stateChange =
                                                                    true;
                                                                _districtListResponse =
                                                                    null;
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'Select State',
                                                  style: GoogleFonts.actor(
                                                    color: Colors.blue,
                                                    fontSize: 20,
                                                    // fontWeight: FontWeight.bold,
                                                    // fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              )
                                            : DropdownButton<String>(
                                                items: _stateListResponse.data
                                                    .map((value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value.name,
                                                    child: Text(
                                                      value.name,
                                                      style:
                                                          kheadingStyle.apply(
                                                        fontWeightDelta: 3,
                                                        fontSizeFactor: 1.2,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    this.selectedState = value;
                                                    this.selectedStateId =
                                                        stateId[selectedState];
                                                    this._districtListResponse =
                                                        null;
                                                    stateChange = true;
                                                    this.selectedDistrict =
                                                        null;
                                                    // print('State: ' + selectedState);
                                                    // print('StateId: ' + selectedStateId);
                                                  });
                                                },
                                                value: selectedState,
                                                hint: Text(
                                                  "Select State",
                                                  style: kheadingStyle.apply(
                                                    fontWeightDelta: 3,
                                                    fontSizeFactor: 1.2,
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      "DISTRICT",
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration:
                                          kSurveyFormContainerDecoration,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Padding(
                                        padding: (_districtListResponse == null)
                                            ? const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 16.0)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 16.0),
                                        child: _districtListResponse == null ||
                                                stateChange
                                            ? InkWell(
                                                onTap: () {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      ApiCall.postDistrict(
                                                              selectedStateId)
                                                          .then((value) =>
                                                              setState(() {
                                                                _districtListResponse =
                                                                    value;
                                                                stateChange =
                                                                    false;
                                                                Navigator.pop(
                                                                    context);
                                                              }));
                                                      return Align(
                                                        alignment:
                                                            Alignment.center,
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text(
                                                  'Select District',
                                                  style: kheadingStyle.apply(
                                                    fontWeightDelta: 3,
                                                    fontSizeFactor: 1.2,
                                                  ),
                                                ),
                                              )
                                            : _districtListResponse
                                                        .data.length ==
                                                    0
                                                ? DropdownButton<String>(
                                                    items: ['No District']
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: kheadingStyle
                                                              .apply(
                                                            fontWeightDelta: 3,
                                                            fontSizeFactor: 1.2,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        this.selectedDistrict =
                                                            value;
                                                      });
                                                    },
                                                    value: selectedDistrict,
                                                    hint: Text(
                                                      "Select District",
                                                      style:
                                                          kheadingStyle.apply(
                                                        fontWeightDelta: 3,
                                                        fontSizeFactor: 1.2,
                                                      ),
                                                    ),
                                                  )
                                                : DropdownButton<String>(
                                                    items: _districtListResponse
                                                        .data
                                                        .map((value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value.name,
                                                        child: Text(
                                                          value.name,
                                                          style: kheadingStyle
                                                              .apply(
                                                            fontWeightDelta: 3,
                                                            fontSizeFactor: 1.2,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        this.selectedDistrict =
                                                            value;
                                                      });
                                                    },
                                                    value: selectedDistrict,
                                                    hint: Text(
                                                      "Select District",
                                                      style: GoogleFonts.actor(
                                                          fontSize: 20,
                                                          color: Colors.blue
                                                          // fontWeight: FontWeight.bold,
                                                          ),
                                                    ),
                                                  ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        labeltext: "Occupation",
                                        // labeltext: "OCCUPATION",
                                        onSaved: (value) {
                                          setState(() {
                                            occupation = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    InputRegistration(
                                        maxlength: 10,
                                        labeltext: "MOBILE",
                                        textInputType: TextInputType.phone,
                                        onSaved: (value) {
                                          setState(() {
                                            mobile = value;
                                          });
                                        }),
                                    SizedBox(height: 30),
                                    Text(
                                      "IDENTITY DOCUMENT",
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      decoration:
                                          kSurveyFormContainerDecoration,
                                      margin: const EdgeInsets.only(
                                          top: 20, right: 10),
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: DropdownButton<String>(
                                          items: identityList.map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: kheadingStyle.apply(
                                                  fontWeightDelta: 3,
                                                  fontSizeFactor: 1.2,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              this.identity = value;
                                            });
                                          },
                                          value: identity,
                                          hint: Text(
                                            "Select Identity Document",
                                            style: kheadingStyle.apply(
                                              fontWeightDelta: 3,
                                              fontSizeFactor: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    InkWell(
                                      onTap: () => getImage(context),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Text(
                                              "UPLOAD DOCUMENT",
                                              style: kheadingStyle.apply(
                                                fontWeightDelta: 3,
                                                fontSizeFactor: 1.2,
                                              ),
                                            ),
                                            img64 == null
                                                ? Icon(
                                                    Icons.cloud_upload,
                                                    color: Color(0xff000000),
                                                  )
                                                : Icon(
                                                    Icons.check,
                                                    color: Color(0xff000000),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    GestureDetector(
                                      onTap: () async {
                                        if (_formKey.currentState.validate()) {
                                          _formKey.currentState.save();
                                          print(firstName +
                                              '\n' +
                                              lastName +
                                              '\n' +
                                              guardianName +
                                              '\n' +
                                              selectedDate.day.toString() +
                                              '/' +
                                              (selectedDate.month + 1)
                                                  .toString() +
                                              '/' +
                                              selectedDate.year.toString() +
                                              '\n' +
                                              country +
                                              '\n' +
                                              address1 +
                                              '\n' +
                                              village +
                                              '\n' +
                                              postOffice +
                                              '\n' +
                                              thana +
                                              '\n' +
                                              pincode +
                                              '\n' +
                                              selectedState +
                                              '\n' +
                                              selectedDistrict +
                                              '\n' +
                                              occupation +
                                              '\n' +
                                              identity +
                                              '\n' +
                                              img64);
                                          Dialogs.showLoadingDialog(
                                              context, _keyLoader);
                                          final signUpResponse =
                                              await ApiCall.postSignUp(
                                            firstName: firstName,
                                            lastName: lastName,
                                            gender: selectedGender,
                                            dob: selectedDate.day.toString() +
                                                '/' +
                                                (selectedDate.month + 1)
                                                    .toString() +
                                                '/' +
                                                selectedDate.year.toString(),
                                            fatherName: guardianName,
                                            address1: address1,
                                            village: village,
                                            postOffice: postOffice,
                                            thana: thana,
                                            country: country,
                                            state: selectedState,
                                            district: selectedDistrict,
                                            pincode: pincode,
                                            occupation: occupation,
                                            identity: identity,
                                            mobile: mobile,
                                            document:
                                                'data:image/jpg;base64,$img64',
                                          );
                                          if (signUpResponse == null) {
                                            CustomView.showInDialog(
                                                context, "Error", "Retry", () {
                                              Navigator.of(context).pop();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          } else if (signUpResponse.status ==
                                              null) {
                                            CustomView.showInDialog(
                                                context, "Error", "Retry", () {
                                              Navigator.of(context).pop();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          } else if (signUpResponse.status ==
                                              "api_error") {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Something is wrong at server end!",
                                                () {
                                              Navigator.of(context).pop();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          } else if (signUpResponse.status ==
                                              "error") {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Phone number already in use!",
                                                () {
                                              Navigator.of(context).pop();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          } else if (signUpResponse.status ==
                                              "validation_error") {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Some fields missing!", () {
                                              Navigator.of(context).pop();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                            });
                                          } else {
                                            if (signUpResponse.status ==
                                                "success") {
                                              print(signUpResponse.status);
                                              print("Otp is: " +
                                                  signUpResponse.otp
                                                      .toString());
                                              otp =
                                                  signUpResponse.otp.toString();
                                              Navigator.of(
                                                      _keyLoader.currentContext,
                                                      rootNavigator: true)
                                                  .pop();
                                              // Navigator.pushReplacementNamed(
                                              //     context, 'login');
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                // return LoginScreen();
                                                return VarifyOtp(
                                                    mobile: mobile, otp: otp);
                                              }));
                                              //IDHR SHOW kra de CUSTOMView DIalog for success.
                                            }
                                          }
                                          print(signUpResponse.status);
                                          print(signUpResponse.message);
                                          print(signUpResponse.data);
                                        }
                                        // Navigator.pushReplacement(context,
                                        //     MaterialPageRoute(builder: (context) {
                                        //   return LoginScreen();
                                        // }));
                                      },
                                      child: Card(
                                        elevation: 10,
                                        shape: BeveledRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Container(
                                          // margin: EdgeInsets.all(value),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.75,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 24.0, vertical: 16),
                                            child: Center(
                                              child: Text(
                                                "SUBMIT",
                                                style: GoogleFonts.roboto(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[900],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // image: DecorationImage(
                                            //     fit: BoxFit.fill,
                                            //     image:
                                            //         AssetImage('assets/images/ButtonBG.png')),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 4.0,
                              style: BorderStyle.solid,
                              color: Colors.transparent,
                            ),
                            gradient: LinearGradient(
                              colors: ksubBg,
                              begin: Alignment.topCenter,
                              end: Alignment.bottomRight,
                            ),
                            // image: DecorationImage(
                            //     fit: BoxFit.fill,
                            //     image:
                            //         AssetImage('assets/images/background.png')),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InputRegistration extends StatelessWidget {
  String labeltext;
  String initialValue;
  final onSaved;
  final onValidate;
  int maxlength;
  TextEditingController otpController;
  TextInputType textInputType;

  InputRegistration(
      {this.labeltext,
      this.onSaved,
      this.textInputType,
      this.onValidate,
      this.maxlength,
      this.initialValue,
      this.otpController});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                labeltext,
                textAlign: TextAlign.start,
                style: kheadingStyle.apply(
                  fontWeightDelta: 3,
                  fontSizeFactor: 1.2,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            decoration: kSurveyFormContainerDecoration,
            margin: const EdgeInsets.only(top: 20, right: 10),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 4,
              ),
              child: TextFormField(
                inputFormatters: [
                  new LengthLimitingTextInputFormatter(maxlength),
                ],
                controller: otpController,
                initialValue: initialValue,
                style: TextStyle(color: Color(0xff2d1f76), fontSize: 20.0),
                validator: onValidate,
                onSaved: onSaved,
                keyboardType:
                    textInputType == null ? TextInputType.text : textInputType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // new UnderlineInputBorder(
                  //   borderSide: new BorderSide(color: Color(0xff3469FA)),
                  // ),
                  // labelText: labeltext,
                  labelStyle: GoogleFonts.roboto(
                      color: Color(0xff819ffd),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width * 0.75,
    );
  }
}
