import 'package:app/features/activities/domain/cubit/habits_cubit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';
import 'package:app/features/activities/domain/repositories/habits_repository.dart';
import 'package:app/features/activities/presentation/components/habit_form_screen.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitCreationFloatingButton extends StatelessWidget {
  const HabitCreationFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final maxGapDaysController = TextEditingController();
    bool enabled = true;

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return HabitFormScreen(
                title: 'Создание привычки',
                enabled: enabled,
                titleController: titleController,
                maxGapDaysController: maxGapDaysController,
                onCancel: () {
                  Navigator.pop(context);
                },
                onConfirm: () async {
                  setState(() => enabled = false);
                  await sl<HabitsRepository>().createHabit(
                    form: HabitFormEntity(
                        name: titleController.text,
                        maxGapDays:
                            int.tryParse(maxGapDaysController.text) ?? 0),
                  );
                  if (context.mounted) {
                    context.read<HabitsCubit>().getHabits();
                    setState(() {
                      titleController.text = "";
                      maxGapDaysController.text = "";
                      enabled = true;
                    });
                    Navigator.pop(context);
                  }
                },
              );
            },
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
