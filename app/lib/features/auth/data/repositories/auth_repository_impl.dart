import 'package:app/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:app/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:app/features/auth/data/datasources/remote/auth_token_service.dart';
import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:app/features/auth/domain/entities/register_form_entity.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final AuthTokenService tokenDataSource;
  final Logger logger;

  const AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.tokenDataSource,
    required this.logger,
  });

  @override
  Future<User?> loadMe() async {
    try {
      if (tokenDataSource.getAccessToken() != null) {
        final localUser = localDataSource.getLocalUser();
        if (localUser != null) {
          return localUser;
        }
      }
      try {
        return await remoteDataSource.fetchMe();
      } on DioException catch (e) {
        if (e.response?.statusCode == 401) {
          localDataSource.setLocalUser(null);
          return null;
        }
        rethrow;
      }
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<User?> login(LoginFormEntity form) async {
    try {
      await remoteDataSource.login(form);
      final remoteUser = await remoteDataSource.fetchMe();
      localDataSource.setLocalUser(remoteUser);
      return remoteUser;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
      await localDataSource.logout();
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }

  @override
  Future<User?> register(RegisterFormEntity form) async {
    try {
      await remoteDataSource.register(form);
      final remoteUser = await remoteDataSource.fetchMe();
      localDataSource.setLocalUser(remoteUser);
      return remoteUser;
    } catch (e) {
      logger.e(e);
      rethrow;
    }
  }
}
