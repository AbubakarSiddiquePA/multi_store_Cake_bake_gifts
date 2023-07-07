// ignore_for_file: avoid_print

import 'dart:io';

import 'package:bake_store/widgets/auth_widgets.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/snackbar.dart';

class CustomerRegister extends StatefulWidget {
  const CustomerRegister({super.key});

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
  late String name;
  late String email;
  late String password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  bool passwordVisibility = false;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  dynamic _pickedImageError;

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        _imageFile = pickedImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
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
                              backgroundImage: _imageFile == null
                                  ? null
                                  : FileImage(File(_imageFile!.path)),
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
                                    _pickImageFromCamera();
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
                                    _pickImageFromGallery();
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your full name";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            name = value;
                          },
                          // controller: _namecontroller,
                          decoration: textFormDecoration.copyWith(
                              labelText: "Full Name",
                              hintText: "Enter your full name"),
                        ),
                      ),
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
                      HaveAccount(
                        actionLabel: "LogIn",
                        haveAccount: "Already have an account?",
                        onPressed: () {
                          Navigator.pushNamed(context, "/customer_login");
                        },
                      ),
                      AuthMainButton(
                        mainButtonLabel: "Sign Up",
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            //validate for image pick
                            if (_imageFile != null) {
                              print("image picked");
                              print("Valid");

                              print(name);
                              print(email);
                              print(password);
                              //just for reseting current values
                              _formKey.currentState!.reset();
                              setState(() {
                                _imageFile = null;
                              });
                            } else {
                              MyMessageHandler.showSnackBar(
                                  _scaffoldKey, "please pick image first");
                            }
                          } else {
                            MyMessageHandler.showSnackBar(
                                _scaffoldKey, "please fill all fields");
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
      ),
    );
  }
}
