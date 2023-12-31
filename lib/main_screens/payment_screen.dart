import 'dart:developer';
import 'package:bake_store/providers/cart_providers.dart';
import 'package:bake_store/providers/razorpay.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:uuid/uuid.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int selectedValue = 1;
  late String orderId;
  late Map<String, dynamic> data;
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');

  void showProgress() {
    ProgressDialog progress = ProgressDialog(context: context);
    progress.show(
      max: 100,
      msg: "Confirming payment please wait....",
      progressBgColor: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = context.watch<Cart>().totalPrice;
    double totalPaid = context.watch<Cart>().totalPrice + 10.0;

    return FutureBuilder<DocumentSnapshot>(
      future: customers.doc(FirebaseAuth.instance.currentUser!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          data = snapshot.data!.data() as Map<String, dynamic>;

          return Material(
            color: Colors.grey.shade200,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.grey.shade200,
                  leading: const AppBarBackButton(),
                  title: const AppBarTitle(title: "Payment"),
                ),
                body: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total",
                                    style: TextStyle(),
                                  ),
                                  Text(
                                    '${totalPaid.toStringAsFixed(2)}  Rs',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Order",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "${totalPrice.toStringAsFixed(2)}  Rs",
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Shipping Charges",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    "10.00  Rs",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            children: [
                              RadioListTile(
                                value: 1,
                                groupValue: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value!;
                                  });
                                },
                                title: const Text("Cash On Delivery"),
                                subtitle:
                                    const Text("Pay on your comfort zone"),
                              ),
                              RadioListTile(
                                  value: 2,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title:
                                      const Text("Pay via Visa / Master Card"),
                                  subtitle: const Row(
                                    children: [
                                      Icon(
                                        Icons.payment,
                                        color: Colors.green,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Icon(
                                          FontAwesomeIcons.ccMastercard,
                                          color: Colors.orange,
                                        ),
                                      ),
                                      Icon(
                                        FontAwesomeIcons.ccVisa,
                                        color: Colors.blue,
                                      )
                                    ],
                                  )),
                              RadioListTile(
                                  value: 3,
                                  groupValue: selectedValue,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedValue = value!;
                                    });
                                  },
                                  title: const Text("Pay via UPI"),
                                  subtitle: const Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.googlePay,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.applePay,
                                        color: Colors.black,
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomSheet: Container(
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: yellowButtonCstm(
                        label: "Confirm ${totalPaid.toStringAsFixed(2)} Rs",
                        onPressed: () async {
                          if (selectedValue == 1) {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 100),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                          style: const TextStyle(
                                            fontSize: 24,
                                          ),
                                          "pay at your doorStep ${totalPaid.toStringAsFixed(2)} Rs"),
                                      yellowButtonCstm(
                                          label:
                                              "Confirm ${totalPaid.toStringAsFixed(2)} Rs",
                                          onPressed: () async {
                                            showProgress();
                                            for (var item in context
                                                .read<Cart>()
                                                .getItems) {
                                              CollectionReference orderRef =
                                                  FirebaseFirestore.instance
                                                      .collection("orders");
                                              orderId = const Uuid().v4();
                                              await orderRef.doc(orderId).set({
                                                "cid": data['cid'],
                                                "custname": data['name'],
                                                "email": data['email'],
                                                "address": data['address'],
                                                "phone": data['phone'],
                                                "profileimage":
                                                    data['profileimage'],
                                                "sid": item.suppId,
                                                "proid": item.documentId,
                                                "orderid": orderId,
                                                "ordername": item.name,
                                                "orderimage":
                                                    item.imagesUrl.first,
                                                "orderqty": item.qty,
                                                "orderprice":
                                                    item.qty * item.price,
                                                "deliverystatus": "preparing",
                                                "deliverydate": "",
                                                "orderdate": DateTime.now(),
                                                "paymentstatus":
                                                    "cash on delivery",
                                                "orderreview": false,
                                              }).whenComplete(() async {
                                                await FirebaseFirestore.instance
                                                    .runTransaction(
                                                        (transaction) async {
                                                  DocumentReference
                                                      documentReference =
                                                      FirebaseFirestore.instance
                                                          .collection(
                                                              "products")
                                                          .doc(item.documentId);
                                                  DocumentSnapshot snapshot2 =
                                                      await transaction.get(
                                                          documentReference);
                                                  transaction.update(
                                                      documentReference, {
                                                    "instock":
                                                        snapshot2["instock"] -
                                                            item.qty
                                                  });
                                                });
                                              });
                                            }
                                            await Future.delayed(const Duration(
                                                    microseconds: 100))
                                                .whenComplete(() {
                                              context.read<Cart>().clearCart();
                                              Navigator.popUntil(
                                                  context,
                                                  (ModalRoute.withName(
                                                      "/customer_screen")));
                                            });
                                          },
                                          width: 0.9,
                                          colore: Colors.green),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else if (selectedValue == 2) {
                            orderId = const Uuid().v4();
                            var totalamout = context.read<Cart>().totalPrice;
                            log(orderId);
                            openSession(
                                amount: totalamout.round(),
                                orderId: orderId,
                                userName: data['name']);
                          } else if (selectedValue == 3) {}
                        },
                        width: 1,
                        colore: Colors.green),
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  final Razorpay _razorpay = Razorpay();

  void intiateRazorPay() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    log(response.orderId.toString());
    log(response.paymentId.toString());
    log(response.signature.toString());

    displayPaymentSheet(data);
    showPaymentStatus(message: "Payment Success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showPaymentStatus(
        message: "Payment failed", color: Colors.red, icon: Icons.close);
    log(response.toString());
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    log(response.toString());
  }

  void openSession(
      {required num amount,
      required String orderId,
      required String userName}) {
    log("amount open $amount");
    var options = {
      'key': keyId,
      'amount': amount,
      'name': userName,
      'description': 'Description for order',
      'retry': {'enabled': true, 'max_count': 3},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      intiateRazorPay();
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  displayPaymentSheet(dynamic data) async {
    try {
      for (var item in context.read<Cart>().getItems) {
        CollectionReference orderRef =
            FirebaseFirestore.instance.collection('orders');

        await orderRef.doc(orderId).set({
          'cid': data['cid'],
          'custname': data['name'],
          'email': data['email'],
          'address': data['address'],
          'phone': data['phone'],
          'profileimage': data['profileimage'],
          'sid': item.suppId,
          'proid': item.documentId,
          'orderid': orderId,
          'ordername': item.name,
          'orderimage': item.imagesUrl.first,
          'orderqty': item.qty,
          'orderprice': item.qty * item.price,
          'deliverystatus': 'preparing',
          'deliverydate': '',
          'orderdate': DateTime.now(),
          'paymentstatus': 'paid online',
          'orderreview': false,
        }).whenComplete(() async {
          await FirebaseFirestore.instance.runTransaction((transaction) async {
            DocumentReference documentReference = FirebaseFirestore.instance
                .collection('products')
                .doc(item.documentId);
            DocumentSnapshot snapshot2 =
                await transaction.get(documentReference);
            transaction.update(documentReference,
                {'instock': snapshot2['instock'] - item.qty});
          });
        });
      }
      await Future.delayed(const Duration(microseconds: 100)).whenComplete(() {
        context.read<Cart>().clearCart();
        Navigator.popUntil(context, ModalRoute.withName('/customer_screen'));
      });
    } catch (e) {
      log(e.toString());
    }
  }

  showPaymentStatus(
      {required String message,
      Color color = Colors.green,
      IconData icon = Icons.check_circle}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    color: color,
                    size: 100.0,
                  ),
                  const SizedBox(height: 10.0),
                  Text(message),
                ],
              ),
            ));
  }
}
