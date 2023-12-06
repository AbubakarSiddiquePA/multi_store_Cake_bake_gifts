import 'package:bake_store/widgets/yellow_btn.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            padding: EdgeInsets.all(7.0),
                            child: Text(
                              "Please choose who you are?",
                              style: TextStyle(
                                  letterSpacing: 5.5,
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        // Container(
                        //   height: 60,
                        //   width: MediaQuery.of(context).size.width * 0.9,
                        //   decoration: const BoxDecoration(
                        //     color: Colors.black,
                        //     borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(50),
                        //       bottomLeft: Radius.circular(50),
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       // AnimatedLogo(controller: _controller),
                        //       yellowButtonCstm(
                        //           label: "LogIn",
                        //           onPressed: () {
                        //             Navigator.pushReplacementNamed(
                        //                 context, "/supplier_login");
                        //           },
                        //           width: 0.25,
                        //           colore: Colors.white),
                        //       Padding(
                        //         padding: const EdgeInsets.only(right: 8),
                        //         child: yellowButtonCstm(
                        //             label: "SignUp",
                        //             onPressed: () {
                        //               Navigator.pushReplacementNamed(
                        //                   context, "/supplier_signup");
                        //             },
                        //             width: 0.25,
                        //             colore: Colors.white),
                        //       )
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {}, child: const Text("Iam a Seller ")),
                const SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, "/Userscreen_login");
                    },
                    child: const Text("Iam a customer ")),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 45),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Container(
                //         height: 60,
                //         width: MediaQuery.of(context).size.width * 0.9,
                //         decoration: const BoxDecoration(
                //           color: Colors.black,
                //           borderRadius: BorderRadius.only(
                //             topRight: Radius.circular(50),
                //             bottomRight: Radius.circular(50),
                //           ),
                //         ),
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.only(left: 8),
                //               child: yellowButtonCstm(
                //                   label: "LogIn",
                //                   onPressed: () {
                //                     Navigator.pushReplacementNamed(
                //                         context, "/customer_login");
                //                   },
                //                   width: 0.25,
                //                   colore: Colors.white),
                //             ),
                //             yellowButtonCstm(
                //                 label: "SignUp",
                //                 onPressed: () {
                //                   Navigator.pushReplacementNamed(
                //                       context, "/customer_signup");
                //                 },
                //                 width: 0.25,
                //                 colore: Colors.white),
                //           ],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
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



// class GoogleFacebookLogin extends StatelessWidget {
//   final String label;
//   final Function() onPressed;
//   final Widget child;
//   const GoogleFacebookLogin(
//       {super.key,
//       required this.child,
//       required this.label,
//       required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: InkWell(
//         onTap: onPressed,
//         child: Column(
//           children: [
//             SizedBox(
//               height: 25,
//               width: 25,
//               child: child,
//             ),
//             Text(
//               label,
//               style: const TextStyle(color: Colors.white),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
