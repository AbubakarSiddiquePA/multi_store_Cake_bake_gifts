import 'package:bake_store/main_screens/cart.dart';
import 'package:bake_store/main_screens/category.dart';
import 'package:bake_store/main_screens/home.dart';
import 'package:bake_store/main_screens/profile.dart';
import 'package:bake_store/main_screens/stores.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';

import '../providers/cart_providers.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = [
    const HomeScreen(),
    const CategoryScreen(),
    const StoresScreen(),
    const CartScreen(),
    ProfileScreen(documentId: FirebaseAuth.instance.currentUser!.uid),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        // elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedItemColor: Colors.black,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Category"),
          const BottomNavigationBarItem(
              icon: Icon(Icons.store), label: "Stores"),
          BottomNavigationBarItem(
            // icon: Icon(Icons.shopping_cart),

            icon: badges.Badge(
              showBadge: context.read<Cart>().getItems.isEmpty ? false : true,
              // stackFit: StackFit.expand,
              badgeStyle: const badges.BadgeStyle(badgeColor: Colors.yellow),
              badgeContent: Text(
                context.watch<Cart>().getItems.length.toString(),
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              child: const Icon(Icons.shopping_cart),
            ),
            label: "Cart",
          ),
          const BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Profile"),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
