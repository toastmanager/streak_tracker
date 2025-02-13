import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    this.onTap,
    required this.habit,
  });

  final void Function()? onTap;
  final HabitDto habit;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: ActivityCardContent(
          habit: habit,
        ),
      ),
    );
  }
}

class ActivityCardContent extends StatelessWidget {
  const ActivityCardContent({
    super.key,
    required this.habit,
  });

  final HabitDto habit;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final streakColor =
        habit.isDoneToday ? colors.primary : colors.onSurfaceVariant;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(habit.name)),
        Row(
          children: [
            Text(
              habit.streak.toString(),
              style: textTheme.bodyMedium?.copyWith(color: streakColor),
            ),
            const SizedBox(width: 4),
            Icon(
              TablerIcons.flame,
              color: streakColor,
            ),
          ],
        )
      ],
    );
  }
}
