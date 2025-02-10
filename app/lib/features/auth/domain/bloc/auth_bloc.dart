import 'package:app/features/auth/domain/cubit/login_cubit.dart';
import 'package:app/features/auth/domain/cubit/registration_cubit.dart';
import 'package:app/features/auth/domain/entities/login_form_entity.dart';
import 'package:app/features/auth/domain/entities/register_form_entity.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final LoginCubit loginCubit;
  final RegistrationCubit registrationCubit;
  final Logger logger;

  AuthBloc({
    required this.authRepository,
    required this.loginCubit,
    required this.registrationCubit,
    required this.logger,
  }) : super(_Initial()) {
    on<AuthLogin>(_onLogin);
    on<AuthRegister>(_onRegister);
    on<AuthLogout>(_onLogout);
    on<AuthFetchMe>(_onFetchMe);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading());
      final user = await authRepository.login(event.loginForm);
      if (user != null) {
        emit(AuthState.logged(user: user));
      } else {
        emit(AuthState.empty());
      }
    } on DioException catch (e) {
      if ([401].contains(e.response?.statusCode)) {
        logger.w(e);
        loginCubit.setErrorMessage(e.response?.data['message']);
        await _setCurrentUser(emit);
        return;
      }
      rethrow;
    } catch (e) {
      logger.e(e);
      emit(AuthState.error('Failed to login'));
    }
  }

  Future<void> _onRegister(AuthRegister event, Emitter<AuthState> emit) async {
    try {
      emit(AuthState.loading());
      final user = await authRepository.register(event.registerForm);
      if (user != null) {
        emit(AuthState.logged(user: user));
      } else {
        emit(AuthState.empty());
      }
    } on DioException catch (e) {
      if ([401, 409].contains(e.response?.statusCode)) {
        logger.w(e);
        registrationCubit.setErrorMessage(e.response?.data['message']);
        await _setCurrentUser(emit);
        return;
      }
    } catch (e) {
      logger.e(e);
      emit(AuthState.error('Failed to register'));
    }
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    try {
      await authRepository.logout();
      emit(AuthState.empty());
    } catch (e) {
      logger.e(e);
      emit(AuthState.error('Failed to logout'));
      rethrow;
    }
  }

  Future<void> _onFetchMe(AuthFetchMe event, Emitter<AuthState> emit) async {
    try {
      final user = await authRepository.loadMe();
      if (user != null) {
        emit(AuthState.logged(user: user));
      } else {
        emit(AuthState.empty());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        emit(AuthState.empty());
        return;
      }
      rethrow;
    } catch (e) {
      logger.e(e);
      emit(AuthState.error('Failed to fetch current user'));
      rethrow;
    }
  }

  Future<void> _setCurrentUser(Emitter<AuthState> emit) async {
    final user = await authRepository.loadMe();
    if (user != null) {
      emit(AuthState.logged(user: user));
    } else {
      emit(AuthState.empty());
    }
  }
}
