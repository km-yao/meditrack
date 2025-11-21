import 'package:meditrack/models/med.dart';

class Disponibilita {

  int id;
  DateTime prelievo;
  DateTime scadenza; 

  Disponibilita({required this.id, required this.prelievo, required this.scadenza});
  
  Disponibilita.med({required Med med}) :
    id = med.id,
    prelievo = DateTime.now(),
    scadenza = DateTime.now().add(Duration(days: med.compresse));
  

  factory Disponibilita.fromMap(Map<String, dynamic> map) {
    // final dynamic raw = map['prelievo'];
    // late DateTime date;

    // if (raw == null) {
    //   date = DateTime.fromMillisecondsSinceEpoch(0);
    // } else if (raw is DateTime) {
    //   date = raw;
    // } else if (raw is int) {
    //   date = DateTime.fromMillisecondsSinceEpoch(raw);
    // } else {
    //   try {
    //     // handles Firestore Timestamp and similar objects with toDate()
    //     date = (raw as dynamic).toDate();
    //   } catch (_) {
    //     date = DateTime.parse(raw.toString());
    //   }
    // }

    return Disponibilita(
      id: map['id'] as int,
      // prelievo: date,
      // scandenza: date,
      prelievo: DateTime.parse(map['prelievo'] as String),
      scadenza: DateTime.parse(map['scadenza'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'attributo': prelievo.toString(),
    'scadenza': scadenza.toString(),
  };

}