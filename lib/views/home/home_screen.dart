import 'package:flutter/material.dart';
import 'package:quickdeal/core/constants/app_colors.dart';
import 'package:quickdeal/core/routes/app_routes.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Home Screen"),
        actions: [
          IconButton(

            onPressed: () {
print(" print :  rprofile clicckkkkkkkkkkkkk");
              Navigator.pushNamed(
                context,
                AppRoutes.profile,
              );

            },

            icon: const Icon(
              Icons.person,
            ),

          )
        ],
      ),
    );
  }
}
