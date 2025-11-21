import 'package:flutter/material.dart';
import 'package:meditrack/models/med.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.med});

  final Med med;

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
            IconButton(onPressed: null, icon: Icon(Icons.more_vert), color: Theme.of(context).colorScheme.inversePrimary,)
          ],
        ),
      ),
    );
  }
}