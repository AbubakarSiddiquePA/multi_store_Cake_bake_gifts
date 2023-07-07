import 'package:flutter/material.dart';

class VisitStore extends StatefulWidget {
  const VisitStore({super.key});

  @override
  State<VisitStore> createState() => _VisitStoreState();
}

class _VisitStoreState extends State<VisitStore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 100,
        flexibleSpace: Image.asset("images/store/store (2).gif"),
      ),
    );
  }
}
