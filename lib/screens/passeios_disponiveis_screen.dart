import 'package:flutter/material.dart';
import 'passeios_comprados_screen.dart';
import 'avaliacoes_screen.dart';

class PasseiosDisponiveisScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Passeios Disponíveis')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Lista de passeios aqui', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PasseiosCompradosScreen()),
                );
              },
              child: Text('Ver Passeios Comprados'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AvaliacoesScreen()),
                );
              },
              child: Text('Ver Avaliações'),
            ),
          ],
        ),
      ),
    );
  }
}
