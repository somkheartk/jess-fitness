import { IsEmail, IsNotEmpty, IsString, IsOptional, IsObject } from 'class-validator';

export class CreateUserDto {
  @IsEmail()
  @IsNotEmpty()
  email: string;

  @IsString()
  @IsNotEmpty()
  password: string;

  @IsString()
  @IsNotEmpty()
  name: string;

  @IsString()
  @IsOptional()
  profileImage?: string;
}

export class UpdateUserDto {
  @IsString()
  @IsOptional()
  name?: string;

  @IsString()
  @IsOptional()
  profileImage?: string;

  @IsObject()
  @IsOptional()
  stats?: {
    workoutsCompleted?: number;
    activeDays?: number;
    totalCalories?: number;
  };
}
