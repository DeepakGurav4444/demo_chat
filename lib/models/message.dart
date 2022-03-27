import 'package:demo_chat/utills/message_util.dart';

class Message {
  String? senderId;
  String? receiverId;
  String? message;
  DateTime? insertDate;
  String? documentId;

  Message(
      {this.senderId,
      this.receiverId,
      this.message,
      this.insertDate,
      this.documentId});

  Message.fromJson(Map<String, dynamic> json) {
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'];
    insertDate = MessageUtils.toDateTime(json['insert_date']);
    documentId = json['documentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['insert_date'] = MessageUtils.fromDateTimeToJson(insertDate);
    // data['documentId'] = documentId;
    return data;
  }
}
