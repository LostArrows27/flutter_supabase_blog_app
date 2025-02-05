import 'package:flutter/material.dart';
import 'package:flutter_supabase/core/theme/app_pallete.dart';
import 'package:flutter_supabase/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_supabase/features/auth/presentation/widget/auth_field.dart';
import 'package:flutter_supabase/features/auth/presentation/widget/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static route() => MaterialPageRoute(builder: (context) => LoginPage());

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              AuthField(
                placeholder: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              AuthField(
                placeholder: 'Password',
                controller: passwordController,
                visiblePassword: true,
              ),
              const SizedBox(height: 30),
              AuthGradientButton(),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                      text: "Don't have an account? ",
                      children: [
                        TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold))
                      ],
                      style: Theme.of(context).textTheme.titleMedium),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
