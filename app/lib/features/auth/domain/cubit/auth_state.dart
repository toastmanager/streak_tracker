part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authorized({
    required UserSensitiveDto user,
  }) = _Authorized;
  const factory AuthState.unauthorized() = _Unauthorized;
  const factory AuthState.error({
    required String message,
  }) = _Error;
}
