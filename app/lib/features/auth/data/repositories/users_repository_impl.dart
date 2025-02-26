import 'package:app/features/auth/domain/repositories/users_repository.dart';
import 'package:app/generated_code/rest_api.swagger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: UsersRepository)
class UsersRepositoryImpl implements UsersRepository {
  final RestApi restApi;
  final Logger logger;

  const UsersRepositoryImpl({required this.restApi, required this.logger});

  @override
  Future<UserDto> updateUser(
    int id,
    String? filePath,
    UpdateUserDto form,
  ) async {
    if (filePath != null) {
      final avatarPutResponse = await restApi.apiV1UsersIdAvatarPut(
          id: id.toString(), file: filePath);
      if (avatarPutResponse.error != null) {
        logger.e(avatarPutResponse.error);
        throw Exception('Failed to put avatar image');
      }
    }

    final response =
        await restApi.apiV1UsersIdPatch(id: id.toString(), body: form);
    if (response.error != null || response.body == null) {
      if (response.statusCode == 404) {
        throw Exception('User not found');
      }
      logger.e(response.error);
      throw Exception('null value received when tried to update user');
    }

    return response.body!;
  }

  @override
  Future<bool> clearAvatar(int id) async {
    final response = await restApi.apiV1UsersIdAvatarDelete(id: id.toString());
    if (response.error != null) {
      logger.e(response.error);
      return false;
    }
    return response.body!.isDeleted;
  }

  @override
  Future<bool> putAvatar(int id) {
    // TODO: implement putAvatar
    throw UnimplementedError();
  }
}
