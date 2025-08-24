import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/passeio.dart';
import '../models/aluno.dart';

class PasseiosDisponiveisScreen extends StatefulWidget {
  final Aluno aluno;

  const PasseiosDisponiveisScreen({required this.aluno, super.key});

  @override
  State<PasseiosDisponiveisScreen> createState() =>
      _PasseiosDisponiveisScreenState();
}

class _PasseiosDisponiveisScreenState extends State<PasseiosDisponiveisScreen> {
  late Future<List<Passeio>> _passeiosFuture;

  @override
  void initState() {
    super.initState();
    _passeiosFuture = ApiService.getPasseios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Passeios Disponíveis")),
      body: FutureBuilder<List<Passeio>>(
        future: _passeiosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum passeio disponível'));
          }

          final passeios = snapshot.data!;

          return ListView.builder(
            itemCount: passeios.length,
            itemBuilder: (context, index) {
              final passeio = passeios[index];
              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
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
                      Image.network(
                        passeio.imagem,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text("Valor: R\$${passeio.preco}"),
                      Text("Data: ${passeio.data}"),
                      const SizedBox(height: 12),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              await ApiService.reservarPasseio(
                                passeio.id,
                                widget.aluno.id,
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Passeio reservado!')),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Erro ao reservar: $e')),
                              );
                            }
                          },
                          child: const Text("Reservar"),
                        ),
                      ),
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
