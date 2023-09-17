import 'package:bake_store/main_screens/cart.dart';
import 'package:bake_store/minor_screens/visit_store.dart';
import 'package:bake_store/providers/cart_providers.dart';
import 'package:bake_store/providers/wish_provider.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/snackbar.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import 'full_screen_view.dart';
import 'package:collection/collection.dart';
import 'package:badges/badges.dart' as badges;
import 'package:expandable/expandable.dart';

class ProductDetailsScreen extends StatefulWidget {
  final dynamic proList;
  const ProductDetailsScreen({super.key, required this.proList});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // late final Stream<QuerySnapshot> _proListStream = FirebaseFirestore.instance
  //     .collection('proList')
  //     .where("maincategory", isEqualTo: widget.proList["maincategory"])
  //     .where("subcategory", isEqualTo: widget.proList["subcategory"])
  //     .snapshots();
  late final Stream<QuerySnapshot> _proListStream = FirebaseFirestore.instance
      .collection('products')
      .where("maincategory", isEqualTo: widget.proList["maincategory"])
      .where("subcategory", isEqualTo: widget.proList["subcategory"])
      .snapshots();

  late final Stream<QuerySnapshot> reviewsStream = FirebaseFirestore.instance
      .collection('products')
      .doc(widget.proList["proid"])
      .collection("reviews")
      .limit(3)
      .snapshots();

  late List<dynamic> imagesList = widget.proList["proimages"];

  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    var onSale = widget.proList["discount"];
    var existingItemCart = context.read<Cart>().getItems.firstWhereOrNull(
        (Product) => Product.documentId == widget.proList["proid"]);
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FullScreenView(imagesList: imagesList),
                          ));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Swiper(
                            pagination: const SwiperPagination(
                                builder: SwiperPagination.dots),
                            itemBuilder: (context, index) {
                              return Image(
                                  image: NetworkImage(imagesList[index]));
                            },
                            itemCount: imagesList.length,
                          ),
                        ),
                        Positioned(
                          left: 15,
                          top: 20,
                          child: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Positioned(
                            right: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.share,
                                    color: Colors.black,
                                  )),
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8, right: 8, left: 8, bottom: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.proList['proname'],
                          style: const TextStyle(
                              color: Colors.black,
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
                                  widget.proList["price"].toStringAsFixed(2),
                                  style: widget.proList["discount"] != 0
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
                                                widget.proList["price"])
                                            .toStringAsFixed(2),
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : const Text("data")
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  var existingItemWishlist = context
                                      .read<Wish>()
                                      .getWishItems
                                      .firstWhereOrNull((Product) =>
                                          Product.documentId ==
                                          widget.proList["proid"]);
                                  existingItemWishlist != null
                                      ? context
                                          .read<Wish>()
                                          .removeThis(widget.proList["proid"])
                                      : context.read<Wish>().addWishItem(
                                            widget.proList["proname"],
                                            onSale != 0
                                                ? ((1 - (onSale / 100)) *
                                                    widget.proList["price"])
                                                : widget.proList["price"],
                                            1,
                                            widget.proList["instock"],
                                            widget.proList["proimages"],
                                            widget.proList["proid"],
                                            widget.proList["sid"],
                                          );
                                },
                                icon: context
                                            .watch<Wish>()
                                            .getWishItems
                                            .firstWhereOrNull((Product) =>
                                                Product.documentId ==
                                                widget.proList["proid"]) !=
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
                        widget.proList["instock"] == 0
                            ? const Text(
                                "This item is out of stock",
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                (widget.proList["instock"].toString()) +
                                    ("pieces available in stock"),
                                style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                      ],
                    ),
                  ),
                  const ProductDetailsHeader(
                    label: "Item Descriptionn",
                  ),
                  Text(
                    textScaleFactor: 1.2,
                    widget.proList['prodesc'].toString(),
                    style: TextStyle(
                        color: Colors.blueGrey.shade800,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  ExpandableTheme(
                      data: const ExpandableThemeData(
                        iconColor: Colors.blue,
                        iconSize: 30,
                      ),
                      child: reviews(reviewsStream)),
                  const ProductDetailsHeader(
                    label: " similar items ",
                  ),
                  SizedBox(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: _proListStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      VisitStore(suppId: widget.proList['sid']),
                                ));
                          },
                          icon: const Icon(Icons.store)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(
                                      back: AppBarBackButton()),
                                ));
                          },
                          icon: badges.Badge(
                              showBadge: context.read<Cart>().getItems.isEmpty
                                  ? false
                                  : true,
                              stackFit: StackFit.expand,
                              badgeStyle: const badges.BadgeStyle(
                                  badgeColor: Colors.yellow),
                              badgeContent: Text(
                                context
                                    .watch<Cart>()
                                    .getItems
                                    .length
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              child: const Icon(Icons.shopping_cart))),
                    ],
                  ),
                  yellowButtonCstm(
                      label: existingItemCart != null
                          ? "added to cart"
                          : "Add to cart",
                      onPressed: () {
                        if (widget.proList["instock"] == 0) {
                          MyMessageHandler.showSnackBar(
                              _scaffoldKey, "this item is out of stock");
                        } else if (existingItemCart != null) {
                          MyMessageHandler.showSnackBar(
                              _scaffoldKey, "this item is already in cart");
                        } else {
                          context.read<Cart>().addItem(
                                widget.proList["proname"],
                                onSale != 0
                                    ? ((1 - (onSale / 100)) *
                                        widget.proList["price"])
                                    : widget.proList["price"],
                                1,
                                widget.proList["instock"],
                                widget.proList["proimages"],
                                widget.proList["proid"],
                                widget.proList["sid"],
                              );
                        }
                      },
                      width: 0.55,
                      colore: Colors.yellow)
                ],
              ),
            ),
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

Widget reviews(var reviewsStream) {
  return ExpandablePanel(
      header: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "reviews",
          style: TextStyle(
              color: Colors.blue, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      collapsed: SizedBox(
        height: 230,
        child: reviewsAll(reviewsStream),
      ),
      expanded: reviewsAll(reviewsStream));
}

Widget reviewsAll(var reviewsStream) {
  return StreamBuilder<QuerySnapshot>(
    stream: reviewsStream,
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot2) {
      if (snapshot2.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      if (snapshot2.data!.docs.isEmpty) {
        return const Center(
          child: Text(
            "this category has no reviews yet",
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
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: snapshot2.data!.docs.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
                  NetworkImage(snapshot2.data!.docs[index]["profileimage"]),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(snapshot2.data!.docs[index]["name"]),
                Row(
                  children: [
                    Text(snapshot2.data!.docs[index]["rate"].toString()),
                    const Icon(
                      Icons.star,
                      color: Colors.amber,
                    )
                  ],
                )
              ],
            ),
            subtitle: Text(snapshot2.data!.docs[index]["comment"]),
          );
        },
      );
    },
  );
}
