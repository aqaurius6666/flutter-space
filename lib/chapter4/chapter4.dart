

import 'package:demo_flutter/chapter4/pong.dart';
import 'package:flutter/material.dart';

class Chapter4App extends StatelessWidget {
  const Chapter4App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ping pong",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ping pong"),
        ),
        body: SafeArea(
          child: Pong(),
        ),
      ),
    );


  }

}
