import 'package:flutter_supabase/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:flutter_supabase/core/secret/app_secret.dart';
import 'package:flutter_supabase/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_supabase/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_supabase/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_supabase/features/auth/domain/usecases/user_signup.dart';
import 'package:flutter_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_supabase/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:flutter_supabase/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:flutter_supabase/features/blog/domain/repositories/blog_repository.dart';
import 'package:flutter_supabase/features/blog/domain/usecases/get_all_blog.dart';
import 'package:flutter_supabase/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter_supabase/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabaseAnonKey);

  // 1 instance everytime called
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth() {
  // new instance everytime called
  serviceLocator
    // data source
    ..registerFactory<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(serviceLocator()))
    // repository
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl(serviceLocator()))
    // use case
    ..registerFactory(() => UserSignup(serviceLocator()))
    ..registerFactory(() => UserLogin(serviceLocator()))
    ..registerFactory(() => CurrentUser(serviceLocator()))
    // bloc
    ..registerLazySingleton(() => AuthBloc(
        userSignup: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator()));
}

void _initBlog() {
  // Datasource
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlog(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () =>
          BlogBloc(uploadBlog: serviceLocator(), getAllBlog: serviceLocator()),
    );
}
