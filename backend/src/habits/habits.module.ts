import { Module } from '@nestjs/common';
import { HabitsService } from './habits.service';
import { HabitsController } from './habits.controller';
import { PrismaService } from '../prisma.service';
import { ActivitiesModule } from './activities/activities.module';

@Module({
  controllers: [HabitsController],
  providers: [HabitsService, PrismaService],
  imports: [ActivitiesModule],
})
export class HabitsModule {}
