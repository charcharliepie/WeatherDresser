import 'package:flutter/material.dart';

class Weather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Clear', style: new TextStyle(color: Colors.black, fontSize: 24.0, fontFamily: 'Monsterrat', fontWeight: FontWeight.w300)),),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Image.asset('assets/img/weather-clear.png', height: 200,),),
        Text('29°', style: new TextStyle(color: Colors.black, fontSize: 58.0, fontFamily: 'Monsterrat', fontWeight: FontWeight.w200)),
        
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('MELBOURNE', style: new TextStyle(color: Colors.black, fontSize: 22.0, fontFamily: 'Monsterrat')),),

        Row(
            mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Text('\u{25BC} min:18°', style: new TextStyle(color: Colors.black, fontFamily: 'Monsterrat')),
            Text('\u{25B2} max:32°', style: new TextStyle(color: Colors.black, fontFamily: 'Monsterrat')),
          ],
        )
        
      ],
    );
  }
}