
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/Doctor/Dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../themes/app_colors_light.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      showDialog(
        context: context,
        barrierColor: Colors.transparent, // Keeps the background visible
        builder: (context) => const ChatBotDialog(),
      );
    }, shape: const CircleBorder(),
      child: const Icon(Icons.support_agent, color: Colors.white,),
    );
  }
}

class ChatBotDialog extends StatefulWidget {
  const ChatBotDialog({super.key});

  @override
  State<ChatBotDialog> createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  late List<Map<String, dynamic>> _messages ;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _messages=[] ;
    super.initState();
  }
  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;

    setState(() {
      _messages.add({"text": _controller.text, "isMe": true});
      _messages.add({"text": "Thinking...", "isMe": false, "isThinking": true});
    });

    context.read<DashboardBloc>().add(Chatbot(_controller.text));

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is ChatbotSuccess) {
          setState(() {
            _messages.removeLast(); // remove thinking
            _messages.add({
              "text": state.message,
              "isMe": false,
            });
          });
        }

        if (state is ChatbotError) {
          setState(() {
            _messages.removeLast();
            _messages.add({
              "text": state.message,
              "isMe": false,
            });
          });
        }
      },
    child:Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      alignment: Alignment.bottomRight, 
      child: Container(
        width: 400,
        height: 550,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColorsLight.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.support_agent, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Help Assistant",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Always here to help",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Messages List
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isMe = msg['isMe'] ?? false;
                  final isThinking = msg['isThinking'] ?? false;

                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.6),
                      decoration: BoxDecoration(
                        color: isMe ? AppColorsLight.primary : const Color(0xffF1F5F9),
                        borderRadius: BorderRadius.circular(15).copyWith(
                          bottomRight: isMe ? const Radius.circular(0) : null,
                          bottomLeft: !isMe ? const Radius.circular(0) : null,
                        ),
                      ),
                      child: Text(
                        msg['text'],
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black87,
                          fontStyle: isThinking ? FontStyle.italic : FontStyle.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            // Input Field
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade200)),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type your question...",
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                        filled: true,
                        fillColor: const Color(0xffF8FAFC),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xff2DD4BF), // Light teal for send button
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send, color: Colors.white, size: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
);
  }
}
