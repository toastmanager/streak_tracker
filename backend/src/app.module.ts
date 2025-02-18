import { Module } from '@nestjs/common';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { ConfigifyModule } from '@itgorillaz/configify';
import { HabitsModule } from './habits/habits.module';

@Module({
  imports: [
    ConfigifyModule.forRootAsync(),
    UsersModule,
    AuthModule,
    HabitsModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
