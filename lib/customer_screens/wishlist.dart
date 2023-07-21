import 'package:bake_store/providers/wish_provider.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../providers/cart_providers.dart';
import '../widgets/alert_dialg.dart';
import '../widgets/snackbar.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({
    super.key,
  });

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            leading: const AppBarBackButton(),
            // automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: "Wishlist"),
            actions: [
              context.watch<Wish>().getWishItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialogue(
                          context: context,
                          title: "Clear Wishlist",
                          content: "Are you sure to clear Wishlist",
                          tabNo: () {
                            Navigator.pop(context);
                          },
                          tabYes: () {
                            context.read<Wish>().clearWishlist();
                            Navigator.pop(context);
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.red,
                      ),
                    ),
            ],
            // leading: const AppBarBackButton(),
          ),
          body: context.watch<Wish>().getWishItems.isNotEmpty
              //can use also
              // body: Provider.of<Cart>(context, listen: true).getItems.isNotEmpty
              ? const WishItems()
              : const EmptyWishlist(),
        ),
      ),
    );
  }
}

class EmptyWishlist extends StatelessWidget {
  const EmptyWishlist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Your Wishlist is Empty !",
            style: TextStyle(fontSize: 30),
          ),
          // const SizedBox(
          //   height: 50,
          // ),
          // Material(
          //   borderRadius: BorderRadius.circular(15),
          //   color: Colors.indigo.shade900,
          //   child: MaterialButton(
          //     onPressed: () {
          //       //pops to profile itself if popping from cart in profile section
          //       //pops to home screen if popping from navbar with the help of checking can pop function
          //       Navigator.canPop(context)
          //           ? Navigator.pop(context)
          //           : Navigator.pushReplacementNamed(
          //               context, "/customer_screen");
          //     },
          //     minWidth: MediaQuery.of(context).size.width * 0.3,
          //     child: const Text(
          //       "Order more >",
          //       style: TextStyle(color: Colors.white, fontSize: 15),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class WishItems extends StatelessWidget {
  const WishItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Wish>(
      builder: (context, wish, child) {
        return ListView.builder(
          itemCount: wish.count,
          itemBuilder: (context, index) {
            final product = wish.getWishItems[index];
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                          context
                                              .read<Wish>()
                                              .removeItem(product);
                                        },
                                        icon: const Icon(Icons.delete_forever),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      context
                                                  .watch<Cart>()
                                                  .getItems
                                                  .firstWhereOrNull((element) =>
                                                      element.documentId ==
                                                      product.documentId) !=
                                              null
                                          ? const SizedBox()
                                          : IconButton(
                                              onPressed: () {
                                                context.read<Cart>().addItem(
                                                    product.name,
                                                    product.price,
                                                    1,
                                                    product.qntty,
                                                    product.imagesUrl,
                                                    product.documentId,
                                                    product.suppId);
                                              },
                                              icon: const Icon(
                                                  Icons.add_shopping_cart),
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
          },
        );
      },
    );
  }
}
