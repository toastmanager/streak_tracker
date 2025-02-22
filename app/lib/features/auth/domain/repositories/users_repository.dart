import 'package:app/generated_code/rest_api.models.swagger.dart';

abstract class UsersRepository {
  Future<bool> putAvatar(int id);
  Future<bool> clearAvatar(int id);
  Future<UserDto> updateUser(int id, String? filePath, UpdateUserDto form);
}
