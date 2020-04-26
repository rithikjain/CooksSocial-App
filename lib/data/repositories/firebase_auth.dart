import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebasePhoneAuth {
  String verificationID;

  Future<void> sendCodeToPhoneNumber(String phoneNumber) async {
    final PhoneVerificationCompleted verificationCompleted = (_) {
      print("Verified");
    };

    final PhoneVerificationFailed verificationFailed = (AuthException e) {
      print(e.message);
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationID = verificationId;
      print("Code Sent");
    };

    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.verificationID = verificationId;
      print("Time out");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      timeout: Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void signInPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID,
      smsCode: smsCode,
    );
    AuthResult authResult = await FirebaseAuth.instance.signInWithCredential(credential);
    FirebaseUser user = authResult.user;
    if (user != null) {
      print("Signed In");
    }
  }
}
