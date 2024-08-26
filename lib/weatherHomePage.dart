import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weatherapp/weather.dart';


final TextEditingController cityController = TextEditingController();





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

  String name="trivandrum";
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
  var size,height,width;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height=size.height;
    width=size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
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
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData) {
                  return const Text('No data available');
                } else {
                  final post = snapshot.data!;

                  return SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height/25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 300,
                              child: TextFormField(
                                controller: cityController,
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
                              shape: const CircleBorder(eccentricity: CircularProgressIndicator.strokeAlignCenter),
                              backgroundColor: Colors.white,
                              onPressed: () {
                                setState(() {
                                  name=eg;
                                });
                              },
                              child: const Icon(Icons.search),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height/25,
                        ),
                        Text(' ${post.name}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 60,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                        Center(
                          child: Container(
                            height:270,
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage(weatherimage(post.icon)),
                                )
                            ),
                          ),
                        ),

                        Text(' ${post.temp}°',
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                            fontSize: 70,
                            fontFamily: "Gotham",
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(' Feels Like ${post.feels_like}°C',
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                              fontSize: 30,
                              fontFamily: "Poppins",
                              color: Colors.white
                          ),
                        ),


                        Text(' ${post.main}',
                          textAlign: TextAlign.center,

                          style: const TextStyle(
                              fontSize: 20,
                              fontFamily: "Gotham",
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),

                        const SizedBox(
                          height: 20,
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
                                    const ImageIcon(
                                        AssetImage("images/humidity.png")
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),


                                    Text('${post.humidity}%',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: "Poppins",
                                        color: Colors.black,
                                      ),
                                    ),


                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Row(
                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                  children: [
                                    const ImageIcon(
                                        AssetImage("images/pressure.png")
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),

                                    Text(' ${post.pressure} hPa',
                                      style: const TextStyle(
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
