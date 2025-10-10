import '../../domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String identificacion;
  final String nombres;
  final String apellidos;
  final String email;

  UserModel({
    required this.id,
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      identificacion: json['identificacion'] ?? '',
      nombres: json['nombres'] ?? '',
      apellidos: json['apellidos'] ?? '',
      email: json['email'] ?? '',
    );
  }
  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      identificacion: entity.identificacion,
      nombres: entity.nombres,
      apellidos: entity.apellidos,
      email: entity.email,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'identificacion': identificacion,
      'nombres': nombres,
      'apellidos': apellidos,
      'email': email,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      identificacion: identificacion,
      nombres: nombres,
      apellidos: apellidos,
      email: email,
    );
  }
}

class LoginResponseModel {
  final String token;
  final UserModel perfil;

  LoginResponseModel({
    required this.token,
    required this.perfil,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json['token'] ?? '',
      perfil: UserModel.fromJson(json['perfil']),
    );
  }
}