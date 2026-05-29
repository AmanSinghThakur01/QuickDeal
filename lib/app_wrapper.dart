import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/connectivity/connectivity_viewmodel.dart';

import 'views/no_internet/no_internet_screen.dart';

class AppWrapper extends StatelessWidget {
  final Widget child;

  const AppWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,

        Selector<ConnectivityViewModel, bool>(
          selector: (_, provider) => provider.isConnected,

          builder: (context, isConnected, _) {
            if (isConnected) {
              return const SizedBox();
            }

            return const NoInternetScreen();
          },
        ),
      ],
    );
  }
}
