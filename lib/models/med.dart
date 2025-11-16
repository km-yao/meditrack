
class Med {
  int id;
  String nome;
  int compresse;
  String dosaggio;

  Med ({
    required this.id,
    required this.nome,
    required this.compresse,
    required this.dosaggio
  });

  Map<String, Object?> toMap() {
    return {
      'id':id,
      'nome':nome,
      'compresse':compresse,
      'dosaggio':dosaggio,
    };
  }

  @override
  String toString() {
    return "Med{id: $id, nome: $nome, compresse: $compresse, dosaggio: $dosaggio}";
  }
}