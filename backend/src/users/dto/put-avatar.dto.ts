import { ApiProperty } from '@nestjs/swagger';

export class PutAvatarDto {
  @ApiProperty({ type: 'string', format: 'binary', required: true })
  file: Express.Multer.File;
}
