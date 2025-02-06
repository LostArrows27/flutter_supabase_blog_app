import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart'  ;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
      : _userSignup = userSignup,
        super(AuthInitial()) {
    on<AuthSignup>((event, emit) async {
      final res = await _userSignup(UserSignupParams(
          name: event.name, email: event.email, password: event.password));

      res.fold((l) => emit(AuthFailure(message: l.message)),
          (r) => emit(AuthSuccess(userId: r)));
    });
  }
}
