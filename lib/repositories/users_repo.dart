import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/utills/user_utils.dart';

import '../models/user.dart';

class UsersRepo {
  Stream<List<User>> getUsers()  {
    var stream1 = FirebaseFirestore.instance
        .collection("users")
        .snapshots()
        .transform(UserUtils.transformer(User.fromJson));
    return stream1;
    // var data = await FirebaseFirestore.instance.collection("users").get();
    // return data.docs.map((e) {
    //   var data = e.data();
    //   data.addAll({"documentId":e.id});
    //   return User.fromJson(data);
    //   }).toList();
  }
}
