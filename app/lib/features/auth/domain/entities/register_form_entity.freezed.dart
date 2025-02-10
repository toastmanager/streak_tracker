// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_form_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RegisterFormEntity _$RegisterFormEntityFromJson(Map<String, dynamic> json) {
  return _RegisterFormEntity.fromJson(json);
}

/// @nodoc
mixin _$RegisterFormEntity {
  String get username => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this RegisterFormEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RegisterFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RegisterFormEntityCopyWith<RegisterFormEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterFormEntityCopyWith<$Res> {
  factory $RegisterFormEntityCopyWith(
          RegisterFormEntity value, $Res Function(RegisterFormEntity) then) =
      _$RegisterFormEntityCopyWithImpl<$Res, RegisterFormEntity>;
  @useResult
  $Res call({String username, String email, String password});
}

/// @nodoc
class _$RegisterFormEntityCopyWithImpl<$Res, $Val extends RegisterFormEntity>
    implements $RegisterFormEntityCopyWith<$Res> {
  _$RegisterFormEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RegisterFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RegisterFormEntityImplCopyWith<$Res>
    implements $RegisterFormEntityCopyWith<$Res> {
  factory _$$RegisterFormEntityImplCopyWith(_$RegisterFormEntityImpl value,
          $Res Function(_$RegisterFormEntityImpl) then) =
      __$$RegisterFormEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String email, String password});
}

/// @nodoc
class __$$RegisterFormEntityImplCopyWithImpl<$Res>
    extends _$RegisterFormEntityCopyWithImpl<$Res, _$RegisterFormEntityImpl>
    implements _$$RegisterFormEntityImplCopyWith<$Res> {
  __$$RegisterFormEntityImplCopyWithImpl(_$RegisterFormEntityImpl _value,
      $Res Function(_$RegisterFormEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of RegisterFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$RegisterFormEntityImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RegisterFormEntityImpl implements _RegisterFormEntity {
  const _$RegisterFormEntityImpl(
      {required this.username, required this.email, required this.password});

  factory _$RegisterFormEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegisterFormEntityImplFromJson(json);

  @override
  final String username;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterFormEntity(username: $username, email: $email, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegisterFormEntityImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, email, password);

  /// Create a copy of RegisterFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RegisterFormEntityImplCopyWith<_$RegisterFormEntityImpl> get copyWith =>
      __$$RegisterFormEntityImplCopyWithImpl<_$RegisterFormEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegisterFormEntityImplToJson(
      this,
    );
  }
}

abstract class _RegisterFormEntity implements RegisterFormEntity {
  const factory _RegisterFormEntity(
      {required final String username,
      required final String email,
      required final String password}) = _$RegisterFormEntityImpl;

  factory _RegisterFormEntity.fromJson(Map<String, dynamic> json) =
      _$RegisterFormEntityImpl.fromJson;

  @override
  String get username;
  @override
  String get email;
  @override
  String get password;

  /// Create a copy of RegisterFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RegisterFormEntityImplCopyWith<_$RegisterFormEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
