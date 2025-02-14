import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsInt } from 'class-validator';
import { HabitDto } from './habit.dto';

export class HabitDetailsDto extends HabitDto {
  @ApiProperty({
    type: 'integer',
  })
  @IsInt()
  streak: number;

  @ApiProperty()
  @IsBoolean()
  isDoneToday: boolean;
}
