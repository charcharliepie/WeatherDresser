class WeatherData {
  final String name;
  final double temp;
  final double minTemp;
  final double maxTemp;
  final String main;
  final String icon;
  final String description;
  final String cod;

  WeatherData(
      {this.name,
      this.temp,
      this.minTemp,
      this.maxTemp,
      this.main,
      this.icon,
      this.description,
      this.cod});

  factory WeatherData.getCode(Map<String, dynamic> json) {
    return WeatherData(cod: json['cod'].toString());
  }
  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cod: json['cod'].toString(),
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
