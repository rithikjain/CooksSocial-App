import 'package:cooks_social/data/repositories/firebase_auth.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:flutter/material.dart';

class OTPPage extends StatefulWidget {
  final FirebasePhoneAuth auth;

  OTPPage({@required this.auth});

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final _formKey = GlobalKey<FormState>();
  String _userNum = "8197512342";
  TextEditingController _controller = TextEditingController();

  getUserNum() async {
    _userNum = await SharedPref.getUserPhoneNum();
  }

  @override
  void initState() {
    super.initState();
    getUserNum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Stack(
                children: <Widget>[
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xFFFC6C6C),
                    ),
                    child: Image.asset(
                      "assets/images/bg.png",
                      fit: BoxFit.fill,
                      color: Color(0xFFDB162F),
                    ),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "OTP sent!",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Text(
                            "Please enter the 6-digit code sent to $_userNum",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 82,
                                  vertical: 32,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Form(
                                      key: _formKey,
                                      child: TextFormField(
                                        controller: _controller,
                                        validator: (value) {
                                          if (value.length != 6) {
                                            return "Please enter a valid OTP";
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: "Enter the 6 digit code",
                                          labelText: "Enter OTP",
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      margin: EdgeInsets.symmetric(
                                        vertical: 32,
                                      ),
                                      child: Builder(
                                        builder: (context) => FlatButton(
                                          padding: EdgeInsets.all(18),
                                          child: Text(
                                            "VERIFY OTP",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: () async {
                                            bool isSignedIn = false;
                                            if (_formKey.currentState
                                                .validate()) {
                                              isSignedIn = await widget.auth
                                                  .signInPhoneNumber(
                                                      _controller.text);
                                              if (isSignedIn) {
                                                print("SignedIn");
                                              } else {
                                                final snackBar = SnackBar(
                                                  content: Text(
                                                    "Hmm, looks like the OTP is incorrect, Try again!",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  backgroundColor: Color(0xFFFC6C6C),
                                                );
                                                Scaffold.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 40,
                          ),
                          child: Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                transform: Matrix4.translationValues(0, -20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}