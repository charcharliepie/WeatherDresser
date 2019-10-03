import 'package:flutter/material.dart';

import 'package:weather_dresser/main.dart';
import 'package:weather_dresser/model/weather_data.dart';

class Weather extends StatelessWidget {

  WeatherData weather;
  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(weather.main, style: new TextStyle(color: txtColor, fontSize: 26.0, fontFamily: 'Monsterrat', fontWeight: FontWeight.w300)),),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Image.asset('assets/img/${weather.icon}.png', height: 200,),),
        Text('${weather.temp.toStringAsFixed(1)}°', style: new TextStyle(color: txtColor, fontSize: 58.0, fontFamily: 'Monsterrat', fontWeight: FontWeight.w200)),
        
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text((weather.name != null) ? weather.name.toUpperCase() : "", style: new TextStyle(color: txtColor, fontSize: 22.0, fontFamily: 'Monsterrat')),),

        Row(
            mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text('\u{25BC} min:${weather.minTemp.toStringAsFixed(1)}°', style: new TextStyle(color: txtColor, fontFamily: 'Monsterrat')),
            Text(' \u{25B2} max:${weather.maxTemp.toStringAsFixed(1)}°', style: new TextStyle(color: txtColor, fontFamily: 'Monsterrat')),
          ],
        )
        
      ],
    );
  }
}