import 'package:flutter/material.dart';
import 'package:test_project/presentation/widgets/widgets.dart';


class StepsCircles extends StatelessWidget {
  const StepsCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(255, 184, 0, 1),
          ),
          child: const Center(
            child: Text(
              '1',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
        ),
        const MyDivider(),
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(236, 236, 236, 1),
          ),
          child: const Center(
            child: Text(
              '2',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
        ),
        const MyDivider(),
        Container(
          width: 45,
          height: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromRGBO(236, 236, 236, 1),
          ),
          child: const Center(
            child: Text(
              '3',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
