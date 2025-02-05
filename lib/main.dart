import 'package:flutter/material.dart';
import 'package:flutter_supabase/core/secret/app_secret.dart';
import 'package:flutter_supabase/core/theme/theme.dart';
import 'package:flutter_supabase/features/auth/presentation/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabaseAnonKey);
  runApp(const MyApp());
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
