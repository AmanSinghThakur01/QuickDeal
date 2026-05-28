import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickdeal/core/routes/app_routes.dart';
import 'package:quickdeal/core/routes/router_generator.dart';
import 'package:quickdeal/firebase_options.dart';
import 'package:quickdeal/main.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
      ChangeNotifierProvider(create: (_) =>null),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "QuickDeal",
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    ),
    );
  }
}
