import 'package:cooks_social/data/models/user.dart';

class SignupResponse {
  String message;
  String token;
  User user;

  SignupResponse({this.message, this.token, this.user});

  SignupResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}