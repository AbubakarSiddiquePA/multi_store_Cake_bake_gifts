import 'dart:math';

import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool processing = false;

  CollectionReference customers =
      FirebaseFirestore.instance.collection("customers");
  late String _uid;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("images/logo/welcome.jpeg"))),
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AnimatedTextKits(),
                // const Text(
                //   "Welcome",
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 34,
                //   ),
                // ),
                const SizedBox(
                  height: 120,
                  width: 200,
                  child: Image(image: AssetImage("images/logo/app_logo1.png")),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              "Suppliers LogIn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedLogo(controller: _controller),
                              yellowButtonCstm(
                                  label: "LogIn",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/supplier_login");
                                  },
                                  width: 0.25,
                                  colore: Colors.white),
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: yellowButtonCstm(
                                    label: "SignUp",
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "/supplier_signup");
                                    },
                                    width: 0.25,
                                    colore: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: yellowButtonCstm(
                                  label: "LogIn",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/customer_login");
                                  },
                                  width: 0.25,
                                  colore: Colors.white),
                            ),
                            yellowButtonCstm(
                                label: "SignUp",
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, "/customer_signup");
                                },
                                width: 0.25,
                                colore: Colors.white),
                            AnimatedLogo(controller: _controller)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GoogleFacebookLogin(
                        label: "Google",
                        child: const Image(
                            image: AssetImage("images/logo/google_logo.png")),
                        onPressed: () {},
                      ),
                      GoogleFacebookLogin(
                        label: "Facebook",
                        child: const Image(
                            image: AssetImage("images/logo/fb_logo.png")),
                        onPressed: () {},
                      ),
                      processing == true
                          ? const CircularProgressIndicator()
                          : GoogleFacebookLogin(
                              label: "Guest",
                              child: const Icon(
                                Icons.person,
                                size: 28,
                                color: Colors.blueAccent,
                              ),
                              onPressed: () async {
                                setState(() {
                                  processing = true;
                                });
                                await FirebaseAuth.instance
                                    .signInAnonymously()
                                    .whenComplete(() async {
                                  _uid = FirebaseAuth.instance.currentUser!.uid;

                                  await customers.doc(_uid).set({
                                    "name": "",
                                    "email": "",
                                    "profileimage": "",
                                    "phone": "",
                                    "address": "",
                                    "cid": _uid
                                  });
                                });

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(
                                    context, "/customer_screen");
                              },
                            ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedTextKits extends StatelessWidget {
  const AnimatedTextKits({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
        isRepeatingAnimation: true,
        repeatForever: true,
        animatedTexts: [
          ColorizeAnimatedText("Cake",
              textStyle: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Acme"),
              colors: [Colors.white, Colors.black]),
          ColorizeAnimatedText("Bake",
              textStyle: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Acme"),
              colors: [Colors.white, Colors.black]),
          ColorizeAnimatedText("Gifts",
              textStyle: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Acme"),
              colors: [Colors.white, Colors.black])
        ]);
  }
}

class AnimatedLogo extends StatelessWidget {
  const AnimatedLogo({
    super.key,
    required AnimationController controller,
  }) : _controller = controller;

  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi,
          child: child,
        );
      },
      child: const Image(image: AssetImage("images/logo/app_logo1.png")),
    );
  }
}

class GoogleFacebookLogin extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Widget child;
  const GoogleFacebookLogin(
      {super.key,
      required this.child,
      required this.label,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: onPressed,
        child: Column(
          children: [
            SizedBox(
              height: 25,
              width: 25,
              child: child,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
