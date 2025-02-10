import {
  Controller,
  Get,
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

@Controller('habits')
export class HabitsController {
  constructor(
    private readonly habitsService: HabitsService,
    private readonly activitiesService: ActivitiesService,
  ) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async create(@Request() req: any, @Body() createHabitDto: CreateHabitDto) {
    const { user } = req;

    return this.habitsService.create({
      data: {
        ...createHabitDto,
        user: {
          connect: {
            id: +user.sub,
          },
        },
      },
    });
  }

  @Get()
  @Roles(Role.MODERATOR)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @ApiBearerAuth()
  findAll() {
    return this.habitsService.findMany({
      orderBy: {
        createdAt: 'desc',
      },
    });
  }

  @Get('users/me')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  findReqUsersAll(@Request() req: any) {
    const { user } = req;

    return this.habitsService.findMany({
      where: {
        userId: +user.sub,
      },
    });
  }

  @Roles(Role.MODERATOR)
  @UseGuards(JwtAuthGuard, RolesGuard)
  @ApiBearerAuth()
  @Get('users/:user_id')
  findUsersAll(@Param('user_id') userId: string) {
    return this.habitsService.findMany({
      where: {
        userId: +userId,
      },
    });
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.habitsService.findUnique({
      where: {
        id: +id,
      },
    });
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

    if (habit && habit.userId == user.id) {
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

    if (habit && habit.userId == user.id) {
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
  // @UseGuards(JwtAuthGuard)
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
      },
    });
    return activities;
  }

  @Get(':id/activities')
  // @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async getActivity(@Request() req: any, @Param('id') id: string) {
    const activities = await this.activitiesService.findMany({
      where: {
        habitId: +id,
      },
    });
    return activities;
  }

  @Post(':id/activities')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async addTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const _ = await this.activitiesService.create({
      data: {
        day: today.getUTCDay(),
        month: today.getUTCMonth(),
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

  @Delete(':id/activities')
  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  async removeTodayActivtiy(@Request() req: any, @Param('id') id: string) {
    const { user } = req;
    const today = new Date();
    const _ = await this.activitiesService.remove({
      where: {
        year_month_day_habitId: {
          day: today.getUTCDay(),
          month: today.getUTCMonth(),
          year: today.getUTCFullYear(),
          habitId: +id,
        },
      },
    });
    return;
  }
}
