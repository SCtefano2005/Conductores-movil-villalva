import 'package:flutter/material.dart';
import '../../data/services/auth_service.dart';

class ResetPasswordController extends ChangeNotifier {
  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController licenciaController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool isLoading = false;
  String? errorMessage;
  int step = 1;

  void validarConductor(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _authService.validarConductor(
        identificacionController.text,
        licenciaController.text,
      );

      if (response['valido'] == true) {
        step = 2;
      } else {
        errorMessage = 'Datos inválidos';
      }
    } catch (e) {
      errorMessage = 'Error: ${e.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }

  void actualizarPassword(BuildContext context) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final mensaje = await _authService.actualizarPassword(
        identificacionController.text,
        passwordController.text,
      );

      // Mostrar mensaje y cerrar modal
      if (context.mounted) {
        Navigator.of(context).pop(); // Cierra modal
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Éxito'),
            content: Text(mensaje),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      errorMessage = 'Error: ${e.toString()}';
    }

    isLoading = false;
    notifyListeners();
  }

  @override
  void dispose() {
    identificacionController.dispose();
    licenciaController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
