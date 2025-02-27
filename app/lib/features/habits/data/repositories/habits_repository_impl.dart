import 'package:app/features/habits/domain/repositories/habits_repository.dart';
import 'package:app/generated_code/rest_api.swagger.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HabitsRepository)
class HabitsRepositoryImpl implements HabitsRepository {
  final RestApi restApi;

  const HabitsRepositoryImpl({
    required this.restApi,
  });

  @override
  Future<HabitDto> createHabit({required CreateHabitDto form}) async {
    final habit = (await restApi.apiV1HabitsPost(body: form)).body;
    return habit!;
  }

  @override
  Future<void> deleteHabit({required int id}) async {
    await restApi.apiV1HabitsIdDelete(
      id: id.toString(),
    );
    return;
  }

  @override
  Future<HabitDetailsDto> getHabit({required int id}) async {
    final habit = (await restApi.apiV1HabitsIdGet(id: id.toString())).body;
    return habit!;
  }

  @override
  Future<List<HabitDetailsDto>> getHabits() async {
    final habits = (await restApi.apiV1HabitsUsersMeGet()).body;
    return habits ?? [];
  }

  @override
  Future<List<int>> getMonthlyActivity(
      {required int id, required int year, required int month}) async {
    final activity = (await restApi.apiV1HabitsIdActivitiesYearMonthGet(
      id: id.toString(),
      year: year.toString(),
      month: month.toString(),
    ))
        .body;
    return activity?.activity ?? [];
  }

  @override
  Future<bool> switchTodayActivity({required int id}) async {
    final isDoneToday =
        (await restApi.apiV1HabitsIdActivitiesTodayPut(id: id.toString())).body;
    return isDoneToday?.isDoneToday ?? false;
  }

  @override
  Future<HabitDetailsDto> updateHabit(
      {required int id, required UpdateHabitDto form}) async {
    final updatedHabit = (await restApi.apiV1HabitsIdPatch(
      id: id.toString(),
      body: form,
    ))
        .body;
    return updatedHabit!;
  }
}
