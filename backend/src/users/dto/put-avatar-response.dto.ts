import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class PutAvatarImageResponseDto {
  @ApiProperty()
  @IsString()
  isUpdated: boolean;
}
