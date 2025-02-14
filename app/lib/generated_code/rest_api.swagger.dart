// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:json_annotation/json_annotation.dart' as json;
import 'package:collection/collection.dart';
import 'dart:convert';

import 'rest_api.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' show MultipartFile;
import 'package:chopper/chopper.dart' as chopper;
export 'rest_api.models.swagger.dart';

part 'rest_api.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class RestApi extends ChopperService {
  static RestApi create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$RestApi(client);
    }

    final newClient = ChopperClient(
        services: [_$RestApi()],
        converter: converter ?? $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        client: httpClient,
        authenticator: authenticator,
        errorConverter: errorConverter,
        baseUrl: baseUrl ?? Uri.parse('http://'));
    return _$RestApi(newClient);
  }

  ///
  Future<chopper.Response> apiV1UsersPost({required CreateUserDto? body}) {
    return _apiV1UsersPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/users',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersPost(
      {@Body() required CreateUserDto? body});

  ///
  Future<chopper.Response> apiV1UsersGet() {
    return _apiV1UsersGet();
  }

  ///
  @Get(path: '/api/v1/users')
  Future<chopper.Response> _apiV1UsersGet();

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdGet({required String? id}) {
    return _apiV1UsersIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/api/v1/users/{id}')
  Future<chopper.Response> _apiV1UsersIdGet({@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdPatch({
    required String? id,
    required UpdateUserDto? body,
  }) {
    return _apiV1UsersIdPatch(id: id, body: body);
  }

  ///
  ///@param id
  @Patch(
    path: '/api/v1/users/{id}',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersIdPatch({
    @Path('id') required String? id,
    @Body() required UpdateUserDto? body,
  });

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdDelete({required String? id}) {
    return _apiV1UsersIdDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/api/v1/users/{id}')
  Future<chopper.Response> _apiV1UsersIdDelete(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdRolesPost({
    required String? id,
    required RoleDto? body,
  }) {
    return _apiV1UsersIdRolesPost(id: id, body: body);
  }

  ///
  ///@param id
  @Post(
    path: '/api/v1/users/{id}/roles',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1UsersIdRolesPost({
    @Path('id') required String? id,
    @Body() required RoleDto? body,
  });

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdRolesDelete({
    required String? id,
    required RoleDto? body,
  }) {
    return _apiV1UsersIdRolesDelete(id: id, body: body);
  }

  ///
  ///@param id
  @Delete(path: '/api/v1/users/{id}/roles')
  Future<chopper.Response> _apiV1UsersIdRolesDelete({
    @Path('id') required String? id,
    @Body() required RoleDto? body,
  });

  ///
  ///@param id
  Future<chopper.Response> apiV1UsersIdRolesGet({required String? id}) {
    return _apiV1UsersIdRolesGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/api/v1/users/{id}/roles')
  Future<chopper.Response> _apiV1UsersIdRolesGet(
      {@Path('id') required String? id});

  ///
  Future<chopper.Response<AuthToken>> apiV1AuthLoginPost(
      {required LoginDto? body}) {
    generatedMapping.putIfAbsent(AuthToken, () => AuthToken.fromJsonFactory);

    return _apiV1AuthLoginPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/login',
    optionalBody: true,
  )
  Future<chopper.Response<AuthToken>> _apiV1AuthLoginPost(
      {@Body() required LoginDto? body});

  ///
  Future<chopper.Response<AuthToken>> apiV1AuthRegisterPost(
      {required RegisterDto? body}) {
    generatedMapping.putIfAbsent(AuthToken, () => AuthToken.fromJsonFactory);

    return _apiV1AuthRegisterPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/auth/register',
    optionalBody: true,
  )
  Future<chopper.Response<AuthToken>> _apiV1AuthRegisterPost(
      {@Body() required RegisterDto? body});

  ///
  Future<chopper.Response<Object>> apiV1AuthLogoutPost() {
    return _apiV1AuthLogoutPost();
  }

  ///
  @Post(
    path: '/api/v1/auth/logout',
    optionalBody: true,
  )
  Future<chopper.Response<Object>> _apiV1AuthLogoutPost();

  ///
  Future<chopper.Response<UserDto>> apiV1AuthMePost() {
    generatedMapping.putIfAbsent(UserDto, () => UserDto.fromJsonFactory);

    return _apiV1AuthMePost();
  }

  ///
  @Post(
    path: '/api/v1/auth/me',
    optionalBody: true,
  )
  Future<chopper.Response<UserDto>> _apiV1AuthMePost();

  ///
  Future<chopper.Response<AuthToken>> apiV1AuthRefreshPost() {
    generatedMapping.putIfAbsent(AuthToken, () => AuthToken.fromJsonFactory);

    return _apiV1AuthRefreshPost();
  }

  ///
  @Post(
    path: '/api/v1/auth/refresh',
    optionalBody: true,
  )
  Future<chopper.Response<AuthToken>> _apiV1AuthRefreshPost();

  ///
  Future<chopper.Response<HabitDto>> apiV1HabitsPost(
      {required CreateHabitDto? body}) {
    generatedMapping.putIfAbsent(HabitDto, () => HabitDto.fromJsonFactory);

    return _apiV1HabitsPost(body: body);
  }

  ///
  @Post(
    path: '/api/v1/habits',
    optionalBody: true,
  )
  Future<chopper.Response<HabitDto>> _apiV1HabitsPost(
      {@Body() required CreateHabitDto? body});

  ///
  Future<chopper.Response<List<HabitDto>>> apiV1HabitsGet() {
    generatedMapping.putIfAbsent(HabitDto, () => HabitDto.fromJsonFactory);

    return _apiV1HabitsGet();
  }

  ///
  @Get(path: '/api/v1/habits')
  Future<chopper.Response<List<HabitDto>>> _apiV1HabitsGet();

  ///
  Future<chopper.Response<List<HabitDetailsDto>>> apiV1HabitsUsersMeGet() {
    generatedMapping.putIfAbsent(
        HabitDetailsDto, () => HabitDetailsDto.fromJsonFactory);

    return _apiV1HabitsUsersMeGet();
  }

  ///
  @Get(path: '/api/v1/habits/users/me')
  Future<chopper.Response<List<HabitDetailsDto>>> _apiV1HabitsUsersMeGet();

  ///
  ///@param user_id
  Future<chopper.Response<List<HabitDetailsDto>>> apiV1HabitsUsersUserIdGet(
      {required String? userId}) {
    generatedMapping.putIfAbsent(
        HabitDetailsDto, () => HabitDetailsDto.fromJsonFactory);

    return _apiV1HabitsUsersUserIdGet(userId: userId);
  }

  ///
  ///@param user_id
  @Get(path: '/api/v1/habits/users/{user_id}')
  Future<chopper.Response<List<HabitDetailsDto>>> _apiV1HabitsUsersUserIdGet(
      {@Path('user_id') required String? userId});

  ///
  ///@param id
  Future<chopper.Response<HabitDetailsDto>> apiV1HabitsIdGet(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        HabitDetailsDto, () => HabitDetailsDto.fromJsonFactory);

    return _apiV1HabitsIdGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/api/v1/habits/{id}')
  Future<chopper.Response<HabitDetailsDto>> _apiV1HabitsIdGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response<HabitDto>> apiV1HabitsIdPatch({
    required String? id,
    required UpdateHabitDto? body,
  }) {
    generatedMapping.putIfAbsent(HabitDto, () => HabitDto.fromJsonFactory);

    return _apiV1HabitsIdPatch(id: id, body: body);
  }

  ///
  ///@param id
  @Patch(
    path: '/api/v1/habits/{id}',
    optionalBody: true,
  )
  Future<chopper.Response<HabitDto>> _apiV1HabitsIdPatch({
    @Path('id') required String? id,
    @Body() required UpdateHabitDto? body,
  });

  ///
  ///@param id
  Future<chopper.Response<HabitDto>> apiV1HabitsIdDelete(
      {required String? id}) {
    generatedMapping.putIfAbsent(HabitDto, () => HabitDto.fromJsonFactory);

    return _apiV1HabitsIdDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/api/v1/habits/{id}')
  Future<chopper.Response<HabitDto>> _apiV1HabitsIdDelete(
      {@Path('id') required String? id});

  ///
  ///@param id
  ///@param year
  ///@param month
  Future<chopper.Response<MonthlyActivityDto>>
      apiV1HabitsIdActivitiesYearMonthGet({
    required String? id,
    required String? year,
    required String? month,
  }) {
    generatedMapping.putIfAbsent(
        MonthlyActivityDto, () => MonthlyActivityDto.fromJsonFactory);

    return _apiV1HabitsIdActivitiesYearMonthGet(
        id: id, year: year, month: month);
  }

  ///
  ///@param id
  ///@param year
  ///@param month
  @Get(path: '/api/v1/habits/{id}/activities/{year}/{month}')
  Future<chopper.Response<MonthlyActivityDto>>
      _apiV1HabitsIdActivitiesYearMonthGet({
    @Path('id') required String? id,
    @Path('year') required String? year,
    @Path('month') required String? month,
  });

  ///
  ///@param id
  Future<chopper.Response> apiV1HabitsIdActivitiesGet({required String? id}) {
    return _apiV1HabitsIdActivitiesGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/api/v1/habits/{id}/activities')
  Future<chopper.Response> _apiV1HabitsIdActivitiesGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> apiV1HabitsIdActivitiesTodayGet(
      {required String? id}) {
    return _apiV1HabitsIdActivitiesTodayGet(id: id);
  }

  ///
  ///@param id
  @Get(path: '/api/v1/habits/{id}/activities/today')
  Future<chopper.Response> _apiV1HabitsIdActivitiesTodayGet(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> apiV1HabitsIdActivitiesTodayPost(
      {required String? id}) {
    return _apiV1HabitsIdActivitiesTodayPost(id: id);
  }

  ///
  ///@param id
  @Post(
    path: '/api/v1/habits/{id}/activities/today',
    optionalBody: true,
  )
  Future<chopper.Response> _apiV1HabitsIdActivitiesTodayPost(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response> apiV1HabitsIdActivitiesTodayDelete(
      {required String? id}) {
    return _apiV1HabitsIdActivitiesTodayDelete(id: id);
  }

  ///
  ///@param id
  @Delete(path: '/api/v1/habits/{id}/activities/today')
  Future<chopper.Response> _apiV1HabitsIdActivitiesTodayDelete(
      {@Path('id') required String? id});

  ///
  ///@param id
  Future<chopper.Response<TodayActivityDto>> apiV1HabitsIdActivitiesTodayPut(
      {required String? id}) {
    generatedMapping.putIfAbsent(
        TodayActivityDto, () => TodayActivityDto.fromJsonFactory);

    return _apiV1HabitsIdActivitiesTodayPut(id: id);
  }

  ///
  ///@param id
  @Put(
    path: '/api/v1/habits/{id}/activities/today',
    optionalBody: true,
  )
  Future<chopper.Response<TodayActivityDto>> _apiV1HabitsIdActivitiesTodayPut(
      {@Path('id') required String? id});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
      chopper.Response response) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
          body: DateTime.parse((response.body as String).replaceAll('"', ''))
              as ResultType);
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
