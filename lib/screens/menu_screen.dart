import 'package:flutter/material.dart';
import 'seus_passeios_screen.dart';
import 'passeios_disponiveis_screen.dart';
import 'avaliacoes_screen.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 32),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset('assets/images/logo.png', height: 50),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Olá Aluno,',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Fulano de Tal',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF4C89AC),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),

              // Botões do menu com navegação
              _menuItem(Icons.insert_emoticon, 'Avaliações', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AvaliacoesScreen()),
                );
              }),
              const SizedBox(height: 20),

              _menuItem(Icons.directions, 'Passeios Disponíveis', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => PasseiosDisponiveisScreen()),
                );
              }),
              const SizedBox(height: 20),

              _menuItem(Icons.favorite_border, 'Seus Passeios', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => SeusPasseiosScreen()),
                );
              }),

              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context); // Volta para tela anterior
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF4C89AC),
        elevation: 4,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Color(0xFF4C89AC)),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 32),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
