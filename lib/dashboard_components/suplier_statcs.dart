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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            StaticsModel(
              label: "Sold Out",
              value: "45",
            ),
            StaticsModel(
              label: "Item Count",
              value: "45",
            ),
            StaticsModel(
              label: "Total Balance",
              value: "45",
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class StaticsModel extends StatelessWidget {
  final String label;
  final dynamic value;
  const StaticsModel({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 66, 12, 0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          height: 90,
          width: MediaQuery.of(context).size.width * 0.7,
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          child: Center(
            child: Text(
              value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Acme",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          ),
        ),
      ],
    );
  }
}
