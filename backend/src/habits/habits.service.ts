import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class HabitsService {
  constructor(private readonly prisma: PrismaService) {}

  async create(args?: Prisma.HabitCreateArgs) {
    const habit = await this.prisma.habit.create(args);
    return habit;
  }

  async findMany(args?: Prisma.HabitFindManyArgs) {
    const habits = await this.prisma.habit.findMany(args);
    return habits;
  }

  async findFirst(args?: Prisma.HabitFindFirstArgs) {
    const habit = await this.prisma.habit.findFirst(args);
    return habit;
  }

  async findUnique(args?: Prisma.HabitFindUniqueArgs) {
    const habit = await this.prisma.habit.findUnique(args);
    return habit;
  }

  async update(args?: Prisma.HabitUpdateArgs) {
    const habit = await this.prisma.habit.update(args);
    return habit;
  }

  async remove(args?: Prisma.HabitDeleteArgs) {
    const habit = await this.prisma.habit.delete(args);
    return habit;
  }
}
