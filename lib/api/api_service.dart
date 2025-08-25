import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/aluno.dart';
import '../models/passeio.dart';
import '../models/avaliacao.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/api';

  // Login retorna um objeto Aluno
  static Future<Aluno> login(String rm, String senha) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/alunos/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'rm': rm, 'senhaBase64': senha}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Aluno.fromJson(jsonDecode(response.body));
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Falha no login: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Registrar novo aluno
  static Future<Aluno> registrarAluno(Aluno aluno) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/alunos/registrar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(aluno.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Aluno.fromJson(jsonDecode(response.body));
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao registrar aluno: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Buscar todos os passeios disponíveis
  static Future<List<Passeio>> getPasseios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/passeios'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => Passeio.fromJson(e)).toList();
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao buscar passeios: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Buscar passeios do usuário
  static Future<List<Passeio>> getPasseiosUsuario(int alunoId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/passeios/usuario/$alunoId'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => Passeio.fromJson(e)).toList();
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao buscar passeios do usuário: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Reservar um passeio usando DTO { alunoId, passeioId }
  static Future<void> reservarPasseio(int passeioId, int alunoId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reservas'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'alunoId': alunoId, 'passeioId': passeioId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao reservar passeio: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Buscar avaliações de um passeio
  static Future<List<Avaliacao>> getAvaliacoes(int passeioId) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/avaliacoes/passeio/$passeioId'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((e) => Avaliacao.fromJson(e)).toList();
      } else {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao buscar avaliações: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Enviar avaliação
  static Future<void> enviarAvaliacao(int passeioId, int alunoId, int nota, String comentario) async {
    try {
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

      if (response.statusCode != 200 && response.statusCode != 201) {
        final msg = _getErrorMessage(response);
        throw Exception('Erro ao enviar avaliação: $msg');
      }
    } catch (e) {
      throw Exception('Erro ao conectar com o servidor: $e');
    }
  }

  // Função interna para extrair mensagem de erro do backend
  static String _getErrorMessage(http.Response response) {
    try {
      final data = jsonDecode(response.body);
      return data['message'] ?? response.body;
    } catch (_) {
      return response.body.isNotEmpty ? response.body : 'Erro desconhecido';
    }
  }

  // Busca os passeios reservados pelo aluno
static Future<List<Passeio>> getPasseiosReservados(int alunoId) async {
  final response = await http.get(Uri.parse('$baseUrl/reservas/aluno/$alunoId'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    // Cada reserva retorna um objeto com "passeio", pegamos apenas o passeio
    return jsonList.map((e) => Passeio.fromJson(e['passeio'])).toList();
  }

  throw Exception('Erro ao buscar passeios do usuário: ${response.body}');
}

}
