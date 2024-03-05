class VerifyOtpCode {
  String? mobileNumber;
  String? otp;

  VerifyOtpCode({this.mobileNumber, this.otp});

  VerifyOtpCode.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobileNumber'] = this.mobileNumber;
    data['otp'] = this.otp;
    return data;
  }
}