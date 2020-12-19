import 'package:blue_angel/models/bannerResponse.dart';
// import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/screens/report_page.dart';
// import 'package:blue_angel/screens/Reportd_survey.dart';
import 'package:blue_angel/screens/report_page_start.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'active_survey_form.dart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class AssignReportSurvey extends StatefulWidget {
  final SurveyListResponse surveyListResponse;
  final bool changeReport;
  final bool withoutDate;
  AssignReportSurvey({
    this.surveyListResponse,
    this.withoutDate=false,
    this.changeReport}
  );
  @override
  _AssignReportSurveyState createState() => _AssignReportSurveyState();
}

class _AssignReportSurveyState extends State<AssignReportSurvey> {
  int _count;
  String status;
  List list;
  List fieldName = new List();
  String accessToken;
  bool isLoading;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    status = widget.surveyListResponse.status;
    _count = widget.surveyListResponse.result.length;
    print('response ${widget.surveyListResponse.status}');
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Scaffold(
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
          child:Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 20,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: _count,
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: () async {
                        if(!widget.withoutDate){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ReportPageStart(
                            widget.surveyListResponse.result[index].survey.id,
                            widget.changeReport,
                          ),
                        ));
                        }else {
                          isLoading = true;
                          SharedPreferences sharedPreferences = await SharedPreferences
                              .getInstance();
                          final SurveyReportResponse
                          surveyReportResponse =
                          await ApiCall.getSurveyReport(
                            endDate: DateTime.now()
                                .toString()
                                .split(' ')[0],
                            startDate: DateTime.now()
                                .subtract(Duration(
                              days: 90,
                            ),)
                                .toString()
                                .split(' ')[0],
                            surveyId: widget.surveyListResponse.result[index]
                                .survey.id,
                          );
                          sharedPreferences.setString(
                              "accessToken", surveyReportResponse.token);
                          setState(() {
                            ApiCall.token =
                                surveyReportResponse.token;
                            isLoading = false;
                          });
                          print(surveyReportResponse.status);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  ReportPage(
                                    completeOrReport: widget.changeReport
                                        ? true
                                        : false,
                                    surveyReportResponse:
                                    surveyReportResponse,
                                  ),
                            ),
                          );
                        }
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
              Visibility(
                  visible: isLoading,
                  child:Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration:BoxDecoration(
                          color:Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      height: MediaQuery.of(context).size.height*0.15,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: CircularProgressIndicator()),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 16) ,child: Text("Please wait..."))
                        ],
                      ),
                    ),
                  )
              )
            ],
          )
        ),
      ),
    );
  }
}
