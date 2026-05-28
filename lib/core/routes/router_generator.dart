

import 'package:flutter/material.dart';

import '../../views/auth/login_screen.dart';
import '../../views/auth/register_screen.dart';

// import '../../views/chat/chat_screen.dart';
// import '../../views/chat/message_screen.dart';
//
// import '../../views/favorite/favorite_screen.dart';
//
// import '../../views/home/home_screen.dart';
//
// import '../../views/no_internet/no_internet_screen.dart';
//
// import '../../views/product/add_product_screen.dart';
// import '../../views/product/edit_product_screen.dart';
// import '../../views/product/product_detail_screen.dart';
//
// import '../../views/profile/profile_screen.dart';

import '../../views/splash/splash_screen.dart';

import 'app_routes.dart';

class RouteGenerator {
static Route<dynamic> generateRoute(RouteSettings settings) {

switch (settings.name) {

// Splash
case AppRoutes.splash:
return MaterialPageRoute(
builder: (_) => const SplashScreen(),
);
//
// // Auth
// case AppRoutes.login:
// return MaterialPageRoute(
// builder: (_) => const LoginScreen(),
// );
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
builder: (_) => Scaffold(
body: Center(
child: Text(
"No Route Found: ${settings.name}",
),
),
),
);
}
}
}
