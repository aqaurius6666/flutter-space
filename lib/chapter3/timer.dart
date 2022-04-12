import 'dart:async';

import './timermodel.dart';

class CountDownTimer {
  double _radius = 1;
  bool _isActive = true;
  int _currentTime = 30;

  late Timer timer;
  late Duration _time;
  late Duration _fullTime;

  int work = 30;
  int shortBreak = 5;
  int longBreak = 10;


  void startWork() {
    _isActive = true;
    _radius = 1;
    _currentTime = work;
    _time = Duration(minutes: _currentTime, seconds: 0);
    _fullTime = _time;
  }

  void startBreak(bool isShort) {
    _isActive = true;
    _radius = 1;
    _currentTime = (isShort) ? shortBreak : longBreak;
    _time = Duration(minutes: _currentTime, seconds: 0);
    _fullTime = _time;
  }

  void restart() {
    _isActive = true;
    _radius = 1;
    _time = Duration(minutes: _currentTime, seconds: 0);
  }

  Stream<TimerModel> stream() async* {
    yield* Stream.periodic(Duration(seconds: 1), (int a) {
      String time;
      if (_isActive) {
        _time = _time - Duration(seconds: 1);
        _radius = _time.inSeconds / _fullTime.inSeconds;
        if (_time.inSeconds <= 0) {
          _isActive = false;
        }
      }
      time = returnTime(_time);
      return TimerModel(time, _radius);
    });
  }

  void stopWork() {
    _isActive = false;
  }
  String returnTime(Duration t) {
    String minute = (t.inMinutes < 10) ? '0' + t.inMinutes.toString() : t.inMinutes.toString();
    String second = (t.inSeconds % 60 < 10) ? '0' + (t.inSeconds % 60).toString() : (t.inSeconds % 60).toString();
    return minute + ":" + second;
  }
}
