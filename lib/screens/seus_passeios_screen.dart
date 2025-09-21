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
    final url = Uri.parse('$baseUrl/reservas'); 
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Erro ao carregar reservas: ${response.statusCode}');
    }

    // Decodifica o corpo como lista
    final List<dynamic> data = json.decode(response.body);

    // Filtra apenas as reservas do aluno logado
    final alunoReservas = data.where((reserva) => reserva['nome'] == widget.aluno.nome).toList();

    // Converte cada reserva para um Passeio
    return alunoReservas.map((reservaJson) {
      return Passeio(
        id: reservaJson['id'],
        nome: reservaJson['passeio'], // o backend retorna 'passeio'
        preco: (reservaJson['preco'] ?? 0).toDouble(),
        dataPasseio: reservaJson['dataPasseio'] ?? '', // ajuste conforme seu backend
      );
    }).toList();
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
