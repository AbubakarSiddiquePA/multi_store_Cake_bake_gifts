// ignore_for_file: avoid_print

import 'package:bake_store/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  bool passwordVisibility = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const AuthHeaderLabel(headerLabel: "SignUp"),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey.shade800,
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            child: IconButton(
                              onPressed: () {
                                print("Pic image from Camera");
                              },
                              icon: const Icon(Icons.camera_alt),
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey.shade800,
                                borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                    bottomRight: Radius.circular(15))),
                            child: IconButton(
                              onPressed: () {
                                print("Pic image from gallery");
                              },
                              icon: const Icon(Icons.photo),
                              color: Colors.white,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      decoration: textFormDecoration.copyWith(
                          labelText: "Full Name",
                          hintText: "Enter your full name"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: textFormDecoration.copyWith(
                          labelText: "Email Adress",
                          hintText: "Enter your email"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      obscureText: passwordVisibility,
                      decoration: textFormDecoration.copyWith(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                            icon: Icon(passwordVisibility
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Colors.grey,
                          ),
                          labelText: "Password",
                          hintText: "Enter your password"),
                    ),
                  ),
                  HaveAccount(
                    actionLabel: "LogIn",
                    haveAccount: "Already have an account?",
                    onPressed: () {},
                  ),
                  AuthMainButton(
                    mainButtonLabel: "SignUp",
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
