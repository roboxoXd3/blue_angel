import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RatingAppByUser extends StatefulWidget {
  @override
  _RatingAppByUserState createState() => _RatingAppByUserState();
}

class _RatingAppByUserState extends State<RatingAppByUser> {
  String accessToken;
  getDataFromSharedPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      accessToken = sharedPreferences.getString("access_token");
    });
  }

  RateMyApp _rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    minDays: 3,
    minLaunches: 7,
    remindDays: 2,
    remindLaunches: 5,
    // appStoreIdentifier: '',
    // googlePlayIdentifier: ''
  );

  @override
  void initState() {
    getDataFromSharedPrefs();
    super.initState();

    _rateMyApp.init().then((_) {
      if (_rateMyApp.shouldOpenDialog) {
        //conditions check if user already rated the app
        _rateMyApp.showStarRateDialog(
          context,
          title: 'What do you think about Our App?',
          message: 'Please leave a rating',
          actionsBuilder: (_, stars) {
            return [
              // Returns a list of actions (that will be shown at the bottom of the dialog).
              FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  print('Thanks for the ' +
                      (stars == null ? '0' : stars.round().toString()) +
                      ' star(s) !');
                  if (stars != null && (stars == 4 || stars == 5)) {
                    //if the user stars is equal to 4 or five
                    // you can redirect the use to playstore or                         appstore to enter their reviews

                  } else {
// else you can redirect the user to a page in your app to tell you how you can make the app better

                  }
                  // You can handle the result as you want (for instance if the user puts 1 star then open your contact page, if he puts more then open the store page, etc...).
                  // This allows to mimic the behavior of the default "Rate" button. See "Advanced > Broadcasting events" for more information :
                  await _rateMyApp
                      .callEvent(RateMyAppEventType.rateButtonPressed);
                  Navigator.pop<RateMyAppDialogButton>(
                      context, RateMyAppDialogButton.rate);
                },
              ),
            ];
          },
          dialogStyle: DialogStyle(
            titleAlign: TextAlign.center,
            messageAlign: TextAlign.center,
            messagePadding: EdgeInsets.only(bottom: 20.0),
          ),
          starRatingOptions: StarRatingOptions(),
          onDismissed: () =>
              _rateMyApp.callEvent(RateMyAppEventType.laterButtonPressed),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rate My App'),
      ),
    );
  }
}
