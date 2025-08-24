class Passeio {
  int id;
  String nome;
  String imagem;
  double preco;
  String data;

  Passeio({
    required this.id,
    required this.nome,
    required this.imagem,
    required this.preco,
    required this.data,
  });

  factory Passeio.fromJson(Map<String, dynamic> json) {
    return Passeio(
      id: json['id'],
      nome: json['nome'],
      imagem: json['imagem'],
      preco: (json['preco'] as num).toDouble(),
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'imagem': imagem,
      'preco': preco,
      'data': data,
    };
  }
}
