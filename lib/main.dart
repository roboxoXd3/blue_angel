import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/bannerResponse.dart';
import 'network/api_call.dart';
import 'screens/splash_screen.dart';

Future main() async {
  BannerResponse bannerResponse;

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var isSignedIn = prefs.getBool('isSigned') ?? false;
  // String version;
  if (isSignedIn) {
    var accessToken = prefs.getString('accessToken');
    var tokenCall = prefs.getString('tokenCall');
    // version = prefs.setString("version", packageInfo.version);
    ApiCall.token = accessToken;
    ApiCall.tokenCall = tokenCall;
    bannerResponse = await ApiCall.getBanner();
    CustomView.firstName = prefs.getString('firstName');
    CustomView.lastName = prefs.getString('lastName');
    CustomView.dob = prefs.getString('dob');
    CustomView.gender = prefs.getString('gender');
    if (bannerResponse != null && bannerResponse.status != "success") {
      bannerResponse = null;
    }
  }
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp(isSignedIn, bannerResponse));
}

class MyApp extends StatelessWidget {
  final bool isSignedIn;
  final BannerResponse bannerResponse;
  MyApp(this.isSignedIn, this.bannerResponse);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blu Angel',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreenPage(isSignedIn, bannerResponse),
      debugShowCheckedModeBanner: false,
    );
  }
}
