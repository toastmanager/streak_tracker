import 'package:app/features/auth/data/datasources/remote/auth_rest_client.dart';
import 'package:app/features/auth/data/datasources/remote/auth_token_service.dart';
import 'package:app/features/auth/data/models/auth_token.dart';
import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:app/features/auth/domain/entities/register_form_entity.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class AuthRemoteDataSource {
  Future<AuthToken> login(LoginFormEntity form);
  Future<AuthToken> register(RegisterFormEntity form);
  Future<User?> fetchMe();
  Future<void> logout();
}

@Injectable(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthRestClient authRestClient;
  final Logger logger;
  final AuthTokenService authTokenService;

  const AuthRemoteDataSourceImpl({
    required this.authRestClient,
    required this.logger,
    required this.authTokenService,
  });

  @override
  Future<User?> fetchMe() async {
    try {
      final user = authRestClient.fetchMe();
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return null;
      }
      rethrow;
    } catch (e) {
      logger.e('Failed to fetch user');
      rethrow;
    }
  }

  @override
  Future<AuthToken> login(LoginFormEntity form) async {
    try {
      final authToken = await authRestClient.login(form);
      authTokenService.setAccessToken(authToken.access_token);
      return authToken;
    } catch (e) {
      logger.e('Failed to login');
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await authRestClient.logout();
      authTokenService.setAccessToken(null);
    } catch (e) {
      logger.e('Failed to logout');
      rethrow;
    }
  }

  @override
  Future<AuthToken> register(RegisterFormEntity form) async {
    try {
      final authToken = await authRestClient.register(form);
      authTokenService.setAccessToken(authToken.access_token);
      return authToken;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
