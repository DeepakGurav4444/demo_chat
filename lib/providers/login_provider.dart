import 'package:demo_chat/models/user.dart';
import 'package:demo_chat/validation_blocs/login_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../models/login_request_model.dart';
import '../repositories/login_repo.dart';
import '../utills/save_data.dart';
import '../utills/show_loading.dart';

class LoginProvider extends ChangeNotifier with LoginValidator {
  TextEditingController mobileNumberController = TextEditingController();
  LoginRepo loginRepo = LoginRepo();

  TextEditingController passwordController = TextEditingController();
  final userMobileNo = BehaviorSubject<String>();
  final userpassword = BehaviorSubject<String>();
  // get
  Stream<String> get id => userMobileNo.stream.transform(validateMobileNumber);

  Stream<String> get password =>
      userpassword.stream.transform(validatepassword);
  Stream<bool> get validLogin =>
      Rx.combineLatest2(id, password, (a, b) => true);

// set
  Function(String) get changeuserMobileNo => userMobileNo.sink.add;
  Function(String) get changePassword => userpassword.sink.add;

  Future<void> callLoginControl(BuildContext context) async {
    var isLogin = await callLoginUser(context);
    if (isLogin) {
      Navigator.pushNamedAndRemoveUntil(context, "/UsersPage", (route) => false);
    }
  }

  Future<bool> callLoginUser(BuildContext context) async {
    try {
      ShowLoading.showLoading(context);
      User? loginResponse = await loginRepo.loginUser(LoginRequestModel(
        password: userpassword.value,
        mobileNumber: userMobileNo.value,
      ));
      Navigator.pop(context);
      if (loginResponse != null) {
        String userData = User.encode(loginResponse);
        await SaveData.saveUserData(userData);
        return true;
      } else {
        Fluttertoast.showToast(msg: "Mobile Number or Password Incorrect");
        return false;
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      Fluttertoast.showToast(msg: "Something went wrong");
      return false;
    }
  }

  @override
  void dispose() {
    userMobileNo.close();
    userpassword.close();
    super.dispose();
  }
}
