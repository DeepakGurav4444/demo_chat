import 'package:demo_chat/models/message.dart';
import 'package:demo_chat/providers/chat_page_provider.dart';
import 'package:demo_chat/widgets/fields/chat_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/message_widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    final chatProvider = Provider.of<ChatPageProvider>(context, listen: false);
    chatProvider.retrieveUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ChatPageProvider>(
        builder: (context, chatModel, child) => Scaffold(
              appBar: AppBar(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: AppBar().preferredSize.height * 0.8,
                        width: AppBar().preferredSize.height * 0.8,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(chatModel.anotherUser.profileImage!),
                                fit: BoxFit.fill))),
                    Padding(
                      padding: EdgeInsets.only(left: size.width*0.02),
                      child: Text("${chatModel.anotherUser.name}"),
                    ),
                  ],
                ),
              ),
              bottomSheet: ChangeNotifierProvider<ChatPageProvider>.value(
                  value: chatModel, child: const ChatField()),
              body: Consumer<ChatPageProvider>(
                builder: (context, chatModel, child) => chatModel
                            .getCurrentUser !=
                        null
                    ? StreamBuilder<List<Message>>(
                      initialData: const [],
                        stream: chatModel.fetchMessags(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                  child: CircularProgressIndicator());
                            default:
                              if (snapshot.hasError) {
                                if (kDebugMode) {
                                  print(snapshot.error);
                                }
                                return buildText(
                                    'Something Went Wrong Try later', size);
                              } else {
                                final messages =
                                    chatModel.getChatMessages(snapshot.data!);
                                return messages.isEmpty
                                    ? buildText('Start your conversation', size)
                                    : ListView.builder(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.08),
                                        reverse: true,
                                        itemCount: messages.length,
                                        itemBuilder: (context, index) {
                                          final message = messages[index];
                                          return ChangeNotifierProvider<
                                              ChatPageProvider>.value(
                                            value: chatModel,
                                            child: MesssageWidget(
                                              message: message,
                                              isMe: chatModel.getIsMe(message),
                                            ),
                                          );
                                        },
                                      );
                              }
                          }
                        },
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ));
  }

  Widget buildText(String text, Size size) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: size.width * 0.04),
        ),
      );
}
