import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'book_appointment_event.dart';
part 'book_appointment_state.dart';

class BookAppointmentBloc
    extends Bloc<BookAppointmentEvent, BookAppointmentState> {
  BookAppointmentBloc() : super(BookingInitial()) {
    on<SubmitBooking>(_onSubmit);
  }

  Future<void> _onSubmit(SubmitBooking event, Emitter<BookAppointmentState> emit,) async {
    emit(BookingLoading());

    try {

      await Future.delayed(const Duration(seconds: 2));

      emit(BookingSuccess());
    } catch (e) {
      emit(BookingError(e.toString()));
    }
  }
}
