import 'package:any_widget_marquee/any_widget_marquee.dart';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/assignReportSurvey.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../EditProfile.dart';
import '../surveyList.dart';
import 'package:package_info/package_info.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:in_app_update/in_app_update.dart';

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
  String nativeAppversion;
  String backendAppVersion;
  int nativeS = 0;
  int backendS = 0;
  AppUpdateInfo _updateInfo;

  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      nativeAppversion = packageInfo.version;
      String S = nativeAppversion.substring(4);

      nativeS = int.parse(S);
    });
  }

  _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
              title: new Text(
                "App Update Available",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: new Text("Please update the app to continue"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Update now'),
                  onPressed: () {
                    // Navigator.of(context).pop();
                    // StoreRedirect.redirect();
                    updateApp();
                  },
                )
              ],
            ));
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

    backendAppVersion = widget.bannerResponse.data.blu_app_version;
    setState(() {
      String S = backendAppVersion.substring(0, 1);
      // backendS = 2;
      backendS = int.parse(S);
    });
  }

  void updateApp() async {
    StoreRedirect.redirect(androidAppId: 'com.bluangel.app');
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    getDataFromSettings();
    getPackageInfo();

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar =
        CustomView.appBarCustom('Menu-Icon-01', 'Arrow-Icon-01', () {
      _scaffoldKey.currentState.openDrawer();
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
          child: CustomView.buildContainerBackgroundImage(
            context: context,
            child: (nativeAppversion == null && backendAppVersion == null)
                ? CircularProgressIndicator()
                : (nativeAppversion.compareTo(backendAppVersion) < 0)
                    ? AlertDialog(
                        title: Text(
                          "App Update Available",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        content: Text(
                          "Please update the app to continue",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[600]),
                        ),
                        actions: [
                          Center(
                            child: new FlatButton(
                              child: Text("Ok"),
                              onPressed: updateApp,
                            ),
                          ),
                        ],
                      )
                    : ListView(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            color: Color(s_background_color),
                            height: 40,
                            child: AnyMargueeWidget(
                              speedRate: 1,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  sliderText,
                                  style: TextStyle(
                                      color: Color(s_font_color), fontSize: 20),
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, left: 10),
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
                                  margin:
                                      const EdgeInsets.only(top: 10, left: 10),
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
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          CustomView.buildTapCard(
                                              context,
                                              'Active',
                                              'ACTIVE SURVEY', () async {
                                            final SurveyListResponse
                                                surveyListResponse =
                                                await ApiCall.getSurveyList();
                                            final BannerResponse
                                                bannerResponse =
                                                await ApiCall.getBanner();
                                            if (surveyListResponse.status ==
                                                    "success" &&
                                                bannerResponse.status ==
                                                    "success") {
                                              SharedPreferences
                                                  sharedPreferences =
                                                  await SharedPreferences
                                                      .getInstance();
                                              sharedPreferences.setString(
                                                  "accessToken",
                                                  surveyListResponse.token);
                                              setState(() {
                                                ApiCall.token =
                                                    surveyListResponse.token;
                                              });
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SurveyList(
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
                                            final SurveyListResponse
                                                surveyListResponse =
                                                await ApiCall.getSurveyList();
                                            final BannerResponse
                                                bannerResponse =
                                                await ApiCall.getBanner();
                                            if (surveyListResponse.status ==
                                                    "success" &&
                                                bannerResponse.status ==
                                                    "success") {
                                              setState(() {
                                                ApiCall.token =
                                                    surveyListResponse.token;
                                              });
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssignReportSurvey(
                                                    bannerResponse:
                                                        bannerResponse,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: <Widget>[
                                          CustomView.buildTapCard(
                                              context,
                                              'ReportPage-Icon',
                                              'report page', () async {

                                            final SurveyListResponse
                                                surveyListResponse =
                                                await ApiCall.getSurveyList();

                                            final BannerResponse
                                                bannerResponse =
                                                await ApiCall.getBanner();
                                            if (surveyListResponse.status ==
                                                    "success" &&
                                                bannerResponse.status ==
                                                    "success") {
                                              setState(() {
                                                ApiCall.token =
                                                    surveyListResponse.token;
                                              });
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AssignReportSurvey(
                                                    bannerResponse:
                                                        bannerResponse,
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
                                            final BannerResponse
                                                bannerResponse =
                                                await ApiCall.getBanner();
                                            if (bannerResponse.status ==
                                                "success") {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfile(
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
