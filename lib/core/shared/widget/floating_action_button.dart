import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/Doctor/Dashboard/presentation/bloc/chatbot_bloc.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          barrierColor: Colors.black54,
          builder: (_) => BlocProvider(
            create: (_) => ChatbotBloc(),
            child: const ChatBotDialog(),
          ),
        );
      },
      child: const Icon(Icons.support_agent),
    );
  }
}

class ChatBotDialog extends StatefulWidget {
  const ChatBotDialog({super.key});

  @override
  State<ChatBotDialog> createState() => _ChatBotDialogState();
}

class _ChatBotDialogState extends State<ChatBotDialog> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    context.read<ChatbotBloc>().add(Chatbot(text));
    controller.clear();


  }
  void scrollToBottom() {
    if (!scrollController.hasClients) return;

    final maxScroll = scrollController.position.maxScrollExtent;

    scrollController.animateTo(
      maxScroll,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: Container(
        width: 400,
        height: 520,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [

            /// Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xff2DD4BF),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.support_agent, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        "Help Assistant",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.white),
                    onPressed: () {
                      context.read<ChatbotBloc>().add(ClearChat());
                    },
                  )
                ],
              ),
            ),

            /// Messages
            Expanded(
              child: BlocBuilder<ChatbotBloc, ChatbotState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
                  return ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final msg = state.messages[index];
                      final isMe = msg.isMe;

                      return Align(
                        alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          constraints: const BoxConstraints(maxWidth: 260),
                          decoration: BoxDecoration(
                            color: isMe
                                ? const Color(0xff2DD4BF)
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(16),
                              topRight: const Radius.circular(16),
                              bottomLeft:
                              isMe ? const Radius.circular(16) : Radius.zero,
                              bottomRight:
                              isMe ? Radius.zero : const Radius.circular(16),
                            ),
                          ),
                          child: Text(
                            msg.text,
                            style: TextStyle(
                              color:
                              isMe ? Colors.white : Colors.black87,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            /// Thinking
            BlocBuilder<ChatbotBloc, ChatbotState>(
              builder: (context, state) {
                if (!state.isThinking) return const SizedBox();

                return const Padding(
                  padding: EdgeInsets.only(left: 16, bottom: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Thinking...",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              },
            ),

            /// Input
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Type your question...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xff2DD4BF),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.send,
                          color: Colors.white, size: 18),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}