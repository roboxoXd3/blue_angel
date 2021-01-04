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
import 'package:marquee/marquee.dart';
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
  String bannerResponseImg1;
  String bannerResponseImg2;
  String accessToken;
  String startDate, lastDate;
  int top_nav;
  int side_nav;
  int s_font_color;
  int s_background_color;
  String sliderText;

  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  getDataFromSettings() {
    String s = widget.bannerResponse.data.top_nav;
    String ss = "0xff" + s.substring(1);
    top_nav = int.parse(ss);

    String side_navs = widget.bannerResponse.data.side_nav;
    String side_navss = "0xff" + side_navs.substring(1);
    side_nav = int.parse(side_navss);

    bannerResponseImg1 = widget.bannerResponse.data.dashboardImage;
    bannerResponseImg2 = widget.bannerResponse.data.dashboard_image2;

    String fc = widget.bannerResponse.data.slider_font_color;
    String fcs = "0xff" + fc.substring(1);
    s_font_color = int.parse(fcs);

    String bg = widget.bannerResponse.data.slider_background_color;
    String bgs = "0xff" + bg.substring(1);
    s_background_color = int.parse(bgs);

    sliderText = widget.bannerResponse.data.slider_text;
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    getDataFromSettings();
    isImage = false;

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar =
        CustomView.appBarCustom('Menu-Icon-01', 'Arrow-Icon-01', () {
      _scaffoldKey.currentState.openDrawer();
      // Navigator.of(context).pop();
    }, () {}, isLeading: true, isAction: true, title: 'home', top_nav: top_nav);

    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar,
      drawer: CustomView.drawerCustom(context, side_nav),
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
                Expanded(
                  // child: Container(
                  //   height: 10,
                  //   color: Color(s_background_color),
                  child: Marquee(
                    blankSpace: 600,
                    text: sliderText,
                    style: TextStyle(color: Color(s_font_color), fontSize: 10),
                  ),
                  // ),
                ),
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10, left: 10),
                      height: 100,
                      width: 55,
                      child: Image.network(
                        bannerResponseImg2,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        height: 100,
                        width: 100,
                        child: Image.network(bannerResponseImg1),
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
                                  final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                  if (surveyListResponse.status == "success" &&
                                      bannerResponse.status == "success") {
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString("accessToken",
                                        surveyListResponse.token);
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => SurveyList(
                                                  bannerResponse:
                                                      bannerResponse,
                                                  surveyListResponse:
                                                      surveyListResponse,
                                                )));
                                  }
                                  // });
                                }),
                                CustomView.buildTapCard(
                                    context,
                                    'Complete-Icon',
                                    'completed survey', () async {
                                  final SurveyListResponse surveyListResponse =
                                      await ApiCall.getSurveyList();
                                  final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                  if (surveyListResponse.status == "success" &&
                                      bannerResponse.status == "success") {
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssignReportSurvey(
                                          bannerResponse: bannerResponse,
                                          changeReport: true,
                                          surveyListResponse:
                                              surveyListResponse,
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

                                  final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                  if (surveyListResponse.status == "success" &&
                                      bannerResponse.status == "success") {
                                    setState(() {
                                      ApiCall.token = surveyListResponse.token;
                                    });
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AssignReportSurvey(
                                          bannerResponse: bannerResponse,
                                          changeReport: true,
                                          surveyListResponse:
                                              surveyListResponse,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                CustomView.buildTapCard(
                                    context,
                                    'EditProfile-Icon-',
                                    'edit profile', () async {
                                  final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                  if (bannerResponse.status == "success") {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => EditProfile(
                                                  bannerResponse:
                                                      bannerResponse,
                                                )));
                                  }
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
