import 'package:flutter/material.dart';

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
                  Image.asset('assets/images/logo.png', height: 50), // Altere conforme necessário
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Olá Aluno,',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      Text('Fulano de Tal',
                          style: TextStyle(fontSize: 18, color: Color(0xFF4C89AC))),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              _menuItem(Icons.insert_emoticon, 'Avaliações'),
              const SizedBox(height: 20),
              _menuItem(Icons.directions, 'Passeios'),
              const SizedBox(height: 20),
              _menuItem(Icons.favorite_border, 'Seus passeios'),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context); // Volta para tela de login
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label) {
    return ElevatedButton(
      onPressed: () {
        // Ação ao clicar em cada item
      },
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
          Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
