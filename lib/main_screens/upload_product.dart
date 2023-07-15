import 'package:bake_store/utilities/categ_list.dart';
import 'package:bake_store/widgets/snackbar.dart';
import 'package:flutter/material.dart';

class UploadProductScreen extends StatefulWidget {
  const UploadProductScreen({super.key});

  @override
  State<UploadProductScreen> createState() => _UploadProductScreenState();
}

class _UploadProductScreenState extends State<UploadProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  String mainCategoryValue = "cake";
  String subCategValue = "Birthday";
  List<String> categCake = [
    "Birthday",
    "Anniversary",
    "Wedding",
  ];

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: const Center(
                          child: Text(
                            "You have not \n \n picked images yet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              "Select Main category",
                            ),
                            DropdownButton(
                              value: mainCategoryValue,
                              // items: ["Cake", "Bake", "Gift", "Hampers"]
                              items: maincateg
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              // items: [
                              //   DropdownMenuItem(
                              //     value: "Cake",
                              //     child: Text("Cake"),
                              //   ),
                              //   DropdownMenuItem(
                              //     value: "Bake",
                              //     child: Text("Bake"),
                              //   ),
                              //   DropdownMenuItem(
                              //     value: "Gift",
                              //     child: Text("Gift"),
                              //   )
                              // ],
                              onChanged: (String? value) {
                                print(value);
                                setState(() {
                                  mainCategoryValue = value!;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              "Select Sub category",
                            ),
                            DropdownButton(
                              value: subCategValue,
                              // items: ["Cake", "Bake", "Gift", "Hampers"]
                              items: categCake
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),

                              onChanged: (String? value) {
                                print(value);
                                setState(() {
                                  subCategValue = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                    child: Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.38,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter price";
                            } else if (value.isValidPrice() != true) {
                              return "please enter valid price";
                            }
                            return null;
                          },
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: textFormDecoration.copyWith(
                              labelText: "Price", hintText: "Price..Rs?")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.45,
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter quantity";
                            } else if (value.isValidQuantity() != true) {
                              return "not valid quantity";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: textFormDecoration.copyWith(
                              labelText: "Quantity", hintText: "Add quantity")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter Product Name";
                            }
                            return null;
                          },
                          maxLength: 100,
                          maxLines: 3,
                          decoration: textFormDecoration.copyWith(
                              labelText: "Product Name",
                              hintText: "Enter product name")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter Product Description";
                            }
                            return null;
                          },
                          maxLength: 800,
                          maxLines: 5,
                          decoration: textFormDecoration.copyWith(
                              labelText: "Product Description",
                              hintText: "Enter Product description")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: FloatingActionButton(
                onPressed: () {},
                backgroundColor: Colors.black,
                child: const Icon(Icons.photo_library),
              ),
            ),
            FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print("valid");
                } else {
                  MyMessageHandler.showSnackBar(
                      _scaffoldKey, "please fill all fields");
                }
              },
              backgroundColor: Colors.black,
              child: const Icon(Icons.upload),
            )
          ],
        ),
      ),
    );
  }
}

var textFormDecoration = InputDecoration(
    labelStyle: const TextStyle(color: Colors.blueGrey),
    labelText: "Price",
    hintText: "Price..Rs?",
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10)));

extension QuantityValidator on String {
  bool isValidQuantity() {
    return RegExp(r'^[1-9][0-9]*$').hasMatch(this);
  }
}

extension PriceValidator on String {
  bool isValidPrice() {
    //we have number from 1st digit can be  1-9 and second digit can startfrom 0 (*implies that digits can be repeated also its optional )  followed by . operator
    //whenn we use || we are going through checking each part
    return RegExp(r'^((([1-9][0-9]*[\.]*)||([0][\.]*))([0-9]{1,2}))$')
        .hasMatch(this);
  }
}
