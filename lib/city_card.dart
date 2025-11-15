import 'package:flutter/material.dart';
import 'package:meditrack/city.dart';

class CityCard extends StatelessWidget {
  const CityCard({super.key, required this.currentCity});

  final City currentCity;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "${currentCity.nome} (${currentCity.provincia})\n" +
      "Popolazione: ${currentCity.popolazione}",
      preferBelow: false,
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
          side: BorderSide(
            width: 3,
            color: Colors.green
          )
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            currentCity.nome,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}