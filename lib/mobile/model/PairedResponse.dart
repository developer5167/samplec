class PairedResponse {
  String? pairedUser="";
  String? message="";

  PairedResponse({this.pairedUser, this.message});

  PairedResponse.fromJson(Map<String, dynamic> json) {
    pairedUser = json['pairedUser'];
    message = json['message'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pairedUser'] = pairedUser;
    data['message'] = message;
    return data;
  }
}