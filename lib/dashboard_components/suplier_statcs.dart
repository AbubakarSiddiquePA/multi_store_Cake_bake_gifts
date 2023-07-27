import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Statics extends StatelessWidget {
  const Statics({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("sid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Material(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          num itemCount = 0;
          for (var item in snapshot.data!.docs) {
            itemCount += item["orderqty"];
          }
          double totalPrice = 0.0;
          for (var item in snapshot.data!.docs) {
            totalPrice += item["orderqty"] * item["orderprice"] + 2;
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: const AppBarTitle(title: " Statics "),
              leading: const AppBarBackButton(),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StaticsModel(
                    label: "Sold Out",
                    value: snapshot.data!.docs.length,
                    decimal: 0,
                  ),
                  StaticsModel(
                    label: "Item Count",
                    value: itemCount,
                    decimal: 0,
                  ),
                  StaticsModel(
                    label: "Total Balance",
                    value: totalPrice,
                    decimal: 2,
                    rs: "Rs",
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        });
  }
}

class StaticsModel extends StatelessWidget {
  String? rs;
  final String label;
  final dynamic value;
  final int decimal;
  StaticsModel({
    super.key,
    required this.label,
    required this.value,
    required this.decimal,
    this.rs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 66, 12, 0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: Center(
            child: Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
            height: 90,
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedCounter(
                  count: value,
                  decimal: decimal,
                ),
                Text(style: TextStyle(color: Colors.white), rs.toString())
              ],
            )),
      ],
    );
  }
}

class AnimatedCounter extends StatefulWidget {
  final int decimal;
  final dynamic count;
  const AnimatedCounter(
      {super.key, required this.count, required this.decimal});

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = _controller;
    setState(() {
      _animation = Tween(begin: _animation.value, end: widget.count)
          .animate(_controller);
    });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Center(
            child: Text(
              _animation.value.toStringAsFixed(widget.decimal),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: "Acme",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
          );
        });
  }
}
