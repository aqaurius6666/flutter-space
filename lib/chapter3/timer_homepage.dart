import 'package:demo_flutter/chapter3/button.dart';
import 'package:demo_flutter/chapter3/config.dart';
import 'package:demo_flutter/chapter3/setting_page.dart';
import 'package:demo_flutter/chapter3/timer.dart';
import 'package:demo_flutter/chapter3/timermodel.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TimerHomepage extends StatelessWidget {
  const TimerHomepage({Key? key}) : super(key: key);
  final defaultPadding = 5.0;

  void empty() {}

  void goToSettings(BuildContext context) {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingPage()),
    );
  }
  @override
  Widget build(BuildContext context) {
    final CountDownTimer countDownTimer = CountDownTimer();
    countDownTimer.startWork();

    final List<PopupMenuItem<String>> menuItems = List.empty(growable: true);
    menuItems.add(const PopupMenuItem(
      value: 'Settings',
      child: Text('Settings'),
    ));

    return Scaffold(
        appBar: AppBar(
          title: Text("Pomodoro Timer"),
          actions: [
         PopupMenuButton<String>(
           itemBuilder: (context) {
             return menuItems.toList();
           },
           onSelected: (s) => {
             if (s == "Settings") {
               goToSettings(context)
             }
           },
         )
            ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          final double avaibleWidth = constraints.maxWidth;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CommonButton(
                        color: Config.PRIMARY_COLOR,
                        onPressed: countDownTimer.startWork,
                        text: "Work"),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CommonButton(
                        color: Config.PRIMARY_COLOR,
                        onPressed: () => countDownTimer.startBreak(true),
                        text: "Short break"),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CommonButton(
                        color: Config.PRIMARY_COLOR,
                        onPressed: () => countDownTimer.startBreak(false),
                        text: "Long break"),
                  ))
                ],
              ),
              Expanded(
                child: StreamBuilder<TimerModel>(
                    initialData: TimerModel("00:00", 1),
                    stream: countDownTimer.stream(),
                    builder: (context, snapshot) {
                      TimerModel timer = snapshot.data!;
                      return CircularPercentIndicator(
                        radius: avaibleWidth / 2,
                        lineWidth: 10.0,
                        percent: timer.percent,
                        center: Text(timer.time,
                            style: Theme.of(context).textTheme.displaySmall),
                        progressColor: Config.SECONDARY_COLOR,
                      );
                    }),
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CommonButton(
                        color: Config.PRIMARY_COLOR,
                        onPressed: countDownTimer.stopWork,
                        text: "Stop"),
                  )),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: CommonButton(
                        color: Config.PRIMARY_COLOR,
                        onPressed: countDownTimer.restart,
                        text: "Restart"),
                  )),
                ],
              )
            ],
          );
        }));
  }
}
