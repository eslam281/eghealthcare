part of 'xray_cubit.dart';

@immutable
sealed class XRayState {}

class XRayInitial extends XRayState {}

class XRayLoading extends XRayState {}

class XRaySuccess extends XRayState {
  final String diagnosis;
  final double confidence;
  final File image;

  XRaySuccess({required this.diagnosis, required this.confidence, required this.image});
}

class XRayError extends XRayState {
  final String message;
  XRayError(this.message);
}

