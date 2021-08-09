import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

const apiKey = '0f4abf9e48d2bdc335bac3abbe5c0e4b';
const myApikey =
    'https://api.openweathermap.org/data/2.5/weather?lat=20.216216216216218&lon=85.71274402766329&appid=0f4abf9e48d2bdc335bac3abbe5c0e4b';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var latitude;
  var longitude;
  //---------------------------------------------------------
  @override
  void initState() {
    super.initState();
    print('app opened');
    // getData();
  }

  void getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    latitude = position.latitude;
    longitude = position.longitude;
    print(position);
    getData();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=0f4abf9e48d2bdc335bac3abbe5c0e4b'));
    print(response.statusCode);
    if (response.statusCode == 200) {
      String data = response.body;
      var longitude = jsonDecode(data)['coord']['lon'];
      var weatherDescription = jsonDecode(data)['weather'][0]['main'];
      var temperature = jsonDecode(data)['main']['temp'];
      var cityName = jsonDecode(data)['name'];

      // print(data); //print json all data
      print(temperature);
      print(weatherDescription);
      print(longitude);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

//---------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  getLocation();
                },
                child: Text('get current lat and log'),
              ),
              ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text('get current location Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
