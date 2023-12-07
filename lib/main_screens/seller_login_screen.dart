import 'package:bake_store/main_screens/welcome_screen.dart';
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AnimatedTextKits(),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Seller LogIn",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(children: [
                    Positioned(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Container(
                          width: 200,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomRight: Radius.circular(25),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, "/supplier_login");
                              },
                              child: const Text(
                                "LogIn",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 35,
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(children: [
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Container(
                              width: 200,
                              decoration: const BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(25),
                                  bottomRight: Radius.circular(25),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/supplier_signup");
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 35,
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            BackButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/welcome_screen");
              },
            )
          ],
        ),
      ),
    );
  }
}
