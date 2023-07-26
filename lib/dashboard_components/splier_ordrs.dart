import 'package:bake_store/dashboard_components/preparing_orders.dart';
import 'package:bake_store/dashboard_components/shipping_orders.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

import 'delivered_orders.dart';

class SupllierOrders extends StatelessWidget {
  const SupllierOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(title: "Supllier Orders"),
          bottom: TabBar(
              indicatorWeight: 8,
              indicatorColor: Colors.grey.shade900,
              tabs: const [
                RepeatedTab(label: "Preparing"),
                RepeatedTab(label: "Shipping"),
                RepeatedTab(label: "Delivered")
              ]),
        ),
        body: const TabBarView(children: [
          Preparing(),
          Shipping(),
          Delivered(),
        ]),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
