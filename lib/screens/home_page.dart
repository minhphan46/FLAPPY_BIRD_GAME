import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plappy_bird_game/widgets/barriers.dart';
import 'package:plappy_bird_game/widgets/bird.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // game varibles
  int score = 0;
  int bestScore = 0;
  // bird varibles
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gameHasStated = false;
  double gravity = -4.9;
  double velocity = 2.8; // van toc
  double birdWith = 0.1; // out of 2
  double birdHeight = 0.1; // out of 2

  // barrier variables
  static List<double> barrierX = [2, 2 + 1.5]; // position barrier 1, 2
  static double barrierWith = 0.25; // out of 2
  List<List<double>> barrierHeight = [
    // out of 2, where 2 is the entire height of the screen
    // [topHeight, bottomHeight]
    [0.6, 0.4],
    [0.4, 0.6],
  ];

  void jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStated = true;
    Timer.periodic(Duration(milliseconds: 20), (timer) {
      time += 0.01;
      height = gravity * time * time + velocity * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        if (barrierX[0] < -2) {
          barrierX[0] += 3;
        } else {
          barrierX[0] -= 0.01;
        }
        if (barrierX[1] < -2) {
          barrierX[1] += 3;
        } else {
          barrierX[1] -= 0.01;
        }
      });
      if (checkScored()) {
        setState(() {
          score++;
          if (score > bestScore) {
            bestScore = score;
          }
        });
      }
      if (birdIsDead()) {
        timer.cancel();
        gameHasStated = false;
        _showDialog();
      }
    });
  }

  bool birdIsDead() {
    // check if the bird is hitting the top or the bottom of the screen
    if (birdYaxis < -1 || birdYaxis > 1) {
      return true;
    }
    // check if the bird is within x coordinates and y coirdinates of barriers
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] <= birdWith &&
          barrierX[i] + barrierWith >= -birdWith &&
          (birdYaxis <= -1 + barrierHeight[i][0] ||
              birdYaxis + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }
    return false;
  }

  bool checkScored() {
    for (int i = 0; i < barrierX.length; i++) {
      if (barrierX[i] >= 0 && barrierX[i] <= 0.01) {
        return true;
      }
    }
    return false;
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdYaxis = 0;
      gameHasStated = false;
      time = 0;
      initialHeight = birdYaxis;
      barrierX = [2, 2 + 1.5];
      score = 0;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.brown,
          title: const Center(
            child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white),
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  color: Colors.white,
                  child: const Text(
                    "PLAY AGAIN",
                    style: TextStyle(color: Colors.brown),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStated) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(
                        0, (2 * birdYaxis + birdHeight) / (2 - birdHeight)),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.blue,
                    child: Bird(
                      birdWidth: birdWith,
                      birdHeight: birdHeight,
                    ),
                  ),

                  Container(
                    alignment: const Alignment(0, -0.4),
                    child: gameHasStated
                        ? const Text("")
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  // top barrier 0
                  Barrier(
                    barrierX: barrierX[0],
                    barrierHeight: barrierHeight[0][0],
                    barrierWidth: barrierWith,
                    isThisBottomBarrier: false,
                  ),
                  // bottom barrier 0
                  Barrier(
                    barrierX: barrierX[0],
                    barrierHeight: barrierHeight[0][1],
                    barrierWidth: barrierWith,
                    isThisBottomBarrier: true,
                  ),
                  // top barrier 1
                  Barrier(
                    barrierX: barrierX[1],
                    barrierHeight: barrierHeight[1][0],
                    barrierWidth: barrierWith,
                    isThisBottomBarrier: false,
                  ),
                  // bottom barrier 1
                  Barrier(
                    barrierX: barrierX[1],
                    barrierHeight: barrierHeight[1][1],
                    barrierWidth: barrierWith,
                    isThisBottomBarrier: true,
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.green,
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "SCORE",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$score",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "BEST",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$bestScore",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
