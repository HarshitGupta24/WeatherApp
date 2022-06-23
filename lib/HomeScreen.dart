import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var temp;
  var currently;
  var windspeed;
  var humidity;
  var description;

Future getWeather() async {

  http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=india&units=imperial&appid=7e974d3c88a8799b7226de1b38a4b782"));
  var results  = jsonDecode(response.body);
  setState(() {
    this.temp = results['main']['temp'];
    this.description = results['weather'][0]['description'];
    this.currently = results['weather'][0]['main'];
    this.humidity= results['main']['humidity'];
    this.windspeed = results['wind']['speed'];
  });
}
@override
  void initState() {

    getWeather();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
            height: MediaQuery.of(context).size.height/3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(bottom: 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Currently in India",style: TextStyle(
                    color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w600,
                  ),),
                ),
                
                ),
                Text(temp != null? temp.toString()+ "\u00B0" :"loading",style: TextStyle(
                  color: Colors.black87,fontSize: 40.0,fontWeight: FontWeight.w600
                ),),
    
                  Padding(padding: EdgeInsets.only(top: 10.0),
                child: Text(description != null? description.toString()+ "\u00B0" :"loading",style: TextStyle(
                  color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.w600
                ),),
                
                ),
              ],
            ),
    
          ), 
          Expanded(child: Padding(padding: EdgeInsets.all(20.0),child: ListView(
            children: [
              
              ListTile(
                leading: FaIcon(FontAwesomeIcons.temperatureHalf),
                title: Text("Temperature"),
                trailing: Text(temp != null? temp.toString()+ "\u00B0" :"loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.sun),
                title: Text("weather"),
                trailing: Text(currently != null? currently.toString() :"loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.cloudRain),
                title: Text("humidty"),
                trailing: Text(humidity != null? humidity.toString() :"loading"),
              ),
              ListTile(
                leading: FaIcon(FontAwesomeIcons.wind),
                title: Text("WindSpeed"),
                trailing: Text(windspeed != null? windspeed.toString() :"loading"),
              ),
            ],
          ),))

          ],
          
        ),
      ),
    );
  }
}