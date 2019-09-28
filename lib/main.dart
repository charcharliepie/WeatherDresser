import 'package:flutter/material.dart';

import 'package:weather_dresser/widgets/Weather.dart';
import 'package:weather_dresser/widgets/WeatherItem.dart';

const MaterialColor grey = const MaterialColor(
  0xFFEDEDED,
  const <int, Color>{
    50: const Color(0xFFEDEDED),
    100: const Color(0xFFEDEDED),
    200: const Color(0xFFEDEDED),
    300: const Color(0xFFEDEDED),
    400: const Color(0xFFEDEDED),
    500: const Color(0xFFEDEDED),
    600: const Color(0xFFEDEDED),
    700: const Color(0xFFEDEDED),
    800: const Color(0xFFEDEDED),
    900: const Color(0xFFEDEDED),
  },
);

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  
  Widget appBarTitle = new Text("天気ワードローブ");
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '天気ワードローブ',
      theme: ThemeData(
        backgroundColor: Color(0xFFEDEDED),
        primarySwatch: grey,
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFEDEDED),
        appBar: new AppBar(
          title: Text('天気ワードローブ'),
          elevation: 0.0,
          actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: (){
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
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      // weather widget
                      child: Weather(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: Color(0xFF093BB1), width: 0.8),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                        onPressed: () => null,
                        child: Text(
                          "  SEE MY OOTD  ",
                          style: TextStyle(color: Color(0xFF093BB1), fontFamily: 'Monsterrat', fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          )
        )
      ),
    );
  }
}