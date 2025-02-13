import { ApiProperty } from '@nestjs/swagger';

export class MonthlyActivityDto {
  @ApiProperty({
    type: 'integer',
    isArray: true,
  })
  activity: number[];
}
