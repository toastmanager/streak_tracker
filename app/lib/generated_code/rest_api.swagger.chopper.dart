// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$RestApi extends RestApi {
  _$RestApi([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = RestApi;

  @override
  Future<Response<UserDto>> _apiV1UsersPost({required CreateUserDto? body}) {
    final Uri $url = Uri.parse('/api/v1/users');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<List<UserDto>>> _apiV1UsersGet() {
    final Uri $url = Uri.parse('/api/v1/users');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<UserDto>, UserDto>($request);
  }

  @override
  Future<Response<UserDto>> _apiV1UsersIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<UserDto>> _apiV1UsersIdPatch({
    required String? id,
    required UpdateUserDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<UserDto>> _apiV1UsersIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<PutAvatarResponseDto>> _apiV1UsersIdAvatarPut({
    required String? id,
    String? file,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${id}/avatar');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<String?>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<PutAvatarResponseDto, PutAvatarResponseDto>($request);
  }

  @override
  Future<Response<DeleteAvatarResponseDto>> _apiV1UsersIdAvatarDelete(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}/avatar');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client
        .send<DeleteAvatarResponseDto, DeleteAvatarResponseDto>($request);
  }

  @override
  Future<Response<UserDto>> _apiV1UsersIdRolesPost({
    required String? id,
    required RoleDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${id}/roles');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserDto, UserDto>($request);
  }

  @override
  Future<Response<RoleDto>> _apiV1UsersIdRolesDelete({
    required String? id,
    required RoleDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/users/${id}/roles');
    final $body = body;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<RoleDto, RoleDto>($request);
  }

  @override
  Future<Response<List<RoleDto>>> _apiV1UsersIdRolesGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/users/${id}/roles');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<RoleDto>, RoleDto>($request);
  }

  @override
  Future<Response<AuthToken>> _apiV1AuthLoginPost({required LoginDto? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/login');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthToken, AuthToken>($request);
  }

  @override
  Future<Response<AuthToken>> _apiV1AuthRegisterPost(
      {required RegisterDto? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/register');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AuthToken, AuthToken>($request);
  }

  @override
  Future<Response<Object>> _apiV1AuthLogoutPost() {
    final Uri $url = Uri.parse('/api/v1/auth/logout');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<Object, Object>($request);
  }

  @override
  Future<Response<UserSensitiveDto>> _apiV1AuthMePost() {
    final Uri $url = Uri.parse('/api/v1/auth/me');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<UserSensitiveDto, UserSensitiveDto>($request);
  }

  @override
  Future<Response<UserSensitiveDto>> _apiV1AuthMePut(
      {required UpdateMeDto? body}) {
    final Uri $url = Uri.parse('/api/v1/auth/me');
    final $body = body;
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<UserSensitiveDto, UserSensitiveDto>($request);
  }

  @override
  Future<Response<String>> _apiV1AuthMeAvatarPut({String? file}) {
    final Uri $url = Uri.parse('/api/v1/auth/me/avatar');
    final List<PartValue> $parts = <PartValue>[
      PartValueFile<String?>(
        'file',
        file,
      )
    ];
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<String, String>($request);
  }

  @override
  Future<Response<AuthToken>> _apiV1AuthRefreshPost() {
    final Uri $url = Uri.parse('/api/v1/auth/refresh');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<AuthToken, AuthToken>($request);
  }

  @override
  Future<Response<HabitDto>> _apiV1HabitsPost({required CreateHabitDto? body}) {
    final Uri $url = Uri.parse('/api/v1/habits');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<HabitDto, HabitDto>($request);
  }

  @override
  Future<Response<List<HabitDto>>> _apiV1HabitsGet() {
    final Uri $url = Uri.parse('/api/v1/habits');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<HabitDto>, HabitDto>($request);
  }

  @override
  Future<Response<List<HabitDetailsDto>>> _apiV1HabitsUsersMeGet() {
    final Uri $url = Uri.parse('/api/v1/habits/users/me');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<HabitDetailsDto>, HabitDetailsDto>($request);
  }

  @override
  Future<Response<List<HabitDetailsDto>>> _apiV1HabitsUsersUserIdGet(
      {required String? userId}) {
    final Uri $url = Uri.parse('/api/v1/habits/users/${userId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<List<HabitDetailsDto>, HabitDetailsDto>($request);
  }

  @override
  Future<Response<HabitDetailsDto>> _apiV1HabitsIdGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<HabitDetailsDto, HabitDetailsDto>($request);
  }

  @override
  Future<Response<HabitDetailsDto>> _apiV1HabitsIdPatch({
    required String? id,
    required UpdateHabitDto? body,
  }) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}');
    final $body = body;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<HabitDetailsDto, HabitDetailsDto>($request);
  }

  @override
  Future<Response<HabitDto>> _apiV1HabitsIdDelete({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<HabitDto, HabitDto>($request);
  }

  @override
  Future<Response<MonthlyActivityDto>> _apiV1HabitsIdActivitiesYearMonthGet({
    required String? id,
    required String? year,
    required String? month,
  }) {
    final Uri $url =
        Uri.parse('/api/v1/habits/${id}/activities/${year}/${month}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MonthlyActivityDto, MonthlyActivityDto>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1HabitsIdActivitiesGet({required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}/activities');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1HabitsIdActivitiesTodayGet(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}/activities/today');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1HabitsIdActivitiesTodayPost(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}/activities/today');
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1HabitsIdActivitiesTodayDelete(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}/activities/today');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<TodayActivityDto>> _apiV1HabitsIdActivitiesTodayPut(
      {required String? id}) {
    final Uri $url = Uri.parse('/api/v1/habits/${id}/activities/today');
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
    );
    return client.send<TodayActivityDto, TodayActivityDto>($request);
  }
}
