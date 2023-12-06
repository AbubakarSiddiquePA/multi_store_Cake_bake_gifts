import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';

class UserScreenLogin extends StatefulWidget {
  const UserScreenLogin({super.key});

  @override
  State<UserScreenLogin> createState() => _UserScreenLoginState();
}

class _UserScreenLoginState extends State<UserScreenLogin> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Padding(
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
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
