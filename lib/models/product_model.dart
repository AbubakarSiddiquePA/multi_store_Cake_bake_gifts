import 'package:bake_store/minor_screens/prdct_dtls_scrn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../minor_screens/edit_products.dart';
import '../providers/wish_provider.dart';

class ProductModel extends StatefulWidget {
  final dynamic products;
  const ProductModel({super.key, required this.products});

  @override
  State<ProductModel> createState() => _ProductModelState();
}

class _ProductModelState extends State<ProductModel> {
  @override
  Widget build(BuildContext context) {
    var onSale = widget.products["discount"];
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ProductDetailsScreen(proList: widget.products),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Container(
                      constraints:
                          const BoxConstraints(minHeight: 100, maxHeight: 250),
                      child: Image(
                          image: NetworkImage(widget.products["proimages"][0])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          widget.products["proname"],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text("Rs ",
                                    style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  widget.products["price"].toStringAsFixed(2),
                                  style: widget.products["discount"] != 0
                                      ? TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 11,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                onSale != 0
                                    ? Text(
                                        ((1 - (onSale / 100)) *
                                                widget.products["price"])
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text("data")
                              ],
                            ),
                            widget.products["sid"] ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditProduct(
                                                items: widget.products),
                                          ));
                                    },
                                    icon: const Icon(Icons.edit))
                                : IconButton(
                                    onPressed: () {
                                      var existingItemWishlist = context
                                          .read<Wish>()
                                          .getWishItems
                                          .firstWhereOrNull((Product) =>
                                              Product.documentId ==
                                              widget.products["proid"]);
                                      existingItemWishlist != null
                                          ? context.read<Wish>().removeThis(
                                              widget.products["proid"])
                                          : context.read<Wish>().addWishItem(
                                                widget.products["proname"],
                                                onSale != 0
                                                    ? ((1 - (onSale / 100)) *
                                                        widget
                                                            .products["price"])
                                                    : widget.products["price"],
                                                1,
                                                widget.products["instock"],
                                                widget.products["proimages"],
                                                widget.products["proid"],
                                                widget.products["sid"],
                                              );
                                    },
                                    icon: context
                                                .watch<Wish>()
                                                .getWishItems
                                                .firstWhereOrNull((Product) =>
                                                    Product.documentId ==
                                                    widget.products["proid"]) !=
                                            null
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline,
                                          )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.products["discount"] != 0
                ? Positioned(
                    top: 30,
                    left: 0,
                    child: Container(
                      height: 20,
                      width: 80,
                      decoration: const BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          )),
                      child: Center(
                        child: Text("Save ${onSale.toString()} %"),
                      ),
                    ),
                  )
                : Container(
                    color: Colors.transparent,
                  )
          ],
        ),
      ),
    );
  }
}
