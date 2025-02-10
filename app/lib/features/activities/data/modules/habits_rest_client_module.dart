import 'package:app/features/activities/data/datasources/habits_rest_client.dart';
import 'package:app/injection.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class HabitsRestClientModule {
  @injectable
  HabitsRestClient get habitsRestClient => HabitsRestClient(sl<Dio>());
}
