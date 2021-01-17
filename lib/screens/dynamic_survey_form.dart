// import 'dart:collection';
//
// import 'package:blue_angel/models/Survey/submitSurvey.dart';
// import 'package:blue_angel/models/bannerResponse.dart';
// import 'package:blue_angel/models/surveyListResponse.dart';
// import 'package:blue_angel/models/surveySubmitResponse.dart';
// import 'package:blue_angel/network/api_call.dart';
// import 'package:blue_angel/screens/common/HomeScreen.dart';
// import 'package:blue_angel/screens/surveyList.dart';
// import 'package:blue_angel/utlis/values/styles.dart';
// import 'package:blue_angel/widgets/custom_view.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:io' as Io;
//
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:toast/toast.dart';
//
// class DynamicSurveyForm extends StatefulWidget {
//   final List surveyForm;
//   final String surveyName;
//   final Map<String, Object> inputDoc;
//   final String surveyId;
//   final BannerResponse bannerResponse;
//   // final List<String> productList;
//   final String lng;
//   final String lat;
//   final String image;
//   final String token;
//
//   const DynamicSurveyForm({
//     Key key,
//     @required this.surveyForm,
//     @required this.surveyName,
//     @required this.inputDoc,
//     @required this.surveyId,
//     @required this.bannerResponse,
//     // @required this.productList,
//     @required this.lng,
//     @required this.lat,
//     @required this.image,
//     @required this.token
//   }) : super(key: key);
//   @override
//   _DynamicSurveyFormState createState() => _DynamicSurveyFormState();
// }
//
// class _DynamicSurveyFormState extends State<DynamicSurveyForm> {
//   final GlobalKey<State> _keyLoader = new GlobalKey<State>();
//   List<String> selectedItemValue = List<String>();
//   int top_nav;
//   // List _selecteCheckbox = List();
//   List _surveyForm;
//   String valueSelected;
//   final format = DateFormat("yyyy-MM-dd");
//
//   String country;
//   List<String> countryList = List();
//   List listData;
//   String textArea, textBox;
//
//   List blank;
//   bool boolValue = true;
//
//   Map store = Map();
//   List<bool> inputs = new List<bool>();
//   List<bool> inputs1 = new List<bool>();
//   Map<String, bool> values = {
//     '0': false,
//     '1': false,
//   };
//   List checkList = List();
//   // int _value2 = 0;
//   int _value2;
//   void lengthFind(int lengthGive) {
//     for (int i = 0; i < lengthGive; i++) {
//       setState(() {
//         inputs.add(true);
//       });
//     }
//   }
//
//   void itemChange(bool val, int index) {
//     setState(() {
//       inputs[index] = val;
//     });
//   }
//
//   Map<String, String> map = {};
//   String newValue;
//   List ValueForkeys = [];
//   List KeysForValues = [];
//   // List<Map<String, Object>> listMap = [];
//   List listMap = List();
//   String img64;
//   Map<String, dynamic> createDoc = new HashMap();
//   String accessToken = ' ';
//   String userId= ' ';
//   getDataFromSharedPrefs() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       accessToken = sharedPreferences.getString("access_token");
//       userId = sharedPreferences.get("user_id");
//     });
//   }
//
//   List<String> newValues;
//   bool isLoading = true;
//   @override
//   void initState() {
//     getDataFromSharedPrefs();
//     boolValue = false;
//     newValues = new List<String>();
//     print("Static data are: "+ widget.inputDoc.toString());
//     for(int i =0;i< widget.inputDoc.length; i++)
//       {
//         ValueForkeys.add(widget.inputDoc.values.elementAt(i));
//       }
//     for(int i =0;i<ValueForkeys.length;i++)
//       {
//         print(''' $i is ${ValueForkeys[i]} ''');
//       }
//     print("Survey id is: " +widget.surveyId);
//     print("Token is: " +widget.token);
//     _surveyForm = widget.surveyForm;
//     print(_surveyForm.length);
//     for (int i = 0; i < _surveyForm.length; i++) {
//       print(_surveyForm[i].filedValue);
//       newValues.add("");
//       print(_surveyForm);
//     }
//
//     countryList = <String>['INDIA'];
//     String ss = widget.bannerResponse.data.top_nav;
//     String s = "0xff" + ss.substring(1);
//     top_nav = int.parse(s);
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('surveyList len => ' + _surveyForm.length.toString());
//     print("User id is: " + userId);
//     return IgnorePointer(
//       ignoring: !isLoading,
//       child: Scaffold(
//           appBar: CustomView.appBarCustom('Arrow-Icon-02', 'Bt-Close-01', () {
//             // _scaffoldKey.currentState.openDrawer();
//             Navigator.of(context).pop();
//           }, () {
//             // Navigator.of(context).pop();
//           },
//               isLeading: true,
//               isAction: false,
//               title: widget.surveyName,
//               top_nav: top_nav),
//           body: Stack(
//             children: [
//               SingleChildScrollView(
//                 child: CustomView.buildContainerBackgroundImage(
//                   context: context,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       CustomView.buildContainerWithImage(
//                         h: 50,
//                         w: 200,
//                         imagePath: 'assets/images/LogoWithMascot-01.png',
//                       ),
//                       CustomView.buildContainerCardUI(
//                         h: MediaQuery.of(context).size.height / 2.8,
//                         w: MediaQuery.of(context).size.width / 10,
//                         color: Colors.transparent,
//                         context: context,
//                         child: Card(
//                           elevation: 10,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                               side: BorderSide(
//                                 width: 4.0,
//                                 style: BorderStyle.solid,
//                                 color: Colors.white,
//                               )),
//                           shadowColor: Colors.black87,
//                           borderOnForeground: true,
//                           clipBehavior: Clip.antiAlias,
//                           child: Container(
//                             margin: const EdgeInsets.only(
//                               bottom: 50,
//                             ),
//                             child: ListView.builder(
//                               itemCount: _surveyForm.length,
//                               itemBuilder: (context, index) {
//                                 // ignore: missing_return
//
//                                 print('in builder');
//                                 String name = _surveyForm[index].filedName;
//
//                                 print('in filedName');
//                                 List<String> comma =
//                                     _surveyForm[index].filedValue.split(",");
//                                 if (newValues[index].isEmpty)
//                                   newValues[index] = comma[0];
//                                 String type = _surveyForm[index].filedType;
//                                 print('in filedType');
//                                 var require = _surveyForm[index].filedRequired;
//                                 print('in filedRequired');
//                                 String fv = _surveyForm[index].filedValue;
//                                 print('in filedValue');
//                                 print('in formValuesComma');
//                                 print(
//                                     'comma len => ' + comma.length.toString());
//                                 bool isNotNull = true;
//                                 if (type.toLowerCase() == "check box") {
//                                   for (int i = 0; i < comma.length; i++) {
//                                     // setState(() {
//                                     checkList.add(false);
//                                     // });
//                                   }
//                                   // lengthFind(comma.length);
//                                   // ignore: missing_return
//                                   return StatefulBuilder(
//                                     builder: (con, updateState) {
//                                       return Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         mainAxisAlignment: MainAxisAlignment.start,
//                                         children: [
//                                           require.toString().toLowerCase() ==
//                                                   "no"
//                                               ? Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name(Optional) :'.toUpperCase(),
//                                                     style: kheadingStyle.apply(
//                                                       fontSizeFactor: 1.2,
//                                                       fontWeightDelta: 5,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name :'.toUpperCase(),
//                                                     style: kheadingStyle.apply(
//                                                       fontSizeFactor: 1.2,
//                                                       fontWeightDelta: 5,
//                                                     ),
//                                                   ),
//                                                 ),
//                                           for (int i = 0; i < comma.length; i++)
//                                             // inputs.add(true),
//                                             // ignore: missing_return
//                                             Container(
//                                               margin: const EdgeInsets.only(
//                                                 top: 8,
//                                               ),
//                                               child: CustomView.checkbox(
//                                                 comma[i],
//                                                 checkList[i],
//                                                 // values[i.toString()],
//                                                 (value) {
//                                                   updateState(() {
//                                                     checkList[i] = value;
//                                                     print(checkList[i]);
//                                                     createDoc["$name"] =
//                                                         checkList[i];
//                                                     print(createDoc);
//                                                   });
//                                                 },
//                                               ),
//                                             )
//                                         ],
//                                       );
//                                     },
//                                   );
//                                   // ignore: missing_return
//                                 } else if (type.toLowerCase() == "radio box") {
//                                   return StatefulBuilder(
//                                       builder: (con, updateState) {
//                                     return Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.start,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         require.toString().toLowerCase() == "no"
//                                             ? Container(
//                                                 margin: const EdgeInsets.only(
//                                                     top: 20, left: 20),
//                                                 child: Text(
//                                                   '$name(Optional) :',
//                                                   style: kheadingStyle.apply(
//                                                     fontSizeFactor: 1.2,
//                                                     fontWeightDelta: 5,
//                                                   ),
//                                                 ),
//                                               )
//                                             : Container(
//                                                 margin: const EdgeInsets.only(
//                                                     top: 20, left: 20),
//                                                 child: Text(
//                                                   '$name :',
//                                                   style: kheadingStyle.apply(
//                                                     fontSizeFactor: 1.2,
//                                                     fontWeightDelta: 5,
//                                                   ),
//                                                 ),
//                                               ),
//                                         for (int i = 0; i < comma.length; i++)
//                                           Container(
//                                             margin:
//                                                 // ignore: missing_return
//                                                 const EdgeInsets.only(
//                                                     top: 20, left: 20),
//                                             child: Row(
//                                               children: <Widget>[
//                                                 Radio(
//                                                   activeColor: Colors.green,
//                                                   toggleable: false,
//                                                   onChanged: (int fn) {
//                                                     updateState(() {
//                                                       _value2 = fn;
//
//                                                       createDoc["$name"] =
//                                                           comma[i];
//                                                       print(createDoc);
//                                                     });
//                                                   },
//                                                   groupValue: _value2,
//                                                   value: i,
//                                                 ),
//                                                 Text(
//                                                   comma[i],
//                                                   style: kheadingStyle.apply(
//                                                     fontSizeFactor: 1.2,
//                                                     fontWeightDelta: 5,
//                                                   ),
//                                                 ),
//                                                 // Text(comma[i]),
//                                               ],
//                                             ),
//                                           ),
//                                       ],
//                                     );
//                                   });
//                                   // }
//                                   // ignore: missing_return
//                                 } else if (type.toLowerCase() == "select box") {
//                                   for (int i = 0; i < comma.length; i++) {
//                                     // ignore: missing_return
//                                     selectedItemValue.add(comma[i]);
//                                   }
//                                   print('comma list => ' + comma.toString());
//                                   return StatefulBuilder(
//                                       builder: (con, updateState) {
//                                     return Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 10.0),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             child: Text(
//                                               _surveyForm[index].filedName,
//                                               style: kheadingStyle.apply(
//                                                 fontSizeFactor: 1.2,
//                                                 fontWeightDelta: 5,
//                                               ),
//                                             ),
//                                           ),
//                                           CustomView.buildDropDown(
//                                             context: context,
//                                             key: ValueKey('${newValue}'),
//                                             inputValue: newValue,
//                                             list: comma,
//                                             fn: (value) {
//                                               updateState(() {
//                                                 newValues[index] = value;
//                                                 createDoc[name] =
//                                                     newValues[index].toString();
//                                                 print(createDoc[name]);
//                                               });
//                                             },
//                                             text: newValues[index],
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   });
//                                 } else if (type.toLowerCase() == "text box") {
//                                   // createDoc[name] = fv.toString();
//                                   return StatefulBuilder(
//                                     builder: (c, updateState) {
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           require.toString().toLowerCase() ==
//                                                   "no"
//                                               ? Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name(Optional) :',
//                                                     style: kheadingStyle.apply(
//                                                       fontSizeFactor: 1.2,
//                                                       fontWeightDelta: 5,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name :',
//                                                     style: kheadingStyle.apply(
//                                                       fontWeightDelta: 3,
//                                                       fontSizeFactor: 1.2,
//                                                     ),
//                                                     softWrap: true,
//                                                   ),
//                                                 ),
//                                           Container(
//                                             margin: const EdgeInsets.only(
//                                               top: 20,
//                                               left: 20,
//                                             ),
//                                             child: CustomView.editTextField(
//                                                 color: Color(0xff004fc10),
//                                                 keyborad: TextInputType.text,
//                                                 // labelText: 'LAST NAME',
//                                                 lengthLimiting: 20,
//                                                 // height: 50,
//                                                 fn: (input) {
//                                                   updateState(() {
//                                                     textBox = input.toString();
//                                                     // createDoc["name1"] = name;
//                                                     createDoc["$name"] =
//                                                         textBox;
//                                                     print(createDoc);
//                                                     // listMap.add(textBox);
//                                                     // print(listMap);
//                                                   });
//                                                 }),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                   // }
//                                 }
//
//                                 {
//
//                                   return StatefulBuilder(
//                                     builder: (c, updateState) {
//                                       return Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.start,
//                                         children: [
//                                           require.toString().toLowerCase() ==
//                                                   "no"
//                                               ? Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name (Optional)',
//                                                     style: kheadingStyle.apply(
//                                                       fontWeightDelta: 3,
//                                                       fontSizeFactor: 1.2,
//                                                     ),
//                                                   ),
//                                                 )
//                                               : Container(
//                                                   margin: const EdgeInsets.only(
//                                                       top: 20, left: 20),
//                                                   child: Text(
//                                                     '$name :',
//                                                     style: kheadingStyle.apply(
//                                                       fontWeightDelta: 3,
//                                                       fontSizeFactor: 1.2,
//                                                     ),
//                                                     softWrap: true,
//                                                   ),
//                                                 ),
//                                           Container(
//                                             margin: const EdgeInsets.only(
//                                               top: 20,
//                                               left: 20,
//                                             ),
//                                             child: CustomView.editTextField(
//                                                 color: Color(0xff004fc10),
//                                                 keyborad: TextInputType.text,
//                                                 // labelText: 'LAST NAME',
//                                                 lengthLimiting: 20,
//                                                 // height: 50,
//                                                 fn: (input) {
//                                                   updateState(() {
//                                                     textArea = input.toString();
//                                                     // createDoc["name"] = name;
//                                                     createDoc["$name"] =
//                                                         textArea;
//                                                     // listMap.add(textArea);
//                                                     // print(listMap);
//                                                     print(createDoc);
//                                                   });
//                                                 }),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.only(right: 20),
//                         alignment: Alignment.bottomRight,
//                         child: CustomView.button(
//                           buttonColor: kfontColorBlue4,
//                           buttonName: 'SUBMIT',
//                           circularRadius: 30,
//                           color: Colors.white,
//                           height: 50,
//                           isCircular: true,
//                           textSize: 20,
//                           width: 150,
//                           function: () async {
//                             setState(() {
//                               isLoading = !isLoading;
//                             });
//                             print("Dynamic form data is: " + createDoc.toString());
//                             // print("Form values are: ");
//                             List dynamicDocValue = [];
//                             List dynamicDocKey = [];
//                             for(int i =0;i< createDoc.length; i++)
//                             {
//                               dynamicDocValue.add(createDoc.values.elementAt(i));
//                               dynamicDocKey.add(createDoc.keys.elementAt(i));
//                             }
//                             print("Form Data is: ");
//                             for(int i =0;i<dynamicDocValue.length;i++)
//                             {
//                               print(''' ${dynamicDocKey[i]} is ${dynamicDocValue[i]} ''');
//                             }
//
//                             for(int i =0;i< widget.inputDoc.length; i++)
//                             {
//                               ValueForkeys.add(widget.inputDoc.values.elementAt(i));
//                               KeysForValues.add(widget.inputDoc.keys.elementAt(i));
//                             }
//
//                             for(int i =0;i<ValueForkeys.length;i++)
//                             {
//                               print(''' ${KeysForValues[i]} is ${ValueForkeys[i]} ''');
//                             }
//
//
//
//                             // final SurveySubmitResponse submitResponse =
//                             //     await ApiCall.getSurveySubmit(
//                             //       accesstoken: accessToken,
//                             //       blue_angel: userId,
//                             //   surveyId: widget.surveyId.toString(),
//                             //   fullName: widget.inputDoc["fullName"],
//                             //   address: widget.inputDoc["address"],
//                             //   village: widget.inputDoc["village"],
//                             //   postOffice: widget.inputDoc["post_office"],
//                             //   thana: widget.inputDoc["thana"],
//                             //   country: widget.inputDoc["country"],
//                             //   district: widget.inputDoc["district"],
//                             //   state: widget.inputDoc["state"],
//                             //   mobileNumber: widget.inputDoc["mobile_Number"],
//                             //   pincode: widget.inputDoc["pincode"],
//                             //   products: widget.inputDoc["Product"],
//                             //   qty: widget.inputDoc["qty"],
//                             //   formData: createDoc,
//                             //   image: 'data:image/jpg;base64,${widget.image}',
//                             //   lat: widget.lat,
//                             //   lng: widget.lng,
//                             // );
//                             // if (submitResponse.status == "success") {
//                             //   print(submitResponse.status);
//                             //   SharedPreferences sharedPreferences =
//                             //       await SharedPreferences.getInstance();
//                             //   sharedPreferences.setString(
//                             //       "accessToken", submitResponse.token);
//                             //   setState(() {
//                             //     ApiCall.token = submitResponse.token;
//                             //   });
//                             //
//                             //   final SurveyListResponse surveyListResponse =
//                             //       await ApiCall.getSurveyList();
//                               final BannerResponse bannerResponse =
//                                   await ApiCall.getBanner();
//                             //   if (surveyListResponse.status == "success" &&
//                             //       bannerResponse.status == "success") {
//                             //     setState(() {
//                             //       ApiCall.token = surveyListResponse.token;
//                             //     });
//                             //     CustomView.showInDialog(
//                             //         context, submitResponse.message, '',
//                             //         () async {
//                             //       setState(() {
//                             //         isLoading = !isLoading;
//                             //       });
//                             //       Navigator.of(context).push(
//                             //         MaterialPageRoute(
//                             //             builder: (context) => SurveyList(
//                             //                   bannerResponse: bannerResponse,
//                             //                   surveyListResponse:
//                             //                       surveyListResponse,
//                             //                 )),
//                             //       );
//                                 // });
//                             //   }
//                             // } else if (submitResponse.status == null) {
//                             //   print('null');
//                             //   setState(() {
//                             //     isLoading = false;
//                             //   });
//                             // }
//                             // else {
//                             //   setState(() {
//                             //     isLoading = false;
//                             //   });
//                             //   print("Submit failure messages are");
//                             //   print(submitResponse.status + submitResponse.message);
//                             // }
//
//
//                             // submitSurevy(
//                             //   token: accessToken,
//                             //   surveyid: widget.surveyId,
//                             //   // productid: _surveyFo,
//                             //   // productid: "5f46814711bfc11e2ce29071",
//                             //   userid: userId,
//                             //   // qntity: "10",
//                             //   full_name: widget.inputDoc["full_name"],
//                             //   address: widget.inputDoc["address"],
//                             //   village: widget.inputDoc["village"],
//                             //   postOffice: widget.inputDoc["post_office"],
//                             //   thana: widget.inputDoc["thana"],
//                             //   country: widget.inputDoc["country"],
//                             //   district: widget.inputDoc["district"],
//                             //   state: widget.inputDoc["state"],
//                             //   mobile: widget.inputDoc["mobile"],
//                             //   pincode: widget.inputDoc["pincode"],
//                             //   formData: createDoc,
//                             //   image: widget.image,
//                             //   lal: widget.lat,
//                             //   long: widget.lng,
//                             //   gender: widget.inputDoc["gender"],
//                             // );
//
//                             submitSurevy(
//                               token: accessToken,
//                               surveyid: widget.surveyId,
//                               // productid: _surveyFo,
//                               productid: "5f46814711bfc11e2ce29071",
//                               userid: userId,
//                               qntity: "10",
//                               full_name: widget.inputDoc["full_name"],
//                               address: widget.inputDoc["address"],
//                               village: widget.inputDoc["village"],
//                               postOffice: widget.inputDoc["post_office"],
//                               thana: widget.inputDoc["thana"],
//                               country: widget.inputDoc["country"],
//                               district: widget.inputDoc["district"],
//                               state: widget.inputDoc["state"],
//                               mobile: widget.inputDoc["mobile"],
//                               pincode: widget.inputDoc["pincode"],
//                               formData: {"Gender":"Male", "Color": "Red"},
//                               image: widget.image,
//                               lal: widget.lat,
//                               long: widget.lng,
//                               // gender: widget.inputDoc["gender"],
//                             ).then((value) {
//                               if (value.status == 'success') {
//                                 setState(() {
//                                   Navigator.of(_keyLoader.currentContext,
//                                       rootNavigator: true)
//                                       .pop();
//                                 });
//                                 // Navigator.of(context)
//                                 //     .pushReplacementNamed('homescreen');
//                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
//                                   return HomeScreen(bannerResponse: bannerResponse,);
//                                 }));
//                                 Toast.show(value.message, context);
//                               } else {
//                                 Toast.show(value.message, context);
//                               }
//                             });
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Visibility(
//                   visible: !isLoading,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.all(Radius.circular(16))),
//                       margin: EdgeInsets.symmetric(horizontal: 16),
//                       height: MediaQuery.of(context).size.height * 0.15,
//                       width: MediaQuery.of(context).size.width,
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 16),
//                               child: CircularProgressIndicator()),
//                           Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 16),
//                               child: Text("Please wait..."))
//                         ],
//                       ),
//                     ),
//                   ))
//             ],
//           )),
//     );
//   }
// }

import 'dart:collection';

import 'package:blue_angel/models/Survey/submitSurvey.dart';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/CicularProgressBar.dart';
import 'package:blue_angel/widgets/Dialog.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:io' as Io;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class DynamicSurveyForm extends StatefulWidget {
  final List surveyForm;
  final String surveyName;
  final Map<String, Object> inputDoc;
  final String surveyId;

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
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // List _selecteCheckbox = List();
  List _surveyForm;
  String valueSelected;
  String selectedDropDown = '';
  bool isImp = false;
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
  String userId = ' ';

  // List<Map<String, Object>> listMap = [];
  List listMap = List();
  String img64;
  Map<String, dynamic> createDoc = new HashMap();
  Map<String, bool> valueRequired = new Map<String, bool>();
  String accessToken = ' ';

  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("Usertoken");
      userId = sharedPreferences.getString("UserId");
    });
  }

  List<String> newValues;

  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  // bool isLoading = true;
  @override
  void initState() {
    print("image is:" + widget.image);
    getDataFromSharedPrefs();
    print("Fetched Data inputDoc => " + widget.inputDoc.toString());
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('surveyList len => ' + _surveyForm.length.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.surveyName),
          //     () {
          //   // _scaffoldKey.currentState.openDrawer();
          //   Navigator.of(context).pop();
          // },
          //     () {
          //   // Navigator.of(context).pop();
          // },
          // isLeading: true,
          // isAction: false,
          // title: widget.surveyName,
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                          itemCount: _surveyForm.length,
                          itemBuilder: (context, index) {
                            print('in builder');
                            String name = _surveyForm[index].filedName;
                            if (_surveyForm[index]
                                    .filedRequired
                                    .toLowerCase() ==
                                "yes") {
                              valueRequired[name] = false;
                              print(name + ' inserted into valueRequired map');
                            }
                            // List requiredfield = new List();
                            // for (int i = 0; i < _surveyForm.length; i++) {
                            //   if (_surveyForm[index].filedRequired) {
                            //     requiredfield.add(_surveyForm[index].filedName);
                            //   }
                            // }
                            // requiredfield.forEach((element) {
                            //   valueRequired["$element"] = false;
                            // });

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
                            print('comma len => ' + comma.length.toString());

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
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      require.toString().toLowerCase() == "no"
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  top: 20, left: 20),
                                              child: Text(
                                                '$name(Optional) :'
                                                    .toUpperCase(),
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
                                                '$name :'.toUpperCase(),
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
                                              top: 8, left: 8),
                                          child: require
                                                      .toString()
                                                      .toLowerCase() ==
                                                  "no"
                                              ? CustomView.checkbox(
                                                  comma[i],
                                                  checkList[i],
                                                  // values[i.toString()],
                                                  (value) {
                                                    updateState(() {
                                                      checkList[i] = value;
                                                      print(checkList[i]);

                                                      createDoc["$name"] =
                                                          comma[i];
                                                      print(createDoc);
                                                    });
                                                  },
                                                )
                                              : CustomView.checkbox(
                                                  comma[i],
                                                  checkList[i],
                                                  // values[i.toString()],

                                                  (value) {
                                                    updateState(() {
                                                      checkList[i] = value;
                                                      print(checkList[i]);
                                                      valueRequired["$name"] =
                                                          true;
                                                      createDoc["$name"] =
                                                          comma[i];
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    require.toString().toLowerCase() == "no"
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                                top: 8, left: 8),
                                            child: Text(
                                              '$name(Optional) :'.toUpperCase(),
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
                                              '$name :'.toUpperCase(),
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
                                                top: 8, left: 8),
                                        child: Row(
                                          children: <Widget>[
                                            (require.toString().toLowerCase() ==
                                                    "no")
                                                ? Radio(
                                                    activeColor: Colors.green,
                                                    toggleable: false,
                                                    onChanged: (int fn) {
                                                      updateState(() {
                                                        _value2 = fn;
                                                        // valueRequired["$name"] = comma[i];
                                                        createDoc["$name"] =
                                                            comma[i];
                                                        print(createDoc);
                                                      });
                                                    },
                                                    groupValue: _value2,
                                                    value: i,
                                                  )
                                                : Radio(
                                                    activeColor: Colors.green,
                                                    toggleable: false,
                                                    onChanged: (int fn) {
                                                      updateState(() {
                                                        _value2 = fn;
                                                        valueRequired["$name"] =
                                                            true;
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
                                      (require.toString().toLowerCase() == "no")
                                          ? Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _surveyForm[index]
                                                          .filedName
                                                          .toString()
                                                          .toUpperCase() +
                                                      "Optional :",
                                                  style: kheadingStyle.apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 5,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  _surveyForm[index]
                                                          .filedName
                                                          .toString()
                                                          .toUpperCase() +
                                                      " :",
                                                  style: kheadingStyle.apply(
                                                    fontSizeFactor: 1.2,
                                                    fontWeightDelta: 5,
                                                  ),
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      (require.toString().toLowerCase() == "no")
                                          ? CustomView.buildDropDown(
                                              context: context,
                                              key: ValueKey('${newValue}'),
                                              inputValue: newValue,
                                              list: comma,
                                              fn: (value) {
                                                updateState(() {
                                                  newValues[index] = value;
                                                  createDoc[name] =
                                                      newValues[index]
                                                          .toString();

                                                  print(createDoc[name]);
                                                });
                                              },
                                              text: newValues[index],
                                            )
                                          : CustomView.buildDropDown(
                                              context: context,
                                              key: ValueKey('${newValue}'),
                                              inputValue: newValue,
                                              list: comma,
                                              fn: (value) {
                                                updateState(() {
                                                  newValues[index] = value;
                                                  createDoc[name] =
                                                      newValues[index]
                                                          .toString();
                                                  valueRequired["$name"] = true;
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
                              return Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  require.toString().toLowerCase() == "no"
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20),
                                          child: Text(
                                            '$name(Optional) :'.toUpperCase(),
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
                                            '$name :'.toUpperCase(),
                                            style: kheadingStyle.apply(
                                              fontSizeFactor: 1.2,
                                              fontWeightDelta: 5,
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  StatefulBuilder(builder: (con, updateState) {
                                    return (require.toString().toLowerCase() ==
                                            "no")
                                        ? CustomView.editTextField(
                                            color: Color(0xff004fc10),
                                            keyborad: TextInputType.text,
                                            // labelText: 'LAST NAME',
                                            lengthLimiting: 20,
                                            // height: 50,
                                            fn: (input) {
                                              updateState(() {
                                                textBox = input.toString();
                                                // createDoc["name1"] = name;
                                                createDoc["$name"] = textBox;
                                                print(createDoc);
                                                // listMap.add(textBox);
                                                // print(listMap);
                                              });
                                            })
                                        : CustomView.editTextField(
                                            color: Color(0xff004fc10),
                                            keyborad: TextInputType.text,
                                            // labelText: 'LAST NAME',
                                            lengthLimiting: 20,
                                            fn: (input) {
                                              updateState(() {
                                                textBox = input.toString();
                                                // createDoc["name1"] = name;
                                                createDoc["$name"] = textBox;
                                                valueRequired["$name"] = true;
                                                print(createDoc);
                                                // listMap.add(textBox);
                                                // print(listMap);
                                              });
                                            });
                                  })
                                ],
                              ));
                            } else {
                              return Container(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  require.toString().toLowerCase() == "no"
                                      ? Container(
                                          margin: const EdgeInsets.only(
                                              top: 20, left: 20),
                                          child: Text(
                                            '$name(Optional) :'.toUpperCase(),
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
                                            '$name :'.toUpperCase(),
                                            style: kheadingStyle.apply(
                                              fontSizeFactor: 1.2,
                                              fontWeightDelta: 5,
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  StatefulBuilder(builder: (con, updateState) {
                                    return (require.toString().toLowerCase() ==
                                            "no")
                                        ? CustomView.editTextField(
                                            color: Color(0xff004fc10),
                                            keyborad: TextInputType.text,
                                            // labelText: 'LAST NAME',
                                            lengthLimiting: 20,
                                            // height: 50,

                                            fn: (input) {
                                              updateState(() {
                                                textArea = input.toString();
                                                // createDoc["name1"] = name;
                                                createDoc["$name"] = textArea;
                                                print(createDoc);
                                                // listMap.add(textBox);
                                                // print(listMap);
                                              });
                                            })
                                        : CustomView.editTextField(
                                            color: Color(0xff004fc10),
                                            keyborad: TextInputType.text,
                                            // labelText: 'LAST NAME',
                                            lengthLimiting: 20,
                                            // height: 50,

                                            fn: (input) {
                                              updateState(() {
                                                textArea = input.toString();
                                                // createDoc["name1"] = name;
                                                createDoc["$name"] = textArea;
                                                valueRequired["$name"] = true;
                                                print(createDoc);
                                                // listMap.add(textBox);
                                                // print(listMap);
                                              });
                                            });
                                  })
                                ],
                              ));
                            }
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      alignment: Alignment.bottomRight,
                      child: CustomView.button(
                        buttonColor: Colors.blue[900],
                        buttonName: 'SUBMIT',
                        circularRadius: 30,
                        color: Colors.white,
                        height: 50,
                        isCircular: true,
                        textSize: 20,
                        width: 150,
                        function: () async {
                          // if(_formKey.currentState.validate())
                          // {
                          //   _formKey.currentState.save();
                          // setState(() {
                          //   isLoading = !isLoading;
                          // });

                          setState(() {
                            // Dialogs.showLoadingDialog(context, _keyLoader);
                            visible = true;
                          });
                          print("Create doc is " + createDoc.toString());
                          print("Value required map is: " +
                              valueRequired.toString());
                          String leftFields = ' ';

                          valueRequired.forEach((key, value) {
                            if (value == false) {
                              setState(() {
                                leftFields = "$leftFields " + key + ",";
                              });
                            }
                          });

                          if (leftFields == ' ') {
                            submitSurevy(
                              // context,
                              // token: accessToken,
                              surveyid: widget.surveyId,
                              product: widget.inputDoc["Product"],

                              qntity: widget.inputDoc["qty"],
                              full_name: widget.inputDoc["fullName"],
                              address: widget.inputDoc["address"],
                              village: widget.inputDoc["village"],
                              postOffice: widget.inputDoc["post_office"],
                              thana: widget.inputDoc["thana"],
                              country: widget.inputDoc["country"],
                              district: widget.inputDoc["district"],
                              state: widget.inputDoc["state"],
                              mobile: widget.inputDoc["mobile_Number"],
                              pincode: widget.inputDoc["pincode"],
                              formData: createDoc,
                              image: widget.image,
                              lal: widget.lat,
                              long: widget.lng,
                              // gender: widget.inputDoc["gender"],
                            ).then((value) async {
                              if (value.status == 'success') {
                                setState(() {
                                  loadProgress();
                                });
                                // setState(() {
                                //   Navigator.of(_keyLoader.currentContext,
                                //           rootNavigator: true)
                                //       .pop();
                                //   // CicularIndicator(

                                // });
                                final BannerResponse bannerResponse =
                                    await ApiCall.getBanner();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return HomeScreen(
                                      bannerResponse: bannerResponse);
                                }));
                                Toast.show(value.message, context);
                              } else {
                                setState(() {
                                  loadProgress();
                                });
                                // setState(() {
                                //   Navigator.of(_keyLoader.currentContext,
                                //           rootNavigator: true)
                                //       .pop();
                                //   // CicularIndicator(
                                //   //   visible: false,
                                //   // );
                                // });
                                Toast.show(value.message, context);
                              }
                            });
                          } else {
                            setState(() {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text: "$leftFields".toUpperCase(),
                                  title: "Mandatory Fields",
                                  onConfirmBtnTap: () {
                                    loadProgress();
                                    Navigator.of(context).pop();
                                  });
                              print("Empty fields are $leftFields");
                            });
                          }

                          // }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Center(
              child: Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: visible,
                  child: Card(
                    elevation: 10,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        height: 200,
                        width: 200,
                        margin: EdgeInsets.only(top: 50, bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                                backgroundColor: Colors.blue),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Loading..",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            )
                          ],
                        )),
                  )),
            ),
          ],
        ));

    // return IgnorePointer(
    //   ignoring: !isLoading,
    //   child: Scaffold(
    //       appBar: AppBar(
    //         title: Text(widget.surveyName),
    //         //     () {
    //         //   // _scaffoldKey.currentState.openDrawer();
    //         //   Navigator.of(context).pop();
    //         // },
    //         //     () {
    //         //   // Navigator.of(context).pop();
    //         // },
    //         // isLeading: true,
    //         // isAction: false,
    //         // title: widget.surveyName,
    //       ),
    //       body: Form(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: <Widget>[
    //             Expanded(
    //               child: Container(
    //                 child: ListView.builder(
    //                     itemCount: _surveyForm.length,
    //                     itemBuilder: (context, index) {
    //                       print('in builder');
    //                       String name = _surveyForm[index].filedName;
    //                       if (_surveyForm[index].filedRequired.toLowerCase() ==
    //                           "yes") {
    //                         valueRequired[name] = false;
    //                         print(name + ' inserted into valueRequired map');
    //                       }
    //                       // List requiredfield = new List();
    //                       // for (int i = 0; i < _surveyForm.length; i++) {
    //                       //   if (_surveyForm[index].filedRequired) {
    //                       //     requiredfield.add(_surveyForm[index].filedName);
    //                       //   }
    //                       // }
    //                       // requiredfield.forEach((element) {
    //                       //   valueRequired["$element"] = false;
    //                       // });

    //                       print('in filedName');
    //                       List<String> comma =
    //                           _surveyForm[index].filedValue.split(",");
    //                       if (newValues[index].isEmpty)
    //                         newValues[index] = comma[0];
    //                       String type = _surveyForm[index].filedType;
    //                       print('in filedType');
    //                       var require = _surveyForm[index].filedRequired;
    //                       print('in filedRequired');
    //                       String fv = _surveyForm[index].filedValue;
    //                       print('in filedValue');
    //                       print('in formValuesComma');
    //                       print('comma len => ' + comma.length.toString());

    //                       if (type.toLowerCase() == "check box") {
    //                         for (int i = 0; i < comma.length; i++) {
    //                           // setState(() {
    //                           checkList.add(false);
    //                           // });
    //                         }
    //                         // lengthFind(comma.length);
    //                         // ignore: missing_return
    //                         return StatefulBuilder(
    //                           builder: (con, updateState) {
    //                             return Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 require.toString().toLowerCase() == "no"
    //                                     ? Container(
    //                                         margin: const EdgeInsets.only(
    //                                             top: 20, left: 20),
    //                                         child: Text(
    //                                           '$name(Optional) :'.toUpperCase(),
    //                                           style: kheadingStyle.apply(
    //                                             fontSizeFactor: 1.2,
    //                                             fontWeightDelta: 5,
    //                                           ),
    //                                         ),
    //                                       )
    //                                     : Container(
    //                                         margin: const EdgeInsets.only(
    //                                             top: 20, left: 20),
    //                                         child: Text(
    //                                           '$name :'.toUpperCase(),
    //                                           style: kheadingStyle.apply(
    //                                             fontSizeFactor: 1.2,
    //                                             fontWeightDelta: 5,
    //                                           ),
    //                                         ),
    //                                       ),
    //                                 for (int i = 0; i < comma.length; i++)
    //                                   // inputs.add(true),
    //                                   // ignore: missing_return
    //                                   Container(
    //                                     margin: const EdgeInsets.only(
    //                                         top: 8, left: 8),
    //                                     child:
    //                                         require.toString().toLowerCase() ==
    //                                                 "no"
    //                                             ? CustomView.checkbox(
    //                                                 comma[i],
    //                                                 checkList[i],
    //                                                 // values[i.toString()],
    //                                                 (value) {
    //                                                   updateState(() {
    //                                                     checkList[i] = value;
    //                                                     print(checkList[i]);

    //                                                     createDoc["$name"] =
    //                                                         comma[i];
    //                                                     print(createDoc);
    //                                                   });
    //                                                 },
    //                                               )
    //                                             : CustomView.checkbox(
    //                                                 comma[i],
    //                                                 checkList[i],
    //                                                 // values[i.toString()],

    //                                                 (value) {
    //                                                   updateState(() {
    //                                                     checkList[i] = value;
    //                                                     print(checkList[i]);
    //                                                     valueRequired["$name"] =
    //                                                         true;
    //                                                     createDoc["$name"] =
    //                                                         comma[i];
    //                                                     print(createDoc);
    //                                                   });
    //                                                 },
    //                                               ),
    //                                   )
    //                               ],
    //                             );
    //                           },
    //                         );
    //                         // ignore: missing_return
    //                       } else if (type.toLowerCase() == "radio box") {
    //                         return StatefulBuilder(builder: (con, updateState) {
    //                           return Column(
    //                             mainAxisAlignment: MainAxisAlignment.start,
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               require.toString().toLowerCase() == "no"
    //                                   ? Container(
    //                                       margin: const EdgeInsets.only(
    //                                           top: 8, left: 8),
    //                                       child: Text(
    //                                         '$name(Optional) :'.toUpperCase(),
    //                                         style: kheadingStyle.apply(
    //                                           fontSizeFactor: 1.2,
    //                                           fontWeightDelta: 5,
    //                                         ),
    //                                       ),
    //                                     )
    //                                   : Container(
    //                                       margin: const EdgeInsets.only(
    //                                           top: 20, left: 20),
    //                                       child: Text(
    //                                         '$name :'.toUpperCase(),
    //                                         style: kheadingStyle.apply(
    //                                           fontSizeFactor: 1.2,
    //                                           fontWeightDelta: 5,
    //                                         ),
    //                                       ),
    //                                     ),
    //                               for (int i = 0; i < comma.length; i++)
    //                                 Container(
    //                                   margin:
    //                                       // ignore: missing_return
    //                                       const EdgeInsets.only(
    //                                           top: 8, left: 8),
    //                                   child: Row(
    //                                     children: <Widget>[
    //                                       (require.toString().toLowerCase() ==
    //                                               "no")
    //                                           ? Radio(
    //                                               activeColor: Colors.green,
    //                                               toggleable: false,
    //                                               onChanged: (int fn) {
    //                                                 updateState(() {
    //                                                   _value2 = fn;
    //                                                   // valueRequired["$name"] = comma[i];
    //                                                   createDoc["$name"] =
    //                                                       comma[i];
    //                                                   print(createDoc);
    //                                                 });
    //                                               },
    //                                               groupValue: _value2,
    //                                               value: i,
    //                                             )
    //                                           : Radio(
    //                                               activeColor: Colors.green,
    //                                               toggleable: false,
    //                                               onChanged: (int fn) {
    //                                                 updateState(() {
    //                                                   _value2 = fn;
    //                                                   valueRequired["$name"] =
    //                                                       true;
    //                                                   createDoc["$name"] =
    //                                                       comma[i];
    //                                                   print(createDoc);
    //                                                 });
    //                                               },
    //                                               groupValue: _value2,
    //                                               value: i,
    //                                             ),
    //                                       Text(
    //                                         comma[i],
    //                                         style: kheadingStyle.apply(
    //                                           fontSizeFactor: 1.2,
    //                                           fontWeightDelta: 5,
    //                                         ),
    //                                       ),
    //                                       // Text(comma[i]),
    //                                     ],
    //                                   ),
    //                                 ),
    //                             ],
    //                           );
    //                         });
    //                         // }
    //                         // ignore: missing_return
    //                       } else if (type.toLowerCase() == "select box") {
    //                         for (int i = 0; i < comma.length; i++) {
    //                           // ignore: missing_return
    //                           selectedItemValue.add(comma[i]);
    //                         }
    //                         print('comma list => ' + comma.toString());
    //                         return StatefulBuilder(builder: (con, updateState) {
    //                           return Padding(
    //                             padding: const EdgeInsets.symmetric(
    //                                 horizontal: 10.0),
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 (require.toString().toLowerCase() == "no")
    //                                     ? Container(
    //                                         child: Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(8.0),
    //                                           child: Text(
    //                                             _surveyForm[index]
    //                                                     .filedName
    //                                                     .toString()
    //                                                     .toUpperCase() +
    //                                                 "Optional :",
    //                                             style: kheadingStyle.apply(
    //                                               fontSizeFactor: 1.2,
    //                                               fontWeightDelta: 5,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       )
    //                                     : Container(
    //                                         child: Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(8.0),
    //                                           child: Text(
    //                                             _surveyForm[index]
    //                                                     .filedName
    //                                                     .toString()
    //                                                     .toUpperCase() +
    //                                                 " :",
    //                                             style: kheadingStyle.apply(
    //                                               fontSizeFactor: 1.2,
    //                                               fontWeightDelta: 5,
    //                                             ),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 (require.toString().toLowerCase() == "no")
    //                                     ? CustomView.buildDropDown(
    //                                         context: context,
    //                                         key: ValueKey('${newValue}'),
    //                                         inputValue: newValue,
    //                                         list: comma,
    //                                         fn: (value) {
    //                                           updateState(() {
    //                                             newValues[index] = value;
    //                                             createDoc[name] =
    //                                                 newValues[index].toString();

    //                                             print(createDoc[name]);
    //                                           });
    //                                         },
    //                                         text: newValues[index],
    //                                       )
    //                                     : CustomView.buildDropDown(
    //                                         context: context,
    //                                         key: ValueKey('${newValue}'),
    //                                         inputValue: newValue,
    //                                         list: comma,
    //                                         fn: (value) {
    //                                           updateState(() {
    //                                             newValues[index] = value;
    //                                             createDoc[name] =
    //                                                 newValues[index].toString();
    //                                             valueRequired["$name"] = true;
    //                                             print(createDoc[name]);
    //                                           });
    //                                         },
    //                                         text: newValues[index],
    //                                       ),
    //                               ],
    //                             ),
    //                           );
    //                         });
    //                       } else if (type.toLowerCase() == "text box") {
    //                         return Container(
    //                             child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             require.toString().toLowerCase() == "no"
    //                                 ? Container(
    //                                     margin: const EdgeInsets.only(
    //                                         top: 20, left: 20),
    //                                     child: Text(
    //                                       '$name(Optional) :'.toUpperCase(),
    //                                       style: kheadingStyle.apply(
    //                                         fontSizeFactor: 1.2,
    //                                         fontWeightDelta: 5,
    //                                       ),
    //                                     ),
    //                                   )
    //                                 : Container(
    //                                     margin: const EdgeInsets.only(
    //                                         top: 20, left: 20),
    //                                     child: Text(
    //                                       '$name :'.toUpperCase(),
    //                                       style: kheadingStyle.apply(
    //                                         fontSizeFactor: 1.2,
    //                                         fontWeightDelta: 5,
    //                                       ),
    //                                     ),
    //                                   ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             StatefulBuilder(builder: (con, updateState) {
    //                               return (require.toString().toLowerCase() ==
    //                                       "no")
    //                                   ? CustomView.editTextField(
    //                                       color: Color(0xff004fc10),
    //                                       keyborad: TextInputType.text,
    //                                       // labelText: 'LAST NAME',
    //                                       lengthLimiting: 20,
    //                                       // height: 50,
    //                                       fn: (input) {
    //                                         updateState(() {
    //                                           textBox = input.toString();
    //                                           // createDoc["name1"] = name;
    //                                           createDoc["$name"] = textBox;
    //                                           print(createDoc);
    //                                           // listMap.add(textBox);
    //                                           // print(listMap);
    //                                         });
    //                                       })
    //                                   : CustomView.editTextField(
    //                                       color: Color(0xff004fc10),
    //                                       keyborad: TextInputType.text,
    //                                       // labelText: 'LAST NAME',
    //                                       lengthLimiting: 20,
    //                                       fn: (input) {
    //                                         updateState(() {
    //                                           textBox = input.toString();
    //                                           // createDoc["name1"] = name;
    //                                           createDoc["$name"] = textBox;
    //                                           valueRequired["$name"] = true;
    //                                           print(createDoc);
    //                                           // listMap.add(textBox);
    //                                           // print(listMap);
    //                                         });
    //                                       });
    //                             })
    //                           ],
    //                         ));
    //                       } else {
    //                         return Container(
    //                             child: Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           mainAxisAlignment: MainAxisAlignment.start,
    //                           children: [
    //                             require.toString().toLowerCase() == "no"
    //                                 ? Container(
    //                                     margin: const EdgeInsets.only(
    //                                         top: 20, left: 20),
    //                                     child: Text(
    //                                       '$name(Optional) :'.toUpperCase(),
    //                                       style: kheadingStyle.apply(
    //                                         fontSizeFactor: 1.2,
    //                                         fontWeightDelta: 5,
    //                                       ),
    //                                     ),
    //                                   )
    //                                 : Container(
    //                                     margin: const EdgeInsets.only(
    //                                         top: 20, left: 20),
    //                                     child: Text(
    //                                       '$name :'.toUpperCase(),
    //                                       style: kheadingStyle.apply(
    //                                         fontSizeFactor: 1.2,
    //                                         fontWeightDelta: 5,
    //                                       ),
    //                                     ),
    //                                   ),
    //                             SizedBox(
    //                               height: 10,
    //                             ),
    //                             StatefulBuilder(builder: (con, updateState) {
    //                               return (require.toString().toLowerCase() ==
    //                                       "no")
    //                                   ? CustomView.editTextField(
    //                                       color: Color(0xff004fc10),
    //                                       keyborad: TextInputType.text,
    //                                       // labelText: 'LAST NAME',
    //                                       lengthLimiting: 20,
    //                                       // height: 50,

    //                                       fn: (input) {
    //                                         updateState(() {
    //                                           textArea = input.toString();
    //                                           // createDoc["name1"] = name;
    //                                           createDoc["$name"] = textArea;
    //                                           print(createDoc);
    //                                           // listMap.add(textBox);
    //                                           // print(listMap);
    //                                         });
    //                                       })
    //                                   : CustomView.editTextField(
    //                                       color: Color(0xff004fc10),
    //                                       keyborad: TextInputType.text,
    //                                       // labelText: 'LAST NAME',
    //                                       lengthLimiting: 20,
    //                                       // height: 50,

    //                                       fn: (input) {
    //                                         updateState(() {
    //                                           textArea = input.toString();
    //                                           // createDoc["name1"] = name;
    //                                           createDoc["$name"] = textArea;
    //                                           valueRequired["$name"] = true;
    //                                           print(createDoc);
    //                                           // listMap.add(textBox);
    //                                           // print(listMap);
    //                                         });
    //                                       });
    //                             })
    //                           ],
    //                         ));
    //                       }
    //                     }),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Container(
    //                 margin: const EdgeInsets.only(right: 20),
    //                 alignment: Alignment.bottomRight,
    //                 child: CustomView.button(
    //                   buttonColor: Colors.blue[900],
    //                   buttonName: 'SUBMIT',
    //                   circularRadius: 30,
    //                   color: Colors.white,
    //                   height: 50,
    //                   isCircular: true,
    //                   textSize: 20,
    //                   width: 150,
    //                   function: () async {
    //                     // if(_formKey.currentState.validate())
    //                     // {
    //                     //   _formKey.currentState.save();
    //                     // setState(() {
    //                     //   isLoading = !isLoading;
    //                     // });

    //                     setState(() {
    //                       Dialogs.showLoadingDialog(context, _keyLoader);
    //                     });
    //                     print("Create doc is " + createDoc.toString());
    //                     print("Value required map is: " +
    //                         valueRequired.toString());
    //                     String leftFields = ' ';

    //                     valueRequired.forEach((key, value) {
    //                       if (value == false) {
    //                         setState(() {
    //                           leftFields = "$leftFields ," + key;
    //                         });
    //                       }
    //                     });

    //                     if (leftFields == ' ') {
    //                       submitSurevy(
    //                         // token: accessToken,
    //                         surveyid: widget.surveyId,
    //                         product: widget.inputDoc["Product"],
    //                         // productid: _surveyFo,
    //                         // productid: "5f46814711bfc11e2ce29071",
    //                         // userid: userId,
    //                         qntity: widget.inputDoc["qty"],
    //                         full_name: widget.inputDoc["fullName"],
    //                         address: widget.inputDoc["address"],
    //                         village: widget.inputDoc["village"],
    //                         postOffice: widget.inputDoc["post_office"],
    //                         thana: widget.inputDoc["thana"],
    //                         country: widget.inputDoc["country"],
    //                         district: widget.inputDoc["district"],
    //                         state: widget.inputDoc["state"],
    //                         mobile: widget.inputDoc["mobile_Number"],
    //                         pincode: widget.inputDoc["pincode"],
    //                         formData: createDoc,
    //                         image: widget.image,
    //                         lal: widget.lat,
    //                         long: widget.lng,
    //                         // gender: widget.inputDoc["gender"],
    //                       ).then((value) async {
    //                         if (value.status == 'success') {
    //                           setState(() {
    //                             Navigator.of(_keyLoader.currentContext,
    //                                     rootNavigator: true)
    //                                 .pop();
    //                           });
    //                           final BannerResponse bannerResponse =
    //                               await ApiCall.getBanner();
    //                           Navigator.push(context,
    //                               MaterialPageRoute(builder: (context) {
    //                             return HomeScreen(
    //                                 bannerResponse: bannerResponse);
    //                           }));
    //                           Toast.show(value.message, context);
    //                         } else {
    //                           setState(() {
    //                             Navigator.of(_keyLoader.currentContext,
    //                                     rootNavigator: true)
    //                                 .pop();
    //                           });
    //                           Toast.show(value.message, context);
    //                         }
    //                       });
    //                     } else {
    //                       setState(() {
    //                         CoolAlert.show(
    //                           context: context,
    //                           type: CoolAlertType.warning,
    //                           text: "$leftFields are required",
    //                         );
    //                         print("Empty fields are $leftFields");
    //                         Navigator.of(_keyLoader.currentContext,
    //                                 rootNavigator: true)
    //                             .pop();
    //                         Navigator.of(context).pop();
    //                       });
    //                     }

    //                     // }
    //                   },
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       )),

    // );
  }
}
