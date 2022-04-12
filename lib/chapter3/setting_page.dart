
import 'package:demo_flutter/chapter3/button.dart';
import 'package:demo_flutter/chapter3/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingPage extends StatefulWidget {

  @override
  SettingState createState() => SettingState();
}

class SettingState extends State<SettingPage> {

  static const String WORKTIME = "workTime";
  static const String SHORTBREAK = "shortBreak";
  static const String LONGBREAK = "longBreak";

  int workTime = 30;
  int shortBreak = 5;
  int longBreak = 10;

  late SharedPreferences prefs;

  TextStyle textStyle = const TextStyle(fontSize: 24);

  late TextEditingController txWork;
  late TextEditingController txShort;
  late TextEditingController txLong;

  @override
  void initState() {
    txWork = TextEditingController();
    txShort = TextEditingController();
    txLong = TextEditingController();
    readSettings();
    super.initState();
  }

  Future readSettings() async {
    prefs = await SharedPreferences.getInstance();
    workTime = prefs.getInt(WORKTIME) != null ? prefs.getInt(WORKTIME)! : workTime;
    shortBreak = prefs.getInt(SHORTBREAK) != null ? prefs.getInt(SHORTBREAK)! : shortBreak;
    longBreak = prefs.getInt(LONGBREAK) != null ? prefs.getInt(LONGBREAK)! : longBreak;

    setState(() {
      txWork.text = workTime.toString();
      txShort.text = shortBreak.toString();
      txLong.text = longBreak.toString();
    });
  }

  void updateSettings(String key, int value) {
    switch (key) {
      case WORKTIME: {
        workTime = prefs.getInt(WORKTIME) != null ? prefs.getInt(WORKTIME)! : workTime;
        workTime += value;
        if (workTime <= 180 && workTime >= 1) {
          prefs.setInt(WORKTIME, workTime);
          setState(() {
            txWork.text = workTime.toString();
          });
        }
        break;
      }
      case SHORTBREAK: {
        shortBreak = prefs.getInt(SHORTBREAK) != null ? prefs.getInt(SHORTBREAK)! : shortBreak;
        shortBreak += value;
        if (shortBreak <= 180 && shortBreak >= 1) {
          prefs.setInt(SHORTBREAK, shortBreak);
          setState(() {
            txShort.text = shortBreak.toString();
          });
        }
        break;
      }
      case LONGBREAK: {
        longBreak = prefs.getInt(LONGBREAK) != null ? prefs.getInt(LONGBREAK)! : longBreak;
        longBreak += value;
        if (longBreak <= 180 && longBreak >= 1) {
          prefs.setInt(LONGBREAK, longBreak);
          setState(() {
            txLong.text = longBreak.toString();
          });
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: GridView.count(
        scrollDirection: Axis.vertical,
          childAspectRatio: 3,
          mainAxisSpacing: 10,
          padding: const EdgeInsets.all(20.0),
          crossAxisCount: 3,
        children: <Widget>[
          Text("Work", style: textStyle,),
          const Text(""),
          const Text(""),
          SettingButton(Config.MINUS_COLOR, "-", -1, WORKTIME ,updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txWork,
          ),
          SettingButton(Config.PLUS_COLOR, "+", 1, WORKTIME,updateSettings),
          Text("Short", style: textStyle,),
          const Text(""),
          const Text(""),
          SettingButton(Config.MINUS_COLOR, "-", -1, SHORTBREAK, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txShort,
          ),
          SettingButton(Config.PLUS_COLOR, "+", 1, SHORTBREAK, updateSettings),
          Text("Long", style: textStyle,),
          const Text(""),
          const Text(""),
          SettingButton(Config.MINUS_COLOR, "-", -1, LONGBREAK, updateSettings),
          TextField(
            style: textStyle,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            controller: txLong,
          ),
          SettingButton(Config.PLUS_COLOR, "+", 1, LONGBREAK, updateSettings),

        ],
      ),
    );
  }
}