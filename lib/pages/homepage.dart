import 'package:flutter/material.dart';
import 'package:meditrack/city.dart';
import 'package:meditrack/city_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final List<City> _cities = [
    City(id: 1, idRegione: 1, popolazione: 160000, nome: 'Perugia', provincia: 'PG'),
    City(id: 2, idRegione: 1, popolazione: 60000, nome: 'Narni', provincia: 'TR'),
    City(id: 3, idRegione: 1, popolazione: 40000, nome: 'Assisi', provincia: 'PG'),
    City(id: 4, idRegione: 1, popolazione: 140000, nome: 'Terni', provincia: 'TR'),
    City(id: 5, idRegione: 1, popolazione: 25000, nome: 'Umbertide', provincia: 'PG'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MediTrack", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: null, icon: Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
          child: ListView.builder(
            itemCount: _cities.length,
            itemBuilder: (context, index) {
              City currentCity = _cities[index];
              return CityCard(currentCity: currentCity);
            },
          ),
        ),
      )
    );
  }
}