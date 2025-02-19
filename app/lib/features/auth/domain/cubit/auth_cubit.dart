import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit({required this.authRepository}) : super(AuthState.initial());

  Future<void> intialLoadMe() async {
    try {
      final user = await authRepository.loadMe();
      if (user == null) {
        throw Exception('Не удалось загрузить пользователя');
      }
      emit(AuthState.authorized(user: user));
    } catch (e) {
      emit(AuthState.unauthorized());
    }
  }

  Future<void> loadMe() async {
    emit(AuthState.loading());
    await intialLoadMe();
  }

  Future<void> login({required LoginDto form}) async {
    try {
      emit(AuthState.loading());
      final user = await authRepository.login(form);
      if (user == null) {
        throw Exception('Не удалось войти в аккаунт');
      }
      emit(AuthState.authorized(user: user));
    } catch (e) {
      emit(
        AuthState.error(message: 'Не удалось войти в аккаунт'),
      );
    }
  }

  Future<void> register({required RegisterDto form}) async {
    try {
      emit(AuthState.loading());
      final user = await authRepository.register(form);
      if (user == null) {
        throw Exception('Не удалось создать в аккаунт');
      }
      emit(AuthState.authorized(user: user));
    } catch (e) {
      emit(
        AuthState.error(message: 'Не удалось создать аккаунт'),
      );
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthState.loading());
      final _ = await authRepository.logout();
      emit(AuthState.unauthorized());
    } catch (e) {
      emit(
        AuthState.error(message: 'Не удалось выйти из аккаунта'),
      );
    }
  }
}
