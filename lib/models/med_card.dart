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

  String getFrequencyText() {
    switch (med.frequenza) {
      case 7:
        return "Settimanalmente";
      case 14:
        return "Ogni 2 settimane";
      case 30:
        return "Mensilmente";
      default:
        return "Giornalmente";
    }
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      color: getCardColor(context),
      elevation: 3,
      margin: EdgeInsets.all(6),
      child: InkWell(
        onLongPress: () => onLongPress(med),
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
                  Text("${med.compresse} compresse | ${getFrequencyText()}"),
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