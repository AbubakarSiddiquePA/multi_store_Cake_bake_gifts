import 'package:bake_store/customer_screens/add_address.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddressBook extends StatefulWidget {
  const AddressBook({super.key});

  @override
  State<AddressBook> createState() => _AddressBookState();
}

class _AddressBookState extends State<AddressBook> {
  final Stream<QuerySnapshot> addressStream = FirebaseFirestore.instance
      .collection("customers")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection("address")
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Address Book"),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const AppBarBackButton(),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
            stream: addressStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Material(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text(
                    "you Dont have set an address yet",
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
                  var customer = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.black12,
                      child: ListTile(
                        title: SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "${customer["firstname"]}   ${customer["lastname"]} "),
                              Text(customer["phone"])
                            ],
                          ),
                        ),
                        subtitle: SizedBox(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "City/State: ${customer["city"]} ${customer["state"]} "),
                              Text("Country : ${customer["country"]}")
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
          yellowButtonCstm(
              label: "Add new address",
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddAddress(),
                    ));
              },
              width: 0.8,
              colore: Colors.blue)
        ],
      )),
    );
  }
}