import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../core/utils/app_navigator.dart';
import '../../core/utils/secure_storage_service.dart';
import '../../data/models/user_model.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  
  LoginController({LoginUseCase? loginUseCase})
      : _loginUseCase = loginUseCase ?? LoginUseCase();

  final TextEditingController identificacionController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _activeTab = 'inicio';
  String get activeTab => _activeTab;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> login() async {
  if (identificacionController.text.isEmpty || passwordController.text.isEmpty) {
    _errorMessage = 'Por favor complete todos los campos';
    notifyListeners();
    return;
  }

  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    final result = await _loginUseCase.execute(
      identificacionController.text,
      passwordController.text,
    );

    if (result.isSuccess && result.data != null) {
      // Guardar token de forma segura
      await SecureStorageService.saveToken(result.data!.token);
      await SecureStorageService.saveUser(UserModel.fromEntity(result.data!.user));


      print('Login exitoso: ${result.data!.user.fullName}');
      print('Token guardado en SecureStorage.');

      // Navegar a home
      AppNavigator.navigateToHome();
    } else {
      _errorMessage = result.message ?? 'Error desconocido';
    }
  } catch (e) {
    _errorMessage = 'Error de conexión. Intente nuevamente.';
    print('Error en login: $e');
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  @override
  void dispose() {
    identificacionController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}