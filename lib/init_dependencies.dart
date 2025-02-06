import 'package:flutter_supabase/core/secret/app_secret.dart';
import 'package:flutter_supabase/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_supabase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabaseAnonKey);

  // 1 instance everytime called
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
}

void _initAuth() {
  // new instance everytime called
  serviceLocator.registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()));

  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));

  serviceLocator.registerFactory(() => UserSignup(serviceLocator()));

  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerLazySingleton(() =>
      AuthBloc(userSignup: serviceLocator(), userLogin: serviceLocator()));
}
