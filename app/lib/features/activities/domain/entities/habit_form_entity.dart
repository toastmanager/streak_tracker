import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit_form_entity.freezed.dart';
part 'habit_form_entity.g.dart';

@freezed
class HabitFormEntity with _$HabitFormEntity {
  const factory HabitFormEntity({
    required String name,
    required int maxGapDays,
  }) = _HabitFormEntity;

  factory HabitFormEntity.fromJson(Map<String, Object?> json) =>
      _$HabitFormEntityFromJson(json);
}
