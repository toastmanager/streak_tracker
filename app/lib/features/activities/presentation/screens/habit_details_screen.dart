import 'package:app/core/extensions/extensions.dart';
import 'package:app/features/activities/domain/cubit/habits_cubit.dart';
import 'package:app/features/activities/domain/entities/habit.dart';
import 'package:app/features/activities/domain/entities/habit_form_entity.dart';
import 'package:app/features/activities/domain/repositories/habits_repository.dart';
import 'package:app/features/activities/presentation/components/habit_form_screen.dart';
import 'package:app/features/activities/presentation/widgets/habit_card.dart';
import 'package:app/injection.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class ActivityDetailsScreen extends StatelessWidget {
  const ActivityDetailsScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final titleController = TextEditingController();
    final maxGapDaysController = TextEditingController();

    return FutureBuilder<Habit>(
        future: sl<HabitsRepository>().getHabit(id: id),
        builder: (context, snapshot) {
          Habit habit = snapshot.data ?? Habit(id: id, name: "", maxGapDays: 0);
          titleController.text = habit.name;
          maxGapDaysController.text = habit.maxGapDays.toString();
          bool isHabitDetailsEnabled = true;

          return StatefulBuilder(builder: (context, setState) {
            void switchTodayActivity() async {
              setState(() {
                habit = habit.copyWith(
                    isDoneToday: !habit.isDoneToday,
                    streak: habit.isDoneToday
                        ? habit.streak - 1
                        : habit.streak + 1);
              });
              await sl<HabitsRepository>().switchTodayActivity(id: id);
              if (context.mounted) {
                context.read<HabitsCubit>().getHabits();
              }
            }

            return Scaffold(
              appBar: AppBar(
                title: Text("Детали"),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setModalState) {
                            return HabitFormScreen(
                              title: 'Обновление привычки',
                              enabled: isHabitDetailsEnabled,
                              titleController: titleController,
                              maxGapDaysController: maxGapDaysController,
                              onCancel: () {
                                Navigator.pop(context);
                              },
                              onConfirm: () async {
                                setModalState(
                                    () => isHabitDetailsEnabled = false);
                                final updatedHabit =
                                    await sl<HabitsRepository>().updateHabit(
                                  id: id,
                                  form: HabitFormEntity(
                                    name: titleController.text,
                                    maxGapDays:
                                        int.parse(maxGapDaysController.text),
                                  ),
                                );
                                if (context.mounted) {
                                  context.read<HabitsCubit>().getHabits();
                                  setState(() => habit = updatedHabit);
                                  setModalState(() {
                                    isHabitDetailsEnabled = true;
                                  });
                                  Navigator.pop(context);
                                }
                              },
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(TablerIcons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text(
                                    'Вы уверены что хотите удалить привыку?'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Отмена')),
                                  TextButton(
                                      onPressed: () {
                                        context
                                            .read<HabitsCubit>()
                                            .deleteHabit(id: id);
                                        Navigator.of(context).pop();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Удалить',
                                        style: textTheme.bodyMedium?.copyWith(
                                          color: colors.error,
                                        ),
                                      )),
                                ],
                              ));
                    },
                    icon: Icon(TablerIcons.trash),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: switchTodayActivity,
                child:
                    Icon(habit.isDoneToday ? Icons.close_rounded : Icons.done),
              ),
              body: SafeArea(
                child: Builder(builder: (context) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: textTheme.bodyMedium?.copyWith(
                          color: colors.error,
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting ||
                      snapshot.hasData) {
                    return Skeletonizer(
                      enabled:
                          snapshot.connectionState == ConnectionState.waiting,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ActivityCard(
                              habit: habit,
                            ),
                            const SizedBox(height: 12),
                            ActivityCalendar(
                              id: id,
                              isDoneToday: habit.isDoneToday,
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Center(
                    child: Text('Непредвиденная ошибка на стороне клиента'),
                  );
                }),
              ),
            );
          });
        });
  }
}

class ActivityCalendar extends StatefulWidget {
  const ActivityCalendar({
    super.key,
    required this.id,
    this.isDoneToday = false,
  });

  final int id;
  final bool isDoneToday;

  @override
  State<ActivityCalendar> createState() => _ActivityCalendarState();
}

class _ActivityCalendarState extends State<ActivityCalendar> {
  DateTime today = DateTime.now();
  DateTime date = DateTime.now();
  int daysInMonth = 31;
  List<int> activityDays = [];

  void updateDate(DateTime newDate) async {
    setState(() {
      date = newDate;
      daysInMonth = DateUtils.getDaysInMonth(date.year, date.month);
    });
    final newDateActivityDays = await sl<HabitsRepository>()
        .getMonthlyActivity(id: widget.id, year: date.year, month: date.month);
    if (mounted) {
      setState(() {
        activityDays = newDateActivityDays;
      });
    }
  }

  @override
  void initState() {
    updateDate(date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);
    final textTheme = TextTheme.of(context);
    final isCurrentMonth = date.year == today.year && date.month == today.month;

    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () async {
            final newDate = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(2021),
              lastDate: DateTime(2222),
            );
            updateDate(newDate ?? date);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    DateFormat.yMMMM().format(date).capitalize(),
                    style: textTheme.titleLarge,
                  )
                ],
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: BoxConstraints.loose(Size(400, 130)),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: daysInMonth,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 12,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) => CalendarDay(
                    color: activityDays.contains(index + 1) ||
                            (isCurrentMonth &&
                                widget.isDoneToday &&
                                index + 1 == today.day)
                        ? colors.primary
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarDay extends StatelessWidget {
  const CalendarDay({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colors = ColorScheme.of(context);

    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        color: color ?? colors.surfaceContainer,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
