import 'package:bake_store/minor_screens/visit_store.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Stores"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("suppliers").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, mainAxisSpacing: 25),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitStore(
                                suppId: snapshot.data!.docs[index]["sid"]),
                          ));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Image.asset(
                              "images/store/store (2).gif",
                            ),
                            Positioned(
                              top: 60,
                              right: 3,
                              child: CircleAvatar(
                                radius: 40,
                                backgroundImage: NetworkImage(
                                  snapshot.data!.docs[index]["storeLogo"],
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          snapshot.data!.docs[index]["storeName"],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text("No Stores"),
            );
          },
        ),
      ),
    );
  }
}
