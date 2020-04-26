import 'package:cooks_social/data/repositories/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnterPhone extends StatefulWidget {
  @override
  _EnterPhoneState createState() => _EnterPhoneState();
}

class _EnterPhoneState extends State<EnterPhone> {
  TextEditingController phoneNumController;
  TextEditingController otpController;

  FirebasePhoneAuth auth = FirebasePhoneAuth();

  @override
  void initState() {
    super.initState();
    phoneNumController = TextEditingController();
    otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter phone num"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: phoneNumController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Phone number",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Submit"),
              onPressed: () {
                auth.sendCodeToPhoneNumber(phoneNumController.text);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24),
            child: TextField(
              controller: otpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "OTP",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: RaisedButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: Text("Verify"),
              onPressed: () {
                auth.signInPhoneNumber(otpController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
