import 'package:app/features/auth/data/datasources/remote/auth_rest_client.dart';
import 'package:app/features/auth/data/models/auth_token.dart';
import 'package:app/injection.dart';
import 'package:injectable/injectable.dart';

abstract class AuthTokenService {
  Future<AuthToken> refresh();
  String? getAccessToken();
  void setAccessToken(String? accessToken);
}

@Singleton(as: AuthTokenService)
class AuthTokenServiceImpl implements AuthTokenService {
  String? _accessToken;

  @override
  String? getAccessToken() {
    return _accessToken;
  }

  @override
  Future<AuthToken> refresh() async {
    final authToken = await sl<AuthRestClient>().refresh();
    _accessToken = authToken.access_token;
    return authToken;
  }

  @override
  void setAccessToken(String? accessToken) {
    _accessToken = accessToken;
  }
}
