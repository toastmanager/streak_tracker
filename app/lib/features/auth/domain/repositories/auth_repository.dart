import 'package:app/generated_code/rest_api.swagger.dart';

abstract class AuthRepository {
  Future<UserSensitiveDto?> login(LoginDto form);
  Future<UserSensitiveDto?> register(RegisterDto form);
  Future<UserSensitiveDto?> loadMe();
  Future<UserSensitiveDto> updateMe(UpdateMeDto form, String? avatarPath);
  Future<void> logout();
}
