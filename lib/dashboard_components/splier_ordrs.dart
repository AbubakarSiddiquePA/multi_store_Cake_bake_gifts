import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

class SupllierOrders extends StatelessWidget {
  const SupllierOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Supllier Orders"),
        leading: const AppBarBackButton(),
        bottom: const TabBar(tabs: [
          RepeatedTab(label: "Preparing"),
          RepeatedTab(label: "Shipping"),
          RepeatedTab(label: "Delivered")
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
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
