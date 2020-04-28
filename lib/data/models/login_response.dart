import 'package:cooks_social/data/models/user.dart';

class LoginResponse {
  String message;
  String token;
  User user;

  LoginResponse({this.message, this.token, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }
}
