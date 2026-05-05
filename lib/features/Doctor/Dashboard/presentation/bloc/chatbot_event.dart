part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotEvent {}
final class Chatbot extends ChatbotEvent {
  final String message;
  Chatbot(this.message);
}
class ClearChat extends ChatbotEvent {}

