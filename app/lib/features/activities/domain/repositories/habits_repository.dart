import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';

abstract class HabitsRepository {
  Future<List<Habit>> getHabits();
  Future<Habit> getHabit({
    required int id,
  });
  Future<Habit> updateHabit({
    required int id,
    required HabitFormEntity form,
  });
  Future<void> deleteHabit({
    required int id,
  });
  Future<Habit> createHabit({required HabitFormEntity form});
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
