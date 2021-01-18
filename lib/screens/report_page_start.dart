import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/network/api_constants.dart';
import 'package:blue_angel/screens/report_page.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ReportPageStart extends StatefulWidget {
  final String surveyId;
  final BannerResponse bannerResponse;
  ReportPageStart({
    this.surveyId,
    this.changeReport,
    @required this.bannerResponse,
  });
  final bool changeReport;
  @override
  _ReportPageStartState createState() => _ReportPageStartState();
}

class _ReportPageStartState extends State<ReportPageStart> {
  int top_nav;
  String startDate, lastDate;
  bool isLoading = true;
  String user_id = '';
  String token = '';
  final format = DateFormat("dd/MM/yyy");
  // String accessToken;
  Future<Map<String, String>> getDataFromSharedPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // setState(() {
    user_id= sharedPreferences.getString("user_id");
    token = sharedPreferences.getString("accessToken");

    print("Body is :" + user_id);
    print("Header is: " + token);
    return {'body': user_id, 'header': token};
  }

  @override
  void initState() {
    // getDataFromSharedPrefs();
    print("Survey id is: " + widget.surveyId);
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    print("top_nav" + s);
    super.initState();
  }
  //  Future<SurveyReportResponse> fetchtSurveyReport({
  //   @required String startDate,
  //   @required String endDate,
  //
  //   @required userId,
  //   @required token
  //
  // }) async {
  //   final response = await http.post(
  //     Uri.encodeFull(AppConstants.surveyReport),
  //     headers: {
  //       "accept": "application/json",
  //       "authorization": "$token",
  //     },
  //     body: json.encode({
  //       "start_date": startDate,
  //       "end_date": endDate,
  //       "blu_angel": userId,
  //       "survey_id": widget.surveyId,
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     print("Inside survey report");
  //     final String responseString = response.body;
  //     return surveyReportResponseFromJson(responseString);
  //   } else {
  //     return null;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
        // backgroundColor: kmainBg,
        appBar: CustomView.appBarCustom('Menu-Icon-01', 'Arrow-Icon-01', () {
          // _scaffoldKey.currentState.openDrawer();
          // Navigator.of(context).pop();
        }, () {
          Navigator.of(context).pop();
        },
            isLeading: false,
            isAction: true,
            title: widget.changeReport ? 'completed page' : 'report page',
            top_nav: top_nav),
        body: CustomView.buildContainerBackgroundImage(
            context: context,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    CustomView.buildContainerWithImage(
                      h: 50,
                      w: 200,
                      imagePath: 'assets/images/LogoWithMascot-01.png',
                    ),
                    CustomView.buildContainerCardUI(
                      h: 220,
                      w: 50,
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
                          margin: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: kfontColorBlue1,
                            width: 2.0,
                          )),
                          child: ListView(
                            children: <Widget>[
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 20),
                                child: Text(
                                  'START DATE',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  // border: Border.all(
                                  //     color: Colors.blue, width: 1),
                                ),
                                child: DateTimeField(
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
                                  onChanged: (input) {
                                    setState(() {
                                      startDate = input.toString();
                                      print(startDate);
                                    });
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: widget.changeReport
                                            ? DateTime.now().subtract(Duration(
                                                days: 180,
                                              ))
                                            : DateTime.now().subtract(Duration(
                                                days: 90,
                                              )),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 20, left: 20),
                                child: Text(
                                  'LAST DATE',
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.0)),
                                  // border: Border.all(
                                  //     color: Colors.blue, width: 1),
                                ),
                                child: DateTimeField(
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
                                  onChanged: (input) {
                                    setState(() {
                                      lastDate = input.toString();
                                      print(lastDate);
                                    });
                                  },
                                  onShowPicker: (context, currentValue) {
                                    return showDatePicker(
                                        context: context,
                                        firstDate: DateTime(1900),
                                        initialDate:
                                            currentValue ?? DateTime.now(),
                                        lastDate: DateTime(2100));
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                padding: const EdgeInsets.only(
                                  left: 30,
                                  right: 30,
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  color: Colors.blue[900],
                                  child: Text(
                                    'SUBMIT',
                                    style: kheadingStyle.apply(
                                      color: Colors.white,
                                      fontWeightDelta: 4,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                    // final SurveyReportResponse
                                    //     surveyReportResponse =
                                    //     await ApiCall.getSurveyReport(
                                    //   startDate: startDate,
                                    //   endDate: lastDate,
                                    //   surveyId: widget.surveyId,
                                    // );
                                    if (startDate == null) {
                                      CustomView.showInDialog(context, "Error",
                                          "Start Date is Empty!", () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isLoading = !isLoading;
                                        });
                                      });
                                    } else if (lastDate == null) {
                                      CustomView.showInDialog(context, "Error",
                                          "Last Date is Empty!", () {
                                        Navigator.of(context).pop();
                                        setState(() {
                                          isLoading = !isLoading;
                                        });
                                      });
                                    }
                                    // else if (surveyReportResponse.status ==
                                    //     "success") {
                                    //   SharedPreferences sharedPreferences =
                                    //       await SharedPreferences.getInstance();
                                    //   sharedPreferences.setString("accessToken",
                                    //       surveyReportResponse.token);
                                    //   setState(() {
                                    //     ApiCall.token =
                                    //         surveyReportResponse.token;
                                    //     isLoading = !isLoading;
                                    //   });
                                    //   // print(surveyReportResponse.status);
                                    //   Navigator.of(context).push(
                                    //     MaterialPageRoute(
                                    //       builder: (context) => ReportPage(
                                    //         completeOrReport:
                                    //             widget.changeReport
                                    //                 ? true
                                    //                 : false,
                                    //         surveyReportResponse:
                                    //             surveyReportResponse,
                                    //       ),
                                    //     ),
                                    //   );
                                    // }
                                    else{
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => ReportPage(
                                            completeOrReport:
                                            widget.changeReport
                                                ? true
                                                : false,
                                            surveyId: widget.surveyId,
                                            startdate: startDate,
                                            enddate: lastDate,
                                            // surveyReportResponse:
                                            // surveyReportResponse,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Visibility(
                    visible: !isLoading,
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
            )),
      ),
    );
  }
}
