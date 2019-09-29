import 'package:flutter/material.dart';

import 'package:weather_dresser/widgets/weather.dart';

final bgColor = const Color(0xFFEDEDED);
final accentColor = const Color(0xFF093BB1);
final txtColor = const Color(0xFF2F2F2F);


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '天気ワードローブ', 
      theme: ThemeData(
        primaryColor: bgColor,
        accentColor: accentColor,
      ),
      home: Scaffold(
        backgroundColor: bgColor,
        appBar: new AppBar(
          title: Text('天気ワードローブ', style: new TextStyle(fontWeight: FontWeight.w400),),
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
              final city = await Navigator.push(
                context,
                MaterialPageRoute(
                ),
              );
              if (city != null) {
                // do something
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