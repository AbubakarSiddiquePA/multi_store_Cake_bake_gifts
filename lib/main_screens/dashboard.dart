import 'package:bake_store/dashboard_components/balance.dart';
import 'package:bake_store/dashboard_components/manage_products.dart';
import 'package:bake_store/dashboard_components/splier_ordrs.dart';
import 'package:bake_store/dashboard_components/suplier_statcs.dart';
import 'package:bake_store/main_screens/delete_privacy_policy.dart';
import 'package:bake_store/minor_screens/visit_store.dart';
import 'package:bake_store/providers/auth_repo.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/alert_dialg.dart';

List<String> label = [
  "my store",
  "orders",
  "Privacy policy",
  "manage products",
  "balance",
  "statics"
];
List<IconData> icons = [
  Icons.store,
  Icons.shop,
  Icons.info,
  Icons.settings,
  Icons.currency_rupee,
  Icons.show_chart,
];

List<Widget> pages = [
  VisitStore(suppId: FirebaseAuth.instance.currentUser!.uid),
  const SupllierOrders(),
  const DeletePrivacyPolicyScreen(),
  const ManageProduct(),
  const Balance(),
  const Statics(),
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              MyAlertDialog.showMyDialogue(
                  context: context,
                  title: "LogOut",
                  content: "Are you sure you want to log out?",
                  tabNo: () {
                    Navigator.of(context).pop();
                  },
                  tabYes: () async {
                    // Perform the log out operation
                    await AuthRepo.logOut();
                    await Future.delayed(const Duration(microseconds: 100))
                        .whenComplete(() {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, "/welcome_screen");
                    });
                  });

              // Navigator.pushReplacementNamed(context, "/welcome_screen");
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.count(
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            crossAxisCount: 2,
            children: List.generate(
              6,
              (index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pages[index],
                        ));
                  },
                  child: Card(
                    elevation: 20,
                    shadowColor: Colors.black,
                    color: Colors.lime.shade200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          size: 45,
                          color: Colors.black,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            label[index].toUpperCase(),
                            style: const TextStyle(
                                fontSize: 24,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                fontFamily: "Acme"),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
