import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aluno.dart';
import '../models/passeio.dart';
import '../models/avaliacao.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Login retorna um objeto Aluno
  static Future<Aluno> login(String rm, String senha) async {
    final response = await http.post(
      Uri.parse('$baseUrl/alunos/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'rm': rm, 'senhaBase64': senha}),
    );

    if (response.statusCode == 200) {
      return Aluno.fromJson(jsonDecode(response.body));
    }
    throw Exception('Falha no login: ${response.body}');
  }

  // Registrar novo aluno
  static Future<Aluno> registrarAluno(Aluno aluno) async {
    final response = await http.post(
      Uri.parse('$baseUrl/alunos/registrar'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(aluno.toJson()),
    );

    if (response.statusCode == 200) {
      return Aluno.fromJson(jsonDecode(response.body));
    }
    throw Exception('Erro ao registrar aluno: ${response.body}');
  }

  // Buscar todos os passeios disponíveis
  static Future<List<Passeio>> getPasseios() async {
    final response = await http.get(Uri.parse('$baseUrl/passeios'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Passeio.fromJson(e)).toList();
    }
    throw Exception('Erro ao buscar passeios: ${response.body}');
  }

  // Buscar passeios do usuário
  static Future<List<Passeio>> getPasseiosUsuario(int alunoId) async {
    final response = await http.get(Uri.parse('$baseUrl/passeios/usuario/$alunoId'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => Passeio.fromJson(e)).toList();
    }
    throw Exception('Erro ao buscar passeios do usuário: ${response.body}');
  }

  // Reservar um passeio
  static Future<void> reservarPasseio(int passeioId, int alunoId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reservas'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'passeioId': passeioId, 'alunoId': alunoId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao reservar passeio: ${response.body}');
    }
  }

  // Buscar avaliações de um passeio
  static Future<List<Avaliacao>> getAvaliacoes(int passeioId) async {
  final response = await http.get(Uri.parse('$baseUrl/avaliacoes/passeio/$passeioId'));
  
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((e) => Avaliacao.fromJson(e)).toList();
  }
  throw Exception('Erro ao buscar avaliações: ${response.body}');
}


  // Enviar avaliação
  static Future<void> enviarAvaliacao(
      int passeioId, int alunoId, int nota, String comentario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/avaliacoes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'passeioId': passeioId,
        'alunoId': alunoId,
        'nota': nota,
        'comentario': comentario,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Erro ao enviar avaliação: ${response.body}');
    }
  }
}
