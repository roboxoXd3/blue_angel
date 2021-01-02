import 'dart:collection';

import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/models/surveySubmitResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/screens/surveyList.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' as Io;

import 'package:shared_preferences/shared_preferences.dart';

class DynamicSurveyForm extends StatefulWidget {
  final List surveyForm;
  final String surveyName;
  final Map<String, Object> inputDoc;
  final String surveyId;
  final BannerResponse bannerResponse;
  // final List<String> productList;
  final String lng;
  final String lat;
  final String image;

  const DynamicSurveyForm({
    Key key,
    @required this.surveyForm,
    @required this.surveyName,
    @required this.inputDoc,
    @required this.surveyId,
    @required this.bannerResponse,
    // @required this.productList,
    @required this.lng,
    @required this.lat,
    @required this.image,
  }) : super(key: key);
  @override
  _DynamicSurveyFormState createState() => _DynamicSurveyFormState();
}

class _DynamicSurveyFormState extends State<DynamicSurveyForm> {
  List<String> selectedItemValue = List<String>();
  int top_nav;
  // List _selecteCheckbox = List();
  List _surveyForm;
  String valueSelected;
  final format = DateFormat("yyyy-MM-dd");

  String country;
  List<String> countryList = List();
  List listData;
  String textArea, textBox;

  List blank;
  bool boolValue = true;

  Map store = Map();
  List<bool> inputs = new List<bool>();
  List<bool> inputs1 = new List<bool>();
  Map<String, bool> values = {
    '0': false,
    '1': false,
  };
  List checkList = List();
  // int _value2 = 0;
  int _value2;
  void lengthFind(int lengthGive) {
    for (int i = 0; i < lengthGive; i++) {
      setState(() {
        inputs.add(true);
      });
    }
  }

  void itemChange(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  Map<String, String> map = {};
  String newValue;
  // List<Map<String, Object>> listMap = [];
  List listMap = List();
  String img64;
  Map<String, dynamic> createDoc = new HashMap();
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  List<String> newValues;
  bool isLoading = true;
  @override
  void initState() {
    getDataFromSharedPrefs();
    boolValue = false;
    newValues = new List<String>();
    _surveyForm = widget.surveyForm;
    print(_surveyForm.length);
    for (int i = 0; i < _surveyForm.length; i++) {
      print(_surveyForm[i].filedValue);
      newValues.add("");
      print(_surveyForm);
    }

    countryList = <String>['INDIA'];
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('surveyList len => ' + _surveyForm.length.toString());
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
              title: widget.surveyName,
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
                          child: Container(
                            margin: const EdgeInsets.only(
                              bottom: 50,
                            ),
                            child: ListView.builder(
                              itemCount: _surveyForm.length,
                              itemBuilder: (context, index) {
                                // ignore: missing_return

                                print('in builder');
                                String name = _surveyForm[index].filedName;

                                print('in filedName');
                                List<String> comma =
                                    _surveyForm[index].filedValue.split(",");
                                if (newValues[index].isEmpty)
                                  newValues[index] = comma[0];
                                String type = _surveyForm[index].filedType;
                                print('in filedType');
                                var require = _surveyForm[index].filedRequired;
                                print('in filedRequired');
                                String fv = _surveyForm[index].filedValue;
                                print('in filedValue');
                                print('in formValuesComma');
                                print(
                                    'comma len => ' + comma.length.toString());
                                bool isNotNull = true;
                                if (type.toLowerCase() == "check box") {
                                  for (int i = 0; i < comma.length; i++) {
                                    // setState(() {
                                    checkList.add(false);
                                    // });
                                  }
                                  // lengthFind(comma.length);
                                  // ignore: missing_return
                                  return StatefulBuilder(
                                    builder: (con, updateState) {
                                      return Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          require.toString().toLowerCase() ==
                                                  "no"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name(Optional) :',
                                                    style: kheadingStyle.apply(
                                                      fontSizeFactor: 1.2,
                                                      fontWeightDelta: 5,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name :',
                                                    style: kheadingStyle.apply(
                                                      fontSizeFactor: 1.2,
                                                      fontWeightDelta: 5,
                                                    ),
                                                  ),
                                                ),
                                          for (int i = 0; i < comma.length; i++)
                                            // inputs.add(true),
                                            // ignore: missing_return
                                            Container(
                                              margin: const EdgeInsets.only(
                                                top: 8,
                                              ),
                                              child: CustomView.checkbox(
                                                comma[i],
                                                checkList[i],
                                                // values[i.toString()],
                                                (value) {
                                                  updateState(() {
                                                    checkList[i] = value;
                                                    print(checkList[i]);
                                                    createDoc["$name"] =
                                                        checkList[i];
                                                    print(createDoc);
                                                  });
                                                },
                                              ),
                                            )
                                        ],
                                      );
                                    },
                                  );
                                  // ignore: missing_return
                                } else if (type.toLowerCase() == "radio box") {
                                  return StatefulBuilder(
                                      builder: (con, updateState) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        require.toString().toLowerCase() == "no"
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20, left: 20),
                                                child: Text(
                                                  '$name(Optional) :',
                                                  style: kheadingStyle.apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 5,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20, left: 20),
                                                child: Text(
                                                  '$name :',
                                                  style: kheadingStyle.apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 5,
                                                  ),
                                                ),
                                              ),
                                        for (int i = 0; i < comma.length; i++)
                                          Container(
                                            margin:
                                                // ignore: missing_return
                                                const EdgeInsets.only(
                                                    top: 20, left: 20),
                                            child: Row(
                                              children: <Widget>[
                                                Radio(
                                                  activeColor: Colors.green,
                                                  toggleable: false,
                                                  onChanged: (int fn) {
                                                    updateState(() {
                                                      _value2 = fn;
                                                      // createDoc[name] =
                                                      //     comma[i].toString();
                                                      // listMap
                                                      //     .add(comma[i].toString());
                                                      // print(listMap);
                                                      createDoc["$name"] =
                                                          comma[i];
                                                      print(createDoc);
                                                    });
                                                  },
                                                  groupValue: _value2,
                                                  value: i,
                                                ),
                                                Text(
                                                  comma[i],
                                                  style: kheadingStyle.apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 5,
                                                  ),
                                                ),
                                                // Text(comma[i]),
                                              ],
                                            ),
                                          ),
                                      ],
                                    );
                                  });
                                  // }
                                  // ignore: missing_return
                                } else if (type.toLowerCase() == "select box") {
                                  for (int i = 0; i < comma.length; i++) {
                                    // ignore: missing_return
                                    selectedItemValue.add(comma[i]);
                                  }
                                  print('comma list => ' + comma.toString());
                                  return StatefulBuilder(
                                      builder: (con, updateState) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                              _surveyForm[index].filedName,
                                              style: kheadingStyle.apply(
                                                fontSizeFactor: 1.2,
                                                fontWeightDelta: 5,
                                              ),
                                            ),
                                          ),
                                          CustomView.buildDropDown(
                                            context: context,
                                            key: ValueKey('${newValue}'),
                                            inputValue: newValue,
                                            list: comma,
                                            fn: (value) {
                                              updateState(() {
                                                newValues[index] = value;
                                                createDoc[name] =
                                                    newValues[index].toString();
                                                print(createDoc[name]);
                                              });
                                            },
                                            text: newValues[index],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                                } else if (type.toLowerCase() == "text box") {
                                  // createDoc[name] = fv.toString();
                                  return StatefulBuilder(
                                    builder: (c, updateState) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          require.toString().toLowerCase() ==
                                                  "no"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name(Optional) :',
                                                    style: kheadingStyle.apply(
                                                      fontSizeFactor: 1.2,
                                                      fontWeightDelta: 5,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name :',
                                                    style: kheadingStyle.apply(
                                                      fontWeightDelta: 3,
                                                      fontSizeFactor: 1.2,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 20,
                                              left: 20,
                                            ),
                                            child: CustomView.editTextField(
                                                color: Color(0xff004fc10),
                                                keyborad: TextInputType.text,
                                                // labelText: 'LAST NAME',
                                                lengthLimiting: 20,
                                                // height: 50,
                                                fn: (input) {
                                                  updateState(() {
                                                    textBox = input.toString();
                                                    // createDoc["name1"] = name;
                                                    createDoc["$name"] =
                                                        textBox;
                                                    print(createDoc);
                                                    // listMap.add(textBox);
                                                    // print(listMap);
                                                  });
                                                }),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  // }
                                } else if (type.toLowerCase() == "text area" &&
                                    fv.isNotEmpty) {
                                  // print(createDoc);
                                  // if (require.toString().toLowerCase() == "yes"
                                  //     ? isNotNull
                                  //     : !isNotNull)
                                  return StatefulBuilder(
                                    builder: (c, updateState) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          require.toString().toLowerCase() ==
                                                  "no"
                                              ? Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name (Optional)',
                                                    style: kheadingStyle.apply(
                                                      fontWeightDelta: 3,
                                                      fontSizeFactor: 1.2,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20, left: 20),
                                                  child: Text(
                                                    '$name :',
                                                    style: kheadingStyle.apply(
                                                      fontWeightDelta: 3,
                                                      fontSizeFactor: 1.2,
                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                              top: 20,
                                              left: 20,
                                            ),
                                            child: CustomView.editTextField(
                                                color: Color(0xff004fc10),
                                                keyborad: TextInputType.text,
                                                // labelText: 'LAST NAME',
                                                lengthLimiting: 20,
                                                // height: 50,
                                                fn: (input) {
                                                  updateState(() {
                                                    textArea = input.toString();
                                                    // createDoc["name"] = name;
                                                    createDoc["$name"] =
                                                        textArea;
                                                    // listMap.add(textArea);
                                                    // print(listMap);
                                                    print(createDoc);
                                                  });
                                                }),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.bottomRight,
                        child: CustomView.button(
                          buttonColor: kfontColorBlue4,
                          buttonName: 'SUBMIT',
                          circularRadius: 30,
                          color: Colors.white,
                          height: 50,
                          isCircular: true,
                          textSize: 20,
                          width: 150,
                          function: () async {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            final SurveySubmitResponse submitResponse =
                                await ApiCall.getSurveySubmit(
                              surveyId: widget.surveyId,
                              fullName: widget.inputDoc["fullName"],
                              address: widget.inputDoc["address"],
                              village: widget.inputDoc["village"],
                              postOffice: widget.inputDoc["post_office"],
                              thana: widget.inputDoc["thana"],
                              country: widget.inputDoc["country"],
                              district: widget.inputDoc["district"],
                              state: widget.inputDoc["state"],
                              mobileNumber: widget.inputDoc["mobile_Number"],
                              pincode: widget.inputDoc["pincode"],
                              products: widget.inputDoc["Product"],
                              qty: widget.inputDoc["qty"],
                              formData: createDoc,
                              image: 'data:image/jpg;base64,${widget.image}',
                              lat: widget.lat,
                              lng: widget.lng,
                            );
                            if (submitResponse.status == "success") {
                              print(submitResponse.status);
                              SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.setString(
                                  "accessToken", submitResponse.token);
                              setState(() {
                                ApiCall.token = submitResponse.token;
                              });

                              final SurveyListResponse surveyListResponse =
                                  await ApiCall.getSurveyList();
                              final BannerResponse bannerResponse =
                                  await ApiCall.getBanner();
                              if (surveyListResponse.status == "success" &&
                                  bannerResponse.status == "success") {
                                setState(() {
                                  ApiCall.token = surveyListResponse.token;
                                });
                                CustomView.showInDialog(
                                    context, submitResponse.message, '',
                                    () async {
                                  setState(() {
                                    isLoading = !isLoading;
                                  });
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) => SurveyList(
                                              bannerResponse: bannerResponse,
                                              surveyListResponse:
                                                  surveyListResponse,
                                            )),
                                  );
                                });
                              }
                            } else if (submitResponse.status == null) {
                              print('null');
                            }
                          },
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
