class ConvertFireStoreToClass {
  String? id = "";
  String? gender = "";
  String? email = "";
  String? interestedIn = "";
  String? name = "";
  String? nickName = "";
  String? mobileNumber = "";
  bool?   accountStatus=true;
  bool?   blockedStatus=false;
  int?    blockedCount=0;
  ConvertFireStoreToClass({this.id, this.name, this.gender, this.email, this.interestedIn, this.nickName, this.mobileNumber, this.accountStatus, this.blockedStatus, this.blockedCount});

  factory ConvertFireStoreToClass.fromFirestore(Map<String, dynamic> data) {
    return ConvertFireStoreToClass(
      id : data['id'],
      gender :data['gender'],
      email :data['email'],
      interestedIn : data['interestedIn'],
      name :data['name'],
      nickName :data['nickName'],
      mobileNumber : data['mobileNumber'],
      accountStatus:data['accountStatus'],
      blockedStatus:data['blockedStatus'],
      blockedCount:data['blockedCount'],
    );
  }
}
