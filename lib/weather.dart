class Weather {
  final double temp;
  final double feels_like;
  final int humidity;
  final int pressure;
  final String name;
  final String main;
  final String icon;



  Weather({
    required this.temp,
    required this.feels_like,
    required this.humidity,
    required this.pressure,
    required this.name,
    required this.main,
    required this.icon,


  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'].toDouble(),
      feels_like: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      pressure: json['main']['pressure'],
      name:json['name'],
      main: json['weather'][0]['main'],
      icon: json['weather'][0]['icon']

    );
  }

}