import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/usecase/usecase.dart';
import 'package:flutter_supabase/features/auth/domain/entities/user.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  const CurrentUser(this.authRepository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return authRepository.getCurrentUser();
  }
}
