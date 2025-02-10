// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_form_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HabitFormEntityImpl _$$HabitFormEntityImplFromJson(
        Map<String, dynamic> json) =>
    _$HabitFormEntityImpl(
      name: json['name'] as String,
      maxGapDays: (json['maxGapDays'] as num).toInt(),
    );

Map<String, dynamic> _$$HabitFormEntityImplToJson(
        _$HabitFormEntityImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'maxGapDays': instance.maxGapDays,
    };
