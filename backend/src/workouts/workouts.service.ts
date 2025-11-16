import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Workout, WorkoutDocument } from './workout.schema';
import { CreateWorkoutDto, UpdateWorkoutDto } from './dto/workout.dto';

@Injectable()
export class WorkoutsService {
  constructor(
    @InjectModel(Workout.name) private workoutModel: Model<WorkoutDocument>,
  ) {}

  async create(createWorkoutDto: CreateWorkoutDto): Promise<Workout> {
    const createdWorkout = new this.workoutModel(createWorkoutDto);
    return createdWorkout.save();
  }

  async findAll(category?: string): Promise<Workout[]> {
    const filter = category ? { category } : {};
    return this.workoutModel.find(filter).exec();
  }

  async findOne(id: string): Promise<Workout> {
    const workout = await this.workoutModel.findById(id).exec();
    if (!workout) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
    return workout;
  }

  async update(id: string, updateWorkoutDto: UpdateWorkoutDto): Promise<Workout> {
    const updatedWorkout = await this.workoutModel
      .findByIdAndUpdate(id, updateWorkoutDto, { new: true })
      .exec();
    
    if (!updatedWorkout) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
    return updatedWorkout;
  }

  async complete(id: string): Promise<Workout> {
    const updatedWorkout = await this.workoutModel
      .findByIdAndUpdate(
        id,
        { isCompleted: true, completedAt: new Date() },
        { new: true }
      )
      .exec();
    
    if (!updatedWorkout) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
    return updatedWorkout;
  }

  async remove(id: string): Promise<void> {
    const result = await this.workoutModel.findByIdAndDelete(id).exec();
    if (!result) {
      throw new NotFoundException(`Workout with ID ${id} not found`);
    }
  }
}
