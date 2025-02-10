import {
	Request,
	Controller,
	Get,
	Post,
	Body,
	Patch,
	Param,
	Delete,
	UseGuards,
	ForbiddenException,
	NotFoundException,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { Roles } from 'src/auth/decorators/roles.decorator';
import { Role, User } from '@prisma/client';
import { RolesGuard } from 'src/auth/guards/roles.guard';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { ApiBearerAuth } from '@nestjs/swagger';
import { RoleDto } from './dto/role.dto';

@Controller('users')
export class UsersController {
	constructor(private readonly usersService: UsersService) {}

	@Post()
	@Roles(Role.MODERATOR)
	@UseGuards(JwtAuthGuard, RolesGuard)
	@ApiBearerAuth()
	create(@Body() createUserDto: CreateUserDto) {
		return this.usersService.create({
			data: createUserDto,
		});
	}

	@Get()
	@Roles(Role.MODERATOR)
	@UseGuards(JwtAuthGuard, RolesGuard)
	@ApiBearerAuth()
	findAll() {
		return this.usersService.findMany({
			orderBy: {
				createdAt: 'desc',
			},
		});
	}

	@Get(':id')
	findOne(@Param('id') id: string) {
		return this.usersService.findUnique({
			where: {
				id: +id,
			},
		});
	}

	@Patch(':id')
	@UseGuards(JwtAuthGuard)
	@ApiBearerAuth()
	async update(
		@Request() req: any,
		@Param('id') id: string,
		@Body() updateUserDto: UpdateUserDto,
	) {
		const { user } = req;
		if (
			user.sub == id ||
			(await this.usersService.checkUserRolesExistence(
				[Role.MODERATOR],
				+user.sub,
			))
		) {
			try {
				return this.usersService.update({
					where: {
						id: +id,
					},
					data: updateUserDto,
				});
			} catch (error) {
				throw new NotFoundException();
			}
		}
		throw new ForbiddenException();
	}

	@Delete(':id')
	@UseGuards(JwtAuthGuard)
	@ApiBearerAuth()
	async remove(@Request() req: any, @Param('id') id: string) {
		const { user } = req;
		if (
			user.sub == id ||
			(await this.usersService.checkUserRolesExistence(
				[Role.MODERATOR],
				+user.sub,
			))
		) {
			try {
				return this.usersService.remove({
					where: {
						id: +id,
					},
				});
			} catch (error) {
				throw new NotFoundException();
			}
		}
		throw new ForbiddenException();
	}

	@Post(':id/roles')
	@ApiBearerAuth()
	@Roles(Role.MODERATOR)
	@UseGuards(JwtAuthGuard, RolesGuard)
	async giveRole(
		@Param('id') id: string,
		@Body() roleDto: RoleDto,
	): Promise<User> {
		const user = await this.usersService.findFirst({
			where: {
				id: +id,
			},
		});

		if (!user) {
			throw new NotFoundException('User not found');
		}

		const result = await this.usersService.giveRole({
			where: {
				id: +id,
			},
			role: roleDto.role,
		});

		return result;
	}

	@Delete(':id/roles')
	@ApiBearerAuth()
	@Roles(Role.MODERATOR)
	@UseGuards(JwtAuthGuard, RolesGuard)
	async removeRole(
		@Param('id') id: string,
		@Body() roleDto: RoleDto,
	): Promise<User> {
		const user = await this.usersService.findFirst({
			where: {
				id: +id,
			},
		});

		if (!user) {
			throw new NotFoundException('User not found');
		}

		const result = await this.usersService.removeRole({
			where: {
				id: +id,
			},
			role: roleDto.role,
		});

		return result;
	}

	@Get(':id/roles')
	@ApiBearerAuth()
	@UseGuards(JwtAuthGuard)
	async getRoles(
		@Request() req: any,
		@Param('id') id: string,
	): Promise<Role[]> {
		const { user: currentUser } = req;

		if (currentUser.id !== id && !currentUser.roles?.includes(Role.MODERATOR)) {
			throw new ForbiddenException(
				'You do not have permissions to get this user roles',
			);
		}

		const user = await this.usersService.findFirst({
			where: {
				id: +id,
			},
		});

		if (!user) {
			throw new NotFoundException('User not found');
		}

		return user.roles;
	}
}
