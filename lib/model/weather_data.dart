class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String main;
  final String icon;

  // convert Kelvin to Celsius
  //final double tempCel = temp - 273.1;
  //final double minTempCel = minTemp - 273.1;
  //final double maxTempCel = maxTemp - 273.1;
  

  WeatherData({this.date, this.name, this.temp, this.minTemp, this.maxTemp, this.main, this.icon});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: json['main']['temp'].toDouble(),
      minTemp: json['main']['temp_min'].toDouble(),
      maxTemp: json['main']['temp_max'].toDouble(),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
    );
  }
}