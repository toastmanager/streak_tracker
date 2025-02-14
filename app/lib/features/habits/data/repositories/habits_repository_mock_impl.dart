// import 'package:app/features/habits/domain/entities/habit.dart';
// import 'package:app/features/habits/domain/repositories/habits_repository.dart';
// import 'package:app/generated_code/rest_api.models.swagger.dart';
// // import 'package:injectable/injectable.dart';

// // @Singleton(as: HabitsRepository)
// class HabitsRepositoryMockImpl implements HabitsRepository {
//   final Map<int, Habit> activities = {
//     1: Habit(
//       id: 1,
//       name: "Тренироваться 30 минут",
//       maxGapDays: 2,
//       streak: 8,
//     ),
//     2: Habit(
//       id: 2,
//       name: "Прочесть 1 главу книги",
//       maxGapDays: 0,
//       streak: 0,
//     ),
//     3: Habit(
//       id: 3,
//       name: "Решить Leetcode daily",
//       maxGapDays: 0,
//       streak: 6,
//     ),
//   };
//   int lastId = 3;

//   @override
//   Future<void> deleteHabit({
//     required int id,
//   }) async {
//     await Future.delayed(Duration(seconds: 1));
//     activities.remove(id);
//   }

//   @override
//   Future<List<HabitDto>> getHabits() async {
//     await Future.delayed(Duration(seconds: 1));
//     return activities.values.toList();
//   }

//   @override
//   Future<HabitDto> getHabit({required int id}) async {
//     await Future.delayed(Duration(seconds: 1));
//     return activities[id]!;
//   }

//   @override
//   Future<List<int>> getMonthlyActivity({
//     required int id,
//     required int year,
//     required int month,
//   }) async {
//     await Future.delayed(Duration(seconds: 1));
//     return List.generate(5, (index) => index);
//   }

//   @override
//   Future<bool> switchTodayActivity({required int id}) async {
//     await Future.delayed(Duration(seconds: 1));
//     activities[id] =
//         activities[id]!.copyWith(isDoneToday: !activities[id]!.isDoneToday);
//     return activities[id]!.isDoneToday;
//   }

//   @override
//   Future<HabitDto> createHabit({required CreateHabitDto form}) async {
//     await Future.delayed(Duration(seconds: 1));
//     lastId++;
//     activities[lastId] = Habit(
//       id: lastId,
//       name: form.name,
//       maxGapDays: form.maxGapDays,
//     );
//     return activities[lastId]!;
//   }

//   @override
//   Future<HabitDto> updateHabit(
//       {required UpdateHabitDto form, required int id}) async {
//     activities[id] = Habit(
//         id: id,
//         name: form.name ?? activities[id]!.name,
//         maxGapDays: form.maxGapDays ?? activities[id]!.maxGapDays);
//     return activities[id]!;
//   }
// }
