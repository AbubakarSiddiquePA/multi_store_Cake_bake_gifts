import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference anonymous =
      FirebaseFirestore.instance.collection("anonymous");
  // late String _uid;

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
          constraints: const BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AnimatedTextKits(),
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
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(50),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              "Please choose who you are?",
                              style: TextStyle(
                                  letterSpacing: 4.5,
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton.icon(
                  label: const Text("I' am a Seller"),
                  icon: const Icon(Icons.sell),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black38,
                      textStyle: const TextStyle(

                          // color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, "/Sellerscreen_login");
                  },
                ),
                // const SizedBox(height: 10),
                TextButton.icon(
                  label: const Text("I' am a Customer"),
                  icon: const Icon(Icons.people_rounded),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black38,
                      textStyle: const TextStyle(

                          // color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, "/Userscreen_login");
                  },
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
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
