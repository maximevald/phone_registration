import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project/presentation/widgets/widgets.dart';

class StepsSubmitionCircles extends StatelessWidget {
  const StepsSubmitionCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: const Color.fromRGBO(57, 163, 20, 1),
                ),
              ),
            ),
            const MyDivider(),
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 184, 0, 1),
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
        ),
        const Positioned(
          bottom: 0,
          left: 58,
          child: Icon(
            CupertinoIcons.check_mark,
            color: Color.fromRGBO(167, 167, 167, 1),
            size: 20,
          ),
        ),
      ],
    );
  }
}
