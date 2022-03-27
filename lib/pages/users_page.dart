import 'package:demo_chat/models/user.dart';
import 'package:demo_chat/providers/users_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final usersProvider = Provider.of<UsersProvider>(context, listen: false);
      usersProvider.retrieveUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<UsersProvider>(
      builder: (context, userModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text("Users"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async => await userModel.logOutUser(context),
                  icon: Icon(
                    Icons.logout,
                    size: size.width * 0.08,
                  ))
            ],
          ),
          body: userModel.getCurrentUser != null
              ? StreamBuilder<List<User>>(
                  stream: userModel.callUsersList(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        if (snapshot.hasError) {
                          if (kDebugMode) {
                            print(snapshot.error);
                          }
                          return buildText(
                              'Something Went Wrong Try later', size);
                        } else {
                          final users =
                              userModel.removeCurrentUser(snapshot.data);
                          return users.isNotEmpty
                              ? ListView.builder(
                                  itemCount: users.length,
                                  itemBuilder: (context, index) => ListTile(
                                      // padding: EdgeInsets.all(size.width*0.02),
                                      onTap: () async => await userModel
                                          .goToChatsPage(context, users[index]),
                                      contentPadding:
                                          EdgeInsets.all(size.width * 0.01),
                                      leading: Container(
                                          height: size.width * 0.15,
                                          width: size.width * 0.15,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  image: NetworkImage(users[index]
                                                      .profileImage!),
                                                  fit: BoxFit.fill))),
                                      title: Text(
                                          "${users[index].name}")))
                              : buildText("User not found", size);
                        }
                    }
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }

  Widget buildText(String text, Size size) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: size.width * 0.04),
        ),
      );
}
