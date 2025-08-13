import 'package:flutter/material.dart';

class AvaliacoesScreen extends StatelessWidget {
  const AvaliacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passeiosFeitos = [
      {"nome": "Museu Catavento", "imagem": "assets/images/catavento.jpg"},
      {"nome": "Passeio para Santos", "imagem": "assets/images/santos.jpg"},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  const Text("Para Avaliar",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4C89AC))),
                  const SizedBox(height: 12),
                  const Text("Seus passeios disponíveis:",
                      style: TextStyle(fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: passeiosFeitos.length,
                      itemBuilder: (context, index) {
                        final passeio = passeiosFeitos[index];
                        return Card(
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4C89AC))),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(passeio["imagem"]!,
                                      height: 120, fit: BoxFit.cover),
                                ),
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

