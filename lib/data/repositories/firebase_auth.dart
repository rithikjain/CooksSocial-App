import 'package:firebase_auth/firebase_auth.dart';

class FirebasePhoneAuth {
  String verificationID;

  Future<void> sendCodeToPhoneNumber(String phoneNumber) async {
    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.verificationID = verificationId;
      print("Code Sent");
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      timeout: Duration(seconds: 4),
      verificationCompleted: null,
      verificationFailed: null,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: null,
    );
  }

  Future<bool> signInPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationID,
      smsCode: smsCode,
    );
    try {
      AuthResult authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseUser user = authResult.user;
      if (user != null) {
        print("Signed In");
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
