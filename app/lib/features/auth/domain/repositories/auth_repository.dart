import 'package:app/generated_code/rest_api.swagger.dart';

abstract class AuthRepository {
  Future<UserDto?> login(LoginDto form);
  Future<UserDto?> register(RegisterDto form);
  Future<UserDto?> loadMe();
  Future<void> logout();
}
