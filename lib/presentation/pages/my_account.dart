import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/presentation/pages/pages.dart';
import 'package:test_project/presentation/widgets/widgets.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      initialRoute: 'account',
      onGenerateRoute: (settings) {
        late Widget page;
        switch (settings.name) {
          case 'account':
            page = const MyAccountPage();
          case 'edit-name':
            page = const EditPage(field: EditField.name);
          case 'edit-surname':
            page = const EditPage(field: EditField.surname);
          case 'edit-email':
            page = const EditPage(field: EditField.email);
        }
        return CupertinoPageRoute(
          builder: (context) => page,
          settings: settings,
        );
      },
    );
  }
}

class MyAccountPage extends StatelessWidget {
  const MyAccountPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text('Аккаунт'),
      ),
      body: Center(
        child: Column(
          children: [
            Avatar(),
            EmailAddress(),
            Info(),
          ],
        ),
      ),
    );
  }
}
