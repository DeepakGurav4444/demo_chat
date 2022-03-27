import 'package:demo_chat/pages/chat_page.dart';
import 'package:demo_chat/pages/start_page.dart';
import 'package:demo_chat/pages/users_page.dart';
import 'package:demo_chat/providers/chat_page_provider.dart';
import 'package:demo_chat/providers/start_page_provider.dart';
import 'package:demo_chat/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../pages/login_page.dart';
import '../providers/login_provider.dart';

final navigationKey = GlobalKey<NavigatorState>();
makeRoute(
    {required BuildContext context,
    required String routeName,
    Object? arguments}) {
  final PageRoute child =
      _buildRoute(context: context, routeName: routeName, arguments: arguments);
  return child;
}

_buildRoute({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) {
  switch (routeName) {
    // case '/':
    // // return normalPageRoute(context: context, page: BottomNavbarPage());

    case '/':
      return normalPageRoute(
        context: context,
        page: ChangeNotifierProvider<StartPageProvider>(
          create: (context) => StartPageProvider(),
          child: const StartPage(),
        ),
      );
    case '/UsersPage':
      return normalPageRoute(
        context: context,
        page: ChangeNotifierProvider<UsersProvider>(
          create: (context) => UsersProvider(),
          child: const UsersPage(),
        ),
      );
    case '/LoginPage':
      return normalPageRoute(
        context: context,
        page: ChangeNotifierProvider<LoginProvider>(
          create: (context) => LoginProvider(),
          child: const LoginPage(),
        ),
      );
    case '/ChatPage':
      User anotherUser = arguments as User;
      return normalPageRoute(
        context: context,
        page: ChangeNotifierProvider<ChatPageProvider>(
          create: (context) => ChatPageProvider(anotherUser: anotherUser),
          child: const ChatPage(),
        ),
      );

    default:
      throw 'Route $routeName is not defined';
  }
}

normalPageRoute({
  required BuildContext context,
  required Widget page,
}) =>
    MaterialPageRoute(
        builder: (BuildContext context) => page,
        maintainState: true,
        fullscreenDialog: false);
