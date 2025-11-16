import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type ExerciseDocument = Exercise & Document;

@Schema({ timestamps: true })
export class Exercise {
  @Prop({ required: true })
  name: string;

  @Prop({ required: true })
  description: string;

  @Prop({ required: true })
  category: string;

  @Prop({ required: true, default: 'Beginner' })
  difficulty: string;

  @Prop()
  imageUrl?: string;

  @Prop()
  duration?: number;

  @Prop()
  sets?: number;

  @Prop()
  reps?: number;
}

export const ExerciseSchema = SchemaFactory.createForClass(Exercise);
