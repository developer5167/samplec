import 'package:samplec/constants.dart';
class Connect {
  static loginRequestConnectionUrl() {
    return Uri.parse("${BASE_URL}app/create");
  }
  static checkUser(String mobileNumber) {
    print('${BASE_URL}app/checkUser?mobileNumber=$mobileNumber');
    return Uri.parse("${BASE_URL}app/checkUser?mobileNumber=$mobileNumber");
  }
}
