import { Injectable, NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { Prisma, Role, User } from '@prisma/client';

@Injectable()
export class UsersService {
	constructor(private readonly prisma: PrismaService) {}

	async create(args?: Prisma.UserCreateArgs) {
		const user = await this.prisma.user.create(args);
		return user;
	}

	async findMany(args?: Prisma.UserFindManyArgs) {
		const users = await this.prisma.user.findMany(args);
		return users;
	}

	async findFirst(args?: Prisma.UserFindFirstArgs) {
		const user = await this.prisma.user.findFirst(args);
		return user;
	}

	async findUnique(args?: Prisma.UserFindUniqueArgs) {
		const user = await this.prisma.user.findUnique(args);
		return user;
	}

	async update(args?: Prisma.UserUpdateArgs) {
		const user = await this.prisma.user.update(args);
		return user;
	}

	async remove(args?: Prisma.UserDeleteArgs) {
		const user = await this.prisma.user.delete(args);
		return user;
	}

	async checkUserRolesExistence(roles: Role[], id: number): Promise<boolean> {
		const user = await this.findUnique({
			where: {
				id: id,
			},
		});

		if (roles.some((role) => user.roles?.includes(role))) {
			return true;
		}

		return false;
	}

	async giveRole(params: {
		where: Prisma.UserWhereUniqueInput;
		role: Role;
	}): Promise<User> {
		const user = await this.prisma.user.update({
			where: params.where,
			data: {
				roles: {
					push: params.role,
				},
			},
		});
		return user;
	}

	async removeRole(params: {
		where: Prisma.UserWhereUniqueInput;
		role: Role;
	}): Promise<User> {
		const user = await this.findFirst({
			where: params.where,
		});

		const roleIndex = user.roles.indexOf(params.role);
		if (roleIndex === -1) {
			throw new NotFoundException('the user does not have this role');
		}

		const newRoles = user.roles.splice(roleIndex, 1);
		const result = await this.prisma.user.update({
			where: params.where,
			data: {
				roles: {
					set: newRoles,
				},
			},
		});
		return result;
	}
}
