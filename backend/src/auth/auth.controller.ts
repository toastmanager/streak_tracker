import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Response,
  Request,
  UseGuards,
  UnauthorizedException,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { JwtAuthGuard } from './guards/jwt-auth.guard';
import { ApiBearerAuth, ApiOkResponse } from '@nestjs/swagger';
import { RegisterDto } from './dto/register.dto';
import { LoginDto } from './dto/login.dto';
import { UsersService } from 'src/users/users.service';
import { AuthToken } from './dto/auth-token.dto';
import { UserDto } from 'src/users/dto/user.dto';

const refreshTokenCookieOptions = {
  expires: new Date(new Date().getTime() + 30 * 24 * 60 * 60 * 1000), // Change according to refresh token expire time
  httpOnly: true,
  sameSite: 'strict',
};

@Controller('auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly usersService: UsersService,
  ) {}

  @Post('login')
  @ApiOkResponse({
    type: AuthToken,
  })
  async login(
    @Request() req,
    @Body() loginDto: LoginDto,
    @Response({ passthrough: true }) response: any,
  ) {
    const fullToken = await this.authService.login(loginDto);
    await this.setCookieRefreshToken(response, fullToken.refresh_token);
    return fullToken;
  }

  @Post('register')
  @ApiOkResponse({
    type: AuthToken,
  })
  async register(
    @Body() registerDto: RegisterDto,
    @Response({ passthrough: true }) response: any,
  ) {
    const fullToken = await this.authService.register(registerDto);
    await this.setCookieRefreshToken(response, fullToken.refresh_token);
    return fullToken;
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('logout')
  @ApiOkResponse({
    type: typeof {
      message: String,
    },
  })
  async logout(@Response({ passthrough: true }) response: any) {
    await this.clearCookieRefreshToken(response);
    return { message: 'successfully logged out' };
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @Post('me')
  @ApiOkResponse({
    type: UserDto,
  })
  async me(@Request() req: any) {
    const { user } = req;
    return await this.usersService.userWithRelatedData({
      user: await this.usersService.findUnique({
        where: {
          id: +user.sub,
        },
      }),
    });
  }

  @Post('refresh')
  @ApiOkResponse({
    type: AuthToken,
  })
  async refresh(
    @Request() req: any,
    @Response({
      passthrough: true,
    })
    response: any,
  ) {
    if (req.cookies) {
      const cookieRefreshToken = req.cookies['refresh_token'];
      if (cookieRefreshToken) {
        try {
          const newAuthToken =
            await this.authService.refreshFullToken(cookieRefreshToken);
          await this.setCookieRefreshToken(
            response,
            newAuthToken.refresh_token,
          );
          return newAuthToken;
        } catch (error) {
          this.clearCookieRefreshToken(response);
          throw error;
        }
      }
    }

    throw new UnauthorizedException('Refresh token не предоставлен');
  }

  async setCookieRefreshToken(@Response() response: any, refreshToken: string) {
    await response.cookie(
      'refresh_token',
      refreshToken,
      refreshTokenCookieOptions,
    );
  }

  async clearCookieRefreshToken(@Response() response: any) {
    await response.clearCookie('refresh_token', refreshTokenCookieOptions);
  }
}
