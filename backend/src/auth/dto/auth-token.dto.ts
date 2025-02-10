import { IsString } from 'class-validator';

export class AuthToken {
	@IsString()
	access_token: string;

	@IsString()
	refresh_token: string;

	@IsString()
	token_type: 'Bearer';
}
