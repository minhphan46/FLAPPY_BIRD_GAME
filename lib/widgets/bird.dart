import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  final double birdWidth;
  final double birdHeight; // out of 2, 2 being the entire height of the screen

  Bird({required this.birdWidth, required this.birdHeight});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.height * birdWidth,
      height: MediaQuery.of(context).size.width * 3 / 4 * birdHeight,
      child: Image.asset('assets/bird.png'),
    );
  }
}
