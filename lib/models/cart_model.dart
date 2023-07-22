import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../providers/cart_providers.dart';
import '../providers/product_class.dart';
import '../providers/wish_provider.dart';

class CartModel extends StatelessWidget {
  const CartModel({
    super.key,
    required this.product,
    required this.cart,
  });

  final Product product;
  final Cart cart;

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
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                product.qty == 1
                                    ? IconButton(
                                        onPressed: () {
                                          showModalBottomSheet<void>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: <Widget>[
                                                      const Text(
                                                          'Are you sure to remove this item ?'),
                                                      const SizedBox(
                                                          height: 20),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .black),
                                                          child: const Text(
                                                            'Move to Wishlist',
                                                          ),
                                                          onPressed: () async {
                                                            context
                                                                        .read<
                                                                            Wish>()
                                                                        .getWishItems
                                                                        .firstWhereOrNull((element) =>
                                                                            element.documentId ==
                                                                            product
                                                                                .documentId) !=
                                                                    null
                                                                ? context
                                                                    .read<
                                                                        Cart>()
                                                                    .removeItem(
                                                                        product)
                                                                : await context
                                                                    .read<
                                                                        Wish>()
                                                                    .addWishItem(
                                                                        product
                                                                            .name,
                                                                        product
                                                                            .price,
                                                                        1,
                                                                        product
                                                                            .qntty,
                                                                        product
                                                                            .imagesUrl,
                                                                        product
                                                                            .documentId,
                                                                        product
                                                                            .suppId);
                                                            context
                                                                .read<Cart>()
                                                                .removeItem(
                                                                    product);
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red),
                                                          child: const Text(
                                                            'Delete Item',
                                                          ),
                                                          onPressed: () {
                                                            context
                                                                .read<Cart>()
                                                                .removeItem(
                                                                    product);
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                      ElevatedButton(
                                                        child: const Text(
                                                          'Cancel ',
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete_forever,
                                          size: 18,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          cart.decrement(product);
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.minus,
                                          size: 18,
                                        )),
                                Text(
                                  product.qty.toString(),
                                  style: product.qty == product.qntty
                                      ? const TextStyle(
                                          fontSize: 20,
                                          fontFamily: "Acme",
                                          color: Colors.red,
                                        )
                                      : const TextStyle(
                                          fontSize: 20, fontFamily: "Acme"),
                                ),
                                IconButton(
                                    onPressed: product.qty == product.qntty
                                        ? null
                                        : () {
                                            cart.increment(product);
                                          },
                                    icon: const Icon(
                                      FontAwesomeIcons.plus,
                                      size: 18,
                                    ))
                              ],
                            ),
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
