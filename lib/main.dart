import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_supabase/core/theme/theme.dart';
import 'package:flutter_supabase/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_supabase/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_supabase/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  runApp(MultiBlocProvider(
    providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
