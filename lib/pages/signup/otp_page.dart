import 'package:cooks_social/data/repositories/firebase_auth.dart';
import 'package:cooks_social/pages/signup/signup_page.dart';
import 'package:cooks_social/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
  int _state = 0;

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
                    child: SvgPicture.asset(
                      "assets/images/bg.svg",
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
                                width:
                                    MediaQuery.of(context).size.width * 2 / 3,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
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
                                        builder: (context) => MaterialButton(
                                          padding: EdgeInsets.all(18),
                                          child: setUpButtonChild(),
                                          color: Theme.of(context).primaryColor,
                                          onPressed: _state == 1
                                              ? null
                                              : () async {
                                                  bool isSignedIn = false;
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    setState(() {
                                                      _state = 1;
                                                    });
                                                    isSignedIn = await widget
                                                        .auth
                                                        .signInPhoneNumber(
                                                            _controller.text);
                                                    if (isSignedIn) {
                                                      setState(() {
                                                        _state = 2;
                                                      });
                                                      Navigator.pop(context);
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                SignupPage()),
                                                      );
                                                    } else {
                                                      setState(() {
                                                        _state = 0;
                                                      });
                                                      final snackBar = SnackBar(
                                                        content: Text(
                                                          "Hmm, looks like the OTP is incorrect, Try again!",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        backgroundColor:
                                                            Color(0xFFFC6C6C),
                                                      );
                                                      Scaffold.of(context)
                                                          .showSnackBar(
                                                              snackBar);
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

  Widget setUpButtonChild() {
    if (_state == 0) {
      return Text(
        "VERIFY OTP",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
      );
    } else if (_state == 1) {
      return Container(
        child: LinearProgressIndicator(backgroundColor: Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}
