import 'package:flutter/material.dart';
import 'package:meditrack/models/med.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.med, required this.onLongPress});

  final Med med;
  final Function onLongPress;

  Color getCardColor(BuildContext context) {
    final now = DateTime.now();
    final difference = med.scadenza.difference(now).inDays;

    if (difference <= 3) {
      return Theme.of(context).colorScheme.error;
    } else if (difference <= 7) {
      return Colors.orangeAccent;
    } else {
      return Theme.of(context).colorScheme.inversePrimary;
    }
  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onLongPress: () => onLongPress,
      child: Card(
        color: getCardColor(context),
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
                  Text("Prelievo: ${med.getPrelievoFormatted()}"),
                  Text("Scadenza: ${med.getScadenzaFormatted()}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}