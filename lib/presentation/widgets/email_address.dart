import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/blocs/name_cubit/profile_cubit.dart';

class EmailAddress extends StatelessWidget {
  const EmailAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () => Navigator.of(context).pushNamed('edit-email'),
          child: state.email.isNotEmpty
              ? Text(
                  state.email,
                  style: const TextStyle(
                    color: Color.fromRGBO(125, 125, 125, 1),
                  ),
                )
              : const Text(
                  'Ваш Email',
                  style: TextStyle(
                    color: Color.fromRGBO(125, 125, 125, 1),
                  ),
                ),
        );
      },
    );
  }
}
