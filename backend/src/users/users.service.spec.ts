import { Test, TestingModule } from '@nestjs/testing';
import { UsersService } from './users.service';
import { PrismaService } from '../prisma.service';
import { DeepMockProxy, mockDeep } from 'jest-mock-extended';
import { PrismaClient, User } from '@prisma/client';
import { CreateUserDto } from './dto/create-user.dto';

describe('UsersService', () => {
  let service: UsersService;
  let prisma: DeepMockProxy<PrismaService>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [UsersService, PrismaService],
    })
      .overrideProvider(PrismaService)
      .useValue(mockDeep<PrismaClient>())
      .compile();

    service = module.get<UsersService>(UsersService);
    prisma = module.get(PrismaService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('should create user', async () => {
    const mockEmail = 'test@example.com';
    const mockUsername = 'testUser';
    const mockPasswordHash = 'Test_user_password_hash_1234';

    const mockCreateUserDto: CreateUserDto = {
      email: mockEmail,
      username: mockUsername,
      passwordHash: mockPasswordHash,
    };

    const mockUser: User = {
      id: 1,
      email: mockEmail,
      username: mockUsername,
      passwordHash: mockPasswordHash,
      isActive: true,
      createdAt: new Date(),
      updatedAt: new Date(),
      avatarKey: null,
      roles: [],
    };

    prisma.user.create.mockResolvedValue(mockUser);
    const createdUser = await service.create({
      data: mockCreateUserDto,
    });

    expect(createdUser).toEqual(mockUser);
    expect(prisma.user.create).toHaveBeenCalledWith({
      data: mockCreateUserDto,
    });
  });
});
