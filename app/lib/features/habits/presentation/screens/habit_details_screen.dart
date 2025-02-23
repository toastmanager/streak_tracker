import 'package:app/core/extensions/extensions.dart';
import 'package:app/features/habits/domain/cubit/habits_cubit.dart';
import 'package:app/features/habits/domain/repositories/habits_repository.dart';
import 'package:app/features/habits/presentation/components/habit_form_screen.dart';
import 'package:app/features/habits/presentation/widgets/habit_card.dart';
import 'package:app/generated_code/rest_api.models.swagger.dart';
import 'package:app/injection.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
    final activityUpdateFormKey = GlobalKey<FormBuilderState>();
    String? activityUpdateFormErrorMessage;

    return FutureBuilder<HabitDetailsDto>(
        future: sl<HabitsRepository>().getHabit(id: id),
        builder: (context, snapshot) {
          HabitDetailsDto habit = snapshot.data ??
              HabitDetailsDto(
                id: id,
                name: '',
                maxGapDays: 0,
                isDoneToday: false,
                streak: 0,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
          titleController.text = habit.name;
          maxGapDaysController.text = habit.maxGapDays.toString();
          bool isHabitDetailsEnabled = true;

          return StatefulBuilder(builder: (context, setState) {
            void switchTodayActivity() async {
              setState(() => habit = habit.copyWith(
                    isDoneToday: !habit.isDoneToday,
                    streak: !habit.isDoneToday
                        ? habit.streak + 1
                        : habit.streak - 1,
                  ));
              final _ =
                  await sl<HabitsRepository>().switchTodayActivity(id: id);
              if (context.mounted) {
                context.read<HabitsCubit>().getHabits();
              }
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Детали'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) => StatefulBuilder(
                          builder: (context, setModalState) {
                            return FormBuilder(
                              key: activityUpdateFormKey,
                              child: HabitFormScreen(
                                formKey: activityUpdateFormKey,
                                title: 'Обновление привычки',
                                enabled: isHabitDetailsEnabled,
                                titleController: titleController,
                                maxGapDaysController: maxGapDaysController,
                                errorMessage: activityUpdateFormErrorMessage,
                                onCancel: () {
                                  setState(() =>
                                      activityUpdateFormErrorMessage = null);
                                  Navigator.pop(context);
                                },
                                onConfirm: () async {
                                  setState(() =>
                                      activityUpdateFormErrorMessage = null);
                                  setModalState(
                                      () => isHabitDetailsEnabled = false);
                                  try {
                                    final updatedHabit =
                                        await sl<HabitsRepository>()
                                            .updateHabit(
                                      id: id,
                                      form: UpdateHabitDto(
                                        name: titleController.text,
                                        maxGapDays: int.parse(
                                            maxGapDaysController.text),
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
                                  } catch (e) {
                                    setState(() => activityUpdateFormErrorMessage =
                                        'Непредвиденная ошибка во время обновления привычки');
                                  }
                                },
                              ),
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
  DateTime today = DateTime.now().toUtc();
  DateTime date = DateTime.now().toUtc();
  int daysInMonth = 31;
  List<int> activityDays = [];

  void updateDate(DateTime newDate) async {
    setState(() {
      date = newDate.toUtc();
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
                    color: (((!isCurrentMonth ||
                                    isCurrentMonth &&
                                        index + 1 != today.day)) &&
                                activityDays.contains(index + 1)) ||
                            (isCurrentMonth &&
                                index + 1 == today.day &&
                                widget.isDoneToday)
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
