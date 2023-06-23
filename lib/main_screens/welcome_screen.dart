import 'package:bake_store/main_screens/cstmr_home.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("images/logo/welcome.jpeg"))),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                "_shop",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 34,
                ),
              ),
              const SizedBox(
                height: 120,
                width: 200,
                child: Image(image: AssetImage("images/logo/app_logo1.png")),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                    Image(image: AssetImage("images/logo/app_logo1.png")),
                    yellowButtonCstm(
                        label: "LogIn",
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerHomeScreen(),
                              ));
                        },
                        width: 0.25,
                        colore: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: yellowButtonCstm(
                          label: "SignUp",
                          onPressed: () {},
                          width: 0.25,
                          colore: Colors.white),
                    )
                  ],
                ),
              ),
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
                          onPressed: () {},
                          width: 0.25,
                          colore: Colors.white),
                    ),
                    yellowButtonCstm(
                        label: "SignUp",
                        onPressed: () {},
                        width: 0.25,
                        colore: Colors.white),
                    Image(image: AssetImage("images/logo/app_logo1.png")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
