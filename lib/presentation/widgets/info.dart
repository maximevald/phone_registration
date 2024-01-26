import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/blocs/name_cubit/profile_cubit.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      child: Column(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
            ListTile(
              tileColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              ),
              title: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      const Text('Имя'),
                      const Spacer(),
                      if (state.name.isEmpty)
                        const Text(
                          'Настроить',
                          style: TextStyle(
                            color: Color.fromARGB(255, 197, 192, 192),
                          ),
                        )
                      else
                        Text(state.name),
                    ],
                  );
                },
              ),
              trailing: const CupertinoListTileChevron(),
              onTap: () => Navigator.of(context).pushNamed('edit-name'),
            ),
            ListTile(
              tileColor: Colors.white,
              title: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      const Text('Фамилия'),
                      const Spacer(),
                      if (state.surname.isEmpty)
                        const Text(
                          'Настроить',
                          style: TextStyle(
                            color: Color.fromARGB(255, 197, 192, 192),
                          ),
                        )
                      else
                        Text(state.surname),
                    ],
                  );
                },
              ),
              trailing: const CupertinoListTileChevron(),
              onTap: () => Navigator.of(context).pushNamed('edit-surname'),
            ),
            const SizedBox.shrink(),
          ],
        ).toList(),
      ),
    );
  }
}
