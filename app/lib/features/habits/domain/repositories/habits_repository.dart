import 'package:app/generated_code/rest_api.models.swagger.dart';

abstract class HabitsRepository {
  Future<List<HabitDto>> getHabits();
  Future<HabitDto> getHabit({
    required int id,
  });
  Future<HabitDto> updateHabit({
    required int id,
    required UpdateHabitDto form,
  });
  Future<void> deleteHabit({
    required int id,
  });
  Future<HabitDto> createHabit({required CreateHabitDto form});
  Future<List<int>> getMonthlyActivity({
    required int id,
    required int year,
    required int month,
  });

  /// Switch [isDoneToday] for habit with given [id]
  ///
  /// Returns [isDoneToday] value
  Future<bool> switchTodayActivity({
    required int id,
  });
}
