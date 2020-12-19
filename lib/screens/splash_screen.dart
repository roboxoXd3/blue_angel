import 'dart:async';
import 'package:blue_angel/models/bannerResponse.dart';
import 'package:blue_angel/screens/common/HomeScreen.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  final bool isSignedIn;
  final BannerResponse bannerResponse;
  SplashScreenPage(this.isSignedIn, this.bannerResponse);

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isSplashTimeout;
  startTime() async {
    return new Timer(
        new Duration(
          milliseconds: 4200,
        ), () {
      setState(() {
        isSplashTimeout = true;
      });
    }); // duration of splash to show
  }

  @override
  void initState() {
    isSplashTimeout = false;
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isSplashTimeout
        ? widget.isSignedIn && widget.bannerResponse!=null?HomeScreen(bannerResponse: widget.bannerResponse):LoginScreen()
        : new Image.asset(
            'assets/images/splash.gif',
            fit: BoxFit.cover,
          );
  }
}
