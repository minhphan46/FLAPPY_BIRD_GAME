import 'package:flutter/material.dart';

void showMyDialog(BuildContext context, VoidCallback resetGame) {
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
