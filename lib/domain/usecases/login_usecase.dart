import '../entities/user_entity.dart';
import '../../data/repositories/auth_repository.dart';
import '../../core/utils/result.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase({AuthRepository? authRepository})
      : _authRepository = authRepository ?? AuthRepository();

  Future<Result<LoginResponse>> execute(String identificacion, String password) async {
    try {
      if (identificacion.isEmpty || password.isEmpty) {
        return Result.error('Identificación y contraseña son requeridos');
      }

      final result = await _authRepository.login(identificacion, password);
      return result;
    } catch (e) {
      return Result.error('Error durante el login: ${e.toString()}');
    }
  }
}

class LoginResponse {
  final String token;
  final UserEntity user;

  LoginResponse({
    required this.token,
    required this.user,
  });
}