import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/features/auth/domain/entities/user.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;

  AuthBloc({required UserSignup userSignup, required UserLogin userLogin})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
  }

  void _onAuthSignUp(AuthSignup event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignup(UserSignupParams(
        name: event.name, email: event.email, password: event.password));

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)));
  }
}
