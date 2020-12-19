import 'package:blue_angel/models/bannerResponse.dart';
// import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/screens/completed_survey.dart';
// import 'package:blue_angel/screens/complete_survey_list.dart';
// import 'package:blue_angel/screens/completed_survey.dart';
import 'package:blue_angel/screens/report_page.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:intl/intl.dart';

// import 'active_survey_form.dart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AssignCompleteSurvey extends StatefulWidget {
  final SurveyListResponse surveyListResponse;
  final String startDate, lastDate;
  AssignCompleteSurvey(
    this.surveyListResponse,
    this.startDate,
    this.lastDate,
  );
  @override
  _AssignCompleteSurveyState createState() => _AssignCompleteSurveyState();
}

class _AssignCompleteSurveyState extends State<AssignCompleteSurvey> {
  String startDate, lastDate;
  int _count;
  String status;
  List list;
  List fieldName = new List();
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    startDate = widget.startDate;
    lastDate = widget.lastDate;
    getDataFromSharedPrefs();
    status = widget.surveyListResponse.status;
    _count = widget.surveyListResponse.result.length;
    print('response ${widget.surveyListResponse.status}');
    super.initState();
    print('date : ${DateTime.now().toString().split(' ')[0]}');
    print('date 90 : ${DateTime.now().subtract(Duration(
          days: 90,
        )).toString().split(' ')[0]}');
    print(widget.surveyListResponse.result[0].survey.id);
    print(ApiCall.tokenCall);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kmainBg,
      appBar: CustomView.appBarCustom(
        'Arrow-Icon-02',
        'Bt-Close-01',
        () async {
          // _scaffoldKey.currentState.openDrawer();
          final BannerResponse bannerResponse = await ApiCall.getBanner();
          if (bannerResponse.status == "success") {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  bannerResponse: bannerResponse,
                ),
              ),
            );
          }
        },
        () {
          // Navigator.of(context).pop();
        },
        isLeading: true,
        isAction: false,
        title: 'assign survey list',
      ),
      body: CustomView.buildContainerBackgroundImage(
        context: context,
        child: Container(
          height: MediaQuery.of(context).size.height - 20,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: _count,
            itemBuilder: (BuildContext context, index) {
              return InkWell(
                onTap: () async {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CompletedSurvey(
                        widget.surveyListResponse.result[index].id),
                  ));
                  // final SurveyReportResponse surveyReportResponse =
                  //     await ApiCall.getSurveyReport(
                  //   startDate: startDate,
                  //   endDate: lastDate,
                  //   surveyId: widget.surveyListResponse.result[index].survey.id,
                  //   // id: ApiCall.tokenCall,
                  // );
                  // if (surveyReportResponse.status == "success") {
                  //   SharedPreferences sharedPreferences =
                  //       await SharedPreferences.getInstance();
                  //   sharedPreferences.setString(
                  //       "accessToken", surveyReportResponse.token);
                  //   setState(() {
                  //     ApiCall.token = surveyReportResponse.token;
                  //     print(surveyReportResponse.imageBaseUrl);
                  //     print(surveyReportResponse);
                  //   });
                  //   // print(
                  //   //     'surveyReportResponse : ${surveyReportResponse.result[surveyReportResponse.result.length].customer}');
                  //   Navigator.of(context).push(
                  //     MaterialPageRoute(
                  //       builder: (context) => ReportPage(
                  //         completeOrReport: true,
                  //         surveyReportResponse: surveyReportResponse,
                  //       ),
                  //     ),
                  //   );
                  // }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height / 6,
                  margin: const EdgeInsets.all(20),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    color: Colors.white,
                    child: Center(
                        child: Text(
                      ' ${widget.surveyListResponse.result[index].survey.name}',
                      style: kheadingStyle.apply(
                        fontSizeDelta: 1.5,
                        fontWeightDelta: 5,
                      ),
                    )),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
