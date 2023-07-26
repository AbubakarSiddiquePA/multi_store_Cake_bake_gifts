import 'package:bake_store/main_screens/category.dart';
import 'package:bake_store/main_screens/dashboard.dart';
import 'package:bake_store/main_screens/home.dart';
import 'package:bake_store/main_screens/stores.dart';
import 'package:bake_store/main_screens/upload_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart ' as badges;

class SupplierHomeScreen extends StatefulWidget {
  const SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _tabs = const [
    HomeScreen(),
    CategoryScreen(),
    StoresScreen(),
    DashboardScreen(),
    UploadProductScreen(),

    // CartScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .where("sid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("deliverystatus", isEqualTo: "preparing")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        return Scaffold(
          body: _tabs[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            // elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            selectedItemColor: Colors.black,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Home"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "Category"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.store), label: "Stores"),
              BottomNavigationBarItem(
                  icon: badges.Badge(
                      showBadge: snapshot.data!.docs.isEmpty ? false : true,
                      // stackFit: StackFit.expand,
                      badgeStyle:
                          const badges.BadgeStyle(badgeColor: Colors.yellow),
                      badgeContent: Text(
                        snapshot.data!.docs.length.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      child: const Icon(Icons.dashboard)),
                  label: "Dashboard"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.upload), label: "Upload"),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
