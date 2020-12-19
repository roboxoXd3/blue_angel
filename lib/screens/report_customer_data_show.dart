import 'package:blue_angel/models/surveyReportResponse.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportcustomerDataShow extends StatefulWidget {
  // final List<Map<String, String>> formData;
  // final SurveyReportResponse surveyReportResponse;
  final String date;
  final String fullName,
      address,
      village,
      postOffice,
      thana,
      state,
      district,
      pincode,
      mobile,
      image,
      lat,
      lng;
  final Map<String, dynamic> formData;
  final bool namechange;
  ReportcustomerDataShow({
    @required this.fullName,
    @required this.address,
    @required this.district,
    @required this.mobile,
    @required this.pincode,
    @required this.postOffice,
    @required this.state,
    @required this.thana,
    @required this.village,
    @required this.formData,
    @required this.image,
    @required this.lat,
    @required this.lng,
    @required this.date,
    @required this.namechange,
  });
  @override
  _ReportcustomerDataShowState createState() => _ReportcustomerDataShowState();
}

class _ReportcustomerDataShowState extends State<ReportcustomerDataShow> {
  Map<String, dynamic> formDataShow;
  String _image;
  var result;
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  @override
  void initState() {
    // getDataFromSharedPrefs();
    getDataFromSharedPrefs();
    formDataShow = widget.formData;
    print(formDataShow);
    _image = widget.image;
    // result = widget.surveyReportResponse.result;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kmainBg,
      appBar: CustomView.appBarCustom(
        'Menu-Icon-01',
        'Arrow-Icon-01',
        () {
          // _scaffoldKey.currentState.openDrawer();
          // Navigator.of(context).pop();
        },
        () {
          Navigator.of(context).pop();
        },
        isLeading: false,
        isAction: true,
        title: widget.namechange ? 'Completed Page' : 'Report Page',
      ),
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
                    padding: const EdgeInsets.all(20),
                    shrinkWrap: true,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: _image == null
                            ? Container(
                                // alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                ),
                                child: CircleAvatar(
                                  radius: 50.0,
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
                                    _image,
                                  ),
                                  radius: 50.0,
                                  // child:
                                ),
                              ),
                      ),
                      if (widget.lng != null && widget.lat != null)
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Longitude : ${widget.lng}',
                                style: kheadingStyle.apply(
                                  fontWeightDelta: 3,
                                  fontSizeFactor: 1.0,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                'Latitude : ${widget.lng}',
                                style: kheadingStyle.apply(
                                  fontWeightDelta: 3,
                                  fontSizeFactor: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Created Date : ${widget.date}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Full Name : ${widget.fullName}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Address : ${widget.address}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Village : ${widget.village}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Post Office : ${widget.postOffice}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Thana : ${widget.thana}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'State : ${widget.state}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'district : ${widget.district}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Pincode : ${widget.pincode}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 20),
                        child: Text(
                          'Mobile Number : ${widget.mobile}',
                          style: kheadingStyle.apply(
                            fontWeightDelta: 3,
                            fontSizeFactor: 1.0,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            left: 20,
                            bottom: 20,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: formDataShow.length,
                            itemBuilder: (ctx, i) {
                              String key = formDataShow.keys.elementAt(i);
                              String value =
                                  formDataShow.values.elementAt(i).toString();
                              var val = formDataShow[key[i]];
                              print(formDataShow[i]);
                              return Row(
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    key.toString() == null
                                        ? 'null'
                                        : key.toString(),
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.0,
                                    ),
                                  ),
                                  Text(
                                    ' : ',
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    formDataShow[key].toString() == null
                                        ? 'null'
                                        : formDataShow[key].toString(),
                                    style: kheadingStyle.apply(
                                      fontWeightDelta: 3,
                                      fontSizeFactor: 1.0,
                                    ),
                                  ),
                                ],
                              );
                            },
                          )),
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
