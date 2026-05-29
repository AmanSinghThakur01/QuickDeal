import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:provider/provider.dart';

import 'app_wrapper.dart';

import 'core/routes/app_routes.dart';
import 'core/routes/router_generator.dart';

import 'firebase_options.dart';

import 'viewmodels/connectivity/connectivity_viewmodel.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FlutterNativeSplash.remove();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectivityViewModel()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "QuickDeal",
        initialRoute: AppRoutes.login,
        onGenerateRoute: RouteGenerator.generateRoute,
        builder: (context, child) {
          return AppWrapper(child: child!);
        },
      ),
    );
  }
}
