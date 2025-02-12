import 'package:app/core/constants/env_constants.dart';
import 'package:app/features/auth/data/datasources/remote/auth_token_data_source.dart';
import 'package:app/injection.dart';
import 'package:app/main.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@injectable
class DioAuthInterceptor extends Interceptor {
  final Logger logger;
  final AuthTokenDataSource authTokenDataSource;

  DioAuthInterceptor({
    required this.logger,
    required this.authTokenDataSource,
  });

  bool isRetrying = false;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = authTokenDataSource.getAccessToken();
    if (accessToken != null) {
      options.headers['Authorization'] = "Bearer $accessToken";
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      if (!isRetrying) {
        isRetrying = true;
        final isRetrySuccess = await refreshToken();
        isRetrying = false;
        if (isRetrySuccess) {
          return handler.resolve(await retry(err.requestOptions));
        }
      } else {
        isRetrying = false;
        return handler.next(err);
      }
    }
    return handler.next(err);
  }

  Future<bool> refreshToken() async {
    try {
      await authTokenDataSource.refresh();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Response> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return sl<Dio>().request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }
}

@module
abstract class NetworkModule {
  @lazySingleton
  PersistCookieJar get persistCookieJar =>
      PersistCookieJar(storage: FileStorage(appDocPath));

  @lazySingleton
  Dio get dio => Dio(BaseOptions(baseUrl: '${EnvConstants.apiBaseUrl}/api/v1'))
    ..interceptors.addAll([
      CookieManager(persistCookieJar),
      sl<DioAuthInterceptor>(),
    ]);
}
