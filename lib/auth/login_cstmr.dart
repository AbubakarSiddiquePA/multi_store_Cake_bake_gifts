// ignore_for_file: avoid_print

import 'package:bake_store/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const AuthHeaderLabel(headerLabel: "LogIn"),
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
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your email";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: textFormDecoration.copyWith(
                            labelText: "Email Adress",
                            hintText: "Enter your email"),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter your password";
                          }
                          return null;
                        },
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
                      actionLabel: "SignUp",
                      haveAccount: "Don't have an account? ",
                      onPressed: () {
                        // Navigator.pushNamed(context, "/welcome_screen");
                      },
                    ),
                    AuthMainButton(
                      mainButtonLabel: "Log In",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("Valid");
                        } else {
                          print("Not valid");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
