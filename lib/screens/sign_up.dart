import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/districtListResponse.dart';
import 'package:blue_angel/models/signUpResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/verifyResponse.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/screens/login_screen.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api_call.dart';
import 'package:image_picker/image_picker.dart'; // import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'dart:io' as Io;

class SignUp extends StatefulWidget {
  final StateListResponse stateListResponse;
  // final List listData;
  SignUp({@required this.stateListResponse});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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

  List signUpData;
  String response;
  bool isLoading;
  String otpData, statusData, message, mobile, tokenCall;

  final format = new DateFormat('dd/MM/yyyy');
  DistrictListResponse districtListResponse1 = DistrictListResponse();
  List<int> bytes;
  List<String> genderList = List();
  List<String> countryList = List();
  List<String> stateList = List();
  List<String> districtList = List();
  List<String> identityList = List();
  // var bytes;
  var base64String;
  String districtId;

  String gender;
  String country;
  String state;
  String district;
  String identity;

  String id, id1;
  List lng, lng1;
  String stripped;
  // FileType _pickingType;

  String firstName;
  String lastName;
  String dob;
  String fatherName;
  String address1;
  String village;
  String postOffice;
  String thana;
  String pincode;
  String occupation;
  // String mobile;
  File document;
  String paths;
  // bool isLoading;
  List<String> listData = List();
  List<String> idData = List();
  List<String> pincodeData = List();
  String addPincode;
  String img64;
  int user_type = 0;
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
                    var image = await ImagePicker().getImage(
                      source: ImageSource.camera,
                      imageQuality: 50,
                    );
                    // var image = await ImagePicker()
                    //     .getImage(source: ImageSource.camera);
                    setState(() {
                      // _image = image;
                      _image = File(image.path);
                      List<int> bytes = Io.File(_image.path).readAsBytesSync();
                      img64 = base64UrlEncode(bytes);
                      // var base64String =
                      //     base64UrlEncode(_image.readAsBytesSync());
                      // base64String = base64Encode(_image.readAsBytesSync());
                      // print('document $img64');
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

  @override
  void initState() {
    isLoading = false;
    for (int i = 0; i < widget.stateListResponse.data.length; i++) {
      listData.add(widget.stateListResponse.data[i].name);
      idData.add(widget.stateListResponse.data[i].id);
      print('listData :  $listData');
    }
    // ApiCall.getSwData();

    super.initState();
    // print("state is ${ApiCall.stateData}");
    // districtList = [''];
    genderList = <String>['Male', 'Female'];
    countryList = <String>['INDIA'];
    identityList = <String>[
      'VOTER ID',
      'PASSPORT',
      'BANK ACCOUNT NO.',
      'RATION CARD',
      'AADHAAR CARD',
      'DRIVING LICENSE',
      'PAN CARD',
    ];
    firstName = '';
    lastName = '';
    dob = '';
    fatherName = '';
    address1 = '';
    village = '';
    postOffice = '';
    thana = '';
    // pincode = '';
    occupation = '';
    mobile = '';
    // document = '';

    paths = '';
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: CustomView.buildContainerBackgroundImage(
            context: context,
            child: Stack(
              children: [
                ListView(
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
                            h: 120,
                            w: 110,
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
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20.0),
                                      child: Text(
                                        'REGISTRATION',
                                        style: kheadingStyle.apply(
                                            color: Color(0xff2b1f75),
                                            fontSizeFactor: 1.8,
                                            fontWeightDelta: 4),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        "FIRST NAME",
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: firstNameController,
                                          key: ValueKey('firstName'),
                                          fn: (input) {
                                            setState(() {
                                              firstName = input.toString();
                                              print('$firstName');
                                            });
                                          },
                                          color: Color(0xff2d1f76),
                                          keyborad: TextInputType.text,
                                          // labelText: 'NAME',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
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
                                        controller: lasttNameController,
                                        key: ValueKey('lastName'),
                                        fn: (input) {
                                          setState(() {
                                            lastName = input.toString();
                                            print('$lastName');
                                          });
                                        },
                                        color: Color(0xff004fc10),
                                        keyborad: TextInputType.text,
                                        // labelText: 'LAST NAME',
                                        lengthLimiting: 20,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'GENDER',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    CustomView.buildDropDown(
                                      key: ValueKey('gender'),
                                      context: context,
                                      inputValue: gender,
                                      list: genderList,
                                      text: 'Select gender',
                                      onchanged: (String newValue) {
                                        setState(() {
                                          gender = newValue.toString();
                                          print(gender);
                                        });
                                      },
                                      fn1: () {},
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6.0)),
                                        // border: Border.all(
                                        //     color: Colors.blue, width: 1),
                                      ),
                                      child: DateTimeField(
                                        key: ValueKey('dob'),
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 5,
                                          fontSizeFactor: 1.0,
                                          color: Color(0xff2d1f76),
                                        ),
                                        decoration: InputDecoration(
                                          suffixIcon: SizedBox(
                                            height: 20.0,
                                            width: 20.0,
                                            child: Image.asset(
                                              'assets/icons/Calender-Icon-01.png',
                                              fit: BoxFit.contain,
                                              height: 20.0,
                                              width: 20.0,
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
                                            dob = format.format(input);
                                            // dob = input.toString();
                                            print(dob);
                                          });
                                        },
                                        onShowPicker: (context, currentValue) {
                                          return showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime(2100));
                                        },
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'FATHER/HUSBAND NAME',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: fatherNameController,
                                          key: ValueKey('fatherName'),
                                          fn: (input) {
                                            setState(() {
                                              fatherName = input.toString();
                                              print(fatherName);
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'NAME',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'ADDRESS 1',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: addressController,
                                          key: ValueKey('address1'),
                                          fn: (input) {
                                            setState(() {
                                              address1 = input.toString();
                                              print('$address1');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'ADDRESS 1',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'VILLAGE',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: villageController,
                                          key: ValueKey('village'),
                                          fn: (input) {
                                            setState(() {
                                              village = input.toString();
                                              print('$village');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'VILLAGE',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'POST OFFICE',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: postOfficeController,
                                          key: ValueKey('postOffice'),
                                          fn: (input) {
                                            setState(() {
                                              postOffice = input.toString();
                                              print('$postOffice');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'POST OFFICE',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'THANA',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: thanaController,
                                          key: ValueKey('thana'),
                                          fn: (input) {
                                            setState(() {
                                              thana = input.toString();
                                              print('$thana');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'NAME',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'COUNTRY',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    CustomView.buildDropDown(
                                      key: ValueKey('country'),
                                      context: context,
                                      inputValue: country,
                                      list: countryList,
                                      text: 'Select country',
                                      onchanged: (String newValue) {
                                        setState(() {
                                          country = newValue;
                                          print(country);
                                        });
                                      },
                                      fn1: () {},
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'STATE',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    CustomView.buildDropDown(
                                        key: ValueKey('state'),
                                        context: context,
                                        inputValue: state,
                                        list: listData == null
                                            ? ['Select State']
                                            : listData,
                                        // list: widget.stateListResponse.data == null
                                        //     ? ['State']
                                        //     : widget.stateListResponse.data,
                                        text: 'Select state',
                                        onchanged: (String newValue) async {
                                          setState(() {
                                            state = newValue;
                                            print(state);
                                            if (districtList.isNotEmpty) {
                                              district = null;
                                              districtList.clear();

                                              // districtList = [];
                                            }
                                          });
                                          for (int i = 0;
                                              i <
                                                  widget.stateListResponse.data
                                                      .length;
                                              i++) {
                                            if (state ==
                                                widget.stateListResponse.data[i]
                                                    .name) {
                                              setState(() {
                                                id = widget.stateListResponse
                                                    .data[i].id;
                                              });
                                              print('id $id');
                                              print('state : $state');
                                              final DistrictListResponse
                                                  districtListResponse =
                                                  await ApiCall.postDistrict(
                                                      id);
                                              if (districtListResponse.status ==
                                                  "success") {
                                                for (int i = 0;
                                                    i <
                                                        districtListResponse
                                                            .data.length;
                                                    i++) {
                                                  setState(() {
                                                    districtListResponse1 =
                                                        districtListResponse;
                                                    districtList.add(
                                                        districtListResponse
                                                            .data[i].name);
                                                    // pincodeData.add(districtListResponse
                                                    //     .data[i].pincode);
                                                    print(
                                                        'district : ${districtListResponse.data[i].name}');
                                                  });
                                                  print(
                                                      'listData :  $districtList');
                                                }
                                              }
                                            }
                                          }
                                        },
                                        fn1: () async {}),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'DISTRICT',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    CustomView.buildDropDown(
                                      key: ValueKey('district'),
                                      context: context,
                                      inputValue: district,
                                      list:
                                          districtList.toSet().toList() == null
                                              ? ['Please Select State First']
                                              : districtList.toSet().toList(),
                                      text: 'Select district',
                                      onchanged: (String newValue) {
                                        setState(() {
                                          district = newValue;
                                          print(district);
                                          // for (int i = 0;
                                          //     i < districtListResponse1.data.length;
                                          //     i++) {
                                          //   if (district ==
                                          //       districtListResponse1
                                          //           .data[i].name) {
                                          //     pincodeData = districtListResponse1
                                          //         .data[i].pincode
                                          //         .split(",");
                                          //     // addPincode.split(",").toList()
                                          //     // pincodeData.add(addPincode);
                                          //     // addPincode.split(",").toList();
                                          //     print(pincodeData);
                                          //   }
                                          // }
                                        });
                                      },
                                      fn1: () async {},
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'PIN CODE',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: pincodeController,
                                          key: ValueKey('pincode'),
                                          maxLength: 6,
                                          fn: (input) {
                                            setState(() {
                                              pincode = input.toString();
                                              print(pincode);
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.number,
                                          // labelText: '+91-00000000',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'OCCUPATION',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: occupationController,
                                          key: ValueKey('occupation'),
                                          fn: (input) {
                                            setState(() {
                                              occupation = input.toString();
                                              print('$occupation');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'OCCUPATION',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'IDENTITY DOCUMENT',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    CustomView.buildDropDown(
                                        key: ValueKey('identity'),
                                        onchanged: (String newValue) {
                                          setState(() {
                                            identity = newValue;
                                            print(identity);
                                          });
                                        },
                                        fn1: () {},
                                        context: context,
                                        inputValue: identity,
                                        list: identityList,
                                        text: 'Select Identity'),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: Text(
                                        'UPLOAD DOCUMENT',
                                        style: kheadingStyle.apply(
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.2,
                                        ),
                                      ),
                                    ),
                                    Container(
                                        // alignment: Alignment.bottomRight,
                                        margin: const EdgeInsets.only(
                                          top: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        child: RaisedButton(
                                          color: Color(0xffbdd5f1),
                                          onPressed: () async {
                                            getImage(context);
                                          },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Upload',
                                                style: kheadingStyle.apply(
                                                  fontWeightDelta: 4,
                                                  fontSizeFactor: 1.2,
                                                  color: Color(0xff2d1f76),
                                                ),
                                              ),
                                              Container(
                                                height: 55,
                                                width: 55,
                                                child: Image.asset(
                                                    'assets/icons/Upload-Icon-01.png'),
                                              ),
                                            ],
                                          ),
                                        )),
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
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          controller: mobileController,
                                          key: ValueKey('mobile'),
                                          maxLength: 10,
                                          fn: (input) {
                                            setState(() {
                                              mobile = input.toString();
                                              print(mobile);
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.number,
                                          // labelText: '+91-00000000',
                                          lengthLimiting: 20),
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
                                      margin: const EdgeInsets.only(top: 20),
                                      child: CustomView.editTextField(
                                          key: ValueKey('otp'),
                                          fn: (input) {
                                            setState(() {
                                              otpData = input.toString();
                                              print('$otpData');
                                            });
                                          },
                                          color: Colors.red,
                                          keyborad: TextInputType.text,
                                          // labelText: 'OTP',
                                          lengthLimiting: 20),
                                    ),
                                    Container(
                                      // alignment: Alignment.bottomRight,
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: CustomView.button(
                                        circularRadius: 10,
                                        isCircular: true,
                                        buttonColor: Color(0xffb3e0f7),
                                        buttonName: 'GENERATE OTP',
                                        color: kfontColorBlue4,
                                        function: () async {
                                          print(firstNameController.text);
                                          print(lasttNameController.text);
                                          print(villageController.text);
                                          print(thanaController.text);
                                          print(mobileController.text);
                                          print(dobController.text);
                                          print(fatherNameController.text);
                                          print(gender);
                                          print(state);
                                          print(country);
                                          print(district);
                                          print(identity);
                                          print(occupationController.text);
                                          print(mobileController.text);
                                          print(pincode);
                                          print('image63 : $img64');

                                          if (firstNameController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "First Name is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (lasttNameController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Last Name is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (gender == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select gender!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (dobController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please fill Date of Birth!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (fatherNameController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Father Name is empty!", () {
                                              Navigator.of(context).pop();
                                            });
                                          } else if (addressController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Address is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (villageController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Village is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (postOfficeController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Post Office is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (thanaController
                                              .text.isEmpty) {
                                            CustomView.showInDialog(context,
                                                "Error", "thana is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (country == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select country", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (state == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select state!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (district == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select district!", () {
                                              Navigator.of(context).pop();
                                            });
                                          } else if (pincode == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Pincode is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (occupationController
                                                  .text ==
                                              null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Occupation is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (identity == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "identity is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (_image == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please upload document!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (mobileController.text ==
                                              null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Mobile Number is Empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else if (mobileController
                                                  .text.length <
                                              10) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Mobile Number is at least 10 digits!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = false;
                                              });
                                            });
                                          } else {
                                            setState(() {
                                              isLoading = true;
                                            });
                                            SignUpResponse signUpResponse =
                                                await ApiCall.postSignUp(
                                              // userType: user_type,
                                              firstName:
                                                  firstNameController.text,
                                              lastName:
                                                  lasttNameController.text,
                                              gender: gender,
                                              dob: dobController.text,
                                              fatherName:
                                                  fatherNameController.text,
                                              address1: addressController.text,
                                              village: villageController.text,
                                              postOffice:
                                                  postOfficeController.text,
                                              thana: thanaController.text,
                                              country: country,
                                              state: state,
                                              district: district,
                                              pincode: pincode.toString(),
                                              occupation:
                                                  occupationController.text,
                                              identity: identity,
                                              mobile: mobileController.text
                                                  .toString(),
                                              // image: _image,
                                              document:
                                                  'data:image/jpg;base64,$img64',
                                              // document:
                                              //     'data:image/jpeg;base64,$img64',
                                            );
                                            setState(() {
                                              isLoading = false;
                                            });
                                            if (signUpResponse == null) {
                                              CustomView.showInDialog(
                                                  context, "Error", "Retry",
                                                  () {
                                                Navigator.of(context).pop();
                                              });
                                            } else if (signUpResponse.status ==
                                                null) {
                                              CustomView.showInDialog(
                                                  context, "Error", "Retry",
                                                  () {
                                                Navigator.of(context).pop();
                                              });
                                            } else if (signUpResponse.status ==
                                                "api_error") {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Something is wrong at server end!",
                                                  () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            } else if (signUpResponse.status ==
                                                "error") {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Phone number already in use!",
                                                  () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            } else if (signUpResponse.status ==
                                                "validation_error") {
                                              CustomView.showInDialog(
                                                  context,
                                                  "Error",
                                                  "Some fields missing!", () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            } else {
                                              if (signUpResponse.status ==
                                                  "success") {
                                                print(signUpResponse.status);
                                                setState(() {
                                                  isLoading = false;
                                                  otpData = signUpResponse.otp
                                                      .toString();
                                                  print(otpData);
                                                  response =
                                                      signUpResponse.status;
                                                  // print("signupResponse of it is:"+ signUpResponse)
                                                });
                                              }
                                            }
                                          }
                                        },
                                        height: 50,
                                        width: 245,
                                        textSize: 20,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 20,
                                        left: 20,
                                        right: 20,
                                      ),
                                      child: CustomView.button(
                                        circularRadius: 10,
                                        isCircular: true,
                                        buttonColor: Color(0xff150bff),
                                        buttonName: 'SUBMIT',
                                        color: Colors.white,
                                        function: () async {
                                          if (mobile == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Mobile Number is Empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (firstName == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "First Name is  empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (mobile.length < 10) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Mobile Number is atleast 10 digits!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (lastName == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Last Name is  empty ", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (gender == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select gender!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (dob == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please fill Data of Birth!",
                                                () {
                                              Navigator.of(context).pop();
                                            });
                                          } else if (fatherName == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Father Name is empty! ", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (address1 == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Address is  empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (village == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Village is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (postOffice == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Post Office is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (thana == null) {
                                            CustomView.showInDialog(context,
                                                "Error", "thana is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (country == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select country!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (state == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select state!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (district == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please select district", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (pincode == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Pincode is empty", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (pincode.length < 6) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Pincode is at least 6 digits!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (occupation == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Occupation is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (identity == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "identity is empty!", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (_image == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please upload document", () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (otpData == null) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please generate otp first!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (otpData.length < 6) {
                                            CustomView.showInDialog(
                                                context,
                                                "Error",
                                                "Please fill at least 6 digits!",
                                                () {
                                              Navigator.of(context).pop();
                                              setState(() {
                                                isLoading = !isLoading;
                                              });
                                            });
                                          } else if (response == "success") {
                                            print("we successfully got in");
                                            VerifyResponse verifyResponse =
                                                await ApiCall.postVerify(
                                              mobileNumber: mobile,
                                              otp: otpData,
                                            );

                                            if (verifyResponse.status ==
                                                "success") {
                                              print(
                                                  "This is varify response+ ");
                                              print('otp is: $otpData');
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              sharedPreferences.setString(
                                                  "accessToken",
                                                  verifyResponse.token);
                                              sharedPreferences.setBool(
                                                  "isSigned", true);
                                              setState(() {
                                                isLoading = !isLoading;
                                                ApiCall.token =
                                                    verifyResponse.token;
                                                print(verifyResponse.token);
                                                ApiCall.tokenCall =
                                                    verifyResponse.result.id
                                                        .toString();
                                                print(verifyResponse.result.id
                                                    .toString());
                                                // print("User type is: " +
                                                //     verifyResponse
                                                //         .result.userType
                                                //         .toString());
                                                CustomView.firstName =
                                                    verifyResponse
                                                        .result.firstName;
                                                CustomView.lastName =
                                                    verifyResponse
                                                        .result.lastName;
                                                CustomView.dob =
                                                    verifyResponse.result.dob;
                                                CustomView.gender =
                                                    verifyResponse
                                                        .result.gender;
                                              });
                                              final BannerResponse
                                                  bannerResponse =
                                                  await ApiCall.getBanner();
                                              if (bannerResponse.status ==
                                                  "success") {
                                                setState(() {
                                                  isLoading = !isLoading;
                                                });
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginScreen(),
                                                    //     HomeScreen(
                                                    //   bannerResponse:
                                                    //       bannerResponse,
                                                    // ),
                                                  ),
                                                );
                                              }
                                            } else if (verifyResponse.status ==
                                                "validation_error") {
                                              print(verifyResponse.status);
                                              CustomView.showInDialog(context,
                                                  "Error", "Invalid otp!", () {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  isLoading = !isLoading;
                                                });
                                              });
                                            }
                                          }
                                        },
                                        height: 50,
                                        width: 245,
                                        textSize: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 100,
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
                Visibility(
                    visible: isLoading,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: CircularProgressIndicator()),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Text("Please wait..."))
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
