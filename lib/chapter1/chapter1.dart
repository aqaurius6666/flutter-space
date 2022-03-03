

import 'package:flutter/material.dart';

class Chapter1App extends StatelessWidget {
  const Chapter1App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Beloved",
      home: Scaffold(
        appBar: AppBar(title: const Text("Beloved")),
        body: const Center(
          child: Text("Hello Hang"),
        )
      )
    );

  }



}