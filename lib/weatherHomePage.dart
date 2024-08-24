import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather.dart';
import 'package:weatherapp/weathersample.dart';
import 'weatherService.dart';


final TextEditingController _controller = TextEditingController();



class weatherHomePage extends StatefulWidget {
  const weatherHomePage({super.key});

  @override
  State<weatherHomePage> createState() => _weatherHomePageState();
}

class _weatherHomePageState extends State<weatherHomePage> {


  Future<Weather> getWeather() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$name&appid=a6920cb083f7613503664bb55f51eefd&units=metric'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Weather.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  String name="chicago";
  String eg="chicago";


  String weatherimage(String? icon){
    if(icon== null) return 'images/sun.png';

    switch(icon){
      case "01d":
        return "images/sun.png";
      case "01n":
        return "images/night.png";
      case "02d":
        return "images/fewclouds.png";
      case "02n":
        return "images/fewcloudsn.png";
      case "03d":
        return "images/clouds.png";
      case "03n":
        return "images/clouds.png";
      case "04d":
        return "images/brokenclouds.png";
      case "04n":
        return "images/brokenclouds.png";
      case "09d":
        return "images/showerain.png";
      case "09n":
        return "images/showerain.png";
      case "10d":
        return "images/rain.png";
      case "10n":
      return "images/rainn.png";
      case "11d":
        return "images/thunderstorm.png";
      case "11n":
        return "images/thunderstormn.png";
      case "13d":
        return "images/snow.png";
      case "13n":
        return "images/snow.png";
      case "50d":
        return "images/mist.png";
      case "50n":
        return "images/mistn.png";
      default:
        return "images/sun.png";
    }
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              fit:BoxFit.cover,
              image: AssetImage("images/bg.jpg")
            )
          ),
          child: Center(
            child: FutureBuilder<Weather>(
              future: getWeather(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return Text('No data available');
                } else {
                  final post = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextField(

                                onChanged: (value) {
                                  eg=value;
                                },
                                controller: _controller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(40),
                                  ),
                                  labelText: 'Enter the city',
                                ),
                              ),
                            ),
                            FloatingActionButton(
                              shape: CircleBorder(eccentricity: CircularProgressIndicator.strokeAlignCenter),
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  name=eg;
                                });
                              },
                              child: Icon(Icons.search),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Text(' ${post.name}',

                          style: TextStyle(
                              fontSize: 60,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Center(
                          child: Container(
                            height:300,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(weatherimage("${post.icon}")),
                                )
                            ),
                          ),
                        ),

                        Text(' ${post.temp}°',

                          style: TextStyle(
                              fontSize: 70,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                          ),
                        ),
                        Text(' Feels Like ${post.feels_like}°C',

                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "Poppins",
                              color: Colors.white
                          ),
                        ),


                        Text(' ${post.main}',

                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),

                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: 80,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                            ),
                            shadowColor: Colors.grey,
                            color: Colors.white,


                            child: Row(


                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageIcon(
                                        AssetImage("images/humidity.png")
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),


                                    Text('${post.humidity}%',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    ImageIcon(
                                        AssetImage("images/pressure.png")
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),

                                    Text(' ${post.pressure} hPa',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),


                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

