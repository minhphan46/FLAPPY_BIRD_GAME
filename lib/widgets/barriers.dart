import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final barrierWidth;
  final barrierHeight;
  final barrierX;
  final bool isThisBottomBarrier;

  Barrier({
    this.barrierHeight, // out of 2, where 2 is the width of the screen
    this.barrierWidth,
    this.barrierX,
    required this.isThisBottomBarrier,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 0),
      alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),
          isThisBottomBarrier ? 1.05 : -1.05),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth,
        height: MediaQuery.of(context).size.width * 3 / 4 * barrierHeight + 16,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 10, 79, 113),
            border:
                Border.all(width: 10, color: Color.fromARGB(255, 11, 30, 46)),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
