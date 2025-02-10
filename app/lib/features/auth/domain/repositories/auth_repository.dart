import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:app/features/auth/domain/entities/register_form_entity.dart';
import 'package:app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(LoginFormEntity form);
  Future<User?> register(RegisterFormEntity form);
  Future<User?> loadMe();
  Future<void> logout();
}
