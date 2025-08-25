import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/passeio.dart';
import '../models/aluno.dart';

class SeusPasseiosScreen extends StatefulWidget {
  final Aluno aluno;

  const SeusPasseiosScreen({required this.aluno, super.key});

  @override
  State<SeusPasseiosScreen> createState() => _SeusPasseiosScreenState();
}

class _SeusPasseiosScreenState extends State<SeusPasseiosScreen> {
  late Future<List<Passeio>> _meusPasseios;

  @override
void initState() {
  super.initState();
  _meusPasseios = ApiService.getPasseiosReservados(widget.aluno.id);
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
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
