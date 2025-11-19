import 'package:flutter/material.dart';
import 'package:meditrack/models/med.dart';

class MedCard extends StatelessWidget {
  const MedCard({super.key, required this.med});

  final Med med;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(6),
      child: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Row(
          children: [
            Column(
              spacing: 8,
              children: [
                Text(med.nome, style: TextStyle(fontSize: 24)),
                Text("${med.compresse} compresse"),
                Text(med.dosaggio),
              ],
            ),
            Expanded(child: const SizedBox()),
            IconButton(onPressed: null, icon: Icon(Icons.more_vert))
          ],
        ),
      ),
    );
  }
}