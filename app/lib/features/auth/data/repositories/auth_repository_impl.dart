import 'package:app/features/auth/data/utils/auth_token_service.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/features/auth/domain/repositories/users_repository.dart';
import 'package:app/generated_code/client_index.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RestApi restApi;
  final UsersRepository usersRepository;
  final AuthTokenService authTokenService;
  final Logger logger;

  const AuthRepositoryImpl({
    required this.restApi,
    required this.usersRepository,
    required this.authTokenService,
    required this.logger,
  });

  @override
  Future<UserSensitiveDto?> loadMe() async {
    try {
      final userResponse = await restApi.apiV1AuthMePost();
      if (userResponse.error != null) {
        throw Exception(userResponse.error);
      }
      final user = userResponse.body;
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserSensitiveDto?> login(LoginDto form) async {
    try {
      final authToken = (await restApi.apiV1AuthLoginPost(body: form));
      if (authToken.error != null) {
        throw Exception(authToken.error);
      }
      authTokenService.setAccessToken(authToken.body!.accessToken);
      final user = await loadMe();
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await restApi.apiV1AuthLogoutPost();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserSensitiveDto?> register(RegisterDto form) async {
    try {
      final _ = (await restApi.apiV1AuthRegisterPost(body: form));
      final user = (await restApi.apiV1AuthMePost()).body;
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<UserSensitiveDto> updateMe(
      UpdateMeDto form, String? avatarPath) async {
    try {
      if (avatarPath != null) {
        await restApi.apiV1AuthMeAvatarPut(
          file: avatarPath,
        );
      }
      final response = (await restApi.apiV1AuthMePut(body: form));
      if (response.error != null) {
        if (response.statusCode == 409) {
          throw Exception('Пользователь с такими данными уже существует');
        }
        throw response.error!;
      }
      final user = response.body;
      if (user == null) {
        logger.e(response.error);
        throw Exception('received empty user while tried to update');
      }
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
