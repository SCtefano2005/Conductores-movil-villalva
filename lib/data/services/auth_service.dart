import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../../core/constants/api_constants.dart';

class AuthService {
  String? _dniValidado; // ⏳ Guardar temporalmente el DNI validado

  Future<Map<String, dynamic>?> login(String identificacion, String password) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/login/conductor'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'identificacion': 'DNI-$identificacion',
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'token': data['token'],
          'perfil': UserModel.fromJson(data['perfil']),
        };
      } else if (response.statusCode == 401) {
        throw Exception('Credenciales inválidas');
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en el servicio de autenticación: $e');
    }
  }

  /// ✅ Versión que guarda el DNI validado para uso en modal
  Future<Map<String, dynamic>> validarConductor(String identificacion, String numeroLicencia) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/verification-credentials'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'identificacion': 'DNI-$identificacion',
          'numero_licencia': numeroLicencia,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['valido'] == true) {
          _dniValidado = identificacion;
        }
        return data;
      } else {
        throw Exception('Error en la verificación');
      }
    } catch (e) {
      throw Exception('Error en la verificación: $e');
    }
  }

  /// ✅ Usado por el Repository → no depende del estado interno
  Future<String> actualizarPassword(String identificacion, String nuevaPassword) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConstants.baseUrl}/api/auth/recovery-password'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'identificacion': 'DNI-$identificacion',
          'nuevaPassword': nuevaPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['mensaje'] ?? 'Contraseña actualizada correctamente';
      } else {
        throw Exception('Error al actualizar contraseña');
      }
    } catch (e) {
      throw Exception('Error al actualizar contraseña: $e');
    }
  }

  /// ✅ Usado desde el modal, si el DNI ya fue validado previamente
  Future<String> actualizarPasswordSinDni(String nuevaPassword) async {
    if (_dniValidado == null) {
      throw Exception('No se ha validado el DNI aún');
    }
    return actualizarPassword(_dniValidado!, nuevaPassword);
  }
}
