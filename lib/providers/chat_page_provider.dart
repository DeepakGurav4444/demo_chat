import 'dart:async';

import 'package:demo_chat/repositories/chat_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../models/message.dart';
import '../models/user.dart';
import '../utills/save_data.dart';

class ChatPageProvider extends ChangeNotifier {
  DateFormat dateFormat = DateFormat("dd MMM h:mm aa");
  TextEditingController chatFieldController = TextEditingController();
  final userChat = BehaviorSubject<String>();

  // get
  Stream<String> get chatField => userChat.stream.transform(
        StreamTransformer<String, String>.fromHandlers(
          handleData: (chat, sink) =>
              chat.isEmpty ? sink.addError("Empty") : sink.add(chat),
        ),
      );

  Stream<bool> get validChat => chatField.map((event) => true);

// set
  Function(String) get changeUserChat => userChat.sink.add;

  final User anotherUser;
  User? currentUser;
  User? get getCurrentUser => currentUser;
  set setUserData(User? val) {
    currentUser = val;
    notifyListeners();
  }

  Future<void> retrieveUserData() async {
    String? savedUserData = await SaveData.getUserData();
    setUserData = User.decode(savedUserData!);
  }

  String getConvertedDate(DateTime date) => dateFormat.format(date);

  ChatPageProvider({required this.anotherUser});

  ChatRepo chatRepo = ChatRepo();

  Stream<List<Message>> fetchMessags() {
    return chatRepo.getChats(
        id1: getCurrentUser!.documentId!, id2: anotherUser.documentId!);
  }

  Future<void> callSendMessage() async {
    try {
      await chatRepo.sendMessage(Message(
          senderId: getCurrentUser!.documentId,
          receiverId: anotherUser.documentId,
          message: userChat.value,
          insertDate: DateTime.now()));

      chatFieldController.clear();
      userChat.addError("Empty");
    } catch (err) {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

  bool getIsMe(Message message) =>
      message.senderId == getCurrentUser!.documentId ? true : false;

  List<Message> getChatMessages(List<Message> val) {
    List<Message> filteredList = [];
    for (var element in val) {
      if (filteredList.indexWhere(
              (filElement) => element.documentId == filElement.documentId) ==
          -1) {
        filteredList.add(element);
      }
    }
    filteredList.sort((a, b) => b.insertDate!.compareTo(a.insertDate!));
    return filteredList;
  }

  @override
  void dispose() {
    userChat.close();
    super.dispose();
  }
}
