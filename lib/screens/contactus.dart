import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContactUs extends StatefulWidget {
  // final List<Map<String, String>> formData;
  final BannerResponse bannerResponse;

  ContactUs({
    @required this.bannerResponse,
  });
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  // Map<String, dynamic> formDataShow;
  String dashboradImage, contactEmail, contactNumber;
  int top_nav;
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  // String _image;
  @override
  void initState() {
    getDataFromSharedPrefs();
    dashboradImage = widget.bannerResponse.data.dashboardImage;
    String ss = widget.bannerResponse.data.top_nav;
    String s = "0xff" + ss.substring(1);
    top_nav = int.parse(s);
    contactEmail = widget.bannerResponse.data.contactEmail;
    contactNumber = widget.bannerResponse.data.contactNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kmainBg,
      appBar: CustomView.appBarCustom('Menu-Icon-01', 'Arrow-Icon-01', () {
        // _scaffoldKey.currentState.openDrawer();
        // Navigator.of(context).pop();
      }, () {
        Navigator.of(context).pop();
      },
          isLeading: false,
          isAction: true,
          title: 'complete survey',
          top_nav: top_nav),
      body: CustomView.buildContainerBackgroundImage(
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
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: dashboradImage == null
                            ? Container(
                                // alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: CircleAvatar(
                                  radius: 100.0,
                                  backgroundImage: AssetImage(
                                      "assets/icons/Upload-Icon.png"),
                                ),
                              )
                            : Container(
                                // alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    dashboradImage,
                                  ),
                                  radius: 100.0,
                                  // child:
                                ),
                              ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'ContactEmail : $contactEmail',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.2,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Contact Number : $contactNumber',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
