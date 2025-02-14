import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsString } from 'class-validator';

export class CreateHabitDto {
  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty({
    type: 'integer',
  })
  @IsInt()
  maxGapDays: number;
}
