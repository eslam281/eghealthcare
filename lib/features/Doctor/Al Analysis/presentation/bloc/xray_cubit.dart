import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'xray_state.dart';

class XRayCubit extends Cubit<XRayState> {
  XRayCubit() : super(XRayInitial());

  File? selectedImage;

  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage = File(picked.path);
      emit(XRayInitial());
    }
  }

  Future<void> analyzeImage() async {
    if (selectedImage == null) return;

    emit(XRayLoading());

    try {
      // TODO: replace with API
      await Future.delayed(const Duration(seconds: 2));

      emit(XRaySuccess(
        diagnosis: "12",
        confidence: 99.3,
        image: selectedImage!,
      ));
    } catch (e) {
      emit(XRayError("Something went wrong"));
    }
  }
}