import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class sample extends StatefulWidget {
  const sample({super.key});

  @override
  State<sample> createState() => _sampleState();
}

class _sampleState extends State<sample> {
  var namecontroller = TextEditingController();
  String picture = "";

  Future<MediaPosts>? futurePost;
  String name ="";


  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  Future<MediaPosts> fetchPost() async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$name&appid=a6920cb083f7613503664bb55f51eefd&units=metric'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return MediaPosts.fromJson(jsonResponse['main']);
    } else {
      throw Exception('Failed to load weather data');
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 71, 184, 254),
        ),
        backgroundColor: Color.fromARGB(255, 71, 184, 254),
        body: SingleChildScrollView(
          child: FutureBuilder<MediaPosts>(
            future: futurePost,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No data available');
              } else {
                final post = snapshot.data!;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      onChanged: (input){
                        setState(() {
                          name = input;
                        }
                        );
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        labelText: "Location",
                        hintText: "Enter The City Name",
                      ),

                    ),
                    ElevatedButton(onPressed: () {
                      setState(() {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => sample(),));


                      });
                    }, child: Text("Go")
                    ),
                    Container(
                      height: 250,
                      child: Image(
                        image: AssetImage("images/sun.png"),
                      ),
                    ),

                    Text(' ${post.temp}°C',

                      style: TextStyle(
                          fontSize: 60,
                          fontFamily: "Gotham",
                          color: Colors.white
                      ),
                    ),

                    Container(
                      width: 350,

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),

                        ),
                        color: Color.fromARGB(255, 123, 203, 254),
                        child: Container(
                          child: Column(
                            children: [
                              Text(' Feels Like ${post.feels_like}°C',

                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: "Poppins",
                                    color: Colors.white
                                ),
                              ),
                              Text('Humidity: ${post.humidity}%',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                ),
                              ),
                              Text('Pressure: ${post.pressure} hPa',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Poppins",
                                  color: Colors.white,
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),


                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MediaPosts {
  final double temp;
  final double feels_like;
  final int humidity;
  final int pressure;
  final String icon;



  MediaPosts({
    required this.temp,
    required this.feels_like,
    required this.humidity,
    required this.pressure,
    required this.icon


  });

  factory MediaPosts.fromJson(Map<String, dynamic> main) {
    return MediaPosts(
      temp: main['temp'].toDouble(),
      feels_like: main['feels_like'].toDouble(),
      humidity: main['humidity'],
      pressure: main['pressure'],
      icon: main['pressure'],



    );
  }
}


