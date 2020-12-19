import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActiveSurvey extends StatefulWidget {
  final Map<String, Object> surveyDoc;
  final List<Map<String, Object>> listMap;

  ActiveSurvey({
    @required this.surveyDoc,
    @required this.listMap,
  });
  @override
  _ActiveSurveyState createState() => _ActiveSurveyState();
}

class _ActiveSurveyState extends State<ActiveSurvey> {
  String mobile;
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomView.appBarCustom(
        'Arrow-Icon-01',
        'Arrow-Icon-01',
        () {
          // Navigator.of(context).pop();
        },
        () {
          Navigator.of(context).pop();
        },
        isLeading: false,
        isAction: true,
        title: 'report page',
      ),
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
                    color1: Colors.black54,
                    color: Colors.white,
                    listColor: [Colors.white, Colors.white],
                    margin: 10,
                    child: ListView(
                      children: [
                        Container(
                          child: Table(
                            border: TableBorder.all(
                              color: Colors.blue[900],
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
                                          'S.N',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: 1.0,
                                            fontWeightDelta: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'Report Page',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: 1.0,
                                            fontWeightDelta: 5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    TableCell(
                                      child: Center(
                                        child: Text(
                                          'Date',
                                          style: kheadingStyle.apply(
                                            color: Colors.white,
                                            fontSizeDelta: 1.0,
                                            fontWeightDelta: 5,
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
                            itemCount: 10,
                            itemBuilder: (BuildContext context, index) {
                              return Table(
                                // defaultColumnWidth: FixedColumnWidth(100),
                                // columnWidths: {1: FractionColumnWidth(0.2)},
                                border: TableBorder.all(
                                  color: Colors.blue[900],
                                ),
                                children: [
                                  TableRow(
                                      // decoration:,
                                      children: [
                                        TableCell(
                                            child: Center(child: Text(''))),
                                        TableCell(
                                            child: Center(child: Text(''))),
                                        TableCell(
                                            child: Center(child: Text(''))),
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
              Container(
                alignment: Alignment.bottomRight,
                margin: const EdgeInsets.only(right: 25),
                child: CustomView.button(
                    circularRadius: 30,
                    isCircular: true,
                    buttonColor: Colors.blue,
                    buttonName: 'Button 1',
                    color: Colors.red,
                    function: () {},
                    height: 50,
                    width: 200,
                    textSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
