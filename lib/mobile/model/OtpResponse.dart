class OtpResponse {
  bool? status;
  String? requestId;
  int? status_code ;
  List<String>? message=[];

  OtpResponse();

  OtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    requestId = json['request_id'];
    status_code = json['status_code'];
    message = json['message'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['request_id'] = this.requestId;
    data['status_code'] = this.status_code;
    data['message'] = this.message;
    return data;
  }
}
