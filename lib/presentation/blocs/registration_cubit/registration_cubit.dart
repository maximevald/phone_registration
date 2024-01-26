import 'package:flutter_bloc/flutter_bloc.dart';

part 'registration_state.dart';

class RegistrationCubit extends Cubit<bool> {
  RegistrationCubit() : super(false);

  void updatePhone(String phoneNumber) {
    if (phoneNumber.length == 10) {
      emit(true);
    } else {
      emit(false);
    }
  }
}
