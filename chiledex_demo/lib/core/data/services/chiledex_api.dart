import 'dart:convert';

import 'package:chiledex_demo/core/domain/models/especie_model.dart';
import 'package:chiledex_demo/core/domain/models/avistamiento_model.dart';
import 'package:chiledex_demo/core/domain/models/usuario_model.dart';
import 'package:http/http.dart' as http;

class ChiledexApi {
  static const baseUrl = 'http://192.168.1.29:8000';

  Future<List<EspecieModel>> obtenerEspecies() async {
    final response = await http.get(Uri.parse('$baseUrl/especies'));

    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode} al cargar especies');
    }

    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => EspecieModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<UsuarioModel> actualizarUsuario({
    required String usuarioId,
    required String email,
    required String nombre,
    String? apPaterno,
    String? apMaterno,
    String? fotoPerfilUrl,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$usuarioId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'nombre': nombre,
        'ap_paterno': apPaterno,
        'ap_materno': apMaterno,
        'foto_perfil_url': fotoPerfilUrl,
      }),
    );
    final body = _readAuthResponse(response);
    return UsuarioModel.fromJson(body['user'] as Map<String, dynamic>);
  }

  Future<void> cerrarSesion(String usuarioId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/logout/$usuarioId'),
    );
    _readAuthResponse(response);
  }

  Future<void> cambiarContrasena({
    required String usuarioId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl/usuarios/$usuarioId/password'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'current_password': currentPassword,
        'new_password': newPassword,
      }),
    );
    _readAuthResponse(response);
  }

  Future<Map<String, dynamic>> iniciarSesion({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return _readAuthResponse(response);
  }

  Future<Map<String, dynamic>> registrarUsuario({
    required String email,
    required String password,
    required String nombre,
    String? apPaterno,
    String? apMaterno,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'nombre': nombre,
        'ap_paterno': apPaterno,
        'ap_materno': apMaterno,
      }),
    );
    return _readAuthResponse(response);
  }

  Future<List<AvistamientoModel>> obtenerAvistamientos(String usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/$usuarioId/avistamientos'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode} al cargar avistamientos');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data
        .map((item) => AvistamientoModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<List<Map<String, dynamic>>> obtenerLogros(String usuarioId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/usuarios/$usuarioId/logros'),
    );
    if (response.statusCode != 200) {
      throw Exception('Error ${response.statusCode} al cargar logros');
    }
    final data = jsonDecode(response.body) as List<dynamic>;
    return data.whereType<Map<String, dynamic>>().toList();
  }

  Map<String, dynamic> _readAuthResponse(http.Response response) {
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        body['detail']?.toString() ?? 'No se pudo completar la operación',
      );
    }
    return body;
  }
}