part of 'profile_cubit.dart';

final class ProfileState {
  ProfileState({
    required this.surname,
    required this.name,
    required this.email, this.image,
  });

  final String name;
  final String surname;
  final File? image;
  final String email;
}
