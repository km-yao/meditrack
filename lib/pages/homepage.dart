import 'package:flutter/material.dart';
import 'package:meditrack/city.dart';
import 'package:meditrack/city_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

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
          child: Placeholder()
          // child: ListView.builder(
          //   itemCount: _cities.length,
          //   itemBuilder: (context, index) {}
              
          // ),
        ),
      )
    );
  }
}