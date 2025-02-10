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
    return await habitsRestClient.create(form);
  }

  @override
  Future<void> deleteHabit({required int id}) async {
    await habitsRestClient.delete(id);
    return;
  }

  @override
  Future<Habit> getHabit({required int id}) async {
    return await habitsRestClient.getById(id);
  }

  @override
  Future<List<Habit>> getHabits() async {
    return await habitsRestClient.getAll();
  }

  @override
  Future<List<int>> getMonthActivity(
      {required int id, required int year, required int month}) {
    // TODO: implement getMonthActivity
    throw UnimplementedError();
  }

  @override
  Future<bool> switchTodayActivity({required int id}) {
    // TODO: implement switchTodayActivity
    throw UnimplementedError();
  }

  @override
  Future<Habit> updateHabit(
      {required int id, required HabitFormEntity form}) async {
    return await habitsRestClient.updateOne(id, form);
  }
}
