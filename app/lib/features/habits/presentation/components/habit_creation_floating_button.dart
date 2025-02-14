import 'package:app/features/habits/domain/cubit/habits_cubit.dart';
import 'package:app/features/habits/domain/repositories/habits_repository.dart';
import 'package:app/features/habits/presentation/components/habit_form_screen.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:app/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class HabitCreationFloatingButton extends StatelessWidget {
  const HabitCreationFloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final maxGapDaysController = TextEditingController();
    final activityCreationFormKey = GlobalKey<FormBuilderState>();
    bool enabled = true;

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => StatefulBuilder(
            builder: (context, setState) {
              return FormBuilder(
                key: activityCreationFormKey,
                child: HabitFormScreen(
                  title: 'Создание привычки',
                  formKey: activityCreationFormKey,
                  enabled: enabled,
                  titleController: titleController,
                  maxGapDaysController: maxGapDaysController,
                  onCancel: () {
                    Navigator.pop(context);
                  },
                  onConfirm: () async {
                    setState(() => enabled = false);
                    await sl<HabitsRepository>().createHabit(
                      form: CreateHabitDto(
                        name: titleController.text,
                        maxGapDays:
                            int.tryParse(maxGapDaysController.text) ?? 0,
                      ),
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
                ),
              );
            },
          ),
        );
      },
      child: Icon(Icons.add),
    );
  }
}
