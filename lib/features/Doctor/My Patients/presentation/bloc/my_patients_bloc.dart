import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/patient_entity.dart' show PatientEntity;

part 'my_patients_event.dart';
part 'my_patients_state.dart';

class MyPatientsBloc extends Bloc<MyPatientsEvent, MyPatientsState> {
  MyPatientsBloc() : super(MyPatientsInitial()) {
    on<MyPatientsRequested>(_onMyPatientsRequested);
  }
  Future<void> _onMyPatientsRequested(MyPatientsRequested event, Emitter<MyPatientsState> emit) async {
    emit(MyPatientsLoading());
    try {
      final List<PatientEntity> dummyPatients = [
        const PatientEntity(
          id: "1",
          name: "John Anderson",
          age: 45,
          gender: "Male",
          image: "https://i.pravatar.cc/150?img=3",
          medicalSummary:
          "History of hypertension, managed with medication. Regular checkups recommended. No known allergies.",
        ),
        const PatientEntity(
          id: "2",
          name: "Sarah Williams",
          age: 32,
          gender: "Female",
          image: "https://i.pravatar.cc/150?img=5",
          medicalSummary:
          "Diabetic patient. Monitoring blood sugar levels regularly. Mild allergy to penicillin.",
        ),
        const PatientEntity(
          id: "3",
          name: "Michael Brown",
          age: 50,
          gender: "Male",
          image: "https://i.pravatar.cc/150?img=8",
          medicalSummary:
          "High cholesterol levels. On dietary plan and medication.",
        ),
      ];
      emit(MyPatientsLoaded(dummyPatients));
    } catch (e) {
      emit(MyPatientsError(e.toString()));
    }
  }

}
