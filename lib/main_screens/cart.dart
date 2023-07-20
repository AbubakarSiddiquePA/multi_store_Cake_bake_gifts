import 'package:bake_store/main_screens/dashboard.dart';
import 'package:bake_store/providers/cart_providers.dart';
import 'package:bake_store/widgets/alert_dialg.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../widgets/yellow_btn.dart';

class CartScreen extends StatefulWidget {
  final Widget? back;
  const CartScreen({super.key, this.back});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: "Cart"),
            actions: [
              context.watch<Cart>().getItems.isEmpty
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        MyAlertDialog.showMyDialogue(
                          context: context,
                          title: "Clear Cart",
                          content: "Are you sure to clear Cart",
                          tabNo: () {
                            Navigator.pop(context);
                          },
                          tabYes: () {
                            context.read<Cart>().clearCart();
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
            leading: widget.back,
          ),
          body: context.watch<Cart>().getItems.isNotEmpty
              //can use also
              // body: Provider.of<Cart>(context, listen: true).getItems.isNotEmpty
              ? const CartItems()
              : const EmptyCart(),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "Total : Rs-",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      context.watch<Cart>().totalPrice.toStringAsFixed(2),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ],
                ),
                yellowButtonCstm(
                  colore: Colors.yellow,
                  label: "CHECK OUT",
                  width: 0.45,
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Your Cart is Empty !",
            style: TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 50,
          ),
          Material(
            borderRadius: BorderRadius.circular(15),
            color: Colors.indigo.shade900,
            child: MaterialButton(
              onPressed: () {
                //pops to profile itself if popping from cart in profile section
                //pops to home screen if popping from navbar with the help of checking can pop function
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : Navigator.pushReplacementNamed(
                        context, "/customer_screen");
              },
              minWidth: MediaQuery.of(context).size.width * 0.3,
              child: const Text(
                "Order more >",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
      builder: (context, cart, child) {
        return ListView.builder(
          itemCount: cart.count,
          itemBuilder: (context, index) {
            final Product = cart.getItems[index];
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
                        child: Image.network(Product.imagesUrl.first),
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
                                    Product.name,
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
                                    Product.price.toStringAsFixed(2),
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
                                        Product.qty == 1
                                            ? IconButton(
                                                onPressed: () {
                                                  cart.removeItem(Product);
                                                },
                                                icon: const Icon(
                                                  Icons.delete_forever,
                                                  size: 18,
                                                ))
                                            : IconButton(
                                                onPressed: () {
                                                  cart.decrement(Product);
                                                },
                                                icon: const Icon(
                                                  FontAwesomeIcons.minus,
                                                  size: 18,
                                                )),
                                        Text(
                                          Product.qty.toString(),
                                          style: Product.qty == Product.qntty
                                              ? const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Acme",
                                                  color: Colors.red,
                                                )
                                              : const TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Acme"),
                                        ),
                                        IconButton(
                                            onPressed:
                                                Product.qty == Product.qntty
                                                    ? null
                                                    : () {
                                                        cart.increment(Product);
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
          },
        );
      },
    );
  }
}
