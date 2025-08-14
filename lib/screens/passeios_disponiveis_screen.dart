import 'package:flutter/material.dart';

class PasseiosDisponiveisScreen extends StatelessWidget {
  final List<Map<String, String>> passeios = [
    {
      "nome": "Museu Catavento",
      "valor": "R\$50,00",
      "data": "15/10/2024",
      "imagem": "assets/images/catavento.jpg",
    },
    {
      "nome": "Hopi Hari",
      "valor": "R\$40,00",
      "data": "20/10/2024",
      "imagem": "assets/images/hopi.jpg",
    },
    {
      "nome": "Passeio para Santos",
      "valor": "R\$60,00",
      "data": "25/10/2024",
      "imagem": "assets/images/santos.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Expanded(
                    child: ListView.builder(
                      itemCount: passeios.length,
                      itemBuilder: (context, index) {
                        final passeio = passeios[index];
                        return Card(
                          color: const Color(0xFFEDEDED),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(passeio["nome"]!,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4C89AC))),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(passeio["imagem"]!,
                                      height: 120, fit: BoxFit.cover),
                                ),
                                const SizedBox(height: 8),
                                Text("Valor: ${passeio["valor"]}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text("Data da excursão: ${passeio["data"]}",
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF4C89AC))),
                                const SizedBox(height: 12),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('${passeio["nome"]} reservado!')),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF4C89AC),
                                    ),
                                    child: const Text("Reservar"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFF4C89AC)),
                onPressed: () => Navigator.pop(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
