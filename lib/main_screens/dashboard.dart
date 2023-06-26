import 'package:bake_store/dashboard_components/balance.dart';
import 'package:bake_store/dashboard_components/edit_buisness.dart';
import 'package:bake_store/dashboard_components/manage_products.dart';
import 'package:bake_store/dashboard_components/my_store.dart';
import 'package:bake_store/dashboard_components/splier_ordrs.dart';
import 'package:bake_store/dashboard_components/suplier_statcs.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

List<String> label = [
  "my store",
  "orders",
  "edit profile",
  "manage products",
  "balance",
  "statics"
];
List<IconData> icons = [
  Icons.store,
  Icons.shop,
  Icons.edit,
  Icons.settings,
  Icons.currency_rupee,
  Icons.show_chart,
];

List<Widget> pages = [
  const MyStore(),
  const SupllierOrders(),
  const EditBuisness(),
  const ManageProduct(),
  const BalanceScreen(),
  const SupplierStatics()
];

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, "/welcome_screen");
            },
            icon: const Icon(Icons.logout),
            color: Colors.black,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
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
                    color: Colors.lightGreen[200],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          icons[index],
                          size: 45,
                          color: Colors.black,
                        ),
                        Text(
                          label[index].toUpperCase(),
                          style: const TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              fontFamily: "Acme"),
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
