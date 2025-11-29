import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meditrack/pages/homepage.dart';


void main() {
  // ApiDb().insertMed(Med.med(nome: "Biktary", compresse: 30, dosaggio: "20mg", prelievo: DateTime.parse("2024-07-01")));
  // ApiDb().insertMed(Med.med(nome: "Orfina", compresse: 20, dosaggio: "10mg", prelievo: DateTime.parse("2024-12-01")));
  // ApiDb().insertMed(Med.med(nome: "Illumina", compresse: 25, dosaggio: "30mg", prelievo: DateTime.parse("2024-07-01")));
  // ApiDb().insertMed(Med.med(nome: "Settima", compresse: 18, dosaggio: "10mg", prelievo: DateTime.parse("2025-07-01")));
  // ApiDb().insertMed(Med.med(nome: "ElleManna", compresse: 20, dosaggio: "40mg", prelievo: DateTime.parse("2025-07-15")));

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
