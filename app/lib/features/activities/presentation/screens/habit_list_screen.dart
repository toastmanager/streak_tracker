import 'package:app/features/activities/domain/cubit/habits_cubit.dart';
import 'package:app/features/activities/domain/entities/habit_mocks.dart';
import 'package:app/features/activities/presentation/widgets/habit_cards_list_view.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ActivityListScreen extends StatelessWidget {
  const ActivityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colors = ColorScheme.of(context);

    return BlocBuilder<HabitsCubit, HabitsState>(
      builder: (context, state) {
        return state.when(
          loaded: (activities) => HabitCardsListView(habits: activities),
          loading: () =>
              Skeletonizer(child: HabitCardsListView(habits: mockActivities)),
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
