import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/chatMessage_model.dart';
import '../../domain/usecases/chatRAG_usecase.dart';
import '../../domain/usecases/makeReport_usecase.dart';
import '../../domain/usecases/makeTemplate_usecase.dart';

part 'workspace_event.dart';
part 'workspace_state.dart';

class WorkspaceBloc extends Bloc<WorkspaceEvent, WorkspaceState> {
  final MakeReportUseCase makeReportUseCase;
  final MakeTemplateUseCase makeTemplateUseCase;
  final ChatRAGUseCase chatRAGUseCase;

  WorkspaceBloc({
    required this.makeReportUseCase,
    required this.makeTemplateUseCase,
    required this.chatRAGUseCase,
  }) : super(WorkspaceState()) {

    // 1. تحميل بيانات الصفحة
    on<LoadWorkspaceData>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      // TODO: هنا هتنادي على الـ API عشان تجيب بيانات المريض والـ History
      await Future.delayed(const Duration(seconds: 1)); // Mock API Call
      emit(state.copyWith(isLoading: false, hasHistory: true)); // خليها true عشان تشوف الـ Filled state
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

      final result = await chatRAGUseCase.call(params: {
        "patientID":"vMHJe45VObOtljKdvwOyXNWpSn03",
        "question":event.message,
        "limit":5
      });

      result.fold(
        (failure) {
          updatedHistory.add(ChatMessage(text: "عذراً، حدث خطأ أثناء الاتصال بالـ AI.", isUser: false));
          emit(state.copyWith(chatHistory: updatedHistory, isLoading: false));
        },
        (response) {
          updatedHistory.add(ChatMessage(text: response.toString(), isUser: false));
          emit(state.copyWith(chatHistory: updatedHistory, isLoading: false));
        },
      );
    });

    // 4. حفظ التقرير
    on<SaveReport>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      
      final result = await makeReportUseCase.call(params: {
          "patientID":"vMHJe45VObOtljKdvwOyXNWpSn03",
          "content":"hifsdg",
          "doctorID":"anIvxQ9KsqNpD8Lm7dxkPqws9Hc2",
          "doctorName":"Dr. Nour Ali",
          "type":"diagnosis"
      });

      result.fold(
        (failure) => emit(state.copyWith(isLoading: false)),
        (success) => emit(state.copyWith(isLoading: false)),
      );
    });
  }
}
