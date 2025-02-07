import 'package:flutter_supabase/core/error/failure.dart';
import 'package:flutter_supabase/core/error/server_exception.dart';
import 'package:flutter_supabase/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_supabase/core/common/entities/user.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  const AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    return _getUser(() async => await remoteDataSource
        .loginWithEmailAndPassword(email: email, password: password));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(() async =>
        await remoteDataSource.signUpWithEmailAndPassword(
            name: name, email: email, password: password));
  }

  Future<Either<Failure, User>> _getUser(Future<User> Function() fn) async {
    try {
      final user = await fn();

      return right(user);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final userData = await remoteDataSource.getCurrentUserData();

      if (userData == null) {
        return left(Failure('User is not logged in.'));
      }

      return right(userData);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
