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
import { Roles } from 'src/auth/decorators/roles.decorator';
import { Role } from '@prisma/client';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { ApiBearerAuth, ApiOkResponse } from '@nestjs/swagger';
import { ActivitiesService } from './activities/activities.service';
import { HabitUtils } from './habits.utils';
import { HabitDto } from './dto/habit.dto';
import { TodayActivityDto } from './dto/today-activity.dto';
import { MonthlyActivityDto } from './dto/monthly-activity.dto';
import { HabitDetailsDto } from './dto/habit-details.dto';

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
  @ApiOkResponse({
    type: HabitDto,
  })
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
  @ApiOkResponse({
    type: HabitDto,
    isArray: true,
  })
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
  @ApiOkResponse({
    type: HabitDetailsDto,
    isArray: true,
  })
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
  @ApiOkResponse({
    type: HabitDetailsDto,
    isArray: true,
  })
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
  @ApiOkResponse({
    type: HabitDetailsDto,
  })
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
  @ApiOkResponse({
    type: HabitDetailsDto,
  })
  async update(
    @Request() req: any,
    @Param('id') id: string,
    @Body() UpdateHabitDto: UpdateHabitDto,
  ): Promise<HabitDetailsDto> {
    const { user } = req;
    const habit = await this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });

    if (habit && habit.userId == +user.sub) {
      try {
        const updatedHabit = await this.habitsService.update({
          where: {
            id: +id,
          },
          data: UpdateHabitDto,
        });
        const relatedData = await this.habitUtils.getRelatedData(updatedHabit);
        return {
          ...updatedHabit,
          ...relatedData,
        };
      } catch (error) {
        throw new NotFoundException();
      }
    }

    throw new ForbiddenException();
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOkResponse({
    type: HabitDto,
  })
  async remove(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const habit = await this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });

    if (habit && habit.userId == +user.sub) {
      try {
        const removedHabit = await this.habitsService.remove({
          where: {
            id: +id,
          },
        });
        return removedHabit;
      } catch (error) {
        throw new NotFoundException();
      }
    }
    throw new ForbiddenException();
  }

  @Get(':id/activities/:year/:month')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOkResponse({
    type: MonthlyActivityDto,
  })
  async getMonthActivity(
    @Request() req: any,
    @Param('id') id: string,
    @Param('year') year: string,
    @Param('month') month: string,
  ): Promise<MonthlyActivityDto> {
    const activities = await this.activitiesService.findMany({
      where: {
        habitId: +id,
        date: {
          gte: new Date(+year, +month - 1),
          lt: new Date(+year, +month),
        },
        isDisplayed: true,
      },
    });
    return {
      activity: activities.map((el) => el.date.getUTCDate()),
    };
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
    const activity = await this.activitiesService.findFirst({
      where: {
        date: {
          gte: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate(),
          ),
          lt: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate() + 1,
          ),
        },
        habitId: +id,
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
        date: today,
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
    const activity = await this.activitiesService.findFirst({
      where: {
        date: {
          gte: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate(),
          ),
          lt: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate() + 1,
          ),
        },
        habitId: +id,
      },
      select: {
        id: true,
      },
    });
    const _ = await this.activitiesService.remove({
      where: {
        id: activity.id,
      },
    });

    return;
  }

  @Put(':id/activities/today')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOkResponse({
    type: TodayActivityDto,
  })
  async switchTodayActivtiy(
    @Request() req: any,
    @Param('id') id: string,
  ): Promise<TodayActivityDto> {
    const { user } = req;
    const today = new Date();
    const activity = await this.activitiesService.findFirst({
      where: {
        date: {
          gte: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate(),
          ),
          lt: new Date(
            today.getUTCFullYear(),
            today.getUTCMonth(),
            today.getUTCDate() + 1,
          ),
        },
        habitId: +id,
      },
    });

    if (!activity) {
      await this.addTodayActivtiy(req, id);
      return {
        isDoneToday: true,
      };
    } else {
      await this.removeTodayActivtiy(req, id);
      return {
        isDoneToday: false,
      };
    }
  }
}
