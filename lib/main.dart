import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quickdeal/viewmodels/profile/profile_viewmodel.dart';

import 'firebase_options.dart';

import 'app_wrapper.dart';

import 'viewmodels/auth/auth_viewmodel.dart';
import 'viewmodels/connectivity/connectivity_viewmodel.dart';

import 'core/routes/router_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options:
    DefaultFirebaseOptions
        .currentPlatform,
  );

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key,
  });

  @override
  Widget build(
      BuildContext context,
      ) {

    return MultiProvider(

      providers: [

        ChangeNotifierProvider(
          create:
              (_) =>
              ConnectivityViewModel(),
        ),

        ChangeNotifierProvider(
          create:
              (_) =>
              AuthViewModel(),
        ),       ChangeNotifierProvider(
          create:
              (_) =>
              ProfileViewModel(),
        ),

      ],

      child: MaterialApp(

        debugShowCheckedModeBanner:
        false,

        title:
        "QuickDeal",

        onGenerateRoute:
        RouteGenerator
            .generateRoute,

        home:
        const AppWrapper(),

      ),

    );
  }
}