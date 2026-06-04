import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_colors.dart';
import '../../viewmodels/auth/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              /// App Title
              const Text(
                "QuickDeal",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Login to continue",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondary,
                ),
              ),

              const SizedBox(height: 50),

              authVM.isLoading
                  ? const CircularProgressIndicator(
                color: AppColors.primary,
              )
                  : CustomButton(
                text: "Continue with Google",
                icon: Icons.g_mobiledata,
                isLoading: authVM.isLoading,
                onPressed: () async {
                  await authVM.signInWithGoogle();

                  if (authVM.isLoggedIn && context.mounted) {
                    Navigator.pushReplacementNamed(
                      context,
                      '/home',
                    );
                  }
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "By continuing, you agree to our Terms & Privacy Policy",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondary,
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}