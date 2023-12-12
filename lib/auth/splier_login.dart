// ignore_for_file: avoid_print
import 'package:bake_store/providers/auth_repo.dart';
import 'package:bake_store/widgets/auth_widgets.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/snackbar.dart';

class SupplierLogin extends StatefulWidget {
  const SupplierLogin({super.key});

  @override
  State<SupplierLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<SupplierLogin> {
  late String email;
  late String password;
  bool processing = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisibility = false;
  bool sendEmailVerification = false;

  void logIn() async {
    setState(() {
      processing = true;
    });
    if (_formKey.currentState!.validate()) {
      //validate for image pick
      try {
        await AuthRepo.signInWithEmailAndPassword(email, password);

        await AuthRepo.reloadUserData();

        if (await AuthRepo.checkEmailVerification()) {
          //just for reseting current values

          _formKey.currentState!.reset();
          await Future.delayed(const Duration(milliseconds: 100))
              .whenComplete(() {
            Navigator.pushReplacementNamed(context, "/supplier_screen");
          });
        } else {
          MyMessageHandler.showSnackBar(
              _scaffoldKey, "please Check your mail inbox");
          setState(() {
            processing = false;
            sendEmailVerification = true;
          });
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          processing = false;
        });
        MyMessageHandler.showSnackBar(_scaffoldKey, e.message.toString());
      }
    } else {
      setState(() {
        processing = false;
      });
      MyMessageHandler.showSnackBar(_scaffoldKey, "please fill all fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AuthHeaderLabel(headerLabel: "LogIn Seller"),
                      SizedBox(
                          height: 50,
                          child: sendEmailVerification == true
                              ? Center(
                                  child: yellowButtonCstm(
                                      label: "Resend verification,",
                                      onPressed: () async {
                                        try {
                                          await FirebaseAuth
                                              .instance.currentUser!
                                              .sendEmailVerification();
                                          MyMessageHandler.showSnackBar(
                                              _scaffoldKey,
                                              "verification Sent please check your mail");
                                        } catch (e) {
                                          print(e);
                                        }

                                        Future.delayed(
                                                const Duration(seconds: 3))
                                            .whenComplete(() {
                                          setState(() {
                                            sendEmailVerification = false;
                                          });
                                        });
                                      },
                                      width: 0.4,
                                      colore: Colors.blue),
                                )
                              : const SizedBox()),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            } else if (value.isValidEmail() == false) {
                              return "invalid email";
                            } else if (value.isValidEmail() == true) {
                              return null;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            email = value;
                          },
                          // controller: _emailcontroller,
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
                          onChanged: (value) {
                            password = value;
                          },
                          // controller: _passwordcontroller,
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
                      TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot Password ? ",
                            style: TextStyle(
                                fontSize: 18, fontStyle: FontStyle.italic),
                          )),
                      HaveAccount(
                        actionLabel: "Sign Up",
                        haveAccount: "Don't have an account?  ",
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, "/supplier_signup");
                        },
                      ),
                      processing == true
                          ? const Center(
                              child: CircularProgressIndicator(
                              semanticsLabel: "logging In",
                              color: Colors.green,
                            ))
                          : AuthMainButton(
                              mainButtonLabel: "Log In",
                              onPressed: () {
                                logIn();
                              },
                            )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
