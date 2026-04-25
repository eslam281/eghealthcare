import 'package:bloc/bloc.dart';
import 'package:eghealthcare/features/Patient/Find%20Doctors/domain/entities/appointment_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';

import '../../../../../injection_container.dart';
import '../../domain/usecases/createAppointment_usecase.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  BookAppointmentBloc() : super(BookingInitial()) {
    on<SubmitBooking>(_onSubmit);
  }
  late final AppointmentEntity appointment;

  Future<void> _onSubmit(SubmitBooking event, Emitter<BookAppointmentState> emit,) async {
    emit(BookingLoading());
    final patientId = await sl<FlutterSecureStorage>().read(key: 'uid');
    try {
      final response = await sl<CreateAppointmentUseCase>().call(params: {
        'patientID':patientId,
        'doctorID': event.doctorId,
        'date': event.date,
        'time': event.time,
        'status':'Pending',
        'type':'Annual Checkup'
      });

      if (response.isLeft()) {
        final message = response.fold((l) => l, (r) => r);
        emit(BookingError(message.toString()));
        return;
      }

      appointment = response.fold((l) => l, (r) => r);
      emit(BookingSuccess(appointment));
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
