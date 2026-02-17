import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';
import '../widgets/chat_header.dart';
import '../widgets/message_bubble.dart';
import '../widgets/message_inputField.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            const Text('Messages'),
            Text("Communicate with your healthcare provider",
                style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        centerTitle: true,
        elevation: 0,),
      backgroundColor: const Color(0xffF8FAFC),
      body: Column(
        children: [

          /// Header
          const ChatHeader(),

          /// Messages
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return MessageBubble(
                  message: messages[index],
                );
              },
            ),
          ),

          /// Input
          const MessageInputField(),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: const Color(0xff14B8A6),
      //   child: const Icon(Icons.support_agent),
      // ),
    );
  }
}
