import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../providers/cart_providers.dart';
import '../providers/product_class.dart';
import '../providers/wish_provider.dart';
import '../widgets/alert_dialg.dart';

class WishlistModel extends StatelessWidget {
  const WishlistModel({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(
            children: [
              SizedBox(
                height: 100,
                width: 120,
                child: Image.network(product.imagesUrl.first),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.price.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  MyAlertDialog.showMyDialogue(
                                    context: context,
                                    title: "Delete Item ",
                                    content: "Delete this Item from Wishlist",
                                    tabNo: () {
                                      Navigator.pop(context);
                                    },
                                    tabYes: () {
                                      context.read<Wish>().removeItem(product);

                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                icon: const Icon(Icons.delete_forever),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              context.watch<Cart>().getItems.firstWhereOrNull(
                                              (element) =>
                                                  element.documentId ==
                                                  product.documentId) !=
                                          null ||
                                      product.qntty == 0
                                  ? const SizedBox()
                                  : IconButton(
                                      onPressed: () {
                                        context.read<Cart>().addItem(
                                            name: product.name,
                                            price: product.price,
                                            qty: 1,
                                            qntty: product.qntty,
                                            imagesUrl: product.imagesUrl,
                                            documentId: product.documentId,
                                            suppId: product.suppId);
                                      },
                                      icon: const Icon(Icons.add_shopping_cart),
                                    ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
