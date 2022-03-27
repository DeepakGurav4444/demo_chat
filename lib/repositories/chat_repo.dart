import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/message.dart';
import 'package:demo_chat/utills/message_util.dart';
import 'package:rxdart/rxdart.dart';

class ChatRepo {
  Stream<List<Message>> getChats({required String id1, required String id2}) {
    var stream1 = FirebaseFirestore.instance
        .collection("chats")
        .where("sender_id", whereIn: [id1, id2])
        .snapshots()
        .transform(MessageUtils.transformer(Message.fromJson));
    var stream2 = FirebaseFirestore.instance
        .collection("chats")
        .where("receiver_id", whereIn: [id1, id2])
        .snapshots()
        .transform(MessageUtils.transformer(Message.fromJson));
    return MergeStream([stream1, stream2]);
  }

  Future<void> sendMessage(Message message) async {
    await FirebaseFirestore.instance.collection('chats').add(message.toJson());   
  } 
}
