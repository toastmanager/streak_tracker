import 'package:app/core/routes/router.dart';
import 'package:app/core/routes/router.gr.dart';
import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/presentation/widgets/habit_card.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';

class HabitCardsListView extends StatelessWidget {
  const HabitCardsListView({
    super.key,
    required this.activities,
  });

  final List<Habit> activities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      itemBuilder: (context, index) {
        final currentActivity = activities[index];
        return ActivityCard(
          name: currentActivity.name,
          streak: currentActivity.streak,
          onTap: () => sl<AppRouter>()
              .push(ActivityDetailsRoute(id: currentActivity.id)),
        );
      },
      separatorBuilder: (context, index) => SizedBox(height: 12),
      itemCount: activities.length,
    );
  }
}
