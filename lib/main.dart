import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/models/api_db.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/pages/homepage.dart';


void main() {
  ApiDb().insertMed(Med(id: 1, nome: "Biktary", compresse: 30, dosaggio: "20mg"));
  ApiDb().insertMed(Med(id: 2, nome: "Orfina", compresse: 20, dosaggio: "10mg"));
  ApiDb().insertMed(Med(id: 3, nome: "Illumina", compresse: 25, dosaggio: "30mg"));
  ApiDb().insertMed(Med(id: 4, nome: "Settima", compresse: 18, dosaggio: "10mg"));
  ApiDb().insertMed(Med(id: 5, nome: "ElleManna", compresse: 20, dosaggio: "40mg"));
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'MediTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const Homepage(),
    );
  }
}
