import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

class SupplierStatics extends StatelessWidget {
  const SupplierStatics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Supplier Statics "),
        leading: const AppBarBackButton(),
      ),
    );
  }
}