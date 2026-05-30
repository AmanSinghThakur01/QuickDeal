import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/auth/auth_viewmodel.dart';
import 'viewmodels/connectivity/connectivity_viewmodel.dart';

import 'views/auth/login_screen.dart';
import 'views/home/home_screen.dart';
import 'views/no_internet/no_internet_screen.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthViewModel, ConnectivityViewModel>(
      builder: (context, auth, connectivity, _) {

        final isLoggedIn = auth.isLoggedIn;

        return Stack(
          children: [
            // ✅ Main screen logic (UNCHANGED LOGIC)
            isLoggedIn ? const HomeScreen() : const LoginScreen(),

            // ✅ Safe overlay (no crash)
            if (!connectivity.isConnected)
              const NoInternetScreen(),

            // optional child (safe usage)
            child,
          ],
        );
      },
    );
  }
}