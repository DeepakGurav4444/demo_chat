import 'package:demo_chat/providers/chat_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatField extends StatefulWidget {
  const ChatField({Key? key}) : super(key: key);

  @override
  State<ChatField> createState() => _ChatFieldState();
}

class _ChatFieldState extends State<ChatField> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<ChatPageProvider>(
      builder: (context, chatModel, child) => Container(
        height: size.height*0.08,
        color: Colors.transparent,
        padding: EdgeInsets.all(size.width*0.02),
        child: Row(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<String>(
                  stream: chatModel.chatField,
                  builder: (context, snapshot) {
                    return TextField(
                        controller: chatModel.chatFieldController,
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: true,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: 'Type your message',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 0),
                            gapPadding: 10,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onChanged: chatModel.changeUserChat);
                  }),
            ),
            // SizedBox(width: size.width * 0.01),

            StreamBuilder<bool>(
                stream: chatModel.validChat,
                builder: (context, snapshot) {
                  return ElevatedButton(
                      onPressed: snapshot.hasData ? ()async=> chatModel.callSendMessage() : null,
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.zero),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                              const CircleBorder())),
                      child: Icon(
                        Icons.send,
                        size: size.width * 0.06,
                        color: Colors.white,
                      ));
                }),

            // GestureDetector(
            //   onTap: ,
            //   child: Container(
            //     padding: const EdgeInsets.all(8),
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.blue,
            //     ),
            //     child: const Icon(Icons.send, color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
