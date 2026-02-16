import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChatHeader extends StatelessWidget {
  const ChatHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusGeometry.circular(5),
          border: Border.all(color: Colors.grey)
      ),
      child: const Row(
        children: [

          CircleAvatar(
            radius: 24,
            backgroundImage: CachedNetworkImageProvider("https://randomuser.me/api/portraits/men/32.jpg"),
          ),

          SizedBox(width: 12),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                "Dr. Sarah Mitchell",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 4),

              Row(
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.green,
                  ),
                  SizedBox(width: 6),
                  Text(
                    "Online",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
