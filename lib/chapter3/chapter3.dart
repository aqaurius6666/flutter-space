

import 'package:demo_flutter/chapter3/config.dart';
import 'package:demo_flutter/chapter3/timer_homepage.dart';
import 'package:flutter/material.dart';

class Chapter3App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My time with Hằng",
      color: Config.PRIMARY_COLOR,
      home: TimerHomepage(),

    );
  }
}