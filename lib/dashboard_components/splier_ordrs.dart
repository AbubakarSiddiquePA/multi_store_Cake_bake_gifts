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
      ),
    );
  }
}
