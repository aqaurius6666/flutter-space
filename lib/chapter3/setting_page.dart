
import 'package:demo_flutter/chapter3/button.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<SettingPage> {

  TextStyle textStyle = TextStyle(fontSize: 24);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Container(
        child: GridView.count(
          scrollDirection: Axis.vertical,
            childAspectRatio: 3,
            mainAxisSpacing: 10,
            padding: const EdgeInsets.all(20.0),
            crossAxisCount: 3,
          children: <Widget>[
            Text("Work", style: textStyle,),
            Text(""),
            Text(""),
            SettingButton(Color(0xff455A64), "-", -1),
          ],
        ),
      ),
    );
  }
}