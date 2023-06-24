import 'package:bake_store/main_screens/cstmr_home.dart';
import 'package:bake_store/main_screens/splier_home.dart';
import 'package:flutter/material.dart';

import 'main_screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
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
      },
    );
  }
}
