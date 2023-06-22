import 'package:flutter/material.dart';

import '../widgets/appbar_widgets.dart';

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
        leading: const AppBarBackButton(),
        title: AppBarTitle(title: subcategoryName),
      ),
      body: Center(
        child: Text(maincategoryName),
      ),
    );
  }
}
