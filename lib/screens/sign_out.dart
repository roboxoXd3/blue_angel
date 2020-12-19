import 'package:shared_preferences/shared_preferences.dart';

class SignOut {
  SignOut() {
    signOut();
  }

  signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("accessToken");
    sharedPreferences.setBool("isSigned", false);
  }
}
