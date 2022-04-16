
import 'package:demo_flutter/chapter5/movies_show.dart';
import 'package:flutter/material.dart';

class Chapter5App extends StatelessWidget {
  const Chapter5App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Movies show",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesShow(),
    );
  }
}
