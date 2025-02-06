import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/error/server_exception.dart';
import 'package:flutter_supabase/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_supabase/features/auth/data/models/user_model.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword(
      {required String email, required String password}) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final user = await remoteDataSource.signUpWithEmailAndPassword(
          name: name, email: email, password: password);
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
