import 'package:http/http.dart';
import 'package:samplec/mobile/model/MyData.dart';
import 'package:samplec/mobile/model/VerifyOtpCode.dart';
import 'apiProvider.dart';

class GenericRepo {
  var apiProvider = ApiProvider();

  Future<Response?> loginRequest(MyData loginRequest) {
    return apiProvider.loginRequest(loginRequest);
  }

  Future<Response?> checkUser(String mobileNumber) {
    return apiProvider.checkUser(mobileNumber);
  }

  Future<Response?> sendOtp(MyData mobileNumber) {
    return apiProvider.sendOtp(mobileNumber);
  }

  Future<Response?> verifyOtp(VerifyOtpCode verifyOtpCode) {
    return apiProvider.verifyOtp(verifyOtpCode);
  }

  Future<Response?> start(MyData myData) {
    return apiProvider.start(myData);
  }

  Future<Response?> pair(MyData myData) {
    return apiProvider.pair(myData);
  }

  Future<Response?> remove(MyData myData) {
    return apiProvider.remove(myData);
  }

  Future<Response?> getUserFromId(String connectedUser) {
    return apiProvider.getUserFromId(connectedUser);
  }
}
