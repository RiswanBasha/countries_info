import 'package:countriesinfo/Screens/Country.dart';
import 'package:countriesinfo/Screens/countryMap.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AllCountries extends StatefulWidget {
  @override
  _AllCountriesState createState() => _AllCountriesState();
}

class _AllCountriesState extends State<AllCountries> {
  List countries=[];
  List filteredCountries=[];
  bool isSearching=false;
  getCountries()async{
    var response=await Dio().get('https://restcountries.eu/rest/v2/all');
    return response.data;
  }

  @override
  void initState() {
    getCountries().then((data){
      setState(() {
        countries=filteredCountries=data;
      });
    });
    super.initState();
  }

  void _filterCountries(value){
    setState(() {
      filteredCountries =
          countries.where((country)=> country['name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    getCountries();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: !isSearching
            ? Text('All Countries')
            : TextField(
          onChanged: (value){
            _filterCountries(value);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(Icons.search,color: Colors.white),
              hintText: "Search Country Here",
              hintStyle: TextStyle(color: Colors.black54),
          ),
        ),
        actions: <Widget>[
          isSearching?
          IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching =false;
                filteredCountries=countries;
              });
            },
          ):
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                setState(() {
                  this.isSearching =true;
                });
              },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredCountries.length>0 ?
        ListView.builder(
            itemCount: filteredCountries.length,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed(Country.routeName,arguments: filteredCountries[index]);
                },
                child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical:10.0 , horizontal: 8.0),
                      child: Text(
                        filteredCountries[index]['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                ),
              );
            })
            :Center(
          child: CircularProgressIndicator(),
        ),
    ),
    );
  }
}