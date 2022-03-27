import 'package:demo_chat/repositories/users_repo.dart';
import 'package:demo_chat/utills/save_data.dart';
import 'package:flutter/cupertino.dart';

import '../models/user.dart';

class UsersProvider extends ChangeNotifier {
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

  Future<void> logOutUser(BuildContext context) async {
    await SaveData.clearValues();
    Navigator.pushNamedAndRemoveUntil(context, "/LoginPage", (route) => false);
  }

  List<User>? userList;

  List<User>? get getUsersList => userList;

  set setUsersList(List<User>? val) {
    userList = val;
    notifyListeners();
  }

  UsersRepo usersRepo = UsersRepo();
  Stream<List<User>> callUsersList() {
    return usersRepo.getUsers();
  }

  List<User> removeCurrentUser(List<User>? val) {
    if (val != null) {
      val.removeWhere(
          (element) => element.documentId == currentUser!.documentId);
      return val;
    }
    return [];
  }

  Future<void> goToChatsPage(BuildContext context, User user) async {
    Navigator.pushNamed(context, "/ChatPage", arguments: user);
  }
}
