import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';
import 'package:app/features/activities/domain/repositories/habits_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'habits_state.dart';
part 'habits_cubit.freezed.dart';

@injectable
class HabitsCubit extends Cubit<HabitsState> {
  final HabitsRepository habitsRepository;

  HabitsCubit({required this.habitsRepository}) : super(HabitsState.initial());

  Future<void> getHabits() async {
    emit(_Loading());
    final habits = await habitsRepository.getHabits();
    emit(
      _Loaded(
        habits: habits,
      ),
    );
  }

  Future<void> deleteHabit({required int id}) async {
    habitsRepository.deleteHabit(id: id);
    emit(
      _Loaded(
        habits: state.whenOrNull(
              loaded: (habits) => habits.where((el) => el.id != id).toList(),
            ) ??
            [],
      ),
    );
  }

  Future<void> updateHabit(
      {required int id, required HabitFormEntity form}) async {
    habitsRepository.updateHabit(id: id, form: form);
    emit(
      _Loaded(
        habits: [
          Habit(id: id, name: form.name, maxGapDays: form.maxGapDays),
          ...state.whenOrNull(
                loaded: (habits) => habits.where((el) => el.id != id).toList(),
              ) ??
              [],
        ],
      ),
    );
  }
}
