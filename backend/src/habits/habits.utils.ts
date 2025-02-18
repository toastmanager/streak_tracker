import { Injectable } from '@nestjs/common';
import { ActivitiesService } from './activities/activities.service';
import { getDateDifferenceInDays } from 'src/core.utils';
import { Habit } from '@prisma/client';
import { HabitDetailsDto } from './dto/habit-details.dto';

@Injectable()
export class HabitUtils {
  constructor(private readonly activitiesService: ActivitiesService) {}

  async getRelatedData(habit: Habit) {
    const activities = await this.activitiesService.findMany({
      where: {
        habitId: habit.id,
      },
      orderBy: {
        date: 'desc',
      },
    });

    let streak = 0;
    let isDoneToday = false;
    let prevDate = new Date();
    if (
      activities.length > 0 &&
      getDateDifferenceInDays(new Date(), activities[0].date) == 0
    ) {
      isDoneToday = true;
    }
    for (const activity of activities) {
      if (
        getDateDifferenceInDays(prevDate, activity.date) >
        habit.maxGapDays + 1
      ) {
        break;
      }
      prevDate = activity.date;
      streak++;
    }

    return { streak: streak, isDoneToday: isDoneToday };
  }

  async getHabitsWithRelatedData(habits: Habit[]) {
    const updatedHabits: HabitDetailsDto[] = [];
    for (const habit of habits) {
      updatedHabits.push({
        ...habit,
        ...(await this.getRelatedData(habit)),
      });
    }
    return updatedHabits.sort((a, b) => b.streak - a.streak);
  }
}
