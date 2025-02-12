import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'habits_rest_client.g.dart';

@RestApi()
abstract class HabitsRestClient {
  factory HabitsRestClient(Dio dio) = _HabitsRestClient;

  static const prefix = 'habits';

  @POST('/$prefix')
  Future<Habit> create(@Body() HabitFormEntity model);

  @GET('/$prefix/users/me')
  Future<List<Habit>> getAll();

  @GET('/$prefix/{id}')
  Future<Habit> getById(@Path("id") int id);

  @PATCH('/$prefix/{id}')
  Future<Habit> updateOne(@Path("id") int id, @Body() HabitFormEntity model);

  @DELETE('/$prefix/{id}')
  Future<void> delete(@Path("id") int id);

  @GET('/$prefix/{id}/activities/{year}/{month}')
  Future<List<int>> getMonthlyActivity(
      @Path("id") int id, @Path("year") int year, @Path("month") int month);

  @PUT('/$prefix/{id}/activities/today')
  Future<String> switchTodayActivity(@Path("id") int id);

  @POST('/$prefix/{id}/activities/today')
  Future<void> addTodayActivity(@Path("id") int id);

  @DELETE('/$prefix/{id}/activities/today')
  Future<void> removeTodayActivity(@Path("id") int id);
}
