import {
  Controller,
  Get,
  Put,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Request,
  UseGuards,
  ForbiddenException,
  NotFoundException,
} from '@nestjs/common';
import { HabitsService } from './habits.service';
import { CreateHabitDto } from './dto/create-habit.dto';
import { UpdateHabitDto } from './dto/update-habit.dto';
import { Roles } from '../auth/decorators/roles.decorator';
import { Role } from '@prisma/client';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { ApiBearerAuth } from '@nestjs/swagger';
import { ActivitiesService } from './activities/activities.service';
import { HabitUtils } from './habits.utils';

@Controller('habits')
export class HabitsController {
  constructor(
    private readonly habitsService: HabitsService,
    private readonly activitiesService: ActivitiesService,
    private readonly habitUtils: HabitUtils,
  ) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async create(@Request() req: any, @Body() createHabitDto: CreateHabitDto) {
    const { user } = req;

    const habit = await this.habitsService.create({
      data: {
        ...createHabitDto,
        user: {
          connect: {
            id: +user.sub,
          },
        },
      },
    });

    return habit;
  }

  @Get()
  @Roles(Role.MODERATOR)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @ApiBearerAuth()
  async findAll() {
    const habits = await this.habitsService.findMany({
      orderBy: {
        createdAt: 'desc',
      },
    });

    return habits;
  }

  @Get('users/me')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async findReqUsersAll(@Request() req: any) {
    const { user } = req;

    const habits = await this.habitsService.findMany({
      where: {
        userId: +user.sub,
      },
    });

    return await this.habitUtils.getHabitsWithRelatedData(habits);
  }

  @Roles(Role.MODERATOR)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @ApiBearerAuth()
  @Get('users/:user_id')
  async findUsersAll(@Param('user_id') userId: string) {
    const habits = await this.habitsService.findMany({
      where: {
        userId: +userId,
      },
      include: {
        activities: true,
      },
    });
    return await this.habitUtils.getHabitsWithRelatedData(habits);
  }

  @Get(':id')
  async findOne(@Param('id') id: string) {
    const habit = await this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });

    const relatedData = await this.habitUtils.getRelatedData(habit);

    return { ...habit, ...relatedData };
  }

  @Patch(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async update(
    @Request() req: any,
    @Param('id') id: string,
    @Body() UpdateHabitDto: UpdateHabitDto,
  ) {
    const { user } = req;
    const habit = await this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });

    if (habit && habit.userId == +user.sub) {
      try {
        return this.habitsService.update({
          where: {
            id: +id,
          },
          data: UpdateHabitDto,
        });
      } catch (error) {
        throw new NotFoundException();
      }
    }

    throw new ForbiddenException();
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async remove(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const habit = await this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });

    if (habit && habit.userId == +user.sub) {
      try {
        return this.habitsService.remove({
          where: {
            id: +id,
          },
        });
      } catch (error) {
        throw new NotFoundException();
      }
    }
    throw new ForbiddenException();
  }

  @Get(':id/activities/:year/:month')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async getMonthActivity(
    @Request() req: any,
    @Param('id') id: string,
    @Param('year') year: string,
    @Param('month') month: string,
  ) {
    const activities = await this.activitiesService.findMany({
      where: {
        habitId: +id,
        year: +year,
        month: +month,
        isDisplayed: true,
      },
    });
    return activities.map((el) => el.day);
  }

  @Get(':id/activities')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async getActivity(@Request() req: any, @Param('id') id: string) {
    const activities = await this.activitiesService.findMany({
      where: {
        habitId: +id,
      },
    });
    return activities;
  }

  @Get(':id/activities/today')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async getTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const activity = await this.activitiesService.findUnique({
      where: {
        year_month_day_habitId: {
          day: today.getUTCDate(),
          month: today.getUTCMonth() + 1,
          year: today.getUTCFullYear(),
          habitId: +id,
        },
      },
    });

    return activity !== undefined;
  }

  @Post(':id/activities/today')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async addTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const _ = await this.activitiesService.create({
      data: {
        day: today.getUTCDate(),
        month: today.getUTCMonth() + 1,
        year: today.getUTCFullYear(),
        habit: {
          connect: {
            id: +id,
          },
        },
        user: {
          connect: {
            id: +user.sub,
          },
        },
      },
    });

    return;
  }

  @Delete(':id/activities/today')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async removeTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const _ = await this.activitiesService.remove({
      where: {
        year_month_day_habitId: {
          day: today.getUTCDate(),
          month: today.getUTCMonth() + 1,
          year: today.getUTCFullYear(),
          habitId: +id,
        },
      },
    });

    return;
  }

  @Put(':id/activities/today')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async switchTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const activity = await this.activitiesService.findUnique({
      where: {
        year_month_day_habitId: {
          day: today.getUTCDate(),
          month: today.getUTCMonth() + 1,
          year: today.getUTCFullYear(),
          habitId: +id,
        },
      },
    });

    if (!activity) {
      await this.activitiesService.create({
        data: {
          day: today.getUTCDate(),
          month: today.getUTCMonth() + 1,
          year: today.getUTCFullYear(),
          habit: {
            connect: {
              id: +id,
            },
          },
          user: {
            connect: {
              id: +user.sub,
            },
          },
        },
      });
      return true;
    } else {
      await this.activitiesService.remove({
        where: {
          year_month_day_habitId: {
            day: today.getUTCDate(),
            month: today.getUTCMonth() + 1,
            year: today.getUTCFullYear(),
            habitId: +id,
          },
        },
      });
      return false;
    }
  }
}
