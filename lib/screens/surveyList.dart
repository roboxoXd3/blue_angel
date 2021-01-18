import 'package:blue_angel/network/api_constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  // final SurveyListResponse surveyListResponse;
  final BannerResponse bannerResponse;

  SurveyList({this.bannerResponse});

  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  int _count;
  int top_nav;
  String status;
  List list;
  List fieldName = new List();
  // String accessToken;
  String token;
  String user_id;

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
    SurveyListResponse supervisorModel = SurveyListResponse();
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
    return supervisorModel;
  }

  @override
  void initState() {
    // status = widget.surveyListResponse.status;
    // _count = widget.surveyListResponse.result.length;
    // print('response ${widget.surveyListResponse.status}');
    // getDataFromSharedPrefs();
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            title: 'active survey list',
            top_nav: top_nav),
        body:
        FutureBuilder(
          future: getDataFromSharedPreference(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, String> bodyData = snapshot.data;
              return FutureBuilder(
                  future: fetchSurveyList(
                    blueAngel: bodyData['body'],
                        accessToken: bodyData['header']
                  ),

                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print("Snapshot has data");
                      SurveyListResponse model = snapshot.data;
                      return CustomView.buildContainerBackgroundImage(
                        context: context,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 20,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: model.result.length,
                            itemBuilder: (BuildContext context, index) {
                              return InkWell(
                                onTap: () async {
                                  // print(widget.surveyListResponse.result[index].survey
                                  //     .fields[index].filedName);
                                  final BannerResponse bannerResponse =
                                      await ApiCall.getBanner();
                                  // List lst = widget.surveyListResponse
                                  //     .result[index].survey.fields;
                                  // print(lst);
                                  // for (int i = 0; i < lst.length; i++) {
                                  //   print(widget.surveyListResponse.result[index]
                                  //       .survey.fields);
                                  // }
                                  final StateListResponse stateListResponse =
                                      await ApiCall.postState();
                                  if (stateListResponse.status == "success" &&
                                      bannerResponse.status == "success") {


                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ActiveSurveyForm(
                                        token:token,
                                        bannerResponse: bannerResponse,
                                        products:
                                            model.products,
                                        surveyForm: model.result[index].survey.fields,
                                        surveyName: model
                                            .result[index].survey.name,
                                        surveyId: model
                                            .result[index].survey.id,
                                        stateListResponse: stateListResponse,
                                          bluAngel: user_id,
                                        // token: token,
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
                                      model.result[index].surveyName,
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
                      );
                    } else {
                      return Center(
                          child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text("Fetching The List..")
                        ],
                      ));
                    }
                  });
            } else {
              return Center(
                  child: Column(
                children: [
                  CircularProgressIndicator(),
                  Text("Fetching Details..")
                ],
              ));
            }
          },
        ),
        );
  }
}
