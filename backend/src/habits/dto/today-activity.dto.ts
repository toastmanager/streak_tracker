import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean } from 'class-validator';

export class TodayActivityDto {
  @ApiProperty()
  @IsBoolean()
  isDoneToday: boolean;
}
