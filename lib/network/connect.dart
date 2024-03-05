import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:samplec/constants.dart';
class Connect {
  static loginRequestConnectionUrl() {
    return Uri.parse("${BASE_URL}app/create");
  }
  static checkUser(String mobileNumber) {
    print('${BASE_URL}app/checkUser?mobileNumber=$mobileNumber');
    return Uri.parse("${BASE_URL}app/checkUser?mobileNumber=$mobileNumber");
  }
  static sendOtp() {
    print('${BASE_URL}app/sendOtp');
    return Uri.parse("${BASE_URL}app/sendOtp");
  }
  static verifyOtp() {
    print('${BASE_URL}app/verifyOtp');
    return Uri.parse("${BASE_URL}app/verifyOtp");
  }
  static start() {
    print('${BASE_URL}app/start');
    return Uri.parse("${BASE_URL}app/start");
  }
  static pair(String mobileNumber) {
    print('${BASE_URL}app/pair?mobileNumber=$mobileNumber');
    return Uri.parse("${BASE_URL}app/pair?mobileNumber=$mobileNumber");
  }
  static getUserFromId(String userId) {
    print('${BASE_URL}app/getUserFromId?userId=$userId');
    return Uri.parse("${BASE_URL}app/getUserFromId?userId=$userId");
  }
  static remove() {
    print('${BASE_URL}app/removeFromOnline');
    return Uri.parse("${BASE_URL}app/removeFromOnline");
  }
 static listenIndebugMode(){
    if (kDebugMode) {
      try {
        FirebaseFunctions.instance.useFunctionsEmulator('127.0.0.1', 5001);
        FirebaseFirestore.instance.useFirestoreEmulator('127.0.0.1', 8080);
      } catch (e) {
        print(e);
      }
    }
  }
}
