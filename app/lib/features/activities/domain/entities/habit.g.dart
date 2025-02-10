// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      streak: (json['streak'] as num?)?.toInt() ?? 0,
      maxGapDays: (json['maxGapDays'] as num).toInt(),
      isDoneToday: json['isDoneToday'] as bool? ?? false,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'streak': instance.streak,
      'maxGapDays': instance.maxGapDays,
      'isDoneToday': instance.isDoneToday,
    };
