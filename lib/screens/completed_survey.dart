import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/complete_survey_list.dart';
import 'package:blue_angel/screens/report_page.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompletedSurvey extends StatefulWidget {
  final String surveyId;
  CompletedSurvey(this.surveyId);
  @override
  _CompletedSurveyState createState() => _CompletedSurveyState();
}

class _CompletedSurveyState extends State<CompletedSurvey> {
  bool isLoading = true;
  String startDate, lastDate;
  final format = DateFormat("dd-MM-yyyy");
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
        // backgroundColor: kmainBg,
        appBar: CustomView.appBarCustom(
          'Menu-Icon-01',
          'Arrow-Icon-01',
          () {
            // _scaffoldKey.currentState.openDrawer();
            // Navigator.of(context).pop();
          },
          () {
            Navigator.of(context).pop();
          },
          isLeading: false,
          isAction: true,
          title: 'complete survey',
        ),
        body:
        CustomView.buildContainerBackgroundImage(
          context: context,
          child:Stack(
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
                              margin: const EdgeInsets.only(top: 20, left: 20),
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
                              margin:
                              const EdgeInsets.only(top: 20, left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              // padding: EdgeInsets.only(left: 3, right: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffbdd5f1),
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                                      firstDate: DateTime.now().subtract(Duration(
                                        days: 90,
                                      )),
                                      initialDate: currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 20, left: 20),
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
                              margin:
                              const EdgeInsets.only(top: 20, left: 20, right: 20),
                              width: MediaQuery.of(context).size.width,
                              // padding: EdgeInsets.only(left: 3, right: 10),
                              decoration: BoxDecoration(
                                color: Color(0xffbdd5f1),
                                borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
                                      firstDate: DateTime(
                                        1900,
                                      ),
                                      initialDate: currentValue ?? DateTime.now(),
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
                                  final SurveyReportResponse
                                  surveyReportResponse =
                                  await ApiCall.getSurveyReport(
                                    startDate: startDate,
                                    endDate: lastDate,
                                    surveyId: widget.surveyId,
                                  );
                                  if (surveyReportResponse.status ==
                                      "success") {
                                    SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                    sharedPreferences.setString("accessToken",
                                        surveyReportResponse.token);
                                    setState(() {
                                      isLoading = !isLoading;
                                      ApiCall.token =
                                          surveyReportResponse.token;
                                    });
                                    print(surveyReportResponse.status);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ReportPage(
                                          completeOrReport: true,
                                          surveyReportResponse:
                                          surveyReportResponse,
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
