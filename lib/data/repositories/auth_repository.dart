import 'dart:convert';
import 'dart:io';

import 'package:cooks_social/data/models/login_response.dart';
import 'package:cooks_social/utils/constants.dart';
import 'package:http/http.dart' as http;

abstract class AuthRepository {
  Future<LoginResponse> loginUser(String email, password);
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<LoginResponse> loginUser(String email, password) async {
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
      if (response.statusCode == 201) {
        var data = json.decode(response.body);
        LoginResponse loginResponse = LoginResponse.fromJson(data);
        return loginResponse;
      } else if (response.statusCode == 404) {
        throw Exception("Incorrect credentials");
      } else {
        throw Exception();
      }
    } on SocketException {
      throw Exception("No internet connection");
    }
  }
}
