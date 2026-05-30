import 'package:flutter/material.dart';
import 'package:quickdeal/core/constants/app_colors.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text("Home Screen"),
      ),
    );
  }
}
