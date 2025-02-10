// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_form_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoginFormEntity _$LoginFormEntityFromJson(Map<String, dynamic> json) {
  return _LoginFormEntity.fromJson(json);
}

/// @nodoc
mixin _$LoginFormEntity {
  String get username => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  /// Serializes this LoginFormEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoginFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoginFormEntityCopyWith<LoginFormEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginFormEntityCopyWith<$Res> {
  factory $LoginFormEntityCopyWith(
          LoginFormEntity value, $Res Function(LoginFormEntity) then) =
      _$LoginFormEntityCopyWithImpl<$Res, LoginFormEntity>;
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class _$LoginFormEntityCopyWithImpl<$Res, $Val extends LoginFormEntity>
    implements $LoginFormEntityCopyWith<$Res> {
  _$LoginFormEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoginFormEntityImplCopyWith<$Res>
    implements $LoginFormEntityCopyWith<$Res> {
  factory _$$LoginFormEntityImplCopyWith(_$LoginFormEntityImpl value,
          $Res Function(_$LoginFormEntityImpl) then) =
      __$$LoginFormEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String username, String password});
}

/// @nodoc
class __$$LoginFormEntityImplCopyWithImpl<$Res>
    extends _$LoginFormEntityCopyWithImpl<$Res, _$LoginFormEntityImpl>
    implements _$$LoginFormEntityImplCopyWith<$Res> {
  __$$LoginFormEntityImplCopyWithImpl(
      _$LoginFormEntityImpl _value, $Res Function(_$LoginFormEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoginFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = null,
    Object? password = null,
  }) {
    return _then(_$LoginFormEntityImpl(
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
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
class _$LoginFormEntityImpl implements _LoginFormEntity {
  const _$LoginFormEntityImpl({required this.username, required this.password});

  factory _$LoginFormEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoginFormEntityImplFromJson(json);

  @override
  final String username;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginFormEntity(username: $username, password: $password)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginFormEntityImpl &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, username, password);

  /// Create a copy of LoginFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginFormEntityImplCopyWith<_$LoginFormEntityImpl> get copyWith =>
      __$$LoginFormEntityImplCopyWithImpl<_$LoginFormEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoginFormEntityImplToJson(
      this,
    );
  }
}

abstract class _LoginFormEntity implements LoginFormEntity {
  const factory _LoginFormEntity(
      {required final String username,
      required final String password}) = _$LoginFormEntityImpl;

  factory _LoginFormEntity.fromJson(Map<String, dynamic> json) =
      _$LoginFormEntityImpl.fromJson;

  @override
  String get username;
  @override
  String get password;

  /// Create a copy of LoginFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginFormEntityImplCopyWith<_$LoginFormEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
