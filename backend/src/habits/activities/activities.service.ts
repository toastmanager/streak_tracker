import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';
import { Prisma } from '@prisma/client';

@Injectable()
export class ActivitiesService {
  constructor(private readonly prisma: PrismaService) {}

  async create(args?: Prisma.ActivityCreateArgs) {
    const activity = await this.prisma.activity.create(args);
    return activity;
  }

  async findMany(args?: Prisma.ActivityFindManyArgs) {
    const activitys = await this.prisma.activity.findMany(args);
    return activitys;
  }

  async findFirst(args?: Prisma.ActivityFindFirstArgs) {
    const activity = await this.prisma.activity.findFirst(args);
    return activity;
  }

  async findUnique(args?: Prisma.ActivityFindUniqueArgs) {
    const activity = await this.prisma.activity.findUnique(args);
    return activity;
  }

  async update(args?: Prisma.ActivityUpdateArgs) {
    const activity = await this.prisma.activity.update(args);
    return activity;
  }

  async remove(args?: Prisma.ActivityDeleteArgs) {
    const activity = await this.prisma.activity.delete(args);
    return activity;
  }
}
