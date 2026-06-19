import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../bloc/workspace_bloc.dart';
import '../widgets/WorkspaceHeader.dart';
import '../widgets/SmartReportEditor.dart';
import '../widgets/RagAgentInsights.dart';

class ClinicalWorkspaceScreen extends StatelessWidget {
  const ClinicalWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkspaceBloc(
        makeReportUseCase: sl(),
        makeTemplateUseCase: sl(),
        chatRAGUseCase: sl(),
      )..add(LoadWorkspaceData('patient_123')),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocBuilder<WorkspaceBloc, WorkspaceState>(
          builder: (context, state) {
            if (state.isLoading && state.reportText.isEmpty && state.chatHistory.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WorkspaceHeader(state: state),
                    const SizedBox(height: 32),
                    SmartReportEditor(state: state),
                    const SizedBox(height: 32),
                    RagAgentInsights(state: state),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
