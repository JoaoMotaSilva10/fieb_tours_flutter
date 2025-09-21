import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/passeio.dart';
import '../models/aluno.dart';
import 'package:http/http.dart' as http;

class SeusPasseiosScreen extends StatefulWidget {
  final Aluno aluno;

  const SeusPasseiosScreen({required this.aluno, super.key});

  @override
  State<SeusPasseiosScreen> createState() => _SeusPasseiosScreenState();
}

class _SeusPasseiosScreenState extends State<SeusPasseiosScreen> {
  late Future<List<Passeio>> _meusPasseios;
  final String baseUrl = 'http://localhost:8080/api';

  @override
  void initState() {
    super.initState();
    _meusPasseios = fetchPasseiosReservados();
  }

  Future<List<Passeio>> fetchPasseiosReservados() async {
    // Busca as reservas
    final reservasUrl = Uri.parse('$baseUrl/reservas');
    final reservasResponse = await http.get(reservasUrl);

    if (reservasResponse.statusCode != 200) {
      throw Exception('Erro ao carregar reservas: ${reservasResponse.statusCode}');
    }

    final List<dynamic> reservasData = json.decode(reservasResponse.body);
    final alunoReservas = reservasData.where((reserva) => reserva['nome'] == widget.aluno.nome).toList();

    if (alunoReservas.isEmpty) return [];

    // Busca todos os passeios
    final passeiosUrl = Uri.parse('$baseUrl/passeios');
    final passeiosResponse = await http.get(passeiosUrl);

    if (passeiosResponse.statusCode != 200) {
      throw Exception('Erro ao carregar passeios: ${passeiosResponse.statusCode}');
    }

    final List<dynamic> passeiosData = json.decode(passeiosResponse.body);

    // Combina reservas com dados dos passeios
    List<Passeio> passeiosReservados = [];
    
    for (var reserva in alunoReservas) {
      final passeioEncontrado = passeiosData.firstWhere(
        (passeio) => passeio['nome'] == reserva['passeio'],
        orElse: () => null,
      );

      if (passeioEncontrado != null) {
        passeiosReservados.add(Passeio(
          id: passeioEncontrado['id'],
          nome: passeioEncontrado['nome'],
          descricao: passeioEncontrado['descricao'] ?? '',
          dataPasseio: passeioEncontrado['dataPasseio'] ?? '',
          preco: (passeioEncontrado['preco'] ?? 0).toDouble(),
          horaSaida: passeioEncontrado['horaSaida'] ?? '',
          horaChegada: passeioEncontrado['horaChegada'] ?? '',
          dataInicioRecebimento: passeioEncontrado['dataInicioRecebimento'] ?? '',
          dataFinalRecebimento: passeioEncontrado['dataFinalRecebimento'] ?? '',
          dataCadastro: passeioEncontrado['dataCadastro'] ?? '',
          statusPasseio: passeioEncontrado['statusPasseio'] ?? '',
        ));
      }
    }

    return passeiosReservados;
  }

  String formatarData(String dataString) {
    if (dataString.isEmpty) return '';
    final data = DateTime.parse(dataString);
    return "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seus Passeios")),
      body: FutureBuilder<List<Passeio>>(
        future: _meusPasseios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final passeios = snapshot.data ?? [];

          if (passeios.isEmpty) {
            return const Center(child: Text('Nenhum passeio reservado.'));
          }

          return ListView.builder(
            itemCount: passeios.length,
            itemBuilder: (context, index) {
              final passeio = passeios[index];
              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        passeio.nome,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          'https://picsum.photos/seed/${passeio.id}/200/120',
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Valor: R\$${passeio.preco.toStringAsFixed(2)}"),
                      Text("Data: ${formatarData(passeio.dataPasseio)}"),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
