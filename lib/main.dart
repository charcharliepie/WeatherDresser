import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:flutter/cupertino.dart';

import 'package:weather_dresser/widgets/homenow.dart';
import 'package:weather_dresser/widgets/hometomorrow.dart';

final bgColor = const Color(0xFFEAEAEA);
final accentColor = const Color(0xFF093BB1);
final txtColor = const Color(0xFF2F2F2F);

void main() {
  // do something while loading splash screen
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: TabBarDemo()};

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      backgroundColor: txtColor,
    ),
    home: AnimatedSplash(
      imagePath: 'assets/img/launchscreen-logo.png',
      home: TabBarDemo(),
      customFunction: duringSplash,
      duration: 3000,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));
}

class TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              MyHomePage(title: 'Today Weather Dresser'),
              MyHomePageTomorrow(title: 'Tomorrow Weather Dresser'),
            ],
          ),
        ),
      ),
    );
  }
}
