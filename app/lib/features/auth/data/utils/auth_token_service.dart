import 'package:app/generated_code/client_index.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:app/injection.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

abstract class AuthTokenService {
  Future<AuthToken?> refresh();
  String? getAccessToken();
  String? getAuthorizationHeader();
  void setAccessToken(String? accessToken);
}

@Singleton(as: AuthTokenService)
class AuthTokenServiceImpl implements AuthTokenService {
  final Logger logger;

  AuthTokenServiceImpl({required this.logger});

  String? _accessToken;
  final String _tokenType = 'Bearer';

  @override
  String? getAccessToken() {
    return _accessToken;
  }

  @override
  Future<AuthToken?> refresh() async {
    final authTokenResponse = await sl<RestApi>().apiV1AuthRefreshPost();
    if (authTokenResponse.body == null) {
      logger.e(authTokenResponse.error);
      return null;
    }
    final authToken = authTokenResponse.body!;
    setAccessToken(authToken.accessToken);
    return authToken;
  }

  @override
  void setAccessToken(String? accessToken) {
    _accessToken = accessToken;
  }

  @override
  String? getAuthorizationHeader() {
    return '$_tokenType $_accessToken';
  }
}
