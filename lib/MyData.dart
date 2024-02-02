class MyData {
  String? id = "";
  String? gender = "";
  String? email = "";
  String? interestedIn = "";
  String? name = "";
  String? nickName = "";
  String? mobileNumber = "";
  bool? accountStatus=true;
  bool? blockedStatus=false;
  int? blockedCount=0;

  static final MyData _httpClientManager = MyData._internal();

  factory MyData() {
    return _httpClientManager;
  }

  MyData._internal();

  MyData._();

  MyData.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    id = json['id'];
    accountStatus = json['accountStatus'];
    blockedStatus = json['blockedStatus'];
    blockedCount = json['blockedCount'];
    email = json['email'];
    interestedIn = json['interestedIn'];
    name = json['name'];
    nickName = json['nickName'];
    mobileNumber = json['mobileNumber'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['id'] = id;
    data['accountStatus'] = accountStatus;
    data['blockedStatus'] = blockedStatus;
    data['blockedCount'] = blockedCount;
    data['email'] = email;
    data['interestedIn'] = interestedIn;
    data['name'] = name;
    data['nickName'] = nickName;
    data['mobileNumber'] = mobileNumber;
    return data;
  }

  bool checkFirstPageStatus() {
    if (gender != "" && email != "" && interestedIn != "") {
      return true;
    } else {
      return false;
    }
  }
  bool checkSecondPageStatus() {
    if (name != "") {
      return true;
    } else {
      return false;
    }
  }
  bool checkLoginScreenStatus() {
    if (mobileNumber != "") {
      return true;
    } else {
      return false;
    }
  }
}
