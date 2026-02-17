class MessageModel {
  final String text;
  final bool isMe;
  final String time;
  final String? imageUrl;

  MessageModel({
    required this.text,
    required this.isMe,
    required this.time,
    required this.imageUrl,
  });
}
List<MessageModel> messages = [
  MessageModel(
    text: "Hello Dr. Mitchell, I have been experiencing some chest discomfort lately.",
    isMe: true,
    time: "10:00 AM",
    imageUrl:"https://randomuser.me/api/portraits/men/32.jpg",
  ),
  MessageModel(
    text: "Hello John, I'm sorry to hear that. Can you describe the discomfort?",
    isMe: false,
    time: "10:05 AM",
    imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
  ),
  MessageModel(
    text: "It's more of a dull ache, usually after physical activity.",
    isMe: true,
    time: "10:08 AM",
    imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
  ),
  MessageModel(
    text: "Thank you for the details. Let's discuss this further.",
    isMe: false,
    time: "10:12 AM",
    imageUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
  ),
];
