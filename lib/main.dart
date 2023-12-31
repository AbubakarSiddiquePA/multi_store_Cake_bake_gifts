import 'package:bake_store/auth/signup_cstmr.dart';
import 'package:bake_store/auth/splier_login.dart';
import 'package:bake_store/auth/splier_signup.dart';
import 'package:bake_store/main_screens/cstmr_home.dart';
import 'package:bake_store/main_screens/seller_login_screen.dart';
import 'package:bake_store/main_screens/splier_home.dart';
import 'package:bake_store/main_screens/user_log_screen.dart';
import 'package:bake_store/providers/cart_providers.dart';
import 'package:bake_store/providers/wish_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/login_cust.dart';
import 'main_screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => Cart(),
    ),
    ChangeNotifierProvider(
      create: (_) => Wish(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: WelcomeScreen(),
      initialRoute: "/welcome_screen",
      routes: {
        "/welcome_screen": (context) => const WelcomeScreen(),
        "/supplier_screen": (context) => const SupplierHomeScreen(),
        "/customer_screen": (context) => const CustomerHomeScreen(),
        "/customer_signup": (context) => const CustomerRegister(),
        "/customer_login": (context) => const CustomerLogin(),
        "/supplier_signup": (context) => const SupplierRegister(),
        "/supplier_login": (context) => const SupplierLogin(),
        "/Userscreen_login": (context) => const UserScreenLogin(),
        "/Sellerscreen_login": (context) => const SellerLoginScreen(),
      },
    );
  }
}
