import 'package:bake_store/providers/auth_repo.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  bool checkPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Change Password"),
        leading: const AppBarBackButton(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 30),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  "To change your password please fill the form below and click save",
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.1,
                      color: Colors.blueGrey,
                      fontFamily: "Acme",
                      fontStyle: FontStyle.italic),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "enter your password";
                      }
                      return null;
                    },
                    controller: oldPasswordController,
                    decoration: passwordFormDecoration.copyWith(
                      labelText: "Old Password",
                      hintText: "Enter your current password",
                      errorText:
                          checkPassword != true ? "not valid password" : null,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: passwordFormDecoration.copyWith(
                      labelText: "New Password",
                      hintText: "Enter your New password",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: passwordFormDecoration.copyWith(
                      labelText: "Repeat Password",
                      hintText: "Re-Enter your New password",
                    ),
                  ),
                ),
                const Spacer(),
                yellowButtonCstm(
                    label: "Save Changes",
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        checkPassword = await AuthRepo.CheckOldPassword(
                            FirebaseAuth.instance.currentUser!.email!,
                            oldPasswordController.text);
                        setState(() {
                          // checkPassword = false;
                        });
                        checkPassword == true
                            ? print("valid old password")
                            : print("not valid old password");
                        // ignore: avoid_print
                        print("form valid");
                      } else {
                        // ignore: avoid_print
                        print("form not valid");
                      }
                    },
                    width: 0.7,
                    colore: Colors.green)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var passwordFormDecoration = InputDecoration(
    labelText: "Full Name",
    hintText: "Enter your full Name",
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.purple, width: 1),
        borderRadius: BorderRadius.circular(6)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.deepPurpleAccent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(6)));
