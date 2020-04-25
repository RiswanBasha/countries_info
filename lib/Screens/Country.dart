import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'countryMap.dart';

class Country extends StatelessWidget {
  static const routeName='/country';


  @override
  Widget build(BuildContext context) {
    final Map country=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: Text(country['name']),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: GridView(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          children: <Widget>[
            FlipCard(
              direction: FlipDirection.VERTICAL,
              front: CountryCard(title: 'Capital'),
              back:CountryDetailCard(title: country['capital'],
                color: Colors.blue,
              ),
            ),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard(title: 'Population'),
                back:CountryDetailCard(title:  country['population'].toString(),
                  color: Colors.green,
                ),
            ),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard(title:  'Flag'),
                back:Card(
                  color: Colors.black54,
                  elevation: 10,
                  child: Center(
                    child: SvgPicture.network(country['flag'],
                    width: 200,
                    )
                  ),
                ),
            ),
            FlipCard(
                direction: FlipDirection.VERTICAL,
                front: CountryCard(title: 'Currency'),
                back:CountryDetailCard(title: country['currencies'][0]['name'],
                  color: Colors.amber,
                ),
            ),
            GestureDetector(onTap: (){
              Navigator.of(context).pushNamed(CountryMap.routeName,arguments: {
                'name': country['name'],
                'latlng':country['latlng'],
              });
            },
                child: CountryCard(title: 'Map')),
        ],
      ),
      ),
    );
  }
}

class CountryDetailCard extends StatelessWidget {
  final String title;
  final MaterialColor color;
  CountryDetailCard({this.title,this.color});
  @override
  Widget build(BuildContext context) {
    return  Card(
      color: color,
      elevation: 10,
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String title;
  const CountryCard({
    Key key,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Center(
          child: Text(
         title,
            style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
      )),
    );
  }
}
