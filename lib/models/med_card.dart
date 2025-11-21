import 'package:flutter/material.dart';
import 'package:meditrack/models/disponibilita.dart';
import 'package:meditrack/models/med.dart';
import 'package:meditrack/services/disp_service.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.med, this.disponibilita});

  final Med med;
  final Disponibilita? disponibilita;

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      elevation: 3,
      margin: EdgeInsets.all(6),
      child: Padding(
        padding: EdgeInsetsGeometry.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(med.nome, style: TextStyle(fontSize: 26)),
                Text("${med.compresse} compresse"),
                Text(med.dosaggio, textAlign: TextAlign.start),
              ],
            ),
            Expanded(child: const SizedBox()),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: 4,
              children: [
                Text("Prelievo: ${disponibilita != null ? disponibilita!.prelievo.toString() : 'N/A'}"),
                Text("Scadenza: ${disponibilita != null ? disponibilita!.scadenza : 'N/A'}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}