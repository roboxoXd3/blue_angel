import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/stateListResponse.dart';
import 'package:blue_angel/models/surveyListResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'active_survey_form.dart.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SurveyList extends StatefulWidget {
  final SurveyListResponse surveyListResponse;
  final BannerResponse bannerResponse;
  SurveyList({this.surveyListResponse, this.bannerResponse});
  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  int _count;
  int top_nav;
  String status;
  List list;
  List fieldName = new List();
  String accessToken;
  String token;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    status = widget.surveyListResponse.status;
    _count = widget.surveyListResponse.result.length;
    print('response ${widget.surveyListResponse.status}');
    getDataFromSharedPrefs();
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kmainBg,
      appBar: CustomView.appBarCustom('Arrow-Icon-02', 'Bt-Close-01', () async {
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
          title: 'active survey list',
          top_nav: top_nav),
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
                  // print(widget.surveyListResponse.result[index].survey
                  //     .fields[index].filedName);
                  final BannerResponse bannerResponse =
                      await ApiCall.getBanner();
                  List lst =
                      widget.surveyListResponse.result[index].survey.fields;
                  print(lst);
                  for (int i = 0; i < lst.length; i++) {
                    print(
                        widget.surveyListResponse.result[index].survey.fields);
                  }
                  final StateListResponse stateListResponse =
                      await ApiCall.postState();
                  if (stateListResponse.status == "success" &&
                      bannerResponse.status == "success") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ActiveSurveyForm(
                        bannerResponse: bannerResponse,
                        products: widget.surveyListResponse.products,
                        surveyForm: lst,
                        surveyName:
                            widget.surveyListResponse.result[index].survey.name,
                        surveyId:
                            widget.surveyListResponse.result[index].survey.id,
                        stateListResponse: stateListResponse,
                        token: widget.surveyListResponse.token,
                      ),
                    ));
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
      ),
    );
  }
}
