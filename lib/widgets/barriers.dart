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
          isThisBottomBarrier ? 1 : -1),
      child: Container(
        width: MediaQuery.of(context).size.width * barrierWidth,
        height: MediaQuery.of(context).size.width * 3 / 4 * barrierHeight,
        decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(width: 10, color: Colors.green.shade700),
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
