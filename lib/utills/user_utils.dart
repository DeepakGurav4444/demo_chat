import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/user.dart';

class UserUtils {
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<User>>
      transformer<T>(User Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<User>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<User>> sink) {
              final snaps = data.docs.map((doc) {
                var data = doc.data();
                data.addAll({"documentId": doc.id});
                return data;
              }).toList();

              final messages = snaps.map((json) => fromJson(json)).toList(); 
              sink.add(messages);
            },
          );
}
