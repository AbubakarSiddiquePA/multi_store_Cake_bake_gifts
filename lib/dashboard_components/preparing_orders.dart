import 'package:bake_store/dashboard_components/splier_ordrs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/cust_order_models.dart';
import '../models/suplir_order_model.dart';

class Preparing extends StatelessWidget {
  const Preparing({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .where("sid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("deliverystatus", isEqualTo: "preparing")
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              "you have no active order's yet",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "Acme",
                  letterSpacing: 1.5,
                  fontSize: 24,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold),
            ),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            return SupplierOrderModel(
              order: snapshot.data!.docs[index],
            );
          },
        );
      },
    );
  }
}
