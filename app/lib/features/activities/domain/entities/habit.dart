import 'package:freezed_annotation/freezed_annotation.dart';

part 'habit.freezed.dart';
part 'habit.g.dart';

@freezed
class Habit with _$Habit {
  const factory Habit({
    required int id,
    required String name,
    @Default(0) int streak,
    required int maxGapDays,
    @Default(false) bool isDoneToday,
  }) = _Activity;

  factory Habit.fromJson(Map<String, Object?> json) => _$HabitFromJson(json);
}
