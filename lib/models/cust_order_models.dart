import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomerOrderModel extends StatefulWidget {
  final dynamic order;
  const CustomerOrderModel({super.key, required this.order});

  @override
  State<CustomerOrderModel> createState() => _CustomerOrderModelState();
}

class _CustomerOrderModelState extends State<CustomerOrderModel> {
  late double rate;
  late String comment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.yellow,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(
              maxHeight: 80,
            ),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Container(
                    constraints:
                        const BoxConstraints(maxHeight: 80, maxWidth: 80),
                    child: Image.network(widget.order["orderimage"]),
                  ),
                ),
                Flexible(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.order["ordername"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(("Rs") +
                              (widget.order["orderprice"].toStringAsFixed(2))),
                          Text(("x") + (widget.order["orderqty"].toString())),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "see more...",
                style: TextStyle(color: Colors.blue),
              ),
              Text(widget.order["deliverystatus"]),
            ],
          ),
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  color: widget.order["deliverystatus"] == "delivered"
                      ? Colors.grey.shade800
                      : Colors.yellow.withOpacity(0.2)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ("Name: ") + (widget.order["custname"]),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ("Phone No. ") + (widget.order["phone"]),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ("Email Address: ") + (widget.order["email"]),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Text(
                      ("Address: ") + (widget.order["address"]),
                      style: const TextStyle(fontSize: 15),
                    ),
                    Row(
                      children: [
                        const Text(
                          ("Payment Status: "),
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          (widget.order["paymentstatus"]),
                          style: const TextStyle(
                              color: Colors.orange, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          ("Delivery Status: "),
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          (widget.order["deliverystatus"]),
                          style: const TextStyle(
                              color: Colors.green, fontSize: 15),
                        ),
                      ],
                    ),
                    widget.order["deliverystatus"] == "shipping"
                        ? Text(
                            ("Estimated Delivery Date: ") +
                                (DateFormat("yyyy-MM-dd").format(
                                        widget.order["deliverydate"].toDate()))
                                    .toString(),
                            style: const TextStyle(fontSize: 15),
                          )
                        : const Text(""),
                    widget.order["deliverystatus"] == "delivered" &&
                            widget.order["orderreview"] == false
                        ? TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => Material(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 1,
                                        minRating: 1,
                                        allowHalfRating: true,
                                        itemBuilder: (context, _) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          );
                                        },
                                        onRatingUpdate: (value) {
                                          rate = value;
                                        },
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                            hintText: "Write a review",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.amber,
                                                    width: 2),
                                                borderRadius:
                                                    BorderRadius.circular(15))),
                                        onChanged: (value) {
                                          comment = value;
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          yellowButtonCstm(
                                              label: "Cancel",
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              width: 0.3,
                                              colore: Colors.blue),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          yellowButtonCstm(
                                              label: "Post",
                                              onPressed: () {},
                                              width: 0.3,
                                              colore: Colors.green),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text("Write a review"))
                        : const Text(""),
                    widget.order["deliverystatus"] == "delivered" &&
                            widget.order["orderreview"] == true
                        ? Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.green.shade800,
                              ),
                              Text(
                                "Review added",
                                style: TextStyle(
                                    color: Colors.green.shade800,
                                    fontStyle: FontStyle.italic),
                              )
                            ],
                          )
                        : const Text(""),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
