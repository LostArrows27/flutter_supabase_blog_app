// abstract interface class
// -> subclass have to implement all method
import 'package:flutter_supabase/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Either<Failure, String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Either<Failure, String> loginWithEmailPassword({
    required String email,
    required String password,
  });
}
