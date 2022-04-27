import 'dart:math';

import 'package:demo_flutter/chapter4/ball.dart';
import 'package:demo_flutter/chapter4/bat.dart';
import 'package:demo_flutter/chapter4/config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

enum Direction {LEFT, RIGHT, UP, DOWN}

class Pong extends StatefulWidget {
  const Pong({Key? key}) : super(key: key);

  @override
  State<Pong> createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  double posX = 0;
  double posY = 0;

  Direction vDir = Direction.DOWN;
  Direction hDir = Direction.LEFT;

  double width = 100;
  double height = 100;
  double batPosition = 0;
  double incrementX = Config.BALL_INCREMENT;
  double incrementY = Config.BALL_INCREMENT;
  double batWidth = 0;
  double batHeight = 10;

  int score = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(minutes: 10000),
    );
    animation = Tween<double>(
      begin: 0,
      end: 100,
    ).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        checkBorder();
        (vDir == Direction.UP) ? posY = (posY - incrementY).roundToDouble() : posY = (posY + incrementY).roundToDouble();
        (hDir == Direction.LEFT) ? posX = (posX - incrementX).roundToDouble() : posX = (posX + incrementX).roundToDouble();
      });

    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          width =  constraints.maxWidth;
          height = constraints.maxHeight;

          batWidth = width / 5;
          batHeight = height / 20;

          return Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) => moveBat(update),
                child: Bat(width: batWidth, height: batHeight),
              ),
              bottom: 0,
              left: batPosition,
            ),
            Positioned(
                child: Text("Score: " + score.toString(), style: TextStyle(fontSize: 20),),
              right: 0,
              top: 0,
            ),
          ],
        );
      }
    );

  }

  void moveBat (DragUpdateDetails update) {
    safeSetState(() {
      batPosition += update.delta.dx;
    });
  }


  void showMessage(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Game over"),
            content: Text("Your score is: " + score.toString() + "\nDo you wanna play again?"),
            actions: [
              ElevatedButton(onPressed: () {
                dispose();
              }, child: Text("No")),
              ElevatedButton(onPressed: ()  {
                setState(() {
                  posX = 10;
                  posY = 20;
                  score = 0;
                });
                Navigator.of(context).pop();
                controller.repeat();
              }, child: Text("Play")),
            ],
          );
        });
  }

  void checkBorder() {
    if (posX <= 0 && hDir == Direction.LEFT) {
      hDir = Direction.RIGHT;
    }
    if (posX >= width - Config.BALL_DIAM && hDir == Direction.RIGHT) {
      hDir = Direction.LEFT;
      randomNumber(incrementX);
      randomNumber(incrementY);
    }
    if (posY <= 0 && vDir == Direction.UP) {
      vDir = Direction.DOWN;
      randomNumber(incrementX);
      randomNumber(incrementY);
    }
    if (posY >= height - Config.BALL_DIAM && vDir == Direction.DOWN) {
      controller.stop();
      showMessage(context);
    }
    if (posY >= height - Config.BALL_DIAM - batHeight && vDir == Direction.DOWN) {
      if (posX >= batPosition && posX + Config.BALL_DIAM <= batPosition + batWidth) {
        vDir = Direction.UP;
        safeSetState(() {
          score++;
        });
        randomNumber(incrementX);
        randomNumber(incrementY);
      }
    }
  }

  void safeSetState(Function func) {
    if (controller.isAnimating && mounted) {
      setState(() {
        func();
      });
    }
  }

  double randomNumber(double a) {
    a *= 1.2;
    return a;
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();

  }
}
