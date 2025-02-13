import 'package:app/features/habits/domain/cubit/habits_cubit.dart';
import 'package:app/features/habits/presentation/widgets/habit_cards_list_view.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HabitsListScreen extends StatelessWidget {
  const HabitsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colors = ColorScheme.of(context);

    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        return state.when(
          loaded: (habits) => HabitCardsListView(habits: habits),
          loading: () => Skeletonizer(
              child: HabitCardsListView(
                  habits: List.filled(
                      6,
                      HabitDto(
                        id: 0,
                        isDoneToday: false,
                        maxGapDays: 0,
                        name: 'dasfasdfsdaafsd',
                        streak: 52,
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      )))),
          initial: () => Center(
            child: Text('Непредвиденная ошибка на стороне клиента'),
          ),
          error: (message) => Center(
            child: Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colors.error,
              ),
            ),
          ),
        );
      },
    );
  }
}
