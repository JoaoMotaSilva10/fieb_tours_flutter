import 'package:flutter/material.dart';

class SeusPasseiosScreen extends StatelessWidget {
  const SeusPasseiosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final meusPasseios = [
      {
        "nome": "Hopi Hari",
        "valor": "R\$200,00",
        "data": "27/09/2024",
        "imagem": "assets/images/hopi.jpg",
      },
    ];

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
                      itemCount: meusPasseios.length,
                      itemBuilder: (context, index) {
                        final passeio = meusPasseios[index];
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[400],
                                      ),
                                      child: const Text("Reservado"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF4C89AC),
                                      ),
                                      child: const Text("Ver comprovante"),
                                    ),
                                  ],
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