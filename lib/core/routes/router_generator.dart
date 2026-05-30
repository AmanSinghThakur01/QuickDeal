

import 'package:flutter/material.dart';
import 'package:quickdeal/views/auth/login_screen.dart';
import 'package:quickdeal/views/auth/register_screen.dart';
import 'package:quickdeal/views/home/home_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
static Route<dynamic> generateRoute(RouteSettings settings) {

switch (settings.name) {


    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );
  case AppRoutes.register:
    return MaterialPageRoute(
      builder: (_) => const RegisterScreen(),
    );
//
case AppRoutes.home:
return MaterialPageRoute(
builder: (_) => const HomeScreen(),
);
//
// case AppRoutes.register:
// return MaterialPageRoute(
// builder: (_) => const RegisterScreen(),
// );
//
// // Home
// case AppRoutes.home:
// return MaterialPageRoute(
// builder: (_) => const HomeScreen(),
// );
//
// // Product
// case AppRoutes.addProduct:
// return MaterialPageRoute(
// builder: (_) => const AddProductScreen(),
// );
//
// case AppRoutes.productDetail:
// return MaterialPageRoute(
// builder: (_) => const ProductDetailScreen(),
// );
//
// case AppRoutes.editProduct:
// return MaterialPageRoute(
// builder: (_) => const EditProductScreen(),
// );
//
// // Favorite
// case AppRoutes.favorite:
// return MaterialPageRoute(
// builder: (_) => const FavoriteScreen(),
// );
//
// // Profile
// case AppRoutes.profile:
// return MaterialPageRoute(
// builder: (_) => const ProfileScreen(),
// );
//
// // Chat
// case AppRoutes.chat:
// return MaterialPageRoute(
// builder: (_) => const ChatScreen(),
// );
//
// case AppRoutes.message:
// return MaterialPageRoute(
// builder: (_) => const MessageScreen(),
// );
//
// // No Internet
// case AppRoutes.noInternet:
// return MaterialPageRoute(
// builder: (_) => const NoInternetScreen(),
// );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text("No Route Found")),
        ),
      );
  }
}
}