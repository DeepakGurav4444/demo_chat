import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/message.dart';

class MessageUtils {
  static StreamTransformer<QuerySnapshot<Map<String, dynamic>>, List<Message>>
      transformer<T>(Message Function(Map<String, dynamic> json) fromJson) =>
          StreamTransformer<QuerySnapshot<Map<String, dynamic>>,
              List<Message>>.fromHandlers(
            handleData: (QuerySnapshot<Map<String, dynamic>> data,
                EventSink<List<Message>> sink) {
              final snaps = data.docs.map((doc) {
                var data = doc.data();
                data.addAll({"documentId": doc.id});
                return data;
              }).toList();

              final messages = snaps.map((json) => fromJson(json)).toList();

              sink.add(messages);
            },
          );

  static DateTime? toDateTime(Timestamp? value) {
    
    if (value == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(value.millisecondsSinceEpoch);
  }

  static dynamic fromDateTimeToJson(DateTime? date) {
    if (date == null) return null;
    return date.toUtc();
  }
}
