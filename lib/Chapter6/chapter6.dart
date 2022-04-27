import 'package:demo_flutter/Chapter6/ui/lists_screen.dart';
import 'package:flutter/material.dart';

class Chapter6App extends StatelessWidget {
  const Chapter6App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: "List cho người đãng trí",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: ListScreen(),
    );
  }
}
