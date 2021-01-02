import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/getLevelResponse.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Level extends StatefulWidget {
  final GetLevelResponse getLevelResponse;
  final BannerResponse bannerResponse;

  const Level({Key key, @required this.getLevelResponse, this.bannerResponse})
      : super(key: key);
  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  String level1;
  String level2;
  String accessToken;

  int top_nav;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    getDataFromSharedPrefs();
    level1 = widget.getLevelResponse.result[0].content;
    level2 = widget.getLevelResponse.result[1].content;

    String s = widget.bannerResponse.data.top_nav;
    String ss = "0xff" + s.substring(1);
    top_nav = int.parse(ss);
    print(level1);
    print(level2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomView.appBarCustom('Menu-Icon-01', 'Bt-Close-01', () {
        // _scaffoldKey.currentState.openDrawer();
        // Navigator.of(context).pop();
      }, () {
        Navigator.of(context).pop();
      }, isLeading: false, isAction: true, title: 'level', top_nav: top_nav),
      body: ListView(
        children: [
          Column(
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
                        ))),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0.0,
                      top: 25,
                      bottom: 25,
                      right: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(130),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      top: 0.0,
                      bottom: 130,
                      right: 260,
                      child: Container(
                        height: 10,
                        width: 10,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: kfontColorBlue4,
                                ),
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: -6.0,
                                  blurRadius: 6.0,
                                ),
                                // BoxShadow(
                                //   color: Colors.blue[800],
                                //   blurRadius: 5.0, // soften the shadow
                                //   spreadRadius: -5.0, //extend the shadow
                                //   offset: Offset(
                                //     0.0, // Move to right 10  horizontally
                                //     0.0, // Move to bottom 5 Vertically
                                //   ),
                                // )
                              ],
                              // color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: kfontColorBlue4,
                                width: 4.0,
                              )),
                          child: Center(
                            child: Text(
                              '1',
                              style: kheadingStyle.apply(
                                fontWeightDelta: 6,
                                fontSizeFactor: 2.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 140,
                      top: 40,
                      child: Container(
                        width: 110,
                        child: Text(
                          '\tYOU ARE IN LEVEL 1 ',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 6,
                            fontSizeFactor: 1.2,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 40,
                      top: 100,
                      child: Container(
                        width: 150,
                        child: Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting',
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                          softWrap: true,
                          style: kheadingStyle.apply(
                            fontWeightDelta: 4,
                            fontSizeFactor: 0.8,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: widget.getLevelResponse.result.length,
                    itemBuilder: (BuildContext context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 20),
                            height: 50,
                            child: Text(
                              widget.getLevelResponse.result[index].name,
                              style: kheadingStyle.apply(
                                fontWeightDelta: 5,
                                fontSizeFactor: 1.5,
                                color: Color(0xff004fc1),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 20.0, left: 20, right: 20),
                            child: Text(
                              widget.getLevelResponse.result[index].content,
                              style: kheadingStyle.apply(
                                color: Color(0xff000000),
                                fontWeightDelta: 2,
                                fontSizeFactor: 1,
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
}
