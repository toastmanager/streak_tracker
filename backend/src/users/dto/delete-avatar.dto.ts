import { ApiProperty } from '@nestjs/swagger';

export class DeleteAvatarDto {
  @ApiProperty({ type: 'string', format: 'binary', required: true })
  file: Express.Multer.File;
}
