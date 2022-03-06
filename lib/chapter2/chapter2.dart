import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chapter2App extends StatefulWidget {
  const Chapter2App({Key? key}) : super(key: key);

  @override
  Chapter2AppState createState() => Chapter2AppState();
}

class Chapter2AppState extends State<Chapter2App> {
  double? _input;
  String? _inputMeasure;
  String? _outputMeasure;
  final _measures = <String>[
    'Meter',
    'Kilometer',
    'Feet',
    'Miles',
  ];

  TextStyle? textStyle =
      const TextStyle(color: Colors.blueAccent, fontSize: 20);
  TextStyle? dropdownItemStyle =
  const TextStyle(color: Colors.black, fontSize: 16);
  TextStyle? dropdownButtonStyle =
      const TextStyle(color: Colors.black, );

  double? outValue() {
    if (_inputMeasure == null || _outputMeasure == null || _input == null) {
      return null;
    }
    return _input! * getBase(_inputMeasure!) / getBase(_outputMeasure!);
  }

  double getBase(String m) {
    switch (m) {
      case 'Kilometer':
        return 1000;
      case 'Meter':
        return 1;
      case 'Feet':
        return 0.3048;
      case 'Miles':
        return 1609.34;
      default:
        return 0;
    }
  }

  void onChangeInputMeasureTextField(String value) {
    var num = double.tryParse(value);
    if (num != null) {
      setState(() {
        _input = num;
      });
    } else {
      setState(() {
        _input = null;
      });
    }
  }

  @override
  void initState() {
    _input = null;
    _inputMeasure = null;
    _outputMeasure = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chuyển đổi hệ đo cùng Hằng <3",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Chuyển đổi hệ đo"),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40),
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 300,
            child: Column(
              children: [
                Text("Value", style: textStyle),
                Spacer(flex: 1,),
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Input value to be converted",
                    ),
                    onChanged: onChangeInputMeasureTextField,
                  ),
                ),
                Spacer(flex: 1,),
                Text(
                  "From:",
                  style: textStyle,
                ),
                Spacer(flex: 1,),
                DropdownButton<String>(
                  isExpanded: true,
                  style: dropdownButtonStyle,
                  value: _inputMeasure,
                  hint: Center(child: Text("Measure", style: dropdownItemStyle,)),
                  alignment: Alignment.center,
                  items: _measures.map((value) {
                    return DropdownMenuItem<String>(
                        child: Center(child: Text(value, style: dropdownItemStyle,)), value: value);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _inputMeasure = value;
                    });
                  },
                ),
                Spacer(flex: 1,),
                Text("To:", style: textStyle),
                Spacer(flex: 1,),
                DropdownButton<String>(
                  isExpanded: true,
                  style: dropdownButtonStyle,
                  value: _outputMeasure,
                  hint: Center(child: Text("Measure", style: dropdownItemStyle,)),
                  alignment: Alignment.center,
                  items: _measures.map((value) {
                    return DropdownMenuItem<String>(
                        child: Center(child: Text(value, style: dropdownItemStyle,)), value: value);
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _outputMeasure = value;
                    });
                  },
                ),
                Spacer(flex: 1,),
                Text((outValue() == null) ? "" : outValue().toString(), style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
