//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// import '../../core/routes/app_routes.dart';
//
// class SplashScreen extends StatefulWidget {
// const SplashScreen({super.key});
//
// @override
// State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//
// @override
// void initState() {
// super.initState();
//
// _initializeApp();
// }
//
// Future<void> _initializeApp() async {
//
// final startTime = DateTime.now();
//
// // Firebase/Auth check
// final user = FirebaseAuth.instance.currentUser;
//
// // Minimum splash duration
// final elapsed =
// DateTime.now().difference(startTime);
//
// if (elapsed < const Duration(seconds: 2)) {
//
// await Future.delayed(
// const Duration(seconds: 2) - elapsed,
// );
// }
//
// if (!mounted) return;
//
// Navigator.pushReplacementNamed(
// context,
// user != null
// ? AppRoutes.home
//     : AppRoutes.login,
// );
// }
//
// @override
// Widget build(BuildContext context) {
//
// return const Scaffold(
//
// backgroundColor: Color(0xFF2563EB),
//
// body: Center(
//
// child: Image(
// image: AssetImage(
// "assets/logo.png",
// ),
//
// width: 120,
// ),
// ),
// );
// }
// }