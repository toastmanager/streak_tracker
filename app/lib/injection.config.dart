// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import 'core/modules/logger_module.dart' as _i1019;
import 'core/modules/network_module.dart' as _i401;
import 'core/modules/shared_preferences_module.dart' as _i1007;
import 'core/routes/router.dart' as _i66;
import 'features/auth/data/repositories/auth_repository_impl.dart' as _i111;
import 'features/auth/data/utils/auth_token_service.dart' as _i250;
import 'features/auth/domain/cubit/auth_cubit.dart' as _i709;
import 'features/auth/domain/repositories/auth_repository.dart' as _i1015;
import 'features/habits/data/repositories/habits_repository_impl.dart' as _i292;
import 'features/habits/domain/cubit/habits_cubit.dart' as _i675;
import 'features/habits/domain/repositories/habits_repository.dart' as _i1025;
import 'generated_code/client_index.dart' as _i87;
import 'generated_code/rest_api.swagger.dart' as _i435;

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
    final loggerModule = _$LoggerModule();
    final networkModule = _$NetworkModule();
    final injectionModule = _$InjectionModule();
    gh.singleton<_i66.AppRouter>(() => _i66.AppRouter());
    gh.lazySingleton<_i974.Logger>(() => loggerModule.logger);
    gh.lazySingleton<_i435.RestApi>(() => networkModule.restApi);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => injectionModule.prefs,
      preResolve: true,
    );
    gh.factory<_i1025.HabitsRepository>(
        () => _i292.HabitsRepositoryImpl(restApi: gh<_i435.RestApi>()));
    gh.singleton<_i250.AuthTokenService>(
        () => _i250.AuthTokenServiceImpl(logger: gh<_i974.Logger>()));
    gh.factory<_i401.AccessTokenInterceptor>(() => _i401.AccessTokenInterceptor(
        authTokenService: gh<_i250.AuthTokenService>()));
    gh.factory<_i401.CookieInterceptor>(
        () => _i401.CookieInterceptor(prefs: gh<_i460.SharedPreferences>()));
    gh.factory<_i1015.AuthRepository>(() => _i111.AuthRepositoryImpl(
          restApi: gh<_i87.RestApi>(),
          authTokenService: gh<_i250.AuthTokenService>(),
          logger: gh<_i974.Logger>(),
        ));
    gh.factory<_i675.HabitsCubit>(() =>
        _i675.HabitsCubit(habitsRepository: gh<_i1025.HabitsRepository>()));
    gh.factory<_i709.AuthCubit>(
        () => _i709.AuthCubit(authRepository: gh<_i1015.AuthRepository>()));
    return this;
  }
}

class _$LoggerModule extends _i1019.LoggerModule {}

class _$NetworkModule extends _i401.NetworkModule {}

class _$InjectionModule extends _i1007.InjectionModule {}
