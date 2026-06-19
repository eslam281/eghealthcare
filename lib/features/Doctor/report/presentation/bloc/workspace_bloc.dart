import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/ChatMessage_model.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  WorkspaceBloc() : super(WorkspaceState()) {

    // 1. تحميل بيانات الصفحة
    on<LoadWorkspaceData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // TODO: هنا هتنادي على الـ API عشان تجيب بيانات المريض والـ History
      await Future.delayed(const Duration(seconds: 1)); // Mock API Call
      emit(state.copyWith(isLoading: false, hasHistory: true)); // غير لـ false عشان تشوف الشاشة الفاضية
    });

    // 2. تحديث نص التقرير
    on<UpdateReportText>((event, emit) {
      emit(state.copyWith(reportText: event.text));
    });

    // 3. إرسال رسالة للـ RAG
    on<SendChatMessage>((event, emit) async {
      // ضيف رسالة اليوزر الأول
      final updatedHistory = List<ChatMessage>.from(state.chatHistory)
        ..add(ChatMessage(text: event.message, isUser: true));
      emit(state.copyWith(chatHistory: updatedHistory, isLoading: true));

      // TODO: هنا هتنادي على الـ AI API
      await Future.delayed(const Duration(seconds: 2)); // Mock AI Delay

      // ضيف رد الـ AI
      updatedHistory.add(ChatMessage(
          text: "هذا رد تجريبي من الـ RAG Agent بناءً على الداتا المتاحة.",
          isUser: false));
      emit(state.copyWith(chatHistory: updatedHistory, isLoading: false));
    });

    // 4. حفظ التقرير
    on<SaveReport>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // TODO: نادى على الـ API عشان تحفظ الـ Report
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(isLoading: false));
    });
  }
}
