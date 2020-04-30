import 'dart:convert';
import 'dart:io';

import 'package:cooks_social/data/models/login_response.dart';
import 'package:cooks_social/data/models/signup_response.dart';
import 'package:cooks_social/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  Future<LoginResponse> loginUser({@required String email, @required String password}) async {
    String url = BASE_URL + "user/login";
    Map credentials = {
      "email": email,
      "password": password,
    };
    var body = json.encode(credentials);
    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        print(data);
        return loginResponse;
      } else if (response.statusCode == 404) {
        throw Exception("Incorrect credentials");
      } else {
        throw Exception("Oof, something wrong on our end");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }

  Future<SignupResponse> signupUser({@required FormData formData}) async {
    String url = BASE_URL + "user/register";
    try {
      var response = await Dio().post(
        url,
        data: formData,
        onSendProgress: (sent, total) {
          print("progress: $sent/$total");
        }
      );
      if (response.statusCode == 201) {
        var data = json.decode(response.data);
        SignupResponse signupResponse = SignupResponse.fromJson(data);
        print(data);
        return signupResponse;
      } else if (response.statusCode == 404) {
        throw Exception("Bad request");
      } else if (response.statusCode == 408) {
        throw Exception("Timeout");
      } else {
        throw Exception("Oof, something wrong on our end");
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }
}
