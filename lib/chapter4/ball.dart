
import 'package:demo_flutter/chapter4/config.dart';
import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  const Ball({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Config.BALL_DIAM,
      height: Config.BALL_DIAM,
      decoration: new BoxDecoration(
        color: Colors.yellow,
        shape: BoxShape.circle,
      ),
    );
  }
}
