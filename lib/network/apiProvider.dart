import 'dart:convert';


import 'package:http/http.dart';
import 'package:samplec/MyData.dart';

import 'connect.dart';

class ApiProvider {
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };
  Map<String, String> loginHeader = {'Content-Type': 'application/json', 'Accept': 'application/json'};


  static Client? client;

  Client? getClient() {
    if (client == null) {
      return client = Client();
    }
    return client;
  }
  Future<Response?> loginRequest(MyData loginRequest) async {
    final response = await getClient()?.post(Connect.loginRequestConnectionUrl(), body: jsonEncode(loginRequest.toJson()),headers: loginHeader);
    return response;
  }
  Future<Response?> checkUser(String mobileNumber) async {
    final response = await getClient()?.post(Connect.checkUser(mobileNumber));
    return response;
  }
}
