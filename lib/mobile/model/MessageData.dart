class MessageData {
  String? message;
  String? senderId;
  bool? status;
  String? receiverId;
  String? messageId;
  String? chatId;

  MessageData(
      {this.message,
        this.senderId,
        this.status,
        this.receiverId,
        this.messageId});

  MessageData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    senderId = json['senderId'];
    status = json['status'];
    receiverId = json['receiverId'];
    messageId = json['messageId'];
    chatId = json['chatId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['senderId'] = senderId;
    data['status'] = status;
    data['receiverId'] = receiverId;
    data['messageId'] = messageId;
    data['chatId'] = chatId;
    return data;
  }
}