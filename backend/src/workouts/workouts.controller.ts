import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
  Query,
  UseGuards,
  ValidationPipe,
} from '@nestjs/common';
import { WorkoutsService } from './workouts.service';
import { CreateWorkoutDto, UpdateWorkoutDto } from './dto/workout.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@Controller('api/workouts')
@UseGuards(JwtAuthGuard)
export class WorkoutsController {
  constructor(private readonly workoutsService: WorkoutsService) {}

  @Post()
  create(@Body(ValidationPipe) createWorkoutDto: CreateWorkoutDto) {
    return this.workoutsService.create(createWorkoutDto);
  }

  @Get()
  findAll(@Query('category') category?: string) {
    return this.workoutsService.findAll(category).then(workouts => ({
      data: workouts,
    }));
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.workoutsService.findOne(id);
  }

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body(ValidationPipe) updateWorkoutDto: UpdateWorkoutDto,
  ) {
    return this.workoutsService.update(id, updateWorkoutDto);
  }

  @Patch(':id/complete')
  complete(@Param('id') id: string) {
    return this.workoutsService.complete(id);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.workoutsService.remove(id);
  }
}
