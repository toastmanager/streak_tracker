// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_api.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateUserDto _$CreateUserDtoFromJson(Map<String, dynamic> json) =>
    CreateUserDto(
      username: json['username'] as String,
      email: json['email'] as String,
      passwordHash: json['passwordHash'] as String,
      isActive: json['isActive'] as bool?,
      avatarKey: json['avatarKey'] as String?,
    );

Map<String, dynamic> _$CreateUserDtoToJson(CreateUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'isActive': instance.isActive,
      'avatarKey': instance.avatarKey,
    };

UpdateUserDto _$UpdateUserDtoFromJson(Map<String, dynamic> json) =>
    UpdateUserDto(
      username: json['username'] as String?,
      email: json['email'] as String?,
      passwordHash: json['passwordHash'] as String?,
      isActive: json['isActive'] as bool?,
      avatarKey: json['avatarKey'] as String?,
    );

Map<String, dynamic> _$UpdateUserDtoToJson(UpdateUserDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'passwordHash': instance.passwordHash,
      'isActive': instance.isActive,
      'avatarKey': instance.avatarKey,
    };

RoleDto _$RoleDtoFromJson(Map<String, dynamic> json) => RoleDto();

Map<String, dynamic> _$RoleDtoToJson(RoleDto instance) => <String, dynamic>{};

LoginDto _$LoginDtoFromJson(Map<String, dynamic> json) => LoginDto(
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$LoginDtoToJson(LoginDto instance) => <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
    };

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
      tokenType: json['token_type'] as String,
    );

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'token_type': instance.tokenType,
    };

RegisterDto _$RegisterDtoFromJson(Map<String, dynamic> json) => RegisterDto(
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$RegisterDtoToJson(RegisterDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      username: json['username'] as String,
      isActive: json['isActive'] as bool,
      avatarUrl: json['avatarUrl'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'username': instance.username,
      'isActive': instance.isActive,
      'avatarUrl': instance.avatarUrl,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

CreateHabitDto _$CreateHabitDtoFromJson(Map<String, dynamic> json) =>
    CreateHabitDto(
      name: json['name'] as String,
      maxGapDays: (json['maxGapDays'] as num).toInt(),
    );

Map<String, dynamic> _$CreateHabitDtoToJson(CreateHabitDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maxGapDays': instance.maxGapDays,
    };

HabitDto _$HabitDtoFromJson(Map<String, dynamic> json) => HabitDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      maxGapDays: (json['maxGapDays'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$HabitDtoToJson(HabitDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxGapDays': instance.maxGapDays,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

HabitDetailsDto _$HabitDetailsDtoFromJson(Map<String, dynamic> json) =>
    HabitDetailsDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      maxGapDays: (json['maxGapDays'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      streak: (json['streak'] as num).toInt(),
      isDoneToday: json['isDoneToday'] as bool,
    );

Map<String, dynamic> _$HabitDetailsDtoToJson(HabitDetailsDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'maxGapDays': instance.maxGapDays,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'streak': instance.streak,
      'isDoneToday': instance.isDoneToday,
    };

UpdateHabitDto _$UpdateHabitDtoFromJson(Map<String, dynamic> json) =>
    UpdateHabitDto(
      name: json['name'] as String?,
      maxGapDays: (json['maxGapDays'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UpdateHabitDtoToJson(UpdateHabitDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maxGapDays': instance.maxGapDays,
    };

MonthlyActivityDto _$MonthlyActivityDtoFromJson(Map<String, dynamic> json) =>
    MonthlyActivityDto(
      activity: (json['activity'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          [],
    );

Map<String, dynamic> _$MonthlyActivityDtoToJson(MonthlyActivityDto instance) =>
    <String, dynamic>{
      'activity': instance.activity,
    };

TodayActivityDto _$TodayActivityDtoFromJson(Map<String, dynamic> json) =>
    TodayActivityDto(
      isDoneToday: json['isDoneToday'] as bool,
    );

Map<String, dynamic> _$TodayActivityDtoToJson(TodayActivityDto instance) =>
    <String, dynamic>{
      'isDoneToday': instance.isDoneToday,
    };
