import 'dart:convert';


import 'package:http/http.dart';
import 'package:samplec/mobile/model/MyData.dart';
import 'package:samplec/mobile/model/VerifyOtpCode.dart';

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
  Future<Response?> sendOtp(MyData myData) async {
    final response = await getClient()?.post(Connect.sendOtp(), body: jsonEncode(myData.toJson()),headers: loginHeader);
    return response;
  }
  Future<Response?> verifyOtp(VerifyOtpCode verifyOtpCode) async {
    final response = await getClient()?.post(Connect.verifyOtp(), body: jsonEncode(verifyOtpCode.toJson()),headers: loginHeader);
    return response;
  }

  Future<Response?> start(MyData myData) async {
    final response = await getClient()?.post(Connect.start(), body: jsonEncode(myData.toJson()),headers: loginHeader);
    return response;
  }
  Future<Response?> pair(MyData myData) async {
    final response = await getClient()?.get(Connect.pair(myData.mobileNumber.toString()),headers: loginHeader);
    return response;
  }
  Future<Response?> remove(MyData myData) async {
    final response = await getClient()?.post(Connect.remove(), body: jsonEncode(myData.toJson()),headers: loginHeader);
    return response;
  }
  Future<Response?> getUserFromId(String connectedUser) async {
    final response = await getClient()?.get(Connect.getUserFromId(connectedUser),headers: loginHeader);
    return response;
  }
}
