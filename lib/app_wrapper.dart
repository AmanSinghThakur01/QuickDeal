import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/auth/auth_viewmodel.dart';
import 'viewmodels/connectivity/connectivity_viewmodel.dart';

import 'views/auth/login_screen.dart';
import 'views/bottom_nav/bottom_nav_screen.dart';
import 'views/no_internet/no_internet_screen.dart';

class AppWrapper
    extends StatelessWidget {

  const AppWrapper({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {

    return Consumer2<
        AuthViewModel,
        ConnectivityViewModel>(

      builder:

          (
          context,
          auth,
          connectivity,
          _
          ) {

        return Stack(

          children: [

            auth.isLoggedIn
                ? const BottomNavScreen()
                : const LoginScreen(),

            if (
            !connectivity
                .isConnected
            )

              const NoInternetScreen(),

          ],

        );

      },

    );
  }
}