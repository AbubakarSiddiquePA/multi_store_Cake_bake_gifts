import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/snackbar.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String firstName;
  late String lastName;
  late String phone;
  String countryValue = "Choose Country";
  String stateValue = "Choose State";
  String cityValue = "Choose City";

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: const AppBarBackButton(),
          title: const AppBarTitle(title: "Add Address"),
        ),
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 40, 30, 40),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.10,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your first name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              firstName = newValue!;
                            },
                            decoration: textFormDecoration.copyWith(
                                labelText: "First Name",
                                hintText: "Enter your first name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.10,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Last name";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              lastName = newValue!;
                            },
                            decoration: textFormDecoration.copyWith(
                                labelText: "Last Name",
                                hintText: "Enter your Last name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.50,
                          height: MediaQuery.of(context).size.width * 0.10,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your Phone number";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              phone = newValue!;
                            },
                            decoration: textFormDecoration.copyWith(
                                labelText: "Phone number",
                                hintText: "Enter your Phone number"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SelectState(
                  // style: TextStyle(color: Colors.red),
                  onCountryChanged: (value) {
                    setState(() {
                      countryValue = value;
                    });
                  },
                  onStateChanged: (value) {
                    setState(() {
                      stateValue = value;
                    });
                  },
                  onCityChanged: (value) {
                    setState(() {
                      cityValue = value;
                    });
                  },
                ),
                Center(
                  child: yellowButtonCstm(
                      label: "Add New Address",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (countryValue != "Choose Country" &&
                              stateValue != "Choose State" &&
                              cityValue != "Choose City") {
                            formKey.currentState!.save();
                          } else {
                            MyMessageHandler.showSnackBar(
                                _scaffoldKey, "Please set your Location");
                          }
                        } else {
                          MyMessageHandler.showSnackBar(
                              _scaffoldKey, "Please fill all fields");
                        }
                      },
                      width: 0.8,
                      colore: Colors.blue),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
  labelText: "Full Name",
  hintText: "Enter Your Full Name",
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: Colors.black, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
);
