// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cookie_jar/cookie_jar.dart' as _i557;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/modules/logger_module.dart' as _i1019;
import 'core/modules/network_module.dart' as _i401;
import 'core/modules/shared_preferences_module.dart' as _i1007;
import 'core/routes/router.dart' as _i66;
import 'features/activities/data/datasources/habits_rest_client.dart' as _i719;
import 'features/activities/data/modules/habits_rest_client_module.dart'
    as _i944;
import 'features/activities/data/repositories/habits_repository_impl.dart'
    as _i767;
import 'features/activities/domain/cubit/habits_cubit.dart' as _i43;
import 'features/activities/domain/repositories/habits_repository.dart'
    as _i804;
import 'features/auth/data/datasources/local/auth_local_data_source.dart'
    as _i554;
import 'features/auth/data/datasources/remote/auth_remote_data_source.dart'
    as _i689;
import 'features/auth/data/datasources/remote/auth_rest_client.dart' as _i475;
import 'features/auth/data/datasources/remote/auth_token_data_source.dart'
    as _i117;
import 'features/auth/data/datasources/remote/auth_token_service.dart' as _i721;
import 'features/auth/data/modules/auth_rest_client_module.dart' as _i533;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/domain/bloc/auth_bloc.dart' as _i122;
import 'features/auth/domain/cubit/login_cubit.dart' as _i390;
import 'features/auth/domain/cubit/registration_cubit.dart' as _i73;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final habitsRestClientModule = _$HabitsRestClientModule();
    final authRestClientModule = _$AuthRestClientModule();
    final injectionModule = _$InjectionModule();
    final networkModule = _$NetworkModule();
    final loggerModule = _$LoggerModule();
    gh.factory<_i719.HabitsRestClient>(
        () => habitsRestClientModule.habitsRestClient);
    gh.factory<_i475.AuthRestClient>(() => authRestClientModule.authRestClient);
    gh.singleton<_i66.AppRouter>(() => _i66.AppRouter());
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i557.PersistCookieJar>(
        () => networkModule.persistCookieJar);
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio);
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i73.RegistrationCubit>(() => _i73.RegistrationCubit());
    gh.lazySingleton<_i390.LoginCubit>(() => _i390.LoginCubit());
    gh.singleton<_i721.AuthTokenService>(() => _i721.AuthTokenServiceImpl());
    gh.factory<_i804.HabitsRepository>(() => _i767.HabitsRepositoryImpl(
        habitsRestClient: gh<_i719.HabitsRestClient>()));
    gh.singleton<_i117.AuthTokenDataSource>(
        () => _i117.AuthTokenDataSourceImpl());
    gh.factory<_i43.HabitsCubit>(
        () => _i43.HabitsCubit(habitsRepository: gh<_i804.HabitsRepository>()));
    gh.factory<_i689.AuthRemoteDataSource>(() => _i689.AuthRemoteDataSourceImpl(
          authRestClient: gh<_i475.AuthRestClient>(),
          logger: gh<_i974.Logger>(),
          authTokenService: gh<_i721.AuthTokenService>(),
        ));
    gh.factory<_i554.AuthLocalDataSource>(() => _i554.AuthLocalDataSourceImpl(
        sharedPreferences: gh<_i460.SharedPreferences>()));
    gh.factory<_i401.DioAuthInterceptor>(() => _i401.DioAuthInterceptor(
          logger: gh<_i974.Logger>(),
          authTokenDataSource: gh<_i117.AuthTokenDataSource>(),
        ));
    gh.factory<_i1015.AuthRepository>(() => _i111.AuthRepositoryImpl(
          localDataSource: gh<_i554.AuthLocalDataSource>(),
          remoteDataSource: gh<_i689.AuthRemoteDataSource>(),
          tokenDataSource: gh<_i721.AuthTokenService>(),
          logger: gh<_i974.Logger>(),
        ));
    gh.factory<_i122.AuthBloc>(() => _i122.AuthBloc(
          authRepository: gh<_i1015.AuthRepository>(),
          loginCubit: gh<_i390.LoginCubit>(),
          registrationCubit: gh<_i73.RegistrationCubit>(),
          logger: gh<_i974.Logger>(),
        ));
    return this;
  }
}

class _$HabitsRestClientModule extends _i944.HabitsRestClientModule {}

class _$AuthRestClientModule extends _i533.AuthRestClientModule {}

class _$InjectionModule extends _i1007.InjectionModule {}

class _$NetworkModule extends _i401.NetworkModule {}

class _$LoggerModule extends _i1019.LoggerModule {}
