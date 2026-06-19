part of 'workspace_bloc.dart';

@immutable
sealed class WorkspaceEvent {}

class LoadWorkspaceData extends WorkspaceEvent {
  final String patientId;
  LoadWorkspaceData(this.patientId);
}

class UpdateReportText extends WorkspaceEvent {
  final String text;
  UpdateReportText(this.text);
}

class SendChatMessage extends WorkspaceEvent {
  final String message;
  SendChatMessage(this.message);
}

class SaveReport extends WorkspaceEvent {}