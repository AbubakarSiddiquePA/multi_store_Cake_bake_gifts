import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

class BalanceScreen extends StatelessWidget {
  const BalanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Balance Screen"),
        leading: const AppBarBackButton(),
      ),
    );
  }
}
