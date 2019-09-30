import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:animated_splash/animated_splash.dart';
import 'dart:convert';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';


import 'package:weather_dresser/widgets/weather.dart';
import 'package:weather_dresser/model/weather_data.dart';

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

  Map<int, Widget> op = {1: MyHomePage()};

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: new ThemeData(
      backgroundColor: txtColor,
    ),
    home: AnimatedSplash(
      imagePath: 'assets/img/launchscreen-logo.png',
      home: MyHomePage(),
      customFunction: duringSplash,
      duration: 3000,
      type: AnimatedSplashType.BackgroundProcess,
      outputAndHome: op,
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '天気ワードローブ',
      theme: ThemeData(
        primaryColor: txtColor,
        accentColor: accentColor,
      ),
      home: MyHomePage(title: '天気ワードローブ'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  WeatherData weatherData;
  Location _location = new Location();
  String error;

  @override
  void initState() {
    super.initState();

    loadWeather();
  }



  Widget appBarTitle = new Text("天気ワードローブ", style: TextStyle(color: txtColor, fontWeight: FontWeight.w300),);
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: new AppBar(
        title:  appBarTitle,
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: <Widget>[
          new IconButton(
            icon: actionIcon,
            color: txtColor,
            onPressed: () {
              // display input field
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);

                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: txtColor,
                    ),
                    decoration: new InputDecoration(
                      prefixIcon:
                          new Icon(Icons.search, color: txtColor),
                      labelText: "Enter city..",
                      labelStyle: new TextStyle(color: txtColor),
                      hintText: "Melbourne",
                      hintStyle: new TextStyle(color: txtColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: txtColor),
                      ),
                    ),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("天気ワードローブ", style: TextStyle(color: txtColor, fontWeight: FontWeight.w300),);
                }
              });
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
                      child: weatherData != null ? Weather(weather: weatherData) : Container(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: new AlwaysStoppedAnimation(Colors.black),
                      ) : IconButton(
                        icon: new Icon(LineIcons.refresh),
                        tooltip: 'Refresh',
                        onPressed: loadWeather,
                        color: txtColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: accentColor, width: 0.8),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                        onPressed: () => null,
                        child: Text(
                          "  SEE MY OOTD  ",
                          style: TextStyle(color: accentColor, fontFamily: 'Monsterrat', fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          )   
        ),
    );
  }

  loadWeather() async {
    setState(() {
      isLoading = true;
    });

    Map<String,double> location;

    try {
      location = await _location.getLocation();

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'Permission denied - please ask the user to enable it from the app settings';
      }

      location = null;
    }

    if (location != null) {
      final lat = location['latitude'];
      final lon = location['longitude'];
    

    // final lat = 40.730610;
    // final lon = -73.935242;
    // Melb -37.809588 -37.809588

    final weatherResponse = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?APPID=931dd482db9863c889f68196f104be72&lat=${lat
            .toString()}&lon=${lon.toString()}');
/*https://api.openweathermap.org/data/2.5/weather?APPID=931dd482db9863c889f68196f104be72&lat=40.730610&lon=-73.935242 */ 
// api key 931dd482db9863c889f68196f104be72

    if (weatherResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
}