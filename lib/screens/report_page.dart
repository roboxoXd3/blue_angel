import 'dart:convert';

import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/network/api_constants.dart';
import 'package:blue_angel/screens/complete_survey_show_customer_data.dart';
import 'package:blue_angel/screens/report_customer_data_show.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportPage extends StatefulWidget {
  final SurveyReportResponse surveyReportResponse;
  final BannerResponse bannerResponse;
  final bool completeOrReport;
  final surveyId;
  ReportPage({
    @required this.surveyReportResponse,
    @required this.completeOrReport,
    @required this.bannerResponse,
    @required this.surveyId,
  });
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // String surveyId = ' ';

  Future<SurveyReportResponse> fetchSurveyReport({
    @required String startDate,
    @required String endDate,
    // @required surveyId,

  }) async {
    final response = await http.post(
      Uri.encodeFull(AppConstants.surveyReport),
      headers: {
        "accept": "application/json",
        "authorization": "${ApiCall.token}",
      },
      body: json.encode({
        "start_date": startDate,
        "end_date": endDate,
        "blu_angel": ApiCall.tokenCall,
        "survey_id": widget.surveyId,
      }),
    );
    if (response.statusCode == 200) {
      final String responseString = response.body;
      print("Response of SurveyReport is: "+responseString);
      return surveyReportResponseFromJson(responseString);
    } else {
      return null;
    }
  }



  int top_nav;
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
    fetchSurveyReport( endDate: DateTime.now().toString().split(' ')[0],
      startDate: DateTime.now()
          .subtract(
        Duration(
          days: 90,
        ),
      )
          .toString()
          .split(' ')[0],
      // surveyId: widget
      //     .surveyListResponse.result[index].survey.id,
    );
    // print('''Survey report reponse is: ${widget.surveyReportResponse.result.first}''');
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomView.appBarCustom('Arrow-Icon-01', 'Arrow-Icon-01', () {
        // Navigator.of(context).pop();
      }, () {
        Navigator.of(context).pop();
      },
          isLeading: false,
          isAction: true,
          title: widget.completeOrReport ? 'completed survey' : 'report survey',
          top_nav: top_nav),
      body: SingleChildScrollView(
        child: CustomView.buildContainerBackgroundImage(
          context: context,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomView.buildContainerWithImage(
                h: 50,
                w: 250,
                imagePath: 'assets/images/LogoWithMascot-01.png',
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: CustomView.buildContainerCardUI(
                  h: MediaQuery.of(context).size.height / 2.5,
                  w: MediaQuery.of(context).size.width / 10,
                  color: Colors.white,
                  context: context,
                  child: CustomView.buildLargeContainer(
                    isOptional: false,
                    color1: Colors.blue[900],
                    color: Colors.white,
                    listColor: [Colors.white, Colors.white],
                    margin: 10,
                    child: ListView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue[900],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(13.0),
                              topRight: Radius.circular(13.0),
                            ),
                          ),
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.blue,
                              width: 0.0,
                              style: BorderStyle.none,
                            ),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                      color: Colors.blue[900],
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(13.0),
                                        topRight: Radius.circular(13.0),
                                      )),
                                  children: [
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'NAME',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: -2,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'MOBILE',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: -2,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'PIN',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: -2,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'VIEW',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: -2,
                                            fontWeightDelta: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                            ],
                          ),
                        ),
                        Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                widget.surveyReportResponse.result.length,
                            itemBuilder: (BuildContext context, index) {
                              var result = widget.surveyReportResponse.result;
                              print(result[index].bluAngelMobile);
                              return Table(
                                border: TableBorder.all(
                                  color: Colors.blue[900],
                                ),
                                children: [
                                  TableRow(
                                      // decoration:,
                                      children: [
                                        TableCell(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                result[index]
                                                    .customerData
                                                    .fullName,
                                                style: kheadingStyle.apply(
                                                  color: Colors.blue[900],
                                                  fontSizeDelta: -3,
                                                  fontWeightDelta: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                result[index]
                                                    .customerData
                                                    .mobile,
                                                style: kheadingStyle.apply(
                                                  color: Colors.blue[900],
                                                  fontSizeDelta: -3,
                                                  fontWeightDelta: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            margin: const EdgeInsets.all(10),
                                            child: Center(
                                              child: Text(
                                                result[index]
                                                    .customerData
                                                    .pincode
                                                    .toString(),
                                                style: kheadingStyle.apply(
                                                  color: Colors.blue[900],
                                                  fontSizeDelta: -3,
                                                  fontWeightDelta: 3,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TableCell(
                                          child: Center(
                                            child: IconButton(
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.blue[900],
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportcustomerDataShow(
                                                      namechange: widget
                                                          .completeOrReport,
                                                      // surveyReportResponse: widget
                                                      //     .surveyReportResponse,
                                                      formData: result[index]
                                                          .formData,
                                                      fullName: result[index]
                                                          .customerData
                                                          .fullName,
                                                      address: result[index]
                                                          .customerData
                                                          .village,
                                                      district: result[index]
                                                          .customerData
                                                          .district,
                                                      mobile: result[index]
                                                          .customerData
                                                          .mobile,
                                                      pincode: result[index]
                                                          .customerData
                                                          .pincode,
                                                      postOffice: result[index]
                                                          .customerData
                                                          .postOffice,
                                                      state: result[index]
                                                          .customerData
                                                          .state,
                                                      thana: result[index]
                                                          .customerData
                                                          .thana,
                                                      village: result[index]
                                                          .customerData
                                                          .village,
                                                      image: widget
                                                              .surveyReportResponse
                                                              .imageBaseUrl
                                                              .toString() +
                                                          result[index]
                                                              .image
                                                              .toString(),
                                                      lat: result[index].lat,
                                                      lng: result[index].lng,
                                                      date: result[index]
                                                          .createdDate
                                                          .toString()
                                                          .split(' ')[0],
                                                    ),
                                                  ),
                                                );
                                                print(widget
                                                        .surveyReportResponse
                                                        .imageBaseUrl
                                                        .toString() +
                                                    result[index]
                                                        .image
                                                        .toString());
                                              },
                                            ),
                                          ),
                                        ),
                                      ]),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
