import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    this.onTap,
    required this.name,
    required this.streak,
  });

  final void Function()? onTap;
  final String name;
  final int streak;

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
          name: name,
          streak: streak,
        ),
      ),
    );
  }
}

class ActivityCardContent extends StatelessWidget {
  const ActivityCardContent({
    super.key,
    required this.name,
    required this.streak,
  });

  final String name;
  final int streak;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(name)),
        Row(
          children: [
            Text(
              streak.toString(),
              style: textTheme.bodyMedium?.copyWith(color: colors.primary),
            ),
            const SizedBox(width: 4),
            Icon(
              TablerIcons.flame,
              color: colors.primary,
            ),
          ],
        )
      ],
    );
  }
}
