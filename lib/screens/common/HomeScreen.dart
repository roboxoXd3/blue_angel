import 'dart:io' show Platform;
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/assignCompleteSurvey.dart';
import 'package:blue_angel/screens/assignReportSurvey.dart';
import 'package:blue_angel/screens/login_screen.dart';
import 'package:blue_angel/screens/report_page_start.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../completed_survey.dart';
import '../edit_profile.dart';
import '../surveyList.dart';

class HomeScreen extends StatefulWidget {
  final BannerResponse bannerResponse;
  HomeScreen({@required this.bannerResponse});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isImage;
  String bannerResponse;
  String accessToken;
  String startDate, lastDate;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    isImage = false;
    bannerResponse = widget.bannerResponse.data.dashboardImage;
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = CustomView.appBarCustom(
      'Menu-Icon-01',
      'Arrow-Icon-01',
      () {
        _scaffoldKey.currentState.openDrawer();
        // Navigator.of(context).pop();
      },
      () {},
      isLeading: true,
      isAction: true,
      title: 'home',
    );

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: CustomView.drawerCustom(context),
      body: WillPopScope(
        onWillPop: () async => showDialog(
            context: context,
            builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to quit?'),
                    actions: <Widget>[
                      RaisedButton(
                        child: Text('exit app'),
                        onPressed: () => SystemNavigator.pop(),
                      ),
                      RaisedButton(
                          child: Text('cancel'),
                          onPressed: () => Navigator.of(context).pop(false)),
                    ])),
        child: SingleChildScrollView(
          // physics: NeverScrollableScrollPhysics(),
          child: CustomView.buildContainerBackgroundImage(
            context: context,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Row(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(top: 10),
                      child: CustomView.buildContainerWithImage(
                        h: 100,
                        w: 55,
                        imagePath: 'assets/images/Mascot-01.png',
                      ),
                    ),
                    widget.bannerResponse == null && bannerResponse == null
                        ? Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: CustomView.buildContainerWithImage(
                              h: 100,
                              w: 100,
                              imagePath: 'assets/images/hut.png',
                            ),
                          )
                        : Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10, left: 10),
                              height: 100,
                              width: 100,
                              child: Image.network(bannerResponse),
                            ),
                          ),
                  ],
                ),
                Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(top: 10),
                  child: CustomView.buildContainerCardUI(
                    h: 240,
                    w: 100,
                    color: Colors.transparent,
                    context: context,
                    child: CustomView.buildLargeContainer(
                      margin: 0.0,
                      color: Color(0xFF8fe9ff),
                      color1: Colors.transparent,
                      listColor: ksubBg,
                      child: ListView(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              'assets/images/Logo-01.png',
                              fit: BoxFit.contain,
                              width: 200,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CustomView.buildTapCard(
                                    context, 'Active', 'ACTIVE SURVEY',
                                    () async {
                                  final SurveyListResponse surveyListResponse =
                                      await ApiCall.getSurveyList();
                                  if (surveyListResponse.status == "success") {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString("accessToken",
                                        surveyListResponse.token);
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => SurveyList(
                                                surveyListResponse)));
                                  }
                                  // });
                                }),
                                CustomView.buildTapCard(
                                    context,
                                    'Complete-Icon',
                                    'completed survey', () async {
                                  // final SurveyListResponse surveyListResponse =
                                  //     await ApiCall.getSurveyList();
                                  // if (surveyListResponse.status == "success") {
                                  //   setState(() {
                                  //     ApiCall.token = surveyListResponse.token;
                                  //   });
                                  //   // Navigator.of(context).push(MaterialPageRoute(
                                  //   //   builder: (context) => CompletedSurvey()));
                                  //   Navigator.of(context).push(
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           AssignCompleteSurvey(
                                  //         surveyListResponse,
                                  //         DateTime.now()
                                  //             .toString()
                                  //             .split(' ')[0],
                                  //         DateTime.now()
                                  //             .subtract(Duration(
                                  //               days: 90,
                                  //             ))
                                  //             .toString()
                                  //             .split(' ')[0],
                                  //       ),
                                  //     ),
                                  //   );
                                  // }
                                  final SurveyListResponse surveyListResponse =
                                      await ApiCall.getSurveyList();
                                  if (surveyListResponse.status == "success") {
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssignReportSurvey(
                                          changeReport: true,
                                              surveyListResponse: surveyListResponse,
                                              withoutDate: true,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                CustomView.buildTapCard(
                                    context, 'ReportPage-Icon', 'report page',
                                    () async {
                                  final SurveyListResponse surveyListResponse =
                                      await ApiCall.getSurveyList();
                                  if (surveyListResponse.status == "success") {
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssignReportSurvey(
                                              changeReport: true,
                                              surveyListResponse: surveyListResponse,
                                            ),
                                      ),
                                    );
                                  }
                                }),
                                CustomView.buildTapCard(context,
                                    'EditProfile-Icon-', 'edit profile', () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditProfile()));
                                }),
                              ],
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
      ),
    );
  }
}
