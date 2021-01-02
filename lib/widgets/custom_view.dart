import 'dart:convert';
// import 'dart:ffi';
import 'package:share/share.dart';
import 'dart:typed_data';
import 'dart:io' show Platform;
import 'package:blue_angel/models/aboutUsResponse.dart';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/models/getLevelResponse.dart';
import 'package:blue_angel/network/api_call.dart';
import 'package:blue_angel/screens/about_us.dart';
// import 'package:blue_angel/screens/common/rate_app.dart';
import 'package:blue_angel/screens/contactus.dart';
import 'package:blue_angel/screens/level.dart';
import 'package:blue_angel/screens/login_screen.dart';
import 'package:blue_angel/screens/request_with_admin.dart';
import 'package:blue_angel/screens/sign_out.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:launch_review/launch_review.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blue_angel/utlis/values/Global.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomView {
  BuildContext context;

  // String androidUrl, IOSUrl = '';
  static String firstName, lastName, gender, dob;

  static Widget appBarCustom(
    final String leadingImg,
    final String actionImg,
    final Function leadingFunction,
    final Function actionFunction, {
    final bool isLeading,
    final bool isAction,
    final String title,
    @required final int top_nav,
  }) {
    return AppBar(
      elevation: 20,
      centerTitle: true,
      // backgroundColor: kmainBg,
      backgroundColor: Color(top_nav),
      title: Text(
        '${title.toUpperCase()}',
        style: kheadingStyle.apply(fontSizeFactor: 1.5, fontWeightDelta: 7),
      ),
      leading: isLeading
          ? IconButton(
              icon: Image.asset(
                'assets/icons/$leadingImg.png',
                height: 20,
              ),
              onPressed: () async {
                leadingFunction();

                // _scaffoldKey.currentState.openDrawer();
              })
          : Container(),
      actions: <Widget>[
        isAction
            ? IconButton(
                icon: Image.asset(
                  'assets/icons/$actionImg.png',
                  height: 20,
                ),
                onPressed: () {
                  actionFunction();
                })
            : Container(),
      ],
    );
  }

  static Widget drawerCustom(BuildContext context, int side_nav) {
    return Drawer(
      elevation: 5.0,
      child: Container(
        // color: kblue,
        color: Color(side_nav),
        child: ListView(
          // padding: EdgeInsets.zero,
          children: <Widget>[
            _createHeader(context),
            Divider(),
            _createDrawerItem(
              icon: Image.asset('assets/icons/Traning-Icon.png'),
              text: "TRAINING ATTENDED",
              // onTap: () => Navigator.of(context).pushNamedAndRemoveUntil(
              //     '/home', (Route<dynamic> route) => false),
            ),
            Divider(),
            _createDrawerItem(
              icon: Image.asset('assets/icons/Level-Icon.png'),
              text: "LEVEL",
              onTap: () async {
                final GetLevelResponse getLevelResponse =
                    await ApiCall.getLevel();
                final BannerResponse bannerResponse = await ApiCall.getBanner();

                // if (getLevelResponse.status == "success")
                if (getLevelResponse.status == "success" &&
                    bannerResponse.status == "success") {
                  ApiCall.token = getLevelResponse.token;
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  sharedPreferences.setString(
                      "accessToken", getLevelResponse.token);
                  sharedPreferences.setString(
                      "top_nav", bannerResponse.data.top_nav.toString());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Level(
                        getLevelResponse: getLevelResponse,
                        bannerResponse: bannerResponse,
                      ),
                    ),
                  );
                }
              },
            ),
            Divider(),
            _createDrawerItem(
                icon: Image.asset('assets/icons/Admin-Icon.png'),
                text: "REQUEST WITH ADMIN",
                onTap: () async {
                  final BannerResponse bannerResponse =
                      await ApiCall.getBanner();
                  if (bannerResponse.status == "success") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RequestWithAdmin(
                          bannerResponse: bannerResponse,
                        ),
                      ),
                    );
                  }
                }),
            Divider(),
            _createDrawerItem(
              icon: Image.asset('assets/icons/AboutUs-Icon.png'),
              text: "ABOUT US",
              onTap: () async {
                final AboutUsResponse aboutUsResponse =
                    await ApiCall.getAboutPage();

                final BannerResponse bannerResponse = await ApiCall.getBanner();

                if (aboutUsResponse.status == "success" &&
                    bannerResponse.status == "success") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          AboutUs(aboutUsResponse, bannerResponse),
                      fullscreenDialog: true,
                    ),
                  );
                }
              },
            ),
            Divider(),
            _createDrawerItem(
                icon: Image.asset('assets/icons/Share-Icon.png'),
                text: "SHARE APP",
                onTap: () {
                  print('jjj');
                  Share.share(
                      'https://play.google.com/store/apps/details?id=com.example.blue_angel');
                  print('jk');
                }),
            Divider(),
            _createDrawerItem(
              icon: Image.asset('assets/icons/Rate-Icon.png'),
              text: "RATE APP",
              onTap: () {
                LaunchReview.launch(
                  androidAppId: "com.example.blue_angel",
                  // iOSAppId: "585027354",
                );
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => RatingAppByUser()));
              },
            ),
            Divider(),
            _createDrawerItem(
                icon: Image.asset('assets/icons/Contact-Icon.png'),
                text: "CONTACT US",
                onTap: () async {
                  final BannerResponse bannerResponse =
                      await ApiCall.getBanner();
                  if (bannerResponse.status == "success") {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ContactUs(
                          bannerResponse: bannerResponse,
                        ),
                      ),
                    );
                  }
                }),
            Divider(),
            _createDrawerItem(
                icon: Image.asset('assets/icons/LogOut-Icon.png'),
                text: "LOGOUT",
                onTap: () {
                  SignOut();

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  static Widget _createHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      // margin: EdgeInsets.all(32),
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: Colors.white,
      child: Image(
        image: AssetImage('assets/images/Logo-01.png'),
        fit: BoxFit.contain,
      ),
    );
  }

  static Widget _createDrawerItem(
      {Widget icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      leading: icon,
      title: Container(
        alignment: Alignment.bottomRight,
        child: Text(
          text,
          style: kheadingStyle.apply(color: Colors.white, fontWeightDelta: 5),
        ),
      ),
      onTap: onTap,
    );
  }

  static Widget button({
    double height,
    double width,
    Function function,
    String buttonName,
    double textSize,
    Color color,
    Color buttonColor,
    bool isCircular,
    double circularRadius,
  }) {
    return SizedBox(
      height: height,
      width: width,
      child: isCircular
          ? FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(circularRadius),
              ),
              color: buttonColor,
              onPressed: function,
              child: Text(
                buttonName,
                style: kheadingStyle.apply(
                  color: color,
                  fontWeightDelta: 4,
                ),
              ),
            )
          : FlatButton(
              color: buttonColor,
              onPressed: function,
              child: Text(
                buttonName,
                style: TextStyle(
                  fontSize: textSize,
                  color: color,
                ),
              ),
            ),
    );
  }

  static Widget editTextField(
      {double height,
      TextEditingController controller,
      String labelText,
      String hint,
      Color color,
      TextInputType keyborad = TextInputType.text,
      int maxLength,
      int maxLines,
      double size,
      int lengthLimiting,
      Function fn,
      Function validator,
      ValueKey key}) {
    return Container(
      // color: Colors.blue[50],
      // alignment: Alignment.bottomCenter,
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 4,
      ),
      child: TextFormField(
        key: key,
        expands: false,
        validator: validator,
        style: TextStyle(color: Color(0xff2d1f76), fontSize: 20.0),
        controller: controller,
        textAlign: TextAlign.start,
        keyboardType: keyborad,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(lengthLimiting),
        ],
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: fn,
        decoration: InputDecoration(
            isDense: true,
            labelText: labelText,
            // contentPadding:
            //     EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            hintText: hint,
            hintStyle: TextStyle(
              color: color,
              fontSize: size,
            ),
            filled: true,
            fillColor: Color(0xffbdd5f1),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            )),
      ),
    );
  }

  static bool emailValidation(String input) {
    var valid = false;
    var valid1 = false;
    var valid2 = false;
    input.runes.forEach((int rune) {
      var char = new String.fromCharCode(rune);
      if (char == '@') {
        valid1 = true;
      }
      if (char == '.') {
        valid2 = true;
      }
    });
    if (valid1 == true && valid2 == true) {
      valid = true;
    }
    return valid;
  }

  static bool nameValidation(String input) {
    var valid = true;
    input.runes.forEach((int rune) {
      var char = new String.fromCharCode(rune);
      for (int i = 0; i < 10; i++) {
        if (char == i.toString()) {
          valid = false;
        }
      }
    });
    return valid;
  }

  static bool mobileValidation(String input) {
    var valid = true;
    String pattern = r'(^([0-9]{10})$)';
    RegExp regExp = new RegExp(pattern);
    var match = regExp.allMatches(input);
    if (match.length == 0) {
      valid = false;
    } else {
      valid = true;
    }
    return valid;
  }

  static Widget buildImageWithText(BuildContext context, String imgName,
      String text, Color color, double margin1, Function fn) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            margin: EdgeInsets.only(left: margin1),
            child: GestureDetector(
              child: Image.asset('assets/icons/$imgName.png'),
              onTap: fn,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              text,
              style: kheadingStyle.apply(
                fontWeightDelta: 4,
                color: color,
                fontSizeFactor: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget buildTapCard(
    BuildContext context,
    String imgName,
    String text,
    Function fn,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height / 4.5,
      width: MediaQuery.of(context).size.width / 3.0,
      child: InkWell(
        onTap: () async {
          print('tap is working');
          fn();
        },
        child: Card(
          elevation: 10.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 10.0,
              ),
              Container(
                  height: 70,
                  width: 70,
                  child: Image.asset('assets/icons/$imgName.png')),
              const SizedBox(
                height: 5.0,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5.0),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    '${text.toUpperCase()}',
                    style: kheadingStyle.apply(
                      fontSizeFactor: 0.8,
                      fontWeightDelta: 7,
                    ),
                    textAlign: TextAlign.center,
                    softWrap: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  static Widget buildContainerCardUI(
      {Widget child, BuildContext context, Color color, double h, double w}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      height: MediaQuery.of(context).size.height - h,
      margin: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width - w,
      child: child,
    );
  }

  static Widget buildContainerBackgroundImage(
      {BuildContext context, Widget child}) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/Sub-BG-Active.png',
          ),
        ),
      ),
      child: child,
    );
  }

  static Widget buildContainerWithImage(
      {String imagePath, double h, double w}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10),
      height: h,
      width: w,
      child: Image.asset(
        imagePath,
        fit: BoxFit.fill,
      ),
    );
  }

  static showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static showProgressDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      child: new Dialog(
        child: Container(
          height: 60.0,
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 8.0,
              ),
              new CircularProgressIndicator(),
              SizedBox(
                width: 15.0,
              ),
              new Text(message),
            ],
          ),
        ),
      ),
    );
  }

  static hideProgressDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static Widget buildLargeContainer({
    Widget child,
    Color color,
    Color color1,
    List<Color> listColor,
    double margin,
    bool isOptional = true,
  }) {
    return Container(
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius:
            isOptional ? BorderRadius.circular(15) : BorderRadius.circular(0),
        color: color,
        gradient: LinearGradient(
          colors: listColor,
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          width: 4.0,
          style: BorderStyle.solid,
          color: color,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        margin: EdgeInsets.all(margin),
        padding: const EdgeInsets.all(0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: color1,
              // kfontColorBlue1,
              width: 2.0,
            )),
        child: child,
      ),
    );
  }

  static Widget buildDropDown({
    BuildContext context,
    String inputValue,
    List<String> list,
    String text,
    Function fn,
    Function fn1,
    ValueKey key,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 3, right: 10),
      decoration: BoxDecoration(
        color: Color(0xffbdd5f1),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      // border: Border.all(color: Colors.blue, width: 1)),
      child: DropdownButtonHideUnderline(
        // key: key,
        child: DropdownButton<String>(
          key: key,
          style: kheadingStyle.apply(
            fontWeightDelta: 3,
            fontSizeFactor: 1.0,
          ),
          // isDense: true,
          value: inputValue,
          autofocus: true,
          isExpanded: true,
          hint: new Container(
              padding: EdgeInsets.only(left: 5),
              child: FittedBox(
                child: Text(
                  text == null ? 'Value' : text,
                  style: kheadingStyle.apply(
                    fontWeightDelta: 3,
                    fontSizeFactor: 1.2,
                  ),
                ),
              )),
          icon: Container(
            height: 15.0,
            width: 15.0,
            child: Image.asset(
              'assets/icons/DropDown-Icon-01.png',
            ),
          ),
          iconSize: 20,
          onChanged: fn,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              onTap: fn1,
              value: value,
              child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    value,
                    style: kheadingStyle.apply(
                      fontWeightDelta: 3,
                      fontSizeFactor: 1.2,
                      color: Color(0xff2d1f76),
                    ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }

  static showInDialog(
      BuildContext context, String title, String value, Function fn,
      {Color color}) async {
    showDialog(
      context: context,
      child: new AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          // style: color == null
          //     ? null
          //     : kheadingStyle.apply(
          //         color: color,
          //         fontWeightDelta: 5,
          //         fontSizeFactor: 1.2,
          //       ),
        ),
        content: Text(
          value,
          textAlign: TextAlign.center,
        ),
        actions: [
          new FlatButton(
            child: const Text("Ok"),
            onPressed: () {
              fn();
            },
          ),
        ],
      ),
    );
  }

  static Widget checkbox(
    String title,
    bool boolValue,
    Function fn,
  ) {
    return Row(
      children: <Widget>[
        Checkbox(
          value: boolValue,
          onChanged: fn,
        ),
        Text(title),
      ],
    );
  }

  static Widget radiobox(String title, Function fn, int groupValue, int value) {
    return RadioListTile(
      activeColor: Colors.green,
      toggleable: true,
      onChanged: fn,
      groupValue: groupValue,
      value: value,
      title: Text(
        title,
        style: kheadingStyle.apply(
          fontSizeFactor: 1.2,
          fontWeightDelta: 5,
        ),
      ),
    );
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Future<void> share(String url) async {
    await FlutterShare.share(
      title: 'Blue Angel',
      linkUrl: url,
    );
  }

  static void referFuncation({
    @required String androidUrl,
    @required String iOSUrl,
    @required BuildContext context,
  }) {
    // Navigator.pop(context);
    print("enter3");
    if (Platform.isAndroid) {
      print("enter1");
      share('https://play.google.com/store/apps/details?id=' + androidUrl);
    } else if (Platform.isIOS) {
      print("enter2");
      share(iOSUrl);
    }
  }

  // static Widget ratingBarCustom(double ratingValue, Function fn) {
  //   return GestureDetector(
  //     onTap: fn,
  //     child: Stack(
  //       children: <Widget>[
  //         Align(
  //           alignment: Alignment.center,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               RatingBar(
  //                 initialRating: ratingValue,
  //                 direction: Axis.horizontal,
  //                 allowHalfRating: true,
  //                 itemCount: 5,
  //                 itemSize: 17.0,
  //                 itemBuilder: (context, _) => Icon(
  //                   Icons.star,
  //                   color: Colors.amber,
  //                 ),
  //                 onRatingUpdate: (double value) {},
  //               ),
  //               Text(
  //                 ratingValue.toString(),
  //                 style: TextStyle(color: Colors.red, fontSize: 16.0,),
  //               )
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static Widget radiobox(String title, Function fn, bool groupValue, int i,
  //     {int intValue = 1}) {
  //   return RadioListTile(
  //     activeColor: Colors.green,
  //     // onChanged: fn,
  //     title: Text(
  //       title,
  //       style: kheadingStyle.apply(
  //         fontSizeFactor: 1.2,
  //         fontWeightDelta: 5,
  //       ),
  //     ),
  //     value: i,
  //     groupValue: intValue,
  //     onChanged: i > 5
  //         ? null
  //         : (int value) {
  //             fn(() {
  //               intValue = value;
  //             });
  //           },
  //   );
  // }
  static showProgressDialogBar(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: Container(
          height: 60.0,
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 8.0,
              ),
              new CircularProgressIndicator(),
              SizedBox(
                width: 15.0,
              ),
              new Text(message),
            ],
          ),
        ),
      ),
    );
  }

  static Widget progressBar() {
    return Container(
      margin: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      padding: const EdgeInsets.all(10),
      // color: Colors.white,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: CircularProgressIndicator(
              semanticsLabel: 'Loading...',
            ),
          ),
          Container(
            child: Text(
              'Loading...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class ABC{ static Widget appBar{}}
// ABC.appBar
