part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(LoginFormEntity loginForm) = AuthLogin;
  const factory AuthEvent.register(RegisterFormEntity registerForm) =
      AuthRegister;
  const factory AuthEvent.fetchMe() = AuthFetchMe;
  const factory AuthEvent.logout() = AuthLogout;
}
