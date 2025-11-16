import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import { LoginDto, RegisterDto } from './dto/auth.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async register(registerDto: RegisterDto) {
    const user: any = await this.usersService.create(registerDto);
    const payload = { email: user.email, sub: user._id || user.id };
    
    return {
      token: this.jwtService.sign(payload),
      userId: user._id || user.id,
      user: {
        id: user._id || user.id,
        email: user.email,
        name: user.name,
      },
    };
  }

  async login(loginDto: LoginDto) {
    const user: any = await this.usersService.findByEmail(loginDto.email);
    
    if (!user) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const isPasswordValid = await bcrypt.compare(loginDto.password, user.password);
    
    if (!isPasswordValid) {
      throw new UnauthorizedException('Invalid credentials');
    }

    const payload = { email: user.email, sub: user._id || user.id };
    
    return {
      token: this.jwtService.sign(payload),
      userId: user._id || user.id,
      user: {
        id: user._id || user.id,
        email: user.email,
        name: user.name,
      },
    };
  }

  async validateUser(payload: any) {
    return this.usersService.findByEmail(payload.email);
  }
}
