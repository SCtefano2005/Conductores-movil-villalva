class UserEntity {
  final String id;
  final String identificacion;
  final String nombres;
  final String apellidos;
  final String email;
  final String? role;

  UserEntity({
    required this.id,
    required this.identificacion,
    required this.nombres,
    required this.apellidos,
    required this.email,
    this.role,
  });

  String get fullName => '$nombres $apellidos';
}