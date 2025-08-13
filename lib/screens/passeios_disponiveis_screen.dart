import 'package:flutter/material.dart';

class PasseiosDisponiveisScreen extends StatelessWidget {
  final List<String> passeios = [
    'Passeio ao Museu de Arte',
    'Visita ao Planetário',
    'Passeio ao Zoológico',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passeios Disponíveis'),
        backgroundColor: Color(0xFF4C89AC),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: passeios.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
            child: ListTile(
              title: Text(
                passeios[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: ElevatedButton(
                onPressed: () {
                  // Aqui vai a lógica de comprar/reservar o passeio
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passeio reservado!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C89AC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Reservar'),
              ),
            ),
          );
        },
      ),
    );
  }
}
