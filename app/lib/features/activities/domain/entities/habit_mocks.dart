import 'package:app/features/activities/domain/entities/habit.dart';

final List<Habit> mockActivities = [
  Habit(
    id: 1,
    name: "Тренироваться 30 минут",
    maxGapDays: 2,
    streak: 8,
  ),
  Habit(
    id: 2,
    name: "Прочесть 1 главу книги",
    maxGapDays: 0,
    streak: 0,
  ),
  Habit(
    id: 3,
    name: "Решить Leetcode daily",
    maxGapDays: 0,
    streak: 6,
  ),
];
