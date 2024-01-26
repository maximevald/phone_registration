import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit()
      : super(
          ProfileState(name: '', surname: '', email: ''),
        );

  void updateName(String name) {
    emit(
      ProfileState(
        name: name,
        surname: state.surname,
        email: state.email,
        image: state.image,
      ),
    );
  }

  void updateSurname(String surname) {
    emit(
      ProfileState(
        name: state.name,
        surname: surname,
        email: state.email,
        image: state.image,
      ),
    );
  }

  void updateEmail(String email) {
    emit(
      ProfileState(
        name: state.name,
        surname: state.surname,
        email: email,
        image: state.image,
      ),
    );
  }

  Future<void> updateImage(ImageSource resource) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: resource,
    );

    if (pickedImage == null) {
      return;
    }
    emit(
      ProfileState(
        surname: state.surname,
        name: state.name,
        email: state.email,
        image: File(pickedImage.path),
      ),
    );
  }
}
