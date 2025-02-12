import 'package:app/core/routes/router.dart';
import 'package:app/core/routes/router.gr.dart';
import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/presentation/widgets/habit_card.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';

class HabitCardsListView extends StatelessWidget {
  const HabitCardsListView({
    super.key,
    required this.habits,
  });

  final List<Habit> habits;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      itemBuilder: (context, index) {
        final currentHabit = habits[index];
        return ActivityCard(
          habit: currentHabit,
          onTap: () =>
              sl<AppRouter>().push(ActivityDetailsRoute(id: currentHabit.id)),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemCount: habits.length,
    );
  }
}
