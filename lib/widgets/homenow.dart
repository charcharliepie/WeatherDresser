import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';


import 'package:weather_dresser/model/globals.dart' as globals;
import 'package:weather_dresser/widgets/weather.dart';
import 'package:weather_dresser/model/weather_data.dart';
import 'package:weather_dresser/widgets/outfit.dart';

final bgColor = const Color(0xFFEAEAEA);
final accentColor = const Color(0xFF093BB1);
final txtColor = const Color(0xFF2F2F2F);

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
  bool isLoading = true;
  WeatherData weatherData;
  Location _location = new Location();
  String error;
  final cityTextFieldController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    cityTextFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    loadWeather();
  }

  Widget appBarTitle = new Text("Today Weather Dresser", style: TextStyle(color: txtColor, fontWeight: FontWeight.w300),);
  Icon actionIcon = new Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

                  this.appBarTitle = new TextFormField(
                    controller: cityTextFieldController,
                    textInputAction: TextInputAction.done,
                    style: new TextStyle(
                      color: txtColor,
                    ),
                    decoration: new InputDecoration(
                      prefixIcon: new Icon(Icons.search),
                      labelText: "Enter city..",
                      labelStyle: new TextStyle(color: txtColor),
                      hintText: "e.g. Melbourne",
                      hintStyle: new TextStyle(color: txtColor),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: txtColor),
                      ),
                    ),
                    onFieldSubmitted: (value){
                      loadCityWeather(value);
                    }
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                }
              });
            },           
          )
        ],
      ),
      body: new Center(
        child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Expanded(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      // weather widget
                      child: weatherData != null ? new Weather(weather: weatherData) : Container(),
                    ),
                    new Padding(
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
                    new Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? Container() : OutlineButton(
                        borderSide: BorderSide(color: accentColor, width: 0.8),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => OutfitPage(weatherDataObject: weatherData)));
                          //Navigator.of(context).push(new OutfitPageRoute());
                          
                        },
                        child: Text(
                          "  MY OOTD FOR TODAY ",
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
        var lat = location['latitude'];
        var lon = location['longitude'];

        var weatherResponse = await http.get('${globals.microserviceBaseUrl}/api/weather/now?lat=${lat.toString()}&lon=${lon.toString()}');

      if (weatherResponse.statusCode == 200) {
        return setState(() {
          weatherData = new WeatherData.fromJson(jsonDecode(weatherResponse.body));
          isLoading = false;
        });
      } else {
        return showDialog(
          context: context,
          builder: (context) {
             setState(() {
              isLoading = false;
            });
            return AlertDialog(
              content: Text("Sorry, I can't locate you..."),
            );
          },
        );
      }
      
    }
  }

  loadCityWeather(String cityName) async {

    final cityWeatherResponse = await http.get('${globals.microserviceBaseUrl}/api/weather/citynow?city=${cityName.toString()}');

    if (cityWeatherResponse.statusCode == 200) {
      return setState(() {
        weatherData = new WeatherData.fromJson(jsonDecode(cityWeatherResponse.body));
      });
    } else {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text("Sorry, I can't find this city..."),
          );
        },
      );
    } 
  }

}


  