import 'package:flutter/material.dart';
import 'menu_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController rmController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/logo.png', // Substitua pelo seu logo real
                height: 100,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Entrar\nAluno',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  SizedBox(width: 20),
                  Icon(Icons.account_circle, size: 40, color: Colors.grey),
                  SizedBox(width: 8),
                  Text('Microsoft',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: rmController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'RM',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.vpn_key),
                  labelText: 'Senha',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => MenuScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4C89AC),
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
