import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/requestAdminResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'common/HomeScreen.dart';

class RequestWithAdmin extends StatefulWidget {
  BannerResponse bannerResponse;
  RequestWithAdmin({this.bannerResponse});
  @override
  _RequestWithAdminState createState() => _RequestWithAdminState();
}

class _RequestWithAdminState extends State<RequestWithAdmin> {
  int top_nav;
  String content, name, mobileNumber;
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  bool isLoading = true;

  @override
  void initState() {
    getDataFromSharedPrefs();
    content = '';
    name = '';
    mobileNumber = '';
    String s = widget.bannerResponse.data.top_nav;
    String ss = "0xff" + s.substring(1);
    top_nav = int.parse(ss);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: Scaffold(
          appBar: CustomView.appBarCustom('Menu-Icon-01', 'Bt-Close-01', () {
            // _scaffoldKey.currentState.openDrawer();
            // Navigator.of(context).pop();
          }, () {
            Navigator.of(context).pop();
          },
              isLeading: false,
              isAction: true,
              title: 'request with admin',
              top_nav: top_nav),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: CustomView.buildContainerBackgroundImage(
                  context: context,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CustomView.buildContainerWithImage(
                        h: 50,
                        w: 200,
                        imagePath: 'assets/images/LogoWithMascot-01.png',
                      ),
                      CustomView.buildContainerCardUI(
                        h: MediaQuery.of(context).size.height / 2.8,
                        w: MediaQuery.of(context).size.width / 10,
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
                          child: ListView(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'NAME',
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: CustomView.editTextField(
                                        color: Colors.red,
                                        keyborad: TextInputType.text,
                                        // labelText: 'NAME',
                                        lengthLimiting: 20),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, left: 20),
                                    child: Text(
                                      'MOBILE NUMBER',
                                      style: kheadingStyle.apply(
                                        fontWeightDelta: 3,
                                        fontSizeFactor: 1.2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 20),
                                    child: CustomView.editTextField(
                                        color: Colors.red,
                                        keyborad: TextInputType.number,
                                        // labelText: '+91-00000000',
                                        lengthLimiting: 20),
                                  ),
                                  Container(
                                    // height: 60,

                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      left: 20,
                                      bottom: 20,
                                    ),
                                    // width: 100,
                                    child: Text(
                                      'DETAIL',
                                      style: kheadingStyle.apply(
                                          color: Color(0xff004fc1),
                                          fontWeightDelta: 3,
                                          fontSizeFactor: 1.5),
                                    ),
                                  ),
                                  CustomView.editTextField(
                                      height: 100,
                                      maxLines: 5,
                                      lengthLimiting: 140,
                                      fn: (input) {
                                        setState(() {
                                          content = input;
                                        });
                                      }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        alignment: Alignment.bottomRight,
                        child: CustomView.button(
                          buttonColor: kfontColorBlue4,
                          buttonName: 'SUBMIT',
                          circularRadius: 30,
                          color: Colors.white,
                          function: () async {
                            setState(() {
                              isLoading = !isLoading;
                            });
                            final RequestAdminResponse requestAdminResponse =
                                await ApiCall.getRequestAdmin(
                              id: ApiCall.tokenCall,
                              content: content,
                            );

                            if (requestAdminResponse.status == "success") {
                              final BannerResponse bannerResponse =
                                  await ApiCall.getBanner();
                              if (bannerResponse.status == "success") {
                                CustomView.showInDialog(context, 'Request Form',
                                    'Message sent successfully', () async {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(
                                        bannerResponse: bannerResponse,
                                      ),
                                    ),
                                  );
                                  setState(() {
                                    isLoading = !isLoading;
                                  });
                                });
                              }
                            }
                          },
                          height: 50,
                          isCircular: true,
                          textSize: 20,
                          width: 150,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: !isLoading,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
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
    );
  }
}
