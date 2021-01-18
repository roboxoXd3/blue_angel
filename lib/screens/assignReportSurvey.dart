import 'package:blue_angel/models/bannerResponse.dart';
// import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/network/api_constants.dart';
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
import 'package:http/http.dart' as http;
import 'dart:convert';
class AssignReportSurvey extends StatefulWidget {
  // final SurveyListResponse surveyListResponse;
  final BannerResponse bannerResponse;
  final bool changeReport;
  final bool withoutDate;
  // final SurveyListResponse surveyListResponse;
  AssignReportSurvey(
      {
        // this.surveyListResponse,
      this.withoutDate = false,
      this.changeReport,
      @required this.bannerResponse});
  @override
  _AssignReportSurveyState createState() => _AssignReportSurveyState();
}

class _AssignReportSurveyState extends State<AssignReportSurvey> {
  int _count;
  int top_nav;
  String status;
  List list;
  List fieldName = new List();
  String accessToken;
  bool isLoading;
  String user_id = '';
  String token = " ";
  // getDataFromSharedPrefs() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     accessToken = sharedPreferences.getString("access_token");
  //   });
  //   print("Access Token is: $accessToken");
  // }
  Future<Map<String, String>> getDataFromSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // setState(() {
    user_id= sharedPreferences.getString("user_id");
    token = sharedPreferences.getString("accessToken");

    print("Body is :" + user_id);
    print("Header is: " + token);
    return {'body': user_id, 'header': token};
  }

  Future<SurveyListResponse> fetchSurveyList(
      {String blueAngel, accessToken}) async {
    SurveyListResponse surveyListrModel = SurveyListResponse();
    var response = await http.post(Uri.encodeFull(AppConstants.surveyList),
        body: json.encode({"blu_angel": blueAngel}),
        headers: {"authorization": accessToken});
    print(response.body);
    if (response.statusCode == 200) {
      return SurveyListResponse.fromJson(json.decode(response.body));
      // getSupervisorModel = json.decode(response.body);
    } else {
      print("There is an error");
    }
    return surveyListrModel;
  }





  @override
  void initState() {
    // getDataFromSharedPrefs();
    // status = widget.surveyListResponse.status;
    // _count = widget.surveyListResponse.result.length;
    // print('id is  ${widget.surveyListResponse.result[0].id}');
    isLoading = false;
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading,
      child: Scaffold(
        // backgroundColor: kmainBg,
        appBar: CustomView.appBarCustom('Arrow-Icon-02', 'Bt-Close-01',
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
        }, () {
          // Navigator.of(context).pop();
        },
            isLeading: true,
            isAction: false,
            title: 'assign survey list',
            top_nav: top_nav),
        body: FutureBuilder(
          future: getDataFromSharedPreference(),
          builder: (context,snapshot)
          {
            if(snapshot.hasData) {
              Map<String, String> bodyData = snapshot.data;
              return FutureBuilder(
                future: fetchSurveyList(   blueAngel: bodyData['body'],
                    accessToken: bodyData['header']),
                  builder: (context  , snapshot){
                if(snapshot.hasData)
                  {
                    SurveyListResponse surveyListResponse = snapshot.data;
                    return CustomView.buildContainerBackgroundImage(
                        context: context,
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height - 20,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                itemCount: surveyListResponse.result.length,
                                itemBuilder: (BuildContext context, index) {
                                  return InkWell(
                                    onTap: () async {
                                      final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                      if (!widget.withoutDate &&
                                          bannerResponse.status == "success") {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => ReportPageStart(

                                            surveyId: surveyListResponse
                                                .result[index].survey.id,
                                            bannerResponse: bannerResponse,
                                            changeReport: widget.changeReport,
                                          ),
                                        ));
                                      } else {
                                        isLoading = true;
                                        // SharedPreferences sharedPreferences =
                                        // await SharedPreferences.getInstance();
                                        final BannerResponse bannerResponses =
                                        await ApiCall.getBanner();

                                        // final SurveyReportResponse
                                        // surveyReportResponse =
                                        // await ApiCall.getSurveyReport(
                                        //   endDate: DateTime.now()
                                        //       .toString()
                                        //       .split(' ')[0],
                                        //   startDate: DateTime.now()
                                        //       .subtract(
                                        //     Duration(
                                        //       days: 90,
                                        //     ),
                                        //   )
                                        //       .toString()
                                        //       .split(' ')[0],
                                        //   // surveyId: widget
                                        //   //     .surveyListResponse.result[index].survey.id,
                                        // );
                                        // sharedPreferences.setString(
                                        //     "accessToken", surveyReportResponse.token);
                                        // sharedPreferences.setString("SurveyId", widget
                                        //     .surveyListResponse.result[index].survey.id);
                                        setState(() {
                                          // ApiCall.token =
                                          //     surveyReportResponse.token;

                                          isLoading = false;
                                        });
                                        // print(surveyReportResponse.status);
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => ReportPage(
                                              startdate:DateTime.now()
                                                    .subtract(
                                                  Duration(
                                                    days: 90,
                                                  ),
                                                )
                                                    .toString()
                                                    .split(' ')[0],
                                              enddate: DateTime.now()
                                                    .toString()
                                                    .split(' ')[0],
                                              surveyId: surveyListResponse.result[index].id,
                                              token: bodyData['header'],
                                              user_id: bodyData['body'],
                                              bannerResponse: bannerResponses,
                                              completeOrReport: widget.changeReport
                                                  ? true
                                                  : false,
                                              // surveyReportResponse:
                                              // surveyReportResponse,
                                              // surveyId: widget
                                              //     .surveyListResponse.result[index].survey.id,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      height:
                                      MediaQuery.of(context).size.height / 6,
                                      margin: const EdgeInsets.all(20),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        color: Colors.white,
                                        child: Center(
                                            child: Text(
                                           surveyListResponse.result[index].survey.name,
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
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(16))),
                                    margin: EdgeInsets.symmetric(horizontal: 16),
                                    height:
                                    MediaQuery.of(context).size.height * 0.15,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: CircularProgressIndicator()),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16),
                                            child: Text("Please wait..."))
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ));
                  }
                else{
                  return Container(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text("Loading.."),
                        ],
                      ),
                    ),
                  );
                }
              });
              }
            else{
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading..."),
                    ],
                  ),
                ),
              );
            }
            },
        )
      ),
    );
  }
}
