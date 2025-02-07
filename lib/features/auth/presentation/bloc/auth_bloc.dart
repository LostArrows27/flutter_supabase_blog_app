import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/core/usecase/usecase.dart';
import 'package:flutter_supabase/features/auth/domain/entities/user.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;

  AuthBloc(
      {required UserSignup userSignup,
      required UserLogin userLogin,
      required CurrentUser currentUser})
      : _userSignup = userSignup,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignup>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_onAuthIsUserLoggedIn);
  }

  void _onAuthIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((l) => emit(AuthFailure(message: l.message)), (r) {
      emit(AuthSuccess(user: r));
    });
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
