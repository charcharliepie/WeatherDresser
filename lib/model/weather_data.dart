class WeatherData {
  final DateTime date;
  final String name;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String main;
  final String icon;
  final String description;

  WeatherData({this.date, this.name, this.temp, this.minTemp, this.maxTemp, this.main, this.icon, this.description});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      date: new DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000, isUtc: false),
      name: json['name'],
      temp: (json['main']['temp'].toDouble() - 273.15),
      minTemp: (json['main']['temp_min'].toDouble() - 273.15),
      maxTemp: (json['main']['temp_max'].toDouble() - 273.15),
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}
