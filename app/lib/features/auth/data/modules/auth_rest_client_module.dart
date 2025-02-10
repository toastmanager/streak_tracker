import 'package:app/features/auth/data/datasources/remote/auth_rest_client.dart';
import 'package:app/injection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AuthRestClientModule {
  @injectable
  AuthRestClient get authRestClient => AuthRestClient(sl<Dio>());
}
