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
      const TextStyle(color: Colors.blueAccent, fontSize: 30);
  TextStyle? dropdownItemStyle =
  const TextStyle(color: Colors.black, fontSize: 20);
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
        body: Center(
          child: SizedBox(
            width: 200,
            child: Column(
              children: [
                Text("Value", style: textStyle),
                Center(
                  child: TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "Input value to be converted",
                    ),
                    onChanged: onChangeInputMeasureTextField,
                  ),
                ),
                Text(
                  "From:",
                  style: textStyle,
                ),
                DropdownButton<String>(
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
                Text("To:", style: textStyle),
                DropdownButton<String>(
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
                Text((outValue() == null) ? "" : outValue().toString(), style: TextStyle(fontSize: 20),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
