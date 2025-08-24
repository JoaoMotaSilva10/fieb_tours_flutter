class Avaliacao {
  int id;
  int passeioId;
  int usuarioId; 
  String usuario; 
  int nota;
  String comentario;

  Avaliacao({
    required this.id,
    required this.passeioId,
    required this.usuarioId,
    required this.usuario,
    required this.nota,
    required this.comentario,
  });

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    return Avaliacao(
      id: json['id'],
      passeioId: json['passeioId'],
      usuarioId: json['usuarioId'], 
      usuario: json['usuario'] ?? 'Anônimo',
      nota: json['nota'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passeioId': passeioId,
      'usuarioId': usuarioId, 
      'nota': nota,
      'comentario': comentario,
    };
  }
}
