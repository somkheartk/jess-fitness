import { IsString, IsNotEmpty, IsNumber, IsBoolean, IsOptional } from 'class-validator';

export class CreateWorkoutDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  @IsString()
  @IsNotEmpty()
  description: string;

  @IsString()
  @IsNotEmpty()
  category: string;

  @IsNumber()
  @IsNotEmpty()
  duration: number;

  @IsNumber()
  @IsNotEmpty()
  exercises: number;

  @IsNumber()
  @IsNotEmpty()
  calories: number;

  @IsString()
  @IsOptional()
  userId?: string;
}

export class UpdateWorkoutDto {
  @IsString()
  @IsOptional()
  title?: string;

  @IsString()
  @IsOptional()
  description?: string;

  @IsString()
  @IsOptional()
  category?: string;

  @IsNumber()
  @IsOptional()
  duration?: number;

  @IsNumber()
  @IsOptional()
  exercises?: number;

  @IsNumber()
  @IsOptional()
  calories?: number;

  @IsBoolean()
  @IsOptional()
  isCompleted?: boolean;
}
