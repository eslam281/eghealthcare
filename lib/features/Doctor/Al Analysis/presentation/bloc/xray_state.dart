part of 'xray_cubit.dart';

@immutable
sealed class XRayState {}

class XRayInitial extends XRayState {}

class XRayLoading extends XRayState {}

class XRaySuccess extends XRayState {
  final XrayAnalysisModel model;

  XRaySuccess({required this.model});
}

class XRayError extends XRayState {
  final String message;
  XRayError(this.message);
}

