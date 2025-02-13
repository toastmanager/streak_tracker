import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsInt, IsISO8601, IsString } from 'class-validator';

export class HabitDto {
  @ApiProperty({
    type: 'integer',
  })
  @IsInt()
  id: number;

  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty({
    type: 'integer',
  })
  @IsInt()
  maxGapDays: number;

  @ApiProperty({
    type: 'integer',
  })
  @IsInt()
  streak: number;

  @ApiProperty()
  @IsBoolean()
  isDoneToday: boolean;

  @ApiProperty()
  @IsISO8601()
  createdAt: Date;

  @ApiProperty()
  @IsISO8601()
  updatedAt: Date;
}
