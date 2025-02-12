import 'package:app/features/activities/data/datasources/habits_rest_client.dart';
import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';
import 'package:app/features/activities/domain/repositories/habits_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HabitsRepository)
class HabitsRepositoryImpl implements HabitsRepository {
  final HabitsRestClient habitsRestClient;

  const HabitsRepositoryImpl({
    required this.habitsRestClient,
  });

  @override
  Future<Habit> createHabit({required HabitFormEntity form}) async {
    final habit = await habitsRestClient.create(form);
    return habit;
  }

  @override
  Future<void> deleteHabit({required int id}) async {
    await habitsRestClient.delete(id);
    return;
  }

  @override
  Future<Habit> getHabit({required int id}) async {
    final habit = await habitsRestClient.getById(id);
    return habit;
  }

  @override
  Future<List<Habit>> getHabits() async {
    final habits = await habitsRestClient.getAll();
    return habits;
  }

  @override
  Future<List<int>> getMonthlyActivity(
      {required int id, required int year, required int month}) async {
    final activities =
        await habitsRestClient.getMonthlyActivity(id, year, month);
    return activities;
  }

  @override
  Future<bool> switchTodayActivity({required int id}) async {
    final isDoneToday = await habitsRestClient.switchTodayActivity(id);
    return isDoneToday == "true";
  }

  @override
  Future<Habit> updateHabit(
      {required int id, required HabitFormEntity form}) async {
    final updatedHabit = await habitsRestClient.updateOne(id, form);
    return updatedHabit;
  }
}
