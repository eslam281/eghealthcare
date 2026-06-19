part of 'workspace_bloc.dart';

class WorkspaceState {
  final bool isLoading;
  final String reportText;
  final List<ChatMessage> chatHistory;
  final bool hasHistory; // عشان نحدد هنعرض شكل الـ Empty state ولا الداتا

  WorkspaceState({
    this.isLoading = false,
    this.reportText = '',
    this.chatHistory = const [],
    this.hasHistory = false,
  });

  WorkspaceState copyWith({
    bool? isLoading,
    String? reportText,
    List<ChatMessage>? chatHistory,
    bool? hasHistory,
  }) {
    return WorkspaceState(
      isLoading: isLoading ?? this.isLoading,
      reportText: reportText ?? this.reportText,
      chatHistory: chatHistory ?? this.chatHistory,
      hasHistory: hasHistory ?? this.hasHistory,
    );
  }
}