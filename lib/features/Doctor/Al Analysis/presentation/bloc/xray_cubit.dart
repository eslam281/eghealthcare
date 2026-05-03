import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../data/models/xrayAnalysis_model.dart';
import '../../domain/usecases/aiAnalysis_usecase.dart';

part 'xray_state.dart';

class XRayCubit extends Cubit<XRayState> {
  XRayCubit() : super(XRayInitial());

  File? selectedImage;

  final ImagePicker picker = ImagePicker();
  late  XFile?  picked ;
  Future<void> pickImage() async {
    picked = await picker.pickImage(source: ImageSource.gallery);

    if (picked != null) {
      selectedImage = File(picked!.path);
      emit(XRayInitial());
    }
  }

  Future<void> analyzeImage() async {
    if (selectedImage == null) return;

    emit(XRayLoading());

    try {
      final response= await sl<AiAnalysisUseCase>().call(params: picked);
      response.fold((l) =>  emit(XRayError("Something went wrong $l")),
          (r) => emit(XRaySuccess(model: r))
      );

    } catch (e) {
      emit(XRayError("Something went wrong $e"));
    }
  }
}