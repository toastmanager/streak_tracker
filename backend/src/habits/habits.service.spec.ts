import { Test, TestingModule } from '@nestjs/testing';
import { HabitsService } from './habits.service';
import { PrismaService } from 'src/prisma.service';
import { HabitUtils } from './habits.utils';
import { ActivitiesModule } from './activities/activities.module';

describe('HabitsService', () => {
  let service: HabitsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [HabitsService, PrismaService, HabitUtils],
      imports: [ActivitiesModule],
    }).compile();

    service = module.get<HabitsService>(HabitsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
