import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
const SplashScreen({super.key});

@override
State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

@override
void initState() {
super.initState();

_navigateToNextScreen();
}

void _navigateToNextScreen() {

Timer(
const Duration(seconds: 3),

() {
Navigator.pushReplacementNamed(
context,
AppRoutes.login,
);
},
);
}

@override
Widget build(BuildContext context) {

return Scaffold(
body: Container(
width: double.infinity,

decoration: const BoxDecoration(
gradient: LinearGradient(
colors: [
Color(0xFF2563EB),
Color(0xFF1E40AF),
],

begin: Alignment.topLeft,
end: Alignment.bottomRight,
),
),

child: const Column(
mainAxisAlignment: MainAxisAlignment.center,

children: [

Icon(
Icons.shopping_bag_rounded,
size: 90,
color: Colors.white,
),

SizedBox(height: 20),

Text(
"QuickDeal",

style: TextStyle(
fontSize: 32,
fontWeight: FontWeight.bold,
color: Colors.white,
letterSpacing: 1,
),
),

SizedBox(height: 10),

Text(
"Buy & Sell Easily",

style: TextStyle(
fontSize: 16,
color: Colors.white70,
),
),

SizedBox(height: 40),

CircularProgressIndicator(
color: Colors.white,
),
],
),
),
);
}
}

