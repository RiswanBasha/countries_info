import 'package:flutter/material.dart';
import 'Screens/AllCountries.dart';
import 'Screens/Country.dart';
import 'Screens/countryMap.dart';
import 'dart:async';
void main(){
  runApp(new MaterialApp(
    debugShowCheckedModeBanner: false,
    home: new AllCountries(),
    routes: {
      CountryMap.routeName: (ctx)=> CountryMap(),
      Country.routeName: (ctx)=>Country()
    },
  ));
}


class AllCounties extends StatefulWidget {
  @override
  _AllCountiesState createState() => _AllCountiesState();
}

class _AllCountiesState extends State<AllCounties> {
  @override
  void initState() {
    super.initState();
      Future.delayed(Duration(
        seconds: 2
      ),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AllCounties(),),);
      }
      );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlutterLogo(
        size: 200,
      ),
    );
  }
}






