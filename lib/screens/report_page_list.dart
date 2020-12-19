// // import 'package:blue_angel/models/ReportPageListResponse.dart';
// import 'package:blue_angel/models/surveyReportResponse.dart';
// import 'package:blue_angel/screens/report_page.dart';
// import 'package:blue_angel/utlis/values/styles.dart';
// import 'package:blue_angel/widgets/custom_view.dart';
// import 'package:flutter/material.dart';

// // import 'package:shared_preferences/shared_preferences.dart';

// class ReportPageList extends StatefulWidget {
//   final SurveyReportResponse surveyReportResponse;
//   ReportPageList({
//     @required this.surveyReportResponse,
//   });
//   @override
//   _ReportPageListState createState() => _ReportPageListState();
// }

// class _ReportPageListState extends State<ReportPageList> {
//   int _count;
//   String status;
//   List list;
//   List fieldName = new List();
//   @override
//   void initState() {
//     status = widget.surveyReportResponse.status;
//     _count = widget.surveyReportResponse.result.length;
//     print('response ${widget.surveyReportResponse.status}');
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: kmainBg,
//       appBar: CustomView.appBarCustom(
//         'Arrow-Icon-02',
//         'Bt-Close-01',
//         () {
//           // _scaffoldKey.currentState.openDrawer();
//           Navigator.of(context).pop();
//         },
//         () {
//           // Navigator.of(context).pop();
//         },
//         isLeading: true,
//         isAction: false,
//         title: 'active survey list',
//       ),
//       body: CustomView.buildContainerBackgroundImage(
//         context: context,
//         child: Container(
//           height: MediaQuery.of(context).size.height - 20,
//           width: MediaQuery.of(context).size.width,
//           child: ListView.builder(
//             itemCount: _count,
//             itemBuilder: (BuildContext context, index) {
//               return InkWell(
//                 onTap: () {
//                   Navigator.of(context).push(MaterialPageRoute(
//                     builder: (context) => ReportPage(
//                       createdDate: widget
//                           .surveyReportResponse.result[index].createdDate
//                           .toString(),
//                       surveyName:
//                           widget.surveyReportResponse.result[index].surveyName,
//                     ),
//                   ));
//                 },
//                 child: Container(
//                   height: MediaQuery.of(context).size.height / 6,
//                   margin: const EdgeInsets.all(20),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     color: Colors.white,
//                     child: Center(
//                         child: Text(
//                       ' ${widget.surveyReportResponse.result[index].surveyName}',
//                       style: kheadingStyle.apply(
//                         fontSizeDelta: 1.5,
//                         fontWeightDelta: 5,
//                       ),
//                     )),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
