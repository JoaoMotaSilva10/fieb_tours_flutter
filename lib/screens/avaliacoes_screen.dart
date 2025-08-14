import 'package:flutter/material.dart';

class AvaliacoesScreen extends StatelessWidget {
  const AvaliacoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final passeiosFeitos = [
      {
        "nome": "Museu Catavento",
        "imagem": "assets/images/catavento.jpg",
        "valor": "R\$35,00",
        "data": "12/07/2024"
      },
      {
        "nome": "Passeio para Santos",
        "imagem": "assets/images/santos.jpg",
        "valor": "R\$80,00",
        "data": "05/08/2024"
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
                  const Text(
                    "Para Avaliar",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4C89AC),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Veja quais passeios você já fez e deixe sua opinião!",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: passeiosFeitos.length,
                      itemBuilder: (context, index) {
                        final passeio = passeiosFeitos[index];
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
                                Text(
                                  passeio["nome"]!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4C89AC),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    passeio["imagem"]!,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Valor: ${passeio["valor"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Data da excursão: ${passeio["data"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF4C89AC),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        // Lógica para ver avaliações
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            Colors.grey[400], // cinza
                                      ),
                                      child: const Text("Ver Avaliações"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // Lógica para dar avaliação
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4C89AC),
                                      ),
                                      child: const Text("Dar Avaliação"),
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
            ),
          ],
        ),
      ),
    );
  }
}
