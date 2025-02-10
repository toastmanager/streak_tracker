import 'package:app/features/auth/data/models/auth_token.dart';
import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:app/features/auth/domain/entities/register_form_entity.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_rest_client.g.dart';

@RestApi()
abstract class AuthRestClient {
  factory AuthRestClient(Dio dio) = _AuthRestClient;

  static const prefix = 'auth';

  @POST('/$prefix/login')
  Future<AuthToken> login(@Body() LoginFormEntity model);

  @POST('/$prefix/register')
  Future<AuthToken> register(@Body() RegisterFormEntity model);

  @POST('/$prefix/refresh')
  Future<AuthToken> refresh();

  @POST('/$prefix/me')
  Future<User> fetchMe();

  @POST('/$prefix/logout')
  Future<void> logout();
}
