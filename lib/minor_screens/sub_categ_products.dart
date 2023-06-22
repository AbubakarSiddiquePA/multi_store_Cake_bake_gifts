import 'package:flutter/material.dart';

class SubCategoryProducts extends StatelessWidget {
  final String subcategoryName;
  final String maincategoryName;
  const SubCategoryProducts(
      {super.key,
      required this.subcategoryName,
      required this.maincategoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text(
          subcategoryName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(maincategoryName),
      ),
    );
  }
}
