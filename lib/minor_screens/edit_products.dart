import 'dart:io';
import 'package:bake_store/utilities/categ_list.dart';
import 'package:bake_store/widgets/snackbar.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class EditProduct extends StatefulWidget {
  final dynamic items;
  const EditProduct({super.key, required this.items});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late double price;
  late int quantity;
  late String productName;
  late String productDescription;
  late String productId;
  int? discount = 0;
  String mainCategoryValue = "select category";
  String subCategValue = "subcategory";
  List<String> subCategList = [];
  bool processing = false;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? imagesFileList = [];
  List<String> imagesUrlList = [];

  dynamic _pickedImageError;

  void pickProductImages() async {
    try {
      final pickedImages = await _picker.pickMultiImage(
          maxHeight: 300, maxWidth: 300, imageQuality: 95);
      setState(() {
        imagesFileList = pickedImages!;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Widget previewImages() {
    if (imagesFileList!.isNotEmpty) {
      return ListView.builder(
        itemCount: imagesFileList!.length,
        itemBuilder: (context, index) {
          return Image.file(File(imagesFileList![index].path));
        },
      );
    } else {
      return const Center(
        child: Text(
          "You have not \n \n picked images yet",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }
  }

  Widget previewCurrentImages() {
    List<dynamic> itemsImages = widget.items["proimages"];
    return ListView.builder(
      itemCount: itemsImages.length,
      itemBuilder: (context, index) {
        return Image.network(itemsImages[index].toString());
      },
    );
  }

  void selectedMainCategory(String? value) {
    if (value == "select category") {
      subCategList = [];
    } else if (value == "cake") {
      subCategList = cake;
    } else if (value == "bake") {
      subCategList = bake;
    } else if (value == "gifts") {
      subCategList = gifts;
    } else if (value == "flowers") {
      subCategList = flowers;
    }
    print(value);
    setState(() {
      mainCategoryValue = value!;
      subCategValue = "subcategory";
    });
  }

  Future<void> uploadImages() async {
    if (mainCategoryValue != "select category" &&
        subCategValue != "subcategory") {
      if (_formKey.currentState!.validate()) {
        //by using on save its going to wait until we save data
        //hear we save by on tapping on upload button
        _formKey.currentState!.save();
        if (imagesFileList!.isNotEmpty) {
          setState(() {
            processing = true;
          });
          try {
            for (var image in imagesFileList!) {
              firebase_storage.Reference ref = firebase_storage
                  .FirebaseStorage.instance
                  .ref("products/${path.basename(image.path)}");
              await ref.putFile(File(image.path)).whenComplete(() async {
                await ref.getDownloadURL().then((value) {
                  imagesUrlList.add(value);
                });
              });
            }
          } catch (e) {
            print(e);
          }
          //because we have few images(multiple) we are setting loop
        } else {
          MyMessageHandler.showSnackBar(_scaffoldKey, "please pick images");
        }
      } else {
        MyMessageHandler.showSnackBar(_scaffoldKey, "please fill all fields");
      }
    } else {
      MyMessageHandler.showSnackBar(_scaffoldKey, "please select categories");
    }
  }

  void uploadData() async {
    if (imagesUrlList.isNotEmpty) {
      CollectionReference productRef =
          FirebaseFirestore.instance.collection("products");
      productId = const Uuid().v4();
      await productRef.doc(productId).set({
        "proid": productId,
        "maincategory": mainCategoryValue,
        "subcategory": subCategValue,
        "price": price,
        "instock": quantity,
        "proname": productName,
        "prodesc": productDescription,
        "sid": FirebaseAuth.instance.currentUser!.uid,
        "proimages": imagesUrlList,
        "discount": discount,
      }).whenComplete(() {
        setState(() {
          processing = false;
          imagesFileList = [];
          mainCategoryValue = "select category";
          // subCategValue = "subcategory";
          subCategList = [];
          imagesUrlList = [];
        });
        _formKey.currentState!.reset();
      });
    } else {
      // ignore: avoid_print
      print("no images");
    }
  }

  void uploadProduct() async {
    await uploadImages().whenComplete(() => uploadData());
  }

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
                          child: previewCurrentImages()),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              " Main category",
                              style: TextStyle(color: Colors.red),
                            ),
                            Container(
                              margin: EdgeInsets.all(8),
                              padding: const EdgeInsets.all(6),
                              // constraints: BoxConstraints(maxHeight: 25),
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                  child: Text(widget.items["maincategory"])),
                            ),
                            Column(
                              children: [
                                const Text(
                                  " Sub category",
                                  style: TextStyle(color: Colors.red),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  padding: const EdgeInsets.all(6),
                                  // constraints: BoxConstraints(maxHeight: 25),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                      child: Text(widget.items["subcategory"])),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.blueGrey.shade100,
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: imagesFileList != null
                            ? previewImages()
                            : const Center(
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
                              "* Select Main category",
                              style: TextStyle(color: Colors.red),
                            ),
                            DropdownButton(
                              iconEnabledColor: Colors.red,
                              dropdownColor: Colors.white,

                              value: mainCategoryValue,
                              // items: ["Cake", "Bake", "Gift", "Hampers"]
                              items: maincateg
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),

                              onChanged: (String? value) {
                                selectedMainCategory(value);
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Column(
                              children: [
                                const Text(
                                  "* Select Sub category",
                                  style: TextStyle(color: Colors.red),
                                ),
                                DropdownButton(
                                  iconEnabledColor: Colors.red,
                                  iconDisabledColor: Colors.black,
                                  menuMaxHeight: 500,
                                  dropdownColor: Colors.white,
                                  disabledHint: const Text("select category"),
                                  value: subCategValue,
                                  // items: ["Cake", "Bake", "Gift", "Hampers"]
                                  items: subCategList
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
                  Row(
                    children: [
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
                              onSaved: (value) {
                                price = double.parse(value!);
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: textFormDecoration.copyWith(
                                  labelText: "Price", hintText: "Price..Rs?")),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: TextFormField(
                              maxLength: 2,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return null;
                                } else if (value.isValidDiscount() != true) {
                                  return "invalid discount";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                discount = int.parse(value!);
                              },
                              keyboardType:
                                  const TextInputType.numberWithOptions(),
                              decoration: textFormDecoration.copyWith(
                                  labelText: "Discount",
                                  hintText: "Discount..%?")),
                        ),
                      ),
                    ],
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
                          onSaved: (value) {
                            quantity = int.parse(value!);
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
                          onSaved: (value) {
                            productName = value!;
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
                          onSaved: (value) {
                            productDescription = value!;
                          },
                          maxLength: 800,
                          maxLines: 5,
                          decoration: textFormDecoration.copyWith(
                              labelText: "Product Description",
                              hintText: "Enter Product description")),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      yellowButtonCstm(
                          label: "Cancel",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 0.25,
                          colore: Colors.blue),
                      yellowButtonCstm(
                          label: "Save changes",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          width: 0.5,
                          colore: Colors.green)
                    ],
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

extension DiscountValidator on String {
  bool isValidDiscount() {
    //we have number from 1st digit can be  1-9 and second digit can startfrom 0 (*implies that digits can be repeated also its optional )  followed by . operator
    //whenn we use || we are going through checking each part
    return RegExp(r'^([0-9]*)$').hasMatch(this);
  }
}
