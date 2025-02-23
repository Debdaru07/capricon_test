import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/constants.dart';
import '../providers/login_provider.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginProvider);
    final loginNotifier = ref.read(loginProvider.notifier);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    ref.listen<LoginState>(loginProvider, (previous, next) {
      log('State changed: isLoading=${next.isLoading}, authResponse=${next.authResponse != null}, error=${next.error}');
      if (next.authResponse != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppConstants.successSnackBar('Login successful! Welcome, ${next.authResponse!.user.fullName}'),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else if (next.error != null && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          AppConstants.errorSnackBar('Invalid credentials'),
        );
      }
    });

    return Theme(
      data: AppConstants.darkTheme,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Text(
                  'Illuminate',
                  style: AppConstants.headlineFont.copyWith(fontSize: 36),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email, color: AppConstants.accentGold),
                    labelStyle: AppConstants.bodyFont,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock, color: AppConstants.accentGold),
                    labelStyle: AppConstants.bodyFont,
                  ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Handle forgot password
                    },
                    child: Text(
                      'Forgot Password?',
                      style: AppConstants.bodyFont.copyWith(fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.paddingLarge),
                ElevatedButton(
                  onPressed: loginState.isLoading
                      ? null
                      : () {
                          loginNotifier.login(
                            emailController.text.trim(),
                            passwordController.text,
                          );
                        },
                  child: loginState.isLoading
                      ? const CircularProgressIndicator(color: AppConstants.primaryBackground)
                      : Text(
                          'Login',
                          style: AppConstants.buttonFont.copyWith(fontSize: 18),
                        ),
                ),
                const SizedBox(height: AppConstants.paddingMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppConstants.bodyFont.copyWith(fontSize: 14),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign-up screen
                      },
                      child: Text(
                        'Sign Up',
                        style: AppConstants.linkFont.copyWith(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}