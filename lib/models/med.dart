
class Med {
  int id;
  String nome;
  int compresse;
  String dosaggio;
  DateTime prelievo;
  DateTime scadenza; 

  Med ({
    required this.id,
    required this.nome,
    required this.compresse,
    required this.dosaggio,
    required this.prelievo,
    required this.scadenza
  });

  Med.med({
    this.id = 0,
    required this.nome,
    required this.compresse,
    required this.dosaggio,
    required this.prelievo,
  }) : scadenza = prelievo.add(Duration(days: compresse));

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'nome': nome,
      'compresse': compresse,
      'dosaggio': dosaggio,
      'prelievo': prelievo.toString(),
      'scadenza': scadenza.toString(),
    };
  }

  factory Med.fromMap(Map<String, dynamic> map) {
    return Med(
      id: map['id'] as int,
      nome: map['nome'] as String,
      compresse: map['compresse'] as int,
      dosaggio: map['dosaggio'] as String,
      prelievo: DateTime.parse(map['prelievo'] as String),
      scadenza: DateTime.parse(map['scadenza'] as String),
    );
  }

  @override
  String toString() {
    return "Med{id: $id, nome: $nome, compresse: $compresse, dosaggio: $dosaggio, prelievo: $prelievo, scadenza: $scadenza}";
  }

  String getPrelievoFormatted() {
    return "${prelievo.day}/${prelievo.month}/${prelievo.year}";
  }

  String getScadenzaFormatted() {
    return "${scadenza.day}/${scadenza.month}/${scadenza.year}";
  }
}