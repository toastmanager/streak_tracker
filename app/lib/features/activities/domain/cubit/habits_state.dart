part of 'habits_cubit.dart';

@freezed
class HabitsState with _$HabitsState {
  const factory HabitsState.initial() = _Initial;
  const factory HabitsState.loading() = _Loading;
  const factory HabitsState.loaded({
    required List<Habit> habits,
  }) = _Loaded;
  const factory HabitsState.error({
    required String message,
  }) = _Error;
}
