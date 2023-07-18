import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class CakeGalleryScreen extends StatefulWidget {
  const CakeGalleryScreen({super.key});

  @override
  State<CakeGalleryScreen> createState() => _CakeGalleryScreenState();
}

class _CakeGalleryScreenState extends State<CakeGalleryScreen> {
  final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
      .collection('products')
      .where("maincategory", isEqualTo: "cake")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
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
              "this category has no items yet",
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
        return SingleChildScrollView(
          child: StaggeredGridView.countBuilder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data!.docs.length,
              crossAxisCount: 2,
              itemBuilder: (context, index) {
                return ProductModel(
                  products: snapshot.data!.docs[index],
                );
              },
              staggeredTileBuilder: (context) => const StaggeredTile.fit(1)),
        );
        // return ListView(
        //   children: snapshot.data!.docs.map((DocumentSnapshot document) {
        //     Map<String, dynamic> data =
        //         document.data()! as Map<String, dynamic>;
        //     return ListTile(
        //       leading: Image(image: NetworkImage(data["proname"][0])),
        //       title: Text(data['proname']),
        //       subtitle: Text(data['price'].toString()),
        //     );
        //   }).toList(),
        // );
      },
    );
  }
}
