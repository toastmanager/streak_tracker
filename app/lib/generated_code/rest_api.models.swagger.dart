// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

part 'rest_api.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class CreateUserDto {
  const CreateUserDto({
    required this.username,
    required this.email,
    required this.passwordHash,
    this.isActive,
    this.avatarKey,
  });

  factory CreateUserDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserDtoFromJson(json);

  static const toJsonFactory = _$CreateUserDtoToJson;
  Map<String, dynamic> toJson() => _$CreateUserDtoToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'passwordHash')
  final String passwordHash;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'avatarKey')
  final String? avatarKey;
  static const fromJsonFactory = _$CreateUserDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateUserDto &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.passwordHash, passwordHash) ||
                const DeepCollectionEquality()
                    .equals(other.passwordHash, passwordHash)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.avatarKey, avatarKey) ||
                const DeepCollectionEquality()
                    .equals(other.avatarKey, avatarKey)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(passwordHash) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(avatarKey) ^
      runtimeType.hashCode;
}

extension $CreateUserDtoExtension on CreateUserDto {
  CreateUserDto copyWith(
      {String? username,
      String? email,
      String? passwordHash,
      bool? isActive,
      String? avatarKey}) {
    return CreateUserDto(
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        isActive: isActive ?? this.isActive,
        avatarKey: avatarKey ?? this.avatarKey);
  }

  CreateUserDto copyWithWrapped(
      {Wrapped<String>? username,
      Wrapped<String>? email,
      Wrapped<String>? passwordHash,
      Wrapped<bool?>? isActive,
      Wrapped<String?>? avatarKey}) {
    return CreateUserDto(
        username: (username != null ? username.value : this.username),
        email: (email != null ? email.value : this.email),
        passwordHash:
            (passwordHash != null ? passwordHash.value : this.passwordHash),
        isActive: (isActive != null ? isActive.value : this.isActive),
        avatarKey: (avatarKey != null ? avatarKey.value : this.avatarKey));
  }
}

@JsonSerializable(explicitToJson: true)
class UserDto {
  const UserDto({
    required this.username,
    required this.isActive,
    this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);

  static const toJsonFactory = _$UserDtoToJson;
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'isActive')
  final bool isActive;
  @JsonKey(name: 'avatarUrl')
  final String? avatarUrl;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  static const fromJsonFactory = _$UserDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UserDto &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.avatarUrl, avatarUrl) ||
                const DeepCollectionEquality()
                    .equals(other.avatarUrl, avatarUrl)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(avatarUrl) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $UserDtoExtension on UserDto {
  UserDto copyWith(
      {String? username,
      bool? isActive,
      String? avatarUrl,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return UserDto(
        username: username ?? this.username,
        isActive: isActive ?? this.isActive,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  UserDto copyWithWrapped(
      {Wrapped<String>? username,
      Wrapped<bool>? isActive,
      Wrapped<String?>? avatarUrl,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt}) {
    return UserDto(
        username: (username != null ? username.value : this.username),
        isActive: (isActive != null ? isActive.value : this.isActive),
        avatarUrl: (avatarUrl != null ? avatarUrl.value : this.avatarUrl),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateUserDto {
  const UpdateUserDto({
    this.username,
    this.email,
    this.passwordHash,
    this.isActive,
    this.avatarKey,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDtoFromJson(json);

  static const toJsonFactory = _$UpdateUserDtoToJson;
  Map<String, dynamic> toJson() => _$UpdateUserDtoToJson(this);

  @JsonKey(name: 'username')
  final String? username;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'passwordHash')
  final String? passwordHash;
  @JsonKey(name: 'isActive')
  final bool? isActive;
  @JsonKey(name: 'avatarKey')
  final String? avatarKey;
  static const fromJsonFactory = _$UpdateUserDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateUserDto &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.passwordHash, passwordHash) ||
                const DeepCollectionEquality()
                    .equals(other.passwordHash, passwordHash)) &&
            (identical(other.isActive, isActive) ||
                const DeepCollectionEquality()
                    .equals(other.isActive, isActive)) &&
            (identical(other.avatarKey, avatarKey) ||
                const DeepCollectionEquality()
                    .equals(other.avatarKey, avatarKey)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(passwordHash) ^
      const DeepCollectionEquality().hash(isActive) ^
      const DeepCollectionEquality().hash(avatarKey) ^
      runtimeType.hashCode;
}

extension $UpdateUserDtoExtension on UpdateUserDto {
  UpdateUserDto copyWith(
      {String? username,
      String? email,
      String? passwordHash,
      bool? isActive,
      String? avatarKey}) {
    return UpdateUserDto(
        username: username ?? this.username,
        email: email ?? this.email,
        passwordHash: passwordHash ?? this.passwordHash,
        isActive: isActive ?? this.isActive,
        avatarKey: avatarKey ?? this.avatarKey);
  }

  UpdateUserDto copyWithWrapped(
      {Wrapped<String?>? username,
      Wrapped<String?>? email,
      Wrapped<String?>? passwordHash,
      Wrapped<bool?>? isActive,
      Wrapped<String?>? avatarKey}) {
    return UpdateUserDto(
        username: (username != null ? username.value : this.username),
        email: (email != null ? email.value : this.email),
        passwordHash:
            (passwordHash != null ? passwordHash.value : this.passwordHash),
        isActive: (isActive != null ? isActive.value : this.isActive),
        avatarKey: (avatarKey != null ? avatarKey.value : this.avatarKey));
  }
}

@JsonSerializable(explicitToJson: true)
class PutAvatarDto {
  const PutAvatarDto({
    required this.file,
  });

  factory PutAvatarDto.fromJson(Map<String, dynamic> json) =>
      _$PutAvatarDtoFromJson(json);

  static const toJsonFactory = _$PutAvatarDtoToJson;
  Map<String, dynamic> toJson() => _$PutAvatarDtoToJson(this);

  @JsonKey(name: 'file')
  final String file;
  static const fromJsonFactory = _$PutAvatarDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PutAvatarDto &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $PutAvatarDtoExtension on PutAvatarDto {
  PutAvatarDto copyWith({String? file}) {
    return PutAvatarDto(file: file ?? this.file);
  }

  PutAvatarDto copyWithWrapped({Wrapped<String>? file}) {
    return PutAvatarDto(file: (file != null ? file.value : this.file));
  }
}

@JsonSerializable(explicitToJson: true)
class PutAvatarImageResponseDto {
  const PutAvatarImageResponseDto({
    required this.isUpdated,
  });

  factory PutAvatarImageResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PutAvatarImageResponseDtoFromJson(json);

  static const toJsonFactory = _$PutAvatarImageResponseDtoToJson;
  Map<String, dynamic> toJson() => _$PutAvatarImageResponseDtoToJson(this);

  @JsonKey(name: 'isUpdated')
  final bool isUpdated;
  static const fromJsonFactory = _$PutAvatarImageResponseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PutAvatarImageResponseDto &&
            (identical(other.isUpdated, isUpdated) ||
                const DeepCollectionEquality()
                    .equals(other.isUpdated, isUpdated)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isUpdated) ^ runtimeType.hashCode;
}

extension $PutAvatarImageResponseDtoExtension on PutAvatarImageResponseDto {
  PutAvatarImageResponseDto copyWith({bool? isUpdated}) {
    return PutAvatarImageResponseDto(isUpdated: isUpdated ?? this.isUpdated);
  }

  PutAvatarImageResponseDto copyWithWrapped({Wrapped<bool>? isUpdated}) {
    return PutAvatarImageResponseDto(
        isUpdated: (isUpdated != null ? isUpdated.value : this.isUpdated));
  }
}

@JsonSerializable(explicitToJson: true)
class DeleteAvatarDto {
  const DeleteAvatarDto({
    required this.file,
  });

  factory DeleteAvatarDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteAvatarDtoFromJson(json);

  static const toJsonFactory = _$DeleteAvatarDtoToJson;
  Map<String, dynamic> toJson() => _$DeleteAvatarDtoToJson(this);

  @JsonKey(name: 'file')
  final String file;
  static const fromJsonFactory = _$DeleteAvatarDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeleteAvatarDto &&
            (identical(other.file, file) ||
                const DeepCollectionEquality().equals(other.file, file)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(file) ^ runtimeType.hashCode;
}

extension $DeleteAvatarDtoExtension on DeleteAvatarDto {
  DeleteAvatarDto copyWith({String? file}) {
    return DeleteAvatarDto(file: file ?? this.file);
  }

  DeleteAvatarDto copyWithWrapped({Wrapped<String>? file}) {
    return DeleteAvatarDto(file: (file != null ? file.value : this.file));
  }
}

@JsonSerializable(explicitToJson: true)
class DeleteAvatarResponseDto {
  const DeleteAvatarResponseDto({
    required this.isDeleted,
  });

  factory DeleteAvatarResponseDto.fromJson(Map<String, dynamic> json) =>
      _$DeleteAvatarResponseDtoFromJson(json);

  static const toJsonFactory = _$DeleteAvatarResponseDtoToJson;
  Map<String, dynamic> toJson() => _$DeleteAvatarResponseDtoToJson(this);

  @JsonKey(name: 'isDeleted')
  final bool isDeleted;
  static const fromJsonFactory = _$DeleteAvatarResponseDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is DeleteAvatarResponseDto &&
            (identical(other.isDeleted, isDeleted) ||
                const DeepCollectionEquality()
                    .equals(other.isDeleted, isDeleted)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isDeleted) ^ runtimeType.hashCode;
}

extension $DeleteAvatarResponseDtoExtension on DeleteAvatarResponseDto {
  DeleteAvatarResponseDto copyWith({bool? isDeleted}) {
    return DeleteAvatarResponseDto(isDeleted: isDeleted ?? this.isDeleted);
  }

  DeleteAvatarResponseDto copyWithWrapped({Wrapped<bool>? isDeleted}) {
    return DeleteAvatarResponseDto(
        isDeleted: (isDeleted != null ? isDeleted.value : this.isDeleted));
  }
}

@JsonSerializable(explicitToJson: true)
class RoleDto {
  const RoleDto({
    required this.role,
  });

  factory RoleDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDtoFromJson(json);

  static const toJsonFactory = _$RoleDtoToJson;
  Map<String, dynamic> toJson() => _$RoleDtoToJson(this);

  @JsonKey(name: 'role')
  final String role;
  static const fromJsonFactory = _$RoleDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RoleDto &&
            (identical(other.role, role) ||
                const DeepCollectionEquality().equals(other.role, role)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(role) ^ runtimeType.hashCode;
}

extension $RoleDtoExtension on RoleDto {
  RoleDto copyWith({String? role}) {
    return RoleDto(role: role ?? this.role);
  }

  RoleDto copyWithWrapped({Wrapped<String>? role}) {
    return RoleDto(role: (role != null ? role.value : this.role));
  }
}

@JsonSerializable(explicitToJson: true)
class LoginDto {
  const LoginDto({
    required this.username,
    required this.password,
  });

  factory LoginDto.fromJson(Map<String, dynamic> json) =>
      _$LoginDtoFromJson(json);

  static const toJsonFactory = _$LoginDtoToJson;
  Map<String, dynamic> toJson() => _$LoginDtoToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$LoginDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is LoginDto &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $LoginDtoExtension on LoginDto {
  LoginDto copyWith({String? username, String? password}) {
    return LoginDto(
        username: username ?? this.username,
        password: password ?? this.password);
  }

  LoginDto copyWithWrapped(
      {Wrapped<String>? username, Wrapped<String>? password}) {
    return LoginDto(
        username: (username != null ? username.value : this.username),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class AuthToken {
  const AuthToken({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
  });

  factory AuthToken.fromJson(Map<String, dynamic> json) =>
      _$AuthTokenFromJson(json);

  static const toJsonFactory = _$AuthTokenToJson;
  Map<String, dynamic> toJson() => _$AuthTokenToJson(this);

  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  static const fromJsonFactory = _$AuthTokenFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthToken &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality()
                    .equals(other.accessToken, accessToken)) &&
            (identical(other.refreshToken, refreshToken) ||
                const DeepCollectionEquality()
                    .equals(other.refreshToken, refreshToken)) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality()
                    .equals(other.tokenType, tokenType)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(refreshToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      runtimeType.hashCode;
}

extension $AuthTokenExtension on AuthToken {
  AuthToken copyWith(
      {String? accessToken, String? refreshToken, String? tokenType}) {
    return AuthToken(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        tokenType: tokenType ?? this.tokenType);
  }

  AuthToken copyWithWrapped(
      {Wrapped<String>? accessToken,
      Wrapped<String>? refreshToken,
      Wrapped<String>? tokenType}) {
    return AuthToken(
        accessToken:
            (accessToken != null ? accessToken.value : this.accessToken),
        refreshToken:
            (refreshToken != null ? refreshToken.value : this.refreshToken),
        tokenType: (tokenType != null ? tokenType.value : this.tokenType));
  }
}

@JsonSerializable(explicitToJson: true)
class RegisterDto {
  const RegisterDto({
    required this.username,
    required this.email,
    required this.password,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  static const toJsonFactory = _$RegisterDtoToJson;
  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  static const fromJsonFactory = _$RegisterDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RegisterDto &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password) ^
      runtimeType.hashCode;
}

extension $RegisterDtoExtension on RegisterDto {
  RegisterDto copyWith({String? username, String? email, String? password}) {
    return RegisterDto(
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password);
  }

  RegisterDto copyWithWrapped(
      {Wrapped<String>? username,
      Wrapped<String>? email,
      Wrapped<String>? password}) {
    return RegisterDto(
        username: (username != null ? username.value : this.username),
        email: (email != null ? email.value : this.email),
        password: (password != null ? password.value : this.password));
  }
}

@JsonSerializable(explicitToJson: true)
class CreateHabitDto {
  const CreateHabitDto({
    required this.name,
    required this.maxGapDays,
  });

  factory CreateHabitDto.fromJson(Map<String, dynamic> json) =>
      _$CreateHabitDtoFromJson(json);

  static const toJsonFactory = _$CreateHabitDtoToJson;
  Map<String, dynamic> toJson() => _$CreateHabitDtoToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'maxGapDays')
  final int maxGapDays;
  static const fromJsonFactory = _$CreateHabitDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateHabitDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxGapDays, maxGapDays) ||
                const DeepCollectionEquality()
                    .equals(other.maxGapDays, maxGapDays)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxGapDays) ^
      runtimeType.hashCode;
}

extension $CreateHabitDtoExtension on CreateHabitDto {
  CreateHabitDto copyWith({String? name, int? maxGapDays}) {
    return CreateHabitDto(
        name: name ?? this.name, maxGapDays: maxGapDays ?? this.maxGapDays);
  }

  CreateHabitDto copyWithWrapped(
      {Wrapped<String>? name, Wrapped<int>? maxGapDays}) {
    return CreateHabitDto(
        name: (name != null ? name.value : this.name),
        maxGapDays: (maxGapDays != null ? maxGapDays.value : this.maxGapDays));
  }
}

@JsonSerializable(explicitToJson: true)
class HabitDto {
  const HabitDto({
    required this.id,
    required this.name,
    required this.maxGapDays,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HabitDto.fromJson(Map<String, dynamic> json) =>
      _$HabitDtoFromJson(json);

  static const toJsonFactory = _$HabitDtoToJson;
  Map<String, dynamic> toJson() => _$HabitDtoToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'maxGapDays')
  final int maxGapDays;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  static const fromJsonFactory = _$HabitDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HabitDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxGapDays, maxGapDays) ||
                const DeepCollectionEquality()
                    .equals(other.maxGapDays, maxGapDays)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxGapDays) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      runtimeType.hashCode;
}

extension $HabitDtoExtension on HabitDto {
  HabitDto copyWith(
      {int? id,
      String? name,
      int? maxGapDays,
      DateTime? createdAt,
      DateTime? updatedAt}) {
    return HabitDto(
        id: id ?? this.id,
        name: name ?? this.name,
        maxGapDays: maxGapDays ?? this.maxGapDays,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt);
  }

  HabitDto copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<int>? maxGapDays,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt}) {
    return HabitDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        maxGapDays: (maxGapDays != null ? maxGapDays.value : this.maxGapDays),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt));
  }
}

@JsonSerializable(explicitToJson: true)
class HabitDetailsDto {
  const HabitDetailsDto({
    required this.id,
    required this.name,
    required this.maxGapDays,
    required this.createdAt,
    required this.updatedAt,
    required this.streak,
    required this.isDoneToday,
  });

  factory HabitDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$HabitDetailsDtoFromJson(json);

  static const toJsonFactory = _$HabitDetailsDtoToJson;
  Map<String, dynamic> toJson() => _$HabitDetailsDtoToJson(this);

  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'maxGapDays')
  final int maxGapDays;
  @JsonKey(name: 'createdAt')
  final DateTime createdAt;
  @JsonKey(name: 'updatedAt')
  final DateTime updatedAt;
  @JsonKey(name: 'streak')
  final int streak;
  @JsonKey(name: 'isDoneToday')
  final bool isDoneToday;
  static const fromJsonFactory = _$HabitDetailsDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is HabitDetailsDto &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxGapDays, maxGapDays) ||
                const DeepCollectionEquality()
                    .equals(other.maxGapDays, maxGapDays)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality()
                    .equals(other.updatedAt, updatedAt)) &&
            (identical(other.streak, streak) ||
                const DeepCollectionEquality().equals(other.streak, streak)) &&
            (identical(other.isDoneToday, isDoneToday) ||
                const DeepCollectionEquality()
                    .equals(other.isDoneToday, isDoneToday)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxGapDays) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(streak) ^
      const DeepCollectionEquality().hash(isDoneToday) ^
      runtimeType.hashCode;
}

extension $HabitDetailsDtoExtension on HabitDetailsDto {
  HabitDetailsDto copyWith(
      {int? id,
      String? name,
      int? maxGapDays,
      DateTime? createdAt,
      DateTime? updatedAt,
      int? streak,
      bool? isDoneToday}) {
    return HabitDetailsDto(
        id: id ?? this.id,
        name: name ?? this.name,
        maxGapDays: maxGapDays ?? this.maxGapDays,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        streak: streak ?? this.streak,
        isDoneToday: isDoneToday ?? this.isDoneToday);
  }

  HabitDetailsDto copyWithWrapped(
      {Wrapped<int>? id,
      Wrapped<String>? name,
      Wrapped<int>? maxGapDays,
      Wrapped<DateTime>? createdAt,
      Wrapped<DateTime>? updatedAt,
      Wrapped<int>? streak,
      Wrapped<bool>? isDoneToday}) {
    return HabitDetailsDto(
        id: (id != null ? id.value : this.id),
        name: (name != null ? name.value : this.name),
        maxGapDays: (maxGapDays != null ? maxGapDays.value : this.maxGapDays),
        createdAt: (createdAt != null ? createdAt.value : this.createdAt),
        updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
        streak: (streak != null ? streak.value : this.streak),
        isDoneToday:
            (isDoneToday != null ? isDoneToday.value : this.isDoneToday));
  }
}

@JsonSerializable(explicitToJson: true)
class UpdateHabitDto {
  const UpdateHabitDto({
    this.name,
    this.maxGapDays,
  });

  factory UpdateHabitDto.fromJson(Map<String, dynamic> json) =>
      _$UpdateHabitDtoFromJson(json);

  static const toJsonFactory = _$UpdateHabitDtoToJson;
  Map<String, dynamic> toJson() => _$UpdateHabitDtoToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'maxGapDays')
  final int? maxGapDays;
  static const fromJsonFactory = _$UpdateHabitDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is UpdateHabitDto &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.maxGapDays, maxGapDays) ||
                const DeepCollectionEquality()
                    .equals(other.maxGapDays, maxGapDays)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(maxGapDays) ^
      runtimeType.hashCode;
}

extension $UpdateHabitDtoExtension on UpdateHabitDto {
  UpdateHabitDto copyWith({String? name, int? maxGapDays}) {
    return UpdateHabitDto(
        name: name ?? this.name, maxGapDays: maxGapDays ?? this.maxGapDays);
  }

  UpdateHabitDto copyWithWrapped(
      {Wrapped<String?>? name, Wrapped<int?>? maxGapDays}) {
    return UpdateHabitDto(
        name: (name != null ? name.value : this.name),
        maxGapDays: (maxGapDays != null ? maxGapDays.value : this.maxGapDays));
  }
}

@JsonSerializable(explicitToJson: true)
class MonthlyActivityDto {
  const MonthlyActivityDto({
    required this.activity,
  });

  factory MonthlyActivityDto.fromJson(Map<String, dynamic> json) =>
      _$MonthlyActivityDtoFromJson(json);

  static const toJsonFactory = _$MonthlyActivityDtoToJson;
  Map<String, dynamic> toJson() => _$MonthlyActivityDtoToJson(this);

  @JsonKey(name: 'activity', defaultValue: <int>[])
  final List<int> activity;
  static const fromJsonFactory = _$MonthlyActivityDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MonthlyActivityDto &&
            (identical(other.activity, activity) ||
                const DeepCollectionEquality()
                    .equals(other.activity, activity)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(activity) ^ runtimeType.hashCode;
}

extension $MonthlyActivityDtoExtension on MonthlyActivityDto {
  MonthlyActivityDto copyWith({List<int>? activity}) {
    return MonthlyActivityDto(activity: activity ?? this.activity);
  }

  MonthlyActivityDto copyWithWrapped({Wrapped<List<int>>? activity}) {
    return MonthlyActivityDto(
        activity: (activity != null ? activity.value : this.activity));
  }
}

@JsonSerializable(explicitToJson: true)
class TodayActivityDto {
  const TodayActivityDto({
    required this.isDoneToday,
  });

  factory TodayActivityDto.fromJson(Map<String, dynamic> json) =>
      _$TodayActivityDtoFromJson(json);

  static const toJsonFactory = _$TodayActivityDtoToJson;
  Map<String, dynamic> toJson() => _$TodayActivityDtoToJson(this);

  @JsonKey(name: 'isDoneToday')
  final bool isDoneToday;
  static const fromJsonFactory = _$TodayActivityDtoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TodayActivityDto &&
            (identical(other.isDoneToday, isDoneToday) ||
                const DeepCollectionEquality()
                    .equals(other.isDoneToday, isDoneToday)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(isDoneToday) ^ runtimeType.hashCode;
}

extension $TodayActivityDtoExtension on TodayActivityDto {
  TodayActivityDto copyWith({bool? isDoneToday}) {
    return TodayActivityDto(isDoneToday: isDoneToday ?? this.isDoneToday);
  }

  TodayActivityDto copyWithWrapped({Wrapped<bool>? isDoneToday}) {
    return TodayActivityDto(
        isDoneToday:
            (isDoneToday != null ? isDoneToday.value : this.isDoneToday));
  }
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
