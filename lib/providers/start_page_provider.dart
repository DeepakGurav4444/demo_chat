import 'package:demo_chat/utills/save_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StartPageProvider extends ChangeNotifier {
  Future<bool> checkUserExist() async {
    var user = await SaveData.getUserData();
    if (user != null) {
      return true;
    }
    return false;
  }

  Future<void> goToRespectedPage(BuildContext context) async {
    var isLogin = await checkUserExist();
    if (isLogin) {
      Navigator.pushNamedAndRemoveUntil(
          context, "/UsersPage", (route) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, "/LoginPage", (route) => false);
    }
  }
}
