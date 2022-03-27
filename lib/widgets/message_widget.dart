import 'package:demo_chat/models/message.dart';
import 'package:demo_chat/providers/chat_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MesssageWidget extends StatelessWidget {
  final bool isMe;
  final Message message;
  const MesssageWidget({Key? key, required this.isMe, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const radius = Radius.circular(12);
    const borderRadius = BorderRadius.all(radius);
    return Consumer<ChatPageProvider>(
      builder: (context, chatModel, child) => Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            constraints: BoxConstraints(maxWidth: size.width*0.5),
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.grey[300]
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: isMe
                  ? borderRadius
                      .subtract(const BorderRadius.only(bottomRight: radius))
                  : borderRadius
                      .subtract(const BorderRadius.only(bottomLeft: radius)),
            ),
            child: buildMessage(chatModel,size),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(ChatPageProvider chatModel,Size size) => Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.message!,
            style: TextStyle(color: isMe ? Colors.black : Colors.white,fontSize: size.width*0.045),
            textAlign: isMe ? TextAlign.end : TextAlign.start,
          ),
          Text(chatModel.getConvertedDate(message.insertDate!),style: TextStyle(
            fontSize: size.width*0.035
          ),),
        ],
      );
}
