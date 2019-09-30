import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:weather_dresser/model/globals.dart' as globals;
import 'package:weather_dresser/model/weather_data.dart';

final accentColor = const Color(0xFF093BB1);

class OutfitPage extends StatefulWidget {
  final WeatherData weatherDataObject;
  OutfitPage({Key key, @required this.weatherDataObject}) : super(key: key);

  @override
  _OutfitPage createState() => _OutfitPage();
}

class _OutfitPage extends State<OutfitPage> {
  bool isLoading = true;
  String dressCode;

  @override
  void initState() {
    super.initState();

    loadDress();

  }

  var _imageNames = [
    "top.jpeg",
    "bottom.jpeg",
    "accessory.jpeg"
  ];

  var _imageTitles = [
    "This Top...",
    "...this bottom...",
    "...& accessoryies!"
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: Text('What To Wear'),
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
                      child: Text(
                        widget.weatherDataObject.description,
                        style: TextStyle(color: accentColor, fontFamily: 'Monsterrat', fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? Container() : Text(
                        dressCode,
                        style: TextStyle(color: accentColor, fontFamily: 'Monsterrat', fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isLoading ? Container() : new ConstrainedBox(
                        child: new Swiper(
                        itemBuilder: (BuildContext context,int index){
                          return new Container(
                            width: screenWidth,
                            child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      _imageTitles[index],
                                      style: TextStyle(color: accentColor, fontFamily: 'Monsterrat', fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Image.network(
                                      '${globals.microserviceBaseUrl}/dress/${dressCode.toString()}/${_imageNames[index]}',
                                      fit: BoxFit.cover,
                                      height: screenWidth - 20,
                                    ),
                                  ),
                                ]
                              )
                            );
                        },
                        itemCount: 3,
                        itemWidth: screenWidth,
                        itemHeight: screenWidth,
                        //layout: SwiperLayout.TINDER,
                        pagination: new SwiperPagination(),
                        control: new SwiperControl(),
                      ),              
                        constraints:new BoxConstraints.loose(new Size(screenWidth, screenWidth))
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlineButton(
                        borderSide: BorderSide(color: accentColor, width: 0.8),
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(0.0)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "  BACK  ",
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

  loadDress() async {
  
      final dresserResponse = await http.get('http://127.0.0.1:3000/api/dress/code?temp=${widget.weatherDataObject.temp.toString()}&description=${widget.weatherDataObject.description}');

      if (dresserResponse.statusCode == 200) {
        return setState(() {
          // here we have the answer e.g. "hot-rain"
          dressCode = jsonDecode(dresserResponse.body);
          isLoading = false;
        });
      }

    }


}
