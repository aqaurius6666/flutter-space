import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final Color? color;
  final double? size;
  final String? text;
  final VoidCallback? onPressed;

  CommonButton(
      {@required this.color,
      @required this.size,
      @required this.text,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: const TextStyle(color: Colors.white),
      ),
      color: color,
      minWidth: size,
    );
  }
}
typedef SettingCallback = Function(String, int);
class SettingButton extends StatelessWidget {
  final Color color;
  final String text;
  final String type;
  final int value;
  final SettingCallback callback;
  SettingButton(this.color, this.text, this.value, this.type, this.callback);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      color: color,
      onPressed: () => callback(this.type, this.value),
    );
  }
}
