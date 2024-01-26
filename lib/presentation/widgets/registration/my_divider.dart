import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 45,
      width: 45,
      child: Divider(
        color: Color.fromRGBO(236, 236, 236, 1),
      ),
    );
  }
}
