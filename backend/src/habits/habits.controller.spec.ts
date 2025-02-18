import { Test, TestingModule } from '@nestjs/testing';
import { HabitsController } from './habits.controller';
import { HabitsService } from './habits.service';
import { HabitUtils } from './habits.utils';
import { PrismaService } from 'src/prisma.service';
import { ActivitiesModule } from './activities/activities.module';

describe('HabitsController', () => {
  let controller: HabitsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [HabitsController],
      providers: [HabitsService, PrismaService, HabitUtils],
      imports: [ActivitiesModule],
    }).compile();

    controller = module.get<HabitsController>(HabitsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
