import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';

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

  Map<int, Widget> op = {1: Home(), 2: HomeSt()};

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      // color
      primaryColor: Color(0xFF2F2F2F),
      accentColor: Color(0xFF2F2F2F),
      // font
      fontFamily: 'Monsterrat',
    ),
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
  Widget appBarTitle = new Text("天気ワードローブ");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title:  appBarTitle,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            color: Color(0xFF2F2F2F),
            onPressed: () {
              // display input field
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);

                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Color(0xFF2F2F2F),
                    ),
                    decoration: new InputDecoration(
                      prefixIcon:
                          new Icon(Icons.search, color: Color(0xFF2F2F2F)),
                      labelText: "Enter city..",
                      labelStyle: new TextStyle(color: Color(0xFF2F2F2F)),
                      hintText: "Melbourne",
                      hintStyle: new TextStyle(color: Color(0xFF2F2F2F)),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF2F2F2F)),
                      ),
                    ),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("天気ワードローブ");
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
