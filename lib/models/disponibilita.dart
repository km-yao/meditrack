class Disponibilita {

  final int id;
  final DateTime prelievo;
  DateTime scandenza; 

  Disponibilita({required this.id, required this.prelievo, required this.scandenza});

  factory Disponibilita.fromMap(Map<String, dynamic> map) {
    final dynamic raw = map['prelievo'];
    late DateTime date;

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
      scandenza: DateTime.parse(map['scadenza'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'attributo': prelievo,
    'scadenza': scandenza,
  };

  void setScadenza(int compresse) {
    scandenza = prelievo.add(Duration(days: compresse)) ;
  }
}