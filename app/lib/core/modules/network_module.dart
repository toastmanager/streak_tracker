import 'dart:async' show FutureOr;
import 'dart:io' show HttpHeaders, HttpStatus;

import 'package:app/core/constants/env_constants.dart';
import 'package:app/features/auth/data/datasources/auth_token_service.dart';
import 'package:app/generated_code/rest_api.swagger.dart';
import 'package:app/injection.dart';
import 'package:chopper/chopper.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class CookieInterceptor implements Interceptor {
  final SharedPreferences prefs;

  const CookieInterceptor({required this.prefs});

  static const String _cookieKey = "cookies";

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    Request request = chain.request;

    // Retrieve stored cookies and attach them to the request
    final storedCookies = prefs.getString(_cookieKey) ?? "";
    if (storedCookies.isNotEmpty) {
      request = request.copyWith(
        headers: {...request.headers, 'Cookie': storedCookies},
      );
    }

    // Proceed with the request and get the response
    final response = await chain.proceed(request);

    // Extract and store cookies from the response
    final rawCookies = response.headers['set-cookie'];
    if (rawCookies != null) {
      prefs.setString(_cookieKey, rawCookies);
    }

    return response;
  }
}

@injectable
class AccessTokenInterceptor implements Interceptor {
  final AuthTokenService authTokenService;

  const AccessTokenInterceptor({required this.authTokenService});

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    Request request = chain.request;

    final authorizationHeader = authTokenService.getAuthorizationHeader() ?? "";
    request = request.copyWith(
      headers: {
        ...request.headers,
        HttpHeaders.authorizationHeader: authorizationHeader
      },
    );

    return chain.proceed(request);
  }
}

class AuthInterceptor extends Authenticator {
  int _refreshAttempts = 0;

  @override
  FutureOr<Request?> authenticate(
    Request request,
    Response response, [
    Request? originalRequest,
  ]) async {
    if (response.statusCode == HttpStatus.unauthorized) {
      if (_refreshAttempts >= 1) {
        return null;
      }

      _refreshAttempts++;
      final String? newToken =
          (await sl<AuthTokenService>().refresh())?.accessToken;

      if (newToken != null) {
        _refreshAttempts = 0;
      }
    }

    final authorizationHeader =
        sl<AuthTokenService>().getAuthorizationHeader() ?? "";
    request = request.copyWith(headers: {
      ...request.headers,
      HttpHeaders.authorizationHeader: authorizationHeader,
    });
    return request;
  }
}

@module
abstract class NetworkModule {
  @lazySingleton
  RestApi get restApi => RestApi.create(
          baseUrl: Uri.parse(EnvConstants.apiBaseUrl),
          authenticator: AuthInterceptor(),
          interceptors: [
            sl<CookieInterceptor>(),
            sl<AccessTokenInterceptor>(),
          ]);
}
