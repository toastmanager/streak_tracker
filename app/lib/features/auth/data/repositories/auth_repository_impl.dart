import 'package:app/features/auth/data/utils/auth_token_service.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/generated_code/client_index.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final RestApi restApi;
  final AuthTokenService authTokenService;
  final Logger logger;

  const AuthRepositoryImpl({
    required this.restApi,
    required this.authTokenService,
    required this.logger,
  });

  @override
  Future<UserDto?> loadMe() async {
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
  Future<UserDto?> login(LoginDto form) async {
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
  Future<UserDto?> register(RegisterDto form) async {
    try {
      final _ = (await restApi.apiV1AuthRegisterPost(body: form));
      final user = (await restApi.apiV1AuthMePost()).body;
      return user;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
