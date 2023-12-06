import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';

class SellerLoginScreen extends StatefulWidget {
  const SellerLoginScreen({super.key});

  @override
  State<SellerLoginScreen> createState() => _SellerLoginScreenState();
}

class _SellerLoginScreenState extends State<SellerLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.amber,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Seller LogIn"),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        child: Icon(Icons.lock),
                      ),
                      yellowButtonCstm(
                          label: "LogIn",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/supplier_login");
                          },
                          width: 0.25,
                          colore: Colors.white),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(child: Icon(Icons.edit)),
                      yellowButtonCstm(
                          label: "SignUp",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, "/supplier_signup");
                          },
                          width: 0.25,
                          colore: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
