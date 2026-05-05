class ChatMessage {
  final String text;
  final bool isMe;

  ChatMessage({
    required this.text,
    required this.isMe,
  });

  Map<String, dynamic> toJson() => {
    "text": text,
    "isMe": isMe,
  };

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      text: json["text"],
      isMe: json["isMe"],
    );
  }
}