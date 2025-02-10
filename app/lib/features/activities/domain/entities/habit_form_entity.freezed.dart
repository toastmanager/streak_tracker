// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_form_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

HabitFormEntity _$HabitFormEntityFromJson(Map<String, dynamic> json) {
  return _HabitFormEntity.fromJson(json);
}

/// @nodoc
mixin _$HabitFormEntity {
  String get name => throw _privateConstructorUsedError;
  int get maxGapDays => throw _privateConstructorUsedError;

  /// Serializes this HabitFormEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HabitFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HabitFormEntityCopyWith<HabitFormEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HabitFormEntityCopyWith<$Res> {
  factory $HabitFormEntityCopyWith(
          HabitFormEntity value, $Res Function(HabitFormEntity) then) =
      _$HabitFormEntityCopyWithImpl<$Res, HabitFormEntity>;
  @useResult
  $Res call({String name, int maxGapDays});
}

/// @nodoc
class _$HabitFormEntityCopyWithImpl<$Res, $Val extends HabitFormEntity>
    implements $HabitFormEntityCopyWith<$Res> {
  _$HabitFormEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HabitFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxGapDays = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxGapDays: null == maxGapDays
          ? _value.maxGapDays
          : maxGapDays // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HabitFormEntityImplCopyWith<$Res>
    implements $HabitFormEntityCopyWith<$Res> {
  factory _$$HabitFormEntityImplCopyWith(_$HabitFormEntityImpl value,
          $Res Function(_$HabitFormEntityImpl) then) =
      __$$HabitFormEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, int maxGapDays});
}

/// @nodoc
class __$$HabitFormEntityImplCopyWithImpl<$Res>
    extends _$HabitFormEntityCopyWithImpl<$Res, _$HabitFormEntityImpl>
    implements _$$HabitFormEntityImplCopyWith<$Res> {
  __$$HabitFormEntityImplCopyWithImpl(
      _$HabitFormEntityImpl _value, $Res Function(_$HabitFormEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of HabitFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? maxGapDays = null,
  }) {
    return _then(_$HabitFormEntityImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      maxGapDays: null == maxGapDays
          ? _value.maxGapDays
          : maxGapDays // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$HabitFormEntityImpl implements _HabitFormEntity {
  const _$HabitFormEntityImpl({required this.name, required this.maxGapDays});

  factory _$HabitFormEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$HabitFormEntityImplFromJson(json);

  @override
  final String name;
  @override
  final int maxGapDays;

  @override
  String toString() {
    return 'HabitFormEntity(name: $name, maxGapDays: $maxGapDays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HabitFormEntityImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.maxGapDays, maxGapDays) ||
                other.maxGapDays == maxGapDays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, maxGapDays);

  /// Create a copy of HabitFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HabitFormEntityImplCopyWith<_$HabitFormEntityImpl> get copyWith =>
      __$$HabitFormEntityImplCopyWithImpl<_$HabitFormEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$HabitFormEntityImplToJson(
      this,
    );
  }
}

abstract class _HabitFormEntity implements HabitFormEntity {
  const factory _HabitFormEntity(
      {required final String name,
      required final int maxGapDays}) = _$HabitFormEntityImpl;

  factory _HabitFormEntity.fromJson(Map<String, dynamic> json) =
      _$HabitFormEntityImpl.fromJson;

  @override
  String get name;
  @override
  int get maxGapDays;

  /// Create a copy of HabitFormEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HabitFormEntityImplCopyWith<_$HabitFormEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
