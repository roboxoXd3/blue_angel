import 'package:blue_angel/screens/Registration.dart';
import 'package:blue_angel/screens/login_screen.dart';
import 'package:blue_angel/utlis/values/styles.dart';
import 'package:blue_angel/widgets/custom_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VarifyOtp extends StatefulWidget {
  String mobile;
  String otp;
  VarifyOtp({@required this.mobile, @required this.otp});
  @override
  _VarifyOtpState createState() => _VarifyOtpState();
}

class _VarifyOtpState extends State<VarifyOtp> {
  String writtenOtp;
  final TextEditingController otpController = TextEditingController();

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Thanks"),
          content: new Text(
              """Your registration for Blu Angel is completed. You can "LOGIN" once your profile get activated"""),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogonError() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sorry"),
          content: new Text("Enter a valid OTP"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return LoginScreen();
                // }));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              height: 100,
              width: 55,
              child: Image.asset(
                'assets/images/Mascot-01.png',
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                // width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                    child: Form(
                  child: Column(
                    children: [
                      InputRegistration(
                        labeltext: "Number",
                        initialValue: widget.mobile,
                        textInputType: TextInputType.number,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InputRegistration(
                        otpController: otpController,
                        labeltext: "OTP",
                        textInputType: TextInputType.number,
                        onSaved: (value) {
                          setState(() {
                            writtenOtp = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (otpController.text == widget.otp) {
                            _showDialog();
                          } else {
                            _showDialogonError();
                          }
                        },
                        child: Card(
                          elevation: 10,
                          shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            // margin: EdgeInsets.all(value),
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0, vertical: 16),
                              child: Center(
                                child: Text(
                                  "SUBMIT",
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(10),
                              // image: DecorationImage(
                              //     fit: BoxFit.fill,
                              //     image:
                              //         AssetImage('assets/images/ButtonBG.png')),
                            ),
                          ),
                        ),
                      ),
                      // RaisedButton(
                      //   child: Text("Varify"),
                      //   onPressed: () {
                      //     if (otpController.text == widget.otp) {
                      //       _showDialog();
                      //     } else {
                      //       _showDialogonError();
                      //     }
                      //   },
                      // )
                    ],
                  ),
                )),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 4.0,
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                  gradient: LinearGradient(
                    colors: ksubBg,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomRight,
                  ),
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/images/background.png')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
