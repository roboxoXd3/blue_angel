// import 'package:blue_angel/models/surveyReportResponse.dart';
// import 'package:blue_angel/screens/complete_survey_show_customer_data.dart';
// import 'package:blue_angel/utlis/values/styles.dart';
// import 'package:blue_angel/widgets/custom_view.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class CompleteSurveyList extends StatefulWidget {
//   final SurveyReportResponse surveyReportResponse;
//   CompleteSurveyList({
//     @required this.surveyReportResponse,
//   });
//   @override
//   _CompleteSurveyListState createState() => _CompleteSurveyListState();
// }

// class _CompleteSurveyListState extends State<CompleteSurveyList> {
//   String accessToken;
//   getDataFromSharedPrefs() async {
//     SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       accessToken = sharedPreferences.getString("access_token");
//     });
//   }

//   @override
//   void initState() {
//     getDataFromSharedPrefs();
//     super.initState();
//     print(widget.surveyReportResponse.imageBaseUrl);
//     // print(widget.surveyReportResponse.result[1].customerData.address);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomView.appBarCustom(
//         'Arrow-Icon-01',
//         'Arrow-Icon-01',
//         () {
//           // Navigator.of(context).pop();
//         },
//         () {
//           Navigator.of(context).pop();
//         },
//         isLeading: false,
//         isAction: true,
//         title: 'complete survey',
//       ),
//       body: SingleChildScrollView(
//         child: CustomView.buildContainerBackgroundImage(
//           context: context,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               CustomView.buildContainerWithImage(
//                 h: 50,
//                 w: 250,
//                 imagePath: 'assets/images/LogoWithMascot-01.png',
//               ),
//               Container(
//                 margin: const EdgeInsets.only(top: 20),
//                 child: CustomView.buildContainerCardUI(
//                   h: MediaQuery.of(context).size.height / 2.5,
//                   w: MediaQuery.of(context).size.width / 10,
//                   color: Colors.white,
//                   context: context,
//                   child: CustomView.buildLargeContainer(
//                     color1: Colors.black54,
//                     color: Colors.white,
//                     listColor: [Colors.white, Colors.white],
//                     margin: 10,
//                     child: ListView(
//                       shrinkWrap: true,
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                               color: Colors.blue[900],
//                               borderRadius: BorderRadius.only(
//                                 topLeft: Radius.circular(13.0),
//                                 topRight: Radius.circular(13.0),
//                               )),
//                           child: Table(
//                             border: TableBorder.all(
//                               color: Colors.blue,
//                               width: 0.0,
//                             ),
//                             children: [
//                               TableRow(
//                                   decoration: BoxDecoration(
//                                       color: Colors.blue[900],
//                                       borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(13.0),
//                                         topRight: Radius.circular(13.0),
//                                       )),
//                                   children: [
//                                     TableCell(
//                                       child: Center(
//                                         child: Text(
//                                           'NAME',
//                                           style: kheadingStyle.apply(
//                                             color: Colors.white,
//                                             fontSizeDelta: -2,
//                                             fontWeightDelta: 3,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Center(
//                                         child: Text(
//                                           'MOBILE',
//                                           style: kheadingStyle.apply(
//                                             color: Colors.white,
//                                             fontSizeDelta: -2,
//                                             fontWeightDelta: 3,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Center(
//                                         child: Text(
//                                           'PIN',
//                                           style: kheadingStyle.apply(
//                                             color: Colors.white,
//                                             fontSizeDelta: -2,
//                                             fontWeightDelta: 3,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     TableCell(
//                                       child: Center(
//                                         child: Text(
//                                           'VIEW',
//                                           style: kheadingStyle.apply(
//                                             color: Colors.white,
//                                             fontSizeDelta: -2,
//                                             fontWeightDelta: 3,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ]),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           child: ListView.builder(
//                             shrinkWrap: true,
//                             itemCount:
//                                 widget.surveyReportResponse.result.length,
//                             itemBuilder: (BuildContext context, index) {
//                               var result = widget.surveyReportResponse.result;
//                               print(result[index].bluAngelMobile);
//                               return Table(
//                                 border: TableBorder.all(
//                                   color: Colors.blue[900],
//                                 ),
//                                 children: [
//                                   TableRow(
//                                       // decoration:,
//                                       children: [
//                                         TableCell(
//                                           child: Center(
//                                             child: Text(
//                                               result[index]
//                                                   .customerData
//                                                   .fullName,
//                                               style: kheadingStyle.apply(
//                                                 color: Colors.black,
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           child: Center(
//                                             child: Text(
//                                               result[index].customerData.mobile,
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           child: Center(
//                                             child: Text(
//                                               result[index]
//                                                   .customerData
//                                                   .pincode
//                                                   .toString(),
//                                             ),
//                                           ),
//                                         ),
//                                         TableCell(
//                                           child: Center(
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 Icons.arrow_forward_ios,
//                                               ),
//                                               onPressed: () {
//                                                 Navigator.of(context).push(
//                                                   MaterialPageRoute(
//                                                     builder: (context) =>
//                                                         CompletedSurveyShowCustomerData(
//                                                       formData: result[index]
//                                                           .formData,
//                                                       fullName: result[index]
//                                                           .customerData
//                                                           .fullName,
//                                                       address: result[index]
//                                                           .customerData
//                                                           .village,
//                                                       district: result[index]
//                                                           .customerData
//                                                           .district,
//                                                       mobile: result[index]
//                                                           .customerData
//                                                           .mobile,
//                                                       pincode: result[index]
//                                                           .customerData
//                                                           .pincode,
//                                                       postOffice: result[index]
//                                                           .customerData
//                                                           .postOffice,
//                                                       state: result[index]
//                                                           .customerData
//                                                           .state,
//                                                       thana: result[index]
//                                                           .customerData
//                                                           .thana,
//                                                       village: result[index]
//                                                           .customerData
//                                                           .village,
//                                                       image: widget
//                                                               .surveyReportResponse
//                                                               .imageBaseUrl
//                                                               .toString() +
//                                                           result[index]
//                                                               .image
//                                                               .toString(),
//                                                       lat: result[index].lat,
//                                                       lng: result[index].lng,
//                                                       date: result[index]
//                                                           .createdDate
//                                                           .toString()
//                                                           .split(' ')[0],
//                                                     ),
//                                                   ),
//                                                 );
//                                                 print(widget
//                                                         .surveyReportResponse
//                                                         .imageBaseUrl
//                                                         .toString() +
//                                                     result[index]
//                                                         .image
//                                                         .toString());
//                                               },
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                 ],
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
