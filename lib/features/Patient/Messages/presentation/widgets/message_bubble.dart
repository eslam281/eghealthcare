import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/message_model.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;

  const MessageBubble({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
      message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: message.isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!message.isMe)
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(50),
                child: CircleAvatar(
                  child: message.imageUrl != null
                      ? CachedNetworkImage(imageUrl:message.imageUrl!)
                      : const Icon(Icons.person),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 7),
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 280),
                decoration: BoxDecoration(
                  color: message.isMe
                      ? const Color(0xff14B8A6)
                      : const Color(0xffE5E7EB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isMe
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
              if (message.isMe)
              ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(50),
                child: CircleAvatar(
                  child: message.imageUrl != null
                      ? CachedNetworkImage(imageUrl:message.imageUrl!)
                      : const Icon(Icons.person),
                ),
              ),
            ],
          ),

          Text(
            message.time,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
