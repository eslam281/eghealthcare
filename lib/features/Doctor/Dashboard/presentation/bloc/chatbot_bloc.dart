import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../data/models/chatbot_model.dart';
import '../../domain/usecases/chatbot_usecase.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends HydratedBloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc() : super(
    ChatbotState(
      messages: [ChatMessage(text: "Hello, how can I help you today?", isMe: false,)],
      isThinking: false,
      status: ChatStatus.initial,
    ),
  ) {
    on<Chatbot>(_onChatbot);
    on<ClearChat>((event, emit) {
      emit(state.copyWith(
        messages: [ChatMessage(text: "Hello, how can I help you today?", isMe: false,)],
        isThinking: false, status: ChatStatus.initial,
      ));
    });
  }

  Future<void> _onChatbot(Chatbot event, Emitter<ChatbotState> emit,) async {

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(text: event.message, isMe: true));

    emit(state.copyWith(
      messages: updatedMessages,
      isThinking: true,
      status: ChatStatus.loading,
    ));

    try {
      final response =
      await sl<ChatbotUseCase>().call(params: event.message);

      response.fold(
            (l) {
          emit(state.copyWith(
            messages: [
              ...updatedMessages,
              ChatMessage(text: "Error: $l", isMe: false),
            ],
            isThinking: false,
            status: ChatStatus.error,
            errorMessage: l.toString(),
          ));
        },
            (r) {
          emit(state.copyWith(
            messages: [
              ...updatedMessages,
              ChatMessage(
                text: r["reply"].toString(),
                isMe: false,
              ),
            ],
            isThinking: false,
            status: ChatStatus.success,
          ));
        },
      );
    } catch (e) {
      emit(state.copyWith(
        messages: [
          ...updatedMessages,
          ChatMessage(text: "Error: $e", isMe: false),
        ],
        isThinking: false,
        status: ChatStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  @override
  ChatbotState? fromJson(Map<String, dynamic> json) {
    return ChatbotState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(ChatbotState state) {
    return state.toJson();
  }
}