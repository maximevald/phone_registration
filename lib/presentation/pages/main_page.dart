import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_project/presentation/blocs/bottom_bar_cubit/page_index_cubit.dart';
import 'package:test_project/presentation/blocs/name_cubit/profile_cubit.dart';
import 'package:test_project/presentation/pages/pages.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const bottomNavScreen = <Widget>[
      MyProjects(),
      MyAccount(),
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PageIndexCubit(),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: BlocBuilder<PageIndexCubit, int>(
        builder: (context, state) {
          return Scaffold(
            body: Center(child: bottomNavScreen.elementAt(state)),
            bottomNavigationBar: CupertinoTabBar(
              activeColor: const Color.fromRGBO(0, 152, 238, 1),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.square_grid_2x2_fill),
                  label: 'Мои проекты',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.person_solid,
                  ),
                  label: 'Мой аккаунт',
                ),
              ],
              currentIndex: context.read<PageIndexCubit>().state,
              onTap: (index) =>
                  context.read<PageIndexCubit>().onItemTapped(index),
            ),
          );
        },
      ),
    );
  }
}
