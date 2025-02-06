import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/usecase/usecase.dart';
import 'package:flutter_supabase/features/auth/domain/entities/user.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignup implements UseCase<User, UserSignupParams> {
  final AuthRepository authRepository;

  const UserSignup(this.authRepository);

  @override
  Future<Either<Failure, User>> call(UserSignupParams params) async {
    return await authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignupParams {
  final String name;
  final String email;
  final String password;

  UserSignupParams(
      {required this.name, required this.email, required this.password});
}
