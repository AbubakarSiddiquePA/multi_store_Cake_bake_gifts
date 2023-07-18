import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final Stream<QuerySnapshot> _productsStream =
      FirebaseFirestore.instance.collection('products').snapshots();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Swiper(
                    pagination: const SwiperPagination(
                        builder: SwiperPagination.fraction),
                    itemBuilder: (context, index) {
                      return const Image(
                          image: AssetImage("images/cake/cake0.jpg"));
                    },
                    itemCount: 1,
                  ),
                ),
                const Text(
                  "Pro name ",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Text(
                          "RS ",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "65.5 ",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.favorite)),
                  ],
                ),
                const Text(
                  "99 pieces available in stock",
                  style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const ProductDetailsHeader(
                  label: "Item Descriptionn",
                ),
                Text(
                  textScaleFactor: 1.2,
                  "Pro description",
                  style: TextStyle(
                      color: Colors.blueGrey.shade800,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const ProductDetailsHeader(
                  label: " similar items ",
                ),
                SizedBox(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _productsStream,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                            staggeredTileBuilder: (context) =>
                                const StaggeredTile.fit(1)),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          bottomSheet: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.store)),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
                ],
              ),
              yellowButtonCstm(
                  label: "Add to cart",
                  onPressed: () {},
                  width: 0.55,
                  colore: Colors.yellow)
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailsHeader extends StatelessWidget {
  final String label;
  const ProductDetailsHeader({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
