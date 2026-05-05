part of 'chatbot_bloc.dart';

enum ChatStatus {
  initial,
  loading,
  success,
  error,
}

@immutable
class ChatbotState {
  final List<ChatMessage> messages;
  final bool isThinking;
  final ChatStatus status;
  final String? errorMessage;

  const ChatbotState({
    required this.messages,
    required this.isThinking,
    required this.status,
    this.errorMessage,
  });

  /// copyWith
  ChatbotState copyWith({
    List<ChatMessage>? messages,
    bool? isThinking,
    ChatStatus? status,
    String? errorMessage,
  }) {
    return ChatbotState(
      messages: messages ?? this.messages,
      isThinking: isThinking ?? this.isThinking,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  /// toJson
  Map<String, dynamic> toJson() => {
    "messages": messages.map((e) => e.toJson()).toList(),
    "isThinking": false,
    "status": status.index,
    "errorMessage": errorMessage,
  };

  /// fromJson
  factory ChatbotState.fromJson(Map<String, dynamic> json) {
    return ChatbotState(
      messages: (json["messages"] as List)
          .map((e) => ChatMessage.fromJson(e))
          .toList(),
      isThinking: false,
      status: ChatStatus.values[json["status"]],
      errorMessage: json["errorMessage"],
    );
  }
}