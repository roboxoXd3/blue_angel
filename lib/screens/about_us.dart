import 'package:blue_angel/models/aboutUsResponse.dart';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUs extends StatefulWidget {
  final AboutUsResponse aboutUsResponse;
  final BannerResponse bannerResponse;
  // final BannerResponse bannerResponse;
  AboutUs(this.aboutUsResponse, this.bannerResponse);
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  String img, content;
  String accessToken;
  int top_nav;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
      // top_nav = sharedPreferences.getInt('top_nav');
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    // getDataFromSharedPrefs();
    // ApiCall.getAboutPage();

    img = widget.aboutUsResponse.image;
    content = widget.aboutUsResponse.content;

    String s = widget.bannerResponse.data.top_nav;
    String ss = "0xff" + s.substring(1);
    top_nav = int.parse(ss);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String img = ApiCall.aboutData["image"];
    // String content = ApiCall.aboutData["content"];

    print('img : $img');
    print('content : $content');
    return Scaffold(
      appBar: CustomView.appBarCustom('Menu-Icon-01', 'Bt-Close-01', () {
        // _scaffoldKey.currentState.openDrawer();
        // Navigator.of(context).pop();
      }, () {
        Navigator.of(context).pop();
      }, isLeading: false, isAction: true, title: 'about us', top_nav: top_nav),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 200,
              height: 70,
              child: Image.asset('assets/images/LogoWithMascot-01.png'),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/images/Sub-Bg-AboutUs.png',
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: img == null
                    ? Image.asset(
                        'assets/images/Logo-01.png',
                        color: Colors.white,
                      )
                    : Image.network(img),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20),
              height: 50,
              child: Text(
                'About Us',
                style: kheadingStyle.apply(
                  fontWeightDelta: 5,
                  fontSizeFactor: 1.5,
                  color: Color(0xff004fc1),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
              child: content == null
                  ? Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      style: kheadingStyle.apply(
                        color: Color(0xff000000),
                        fontWeightDelta: 2,
                        fontSizeFactor: 1,
                      ),
                      softWrap: true,
                    )
                  : Text(
                      content,
                      style: kheadingStyle.apply(
                        color: Color(0xff000000),
                        fontWeightDelta: 2,
                        fontSizeFactor: 1,
                      ),
                      softWrap: true,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
