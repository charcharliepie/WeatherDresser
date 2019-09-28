import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

void main() {
  Function duringSplash = () {
    print('Something background process');
    int a = 123 + 23;
    print(a);

    if (a > 100)
      return 1;
    else
      return 2;
  };

  Map<int, Widget> op = {1: Home(), 2: HomeSt()};

  runApp(MaterialApp(
    home: AnimatedSplash(
      imagePath: 'assets/img/splash-logo.png',
      home: Home(),
      customFunction: duringSplash,
      duration: 3000,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Widget appBarTitle = new Text("");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: appBarTitle,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            color: Colors.black,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);

                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.black,
                    ),
                    decoration: new InputDecoration
                    (
                      prefixIcon: new Icon(Icons.search, color: Colors.black),
                      labelText: "Enter city..",
                      labelStyle: new TextStyle(color: Colors.black),
                      hintText: "Melbourne",
                      hintStyle: new TextStyle(color: Colors.black),
                    ),
                  );
                }
                else
                {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("");
                }
              });
            },
          )
        ],
      ),
    );
  }
}

class HomeSt extends StatefulWidget {
  @override
  _HomeStState createState() => _HomeStState();
}

class _HomeStState extends State<HomeSt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: Center(
            child: Text('My Cool App home page 2',
                style: TextStyle(color: Colors.black, fontSize: 20.0))));
  }
}
