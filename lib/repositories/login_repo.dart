import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_chat/models/login_request_model.dart';

import '../models/user.dart';

class LoginRepo {
  Future<User?> loginUser(LoginRequestModel requestModel) async {
    List<User> userData=[];
    var resData = await FirebaseFirestore.instance
        .collection("users")
        .where("mobile_number", isEqualTo: requestModel.mobileNumber)
        .where("password", isEqualTo: requestModel.password)
        .get();
      userData = resData.docs.map((e) {
      var data = e.data();
      data.addAll({"documentId": e.id});
      return User.fromJson(data);
    }).toList();
    if(userData.isEmpty){
      return null;
    }
    return userData.single;
  }
}
