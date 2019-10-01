import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'package:weather_dresser/model/globals.dart' as globals;
import 'package:weather_dresser/model/weather_data.dart';

final bgColor = const Color(0xFFEAEAEA);
final accentColor = const Color(0xFF093BB1);
final txtColor = const Color(0xFF2F2F2F);

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
    if (Platform.isAndroid) {
      // ANDROID STUFF
    } else if (Platform.isIOS) {}
    loadDress();
  }

  var _imageNames = ["top.jpeg", "bottom.jpeg", "accessory.jpeg"];

  var _imageTitles = ["Top:", "Bottom:", "& a touch of accessory!"];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("DRESSERワードローブ",
            style: TextStyle(color: txtColor, fontWeight: FontWeight.w300)),
        backgroundColor: bgColor,
        elevation: 0.0,
      ),
      body: Center(
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('G\u{00027}Day!',
                  style: new TextStyle(
                      color: txtColor,
                      fontSize: 48.0,
                      fontFamily: 'Monsterrat',
                      fontWeight: FontWeight.w200)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? Container()
                    : Text(
                        'This ${dressCode} weather today is perfect for:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: txtColor,
                            fontFamily: 'Monsterrat',
                            fontWeight: FontWeight.w300,
                            fontSize: 14.0),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: isLoading
                    ? Container()
                    : new ConstrainedBox(
                        child: new Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return new Container(
                                width: screenWidth,
                                child: Column(children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Text(
                                      _imageTitles[index],
                                      style: TextStyle(
                                          color: txtColor,
                                          fontFamily: 'Monsterrat',
                                          fontWeight: FontWeight.w300),
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
                                ]));
                          },
                          itemCount: 3,
                          itemWidth: screenWidth,
                          itemHeight: screenWidth,
                          //layout: SwiperLayout.TINDER,
                          pagination: new SwiperPagination(),
                          control: new SwiperControl(),
                        ),
                        constraints: new BoxConstraints.loose(
                            new Size(screenWidth, screenWidth))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlineButton(
                  borderSide: BorderSide(color: accentColor, width: 0.8),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(0.0)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "  BACK  ",
                    style: TextStyle(
                        color: accentColor,
                        fontFamily: 'Monsterrat',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ],
          ),
        ),
      ])),
    );
  }

  loadDress() async {
    final dresserResponse = await http.get(
        'http://127.0.0.1:3000/api/dress/code?temp=${widget.weatherDataObject.temp.toString()}&description=${widget.weatherDataObject.description}');

    if (dresserResponse.statusCode == 200) {
      return setState(() {
        // here we have the answer e.g. "hot-rain"
        dressCode = jsonDecode(dresserResponse.body);
        isLoading = false;
      });
    }
  }
}
