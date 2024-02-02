
import 'package:http/http.dart';
import 'package:samplec/MyData.dart';
import 'apiProvider.dart';

class GenericRepo {
  var apiProvider = ApiProvider();
  Future<Response?> loginRequest(MyData loginRequest) {
    return apiProvider.loginRequest(loginRequest);
  }
  Future<Response?> checkUser(String mobileNumber) {
    return apiProvider.checkUser(mobileNumber);
  }
}
