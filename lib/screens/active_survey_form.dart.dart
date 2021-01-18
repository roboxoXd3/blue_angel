import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/districtListResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/dynamic_survey_form.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// import 'common/active_survey.dart';

class ActiveSurveyForm extends StatefulWidget {
  final List surveyForm;
  final List products;
  final String surveyName;
  final String surveyId;
  final StateListResponse stateListResponse;
  final BannerResponse bannerResponse;
  final String token;
  final String bluAngel;

  const ActiveSurveyForm(
      {Key key,
      @required this.surveyForm,
      @required this.surveyName,
      @required this.products,
      @required this.surveyId,
      @required this.stateListResponse,
      @required this.bannerResponse,
        @required this.bluAngel,
        @required this.token
      })
      : super(key: key);
  @override
  _ActiveSurveyFormState createState() => _ActiveSurveyFormState();
}

class _ActiveSurveyFormState extends State<ActiveSurveyForm> {
  List _surveyForm, products;

  int _itemCount = 0;
  int top_nav;
  final format = DateFormat("yyyy/MM/dd");

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

  List<String> stateList = List();
  List<String> districtList = List();
  List<String> pincodeData = List();
  List<String> listData = List();
  List<String> idData = List();
  List surveyFields = List();

  String country;
  String fullName;
  String address;
  String village;
  String postOffice;
  String thana;
  String state;
  String district;
  String pincode;
  String mobileNumber;

  bool isLoading = true;

  List<String> countryList = List();
  List<int> bytes;
  // List listData;

  List blank;
  Map<String, Object> inputDoc = new HashMap();
  List<String> productList = List();
  String lng, lat;
  String img64;


  // Future<Map<String, String>> getDataFromSharedPreference() async {
  //   // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // // setState(() {
  //   // user_id= sharedPreferences.getString("user_id");
  //   // token = sharedPreferences.getString("accessToken");
  //   //
  //   // print("Body is :" + user_id);
  //   // print("Header is: " + token);
  //   // return {'body': user_id, 'header': token};
  // }



  void getcurrentLocation() async {
    final position = await GeolocatorPlatform.instance.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    print(position);

    setState(() {
      lng = position.longitude.toString();
      print(lng);
      lat = position.latitude.toString();
      print(lat);
    });
  }

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

  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
      top_nav = sharedPreferences.getInt("top_nav");
    });
  }

  String id;
  DistrictListResponse districtListResponse1 = DistrictListResponse();
  @override
  void initState() {
    getDataFromSharedPrefs();
    for (int i = 0; i < widget.stateListResponse.data.length; i++) {
      listData.add(widget.stateListResponse.data[i].name);
      idData.add(widget.stateListResponse.data[i].id);
      print('listData :  $listData');
    }



    getcurrentLocation();
    fullName = '';
    address = '';
    village = '';
    postOffice = '';
    thana = '';
    // state = '';
    // district = '';
    // pincode = '';
    mobileNumber = '';
    products = widget.products;
    _surveyForm = widget.surveyForm;
    print(_surveyForm.length);
    for (int i = 0; i < _surveyForm.length; i++) {
      print(_surveyForm[i].filedValue);
      print(_surveyForm);
    }

    countryList = <String>['INDIA'];
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
          appBar: CustomView.appBarCustom('Arrow-Icon-02', 'Bt-Close-01', () {
            // _scaffoldKey.currentState.openDrawer();
            Navigator.of(context).pop();
          }, () {
            // Navigator.of(context).pop();
          },
              isLeading: true,
              isAction: false,
              title: 'active survey form',
              top_nav: top_nav),
          body: Stack(
            children: [
              SingleChildScrollView(
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
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Survey Form',
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 5,
                                        fontSizeFactor: 1.5,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _image == null
                                            ? Container(
                                                // alignment: Alignment.topLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: AssetImage(
                                                      "assets/icons/Upload-Icon.png"),
                                                ),
                                              )
                                            : Container(
                                                // alignment: Alignment.topLeft,
                                                decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                ),
                                                child: CircleAvatar(
                                                  radius: 30.0,
                                                  backgroundImage: FileImage(
                                                    _image,
                                                  ),
                                                ),
                                              ),
                                        CustomView.button(
                                            buttonColor: Colors.blue[900],
                                            circularRadius: 10,
                                            buttonName: 'Upload picture',
                                            isCircular: true,
                                            height: 50,
                                            color: Colors.white,
                                            textSize: 15,
                                            width: 200,
                                            function: () async {
                                              getImage(context);
                                              print(_image.toString());
                                            }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'FULL NAME'.toUpperCase(),
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
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            fullName = input;
                                            inputDoc["fullName"] = fullName;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Address'.toUpperCase(),
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
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'LAST NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            address = input;
                                            inputDoc["address"] = address;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Village'.toUpperCase(),
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
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            village = input;
                                            inputDoc["village"] = village;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Post Office'.toUpperCase(),
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
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            postOffice = input;
                                            inputDoc["post_office"] =
                                                postOffice;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Thana'.toUpperCase(),
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
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            thana = input;
                                            inputDoc["thana"] = thana;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Country'.toUpperCase(),
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                  ),
                                  CustomView.buildDropDown(
                                    context: context,
                                    inputValue: country,
                                    list: countryList,
                                    text: 'Select country',
                                    onchanged: (String newValue) {
                                      setState(() {
                                        country = newValue;
                                        inputDoc["country"] = country;
                                        print(inputDoc);
                                      });
                                    },
                                    onTap: () {},
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'State'.toUpperCase(),
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                  ),
                                  CustomView.buildDropDown(
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
                                          inputDoc["state"] = state;
                                          if (districtList.isNotEmpty) {
                                            district = null;
                                            districtList.clear();

                                            // districtList = [];
                                          }
                                          // print(inputDoc);
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
                                              id = widget
                                                  .stateListResponse.data[i].id;

                                              // print(districtList);
                                            });
                                            print('id $id');
                                            final DistrictListResponse
                                                districtListResponse =
                                                await ApiCall.postDistrict(id);
                                            print(id);
                                            if (districtListResponse.status ==
                                                "success") {
                                              districtListResponse1 =
                                                  districtListResponse;
                                              // setState(() {});

                                              for (int i = 0;
                                                  i <
                                                      districtListResponse
                                                          .data.length;
                                                  i++) {
                                                setState(() {
                                                  // if (districtList.isEmpty) {
                                                  districtList.add(
                                                      districtListResponse
                                                          .data[i].name);
                                                  // }

                                                  // pincodeData.add(
                                                  //     districtListResponse.data[i].pincode);
                                                  // print(
                                                  //     'district : ${districtListResponse.data[i].name}');
                                                });
                                                // print('listData :  $districtList');
                                              }
                                            }

                                            // print('state : $state');
                                          }
                                        }
                                      },
                                      onTap: () async {
                                        // districtList.remove();
                                      }),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'DISTRICT'.toUpperCase(),
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                  ),
                                  CustomView.buildDropDown(
                                    context: context,
                                    inputValue: district,
                                    list: districtList.toSet().toList() == null
                                        ? ['Please Select State First']
                                        : districtList.toSet().toList(),
                                    text: 'Select district',
                                    onchanged: (String newValue) {
                                      setState(() {
                                        district = newValue;
                                        inputDoc["district"] = district;
                                        // print(inputDoc);
                                        // for (int i = 0;
                                        //     i < districtListResponse1.data.length;
                                        //     i++) {
                                        //   if (district ==
                                        //       districtListResponse1.data[i].name) {
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
                                    onTap: () async {},
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'PIN CODE'.toUpperCase(),
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
                                        maxLength: 6,
                                        color: Colors.red,
                                        keyborad: TextInputType.number,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            pincode = input.toString();
                                            inputDoc["pincode"] = pincode;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  // CustomView.buildDropDown(
                                  //   context: context,
                                  //   inputValue: pincode,
                                  //   list: pincodeData.toSet().toList() == null
                                  //       ? ['Please Select District First']
                                  //       : pincodeData.toSet().toList(),
                                  //   text: 'Select pincode',
                                  //   fn: (String newValue) {
                                  //     setState(() {
                                  //       pincode = newValue;
                                  //       inputDoc["pincode"] = pincode;
                                  //       print(inputDoc);
                                  //     });
                                  //   },
                                  //   fn1: () {},
                                  // ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'Mobile Number'.toUpperCase(),
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
                                        maxLength: 10,
                                        color: Colors.red,
                                        keyborad: TextInputType.number,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20,
                                        onChanged: (input) {
                                          setState(() {
                                            mobileNumber = input.toString();
                                            inputDoc["mobile_Number"] =
                                                mobileNumber;
                                            print(inputDoc);
                                          });
                                        }),
                                  ),
                                  Container(
                                      height: 200,
                                      margin: const EdgeInsets.only(
                                          top: 20, left: 20),
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: products.length,
                                          itemBuilder: (context, index) {
                                            // int itemIndex = 1;
                                            // int item=1;
                                            // int item = 1;
                                            // inputDoc["product"] = products[index].name;
                                            // productList.add(products[index].name);
                                            print(inputDoc);
                                            inputDoc["Product"] =
                                                products[index].name;
                                            inputDoc["qty"] = _itemCount.toString();
                                            print(inputDoc);
                                            return Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    'Products : ${products[index].name}',
                                                    style: kheadingStyle.apply(
                                                      fontWeightDelta: 3,
                                                      fontSizeFactor: 1.2,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          'Quantity  :'
                                                              .toUpperCase(),
                                                          style: kheadingStyle
                                                              .apply(
                                                            fontSizeFactor: 1.2,
                                                            fontWeightDelta: 3,
                                                          ),
                                                        ),
                                                      ),
                                                      // IconButton(
                                                      //     icon: Icon(
                                                      //       Icons
                                                      //           .add_circle_outline,
                                                      //       color: Colors
                                                      //           .blue[900],
                                                      //     ),
                                                      //     onPressed: () {
                                                      //       // int temp = item;
                                                      //       setState(() {
                                                      //         // item++;
                                                      //         // item = item;
                                                      //         inputDoc["qty"] =
                                                      //             item.toString();
                                                      //         print(inputDoc);
                                                      //       });
                                                      //     }),
                                                      // Container(
                                                      //   margin: EdgeInsets.only(
                                                      //     left: 2,
                                                      //     right: 2,
                                                      //   ),
                                                      //   child: Text(
                                                      //     item.toString(),
                                                      //     style: kheadingStyle
                                                      //         .apply(
                                                      //       fontWeightDelta: 3,
                                                      //       fontSizeFactor: 1.0,
                                                      //     ),
                                                      //   ),
                                                      // ),
                                                      // IconButton(
                                                      //     icon: Icon(
                                                      //       Icons
                                                      //           .remove_circle_outline,
                                                      //       color: Colors
                                                      //           .blue[900],
                                                      //     ),
                                                      //     onPressed: () {
                                                      //       int item=1;
                                                      //       if (item > 1) {
                                                      //         setState(() {
                                                      //           item--;
                                                      //           item = item;
                                                      //           inputDoc[
                                                      //                   "qty"] =
                                                      //               item.toString();
                                                      //           print(inputDoc);
                                                      //         });
                                                      //       }
                                                      //     }),
                                                      _itemCount!=0? new  IconButton(icon: new Icon(Icons.remove_circle),onPressed: ()=>setState(() {
                                                        _itemCount--;
                                                        setState(() {
                                                          inputDoc["qty"] = _itemCount.toString();
                                                        });
                                                      }),):new Container(),
                                                      new Text(_itemCount.toString()),
                                                      new IconButton(icon: new Icon(Icons.add_circle),onPressed: ()=>setState(() {
                                                        _itemCount++;
                                                       setState(() {
                                                         inputDoc["qty"] = _itemCount.toString();
                                                       });
                                                      }))
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          })),
                                  SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.bottomRight,
                        child: CustomView.button(
                          buttonColor: kfontColorBlue4,
                          buttonName: 'NEXT',
                          circularRadius: 30,
                          color: Colors.white,
                          function: () async {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            if (mobileController.text == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Mobile Number is Empty!",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (mobileController.text.length < 10) {
                              CustomView.showInDialog(context, "Error",
                                  "Mobile Number is atleast 10 digits", () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (firstNameController.text.isEmpty) {
                              CustomView.showInDialog(
                                  context, "Error", "Please fill full name",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (addressController.text.isEmpty) {
                              CustomView.showInDialog(
                                  context, "Error", "Please fill address", () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (villageController.text.isEmpty) {
                              CustomView.showInDialog(
                                  context, "Error", "Please fill village", () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (postOfficeController.text.isEmpty) {
                              CustomView.showInDialog(
                                  context, "Error", "Please fill post office",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (thanaController.text.isEmpty) {
                              CustomView.showInDialog(
                                  context, "Error", "Please fill thana", () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (country == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Please select country",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (state == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Please select state", () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (district == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Please select district",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (pincode == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Please select pincode",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            } else if (img64 == null) {
                              CustomView.showInDialog(
                                  context, "Error", "Please upload picture",
                                  () {
                                Navigator.of(context).pop();
                                setState(() {
                                  isLoading = !isLoading;
                                });
                              });
                            }
                            else {
                              setState(() {
                                isLoading = !isLoading;
                              });
                              final BannerResponse bannerResponse =
                                  await ApiCall.getBanner();
                              if (bannerResponse.status == "success") {
                                Navigator.of(context).push(

                                  MaterialPageRoute(
                                    builder: (context) => DynamicSurveyForm(
                                      bannerResponse: bannerResponse,
                                      surveyForm: widget.surveyForm,
                                      surveyName: widget.surveyName,
                                      inputDoc: inputDoc,
                                      surveyId: widget.surveyId,
                                      // userId: widget.bluAngel,
                                      // productList: productList,
                                      lng: lng.toString(),
                                      lat: lat.toString(),
                                      image: img64,
                                      // token: widget.token,
                                    ),
                                  ),
                                );
                              }
                              print(img64);
                              print(_image.path.split('/').last);
                            }
                          },
                          height: 50,
                          isCircular: true,
                          textSize: 20,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: !isLoading,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
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
          )),
    );
  }
}
