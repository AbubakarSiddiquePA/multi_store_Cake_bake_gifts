import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerOrders extends StatelessWidget {
  const CustomerOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: " Orders"),
        leading: const AppBarBackButton(),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("cid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
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
              var order = snapshot.data!.docs[index];
              return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.yellow,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: ExpansionTile(
                  title: Container(
                    constraints: const BoxConstraints(
                      maxHeight: 80,
                    ),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Container(
                            constraints: const BoxConstraints(
                                maxHeight: 80, maxWidth: 80),
                            child: Image.network(order["orderimage"]),
                          ),
                        ),
                        Flexible(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  order["ordername"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(("Rs") +
                                      (order["orderprice"].toStringAsFixed(2))),
                                  Text(("x") + (order["orderqty"].toString())),
                                ],
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "see more...",
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(order["deliverystatus"]),
                    ],
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                          color: order["deliverystatus"] == "delivered"
                              ? Colors.green.shade50
                              : Colors.yellow.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ("Name: ") + (order["custname"]),
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              ("Phone No. ") + (order["phone"]),
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              ("Email Address: ") + (order["email"]),
                              style: const TextStyle(fontSize: 15),
                            ),
                            Text(
                              ("Address: ") + (order["address"]),
                              style: const TextStyle(fontSize: 15),
                            ),
                            Row(
                              children: [
                                const Text(
                                  ("Payment Status: "),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  (order["paymentstatus"]),
                                  style: const TextStyle(
                                      color: Colors.orange, fontSize: 15),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  ("Delivery Status: "),
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  (order["deliverystatus"]),
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                              ],
                            ),
                            order["deliverystatus"] == "shipping"
                                ? Text(
                                    ("Estimated Delivery Date: ") +
                                        (order["deliverydate"]),
                                    style: const TextStyle(fontSize: 15),
                                  )
                                : const Text(""),
                            order["deliverystatus"] == "delivered" &&
                                    order["orderreview"] == false
                                ? TextButton(
                                    onPressed: () {},
                                    child: const Text("Write a review"))
                                : const Text(""),
                            order["deliverystatus"] == "delivered" &&
                                    order["orderreview"] == true
                                ? Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green.shade800,
                                      ),
                                      Text(
                                        "Review added",
                                        style: TextStyle(
                                            color: Colors.green.shade800,
                                            fontStyle: FontStyle.italic),
                                      )
                                    ],
                                  )
                                : const Text(""),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
