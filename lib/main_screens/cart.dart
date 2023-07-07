import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

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
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const AppBarTitle(title: "Cart"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
              ),
            ],
            leading: widget.back,
          ),
          body: Center(
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
          ),
          bottomSheet: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "Total : Rs-",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "00.00",
                      style: TextStyle(
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
