import 'dart:io';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/snackbar.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key, required this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
  late String storeName;
  late String phone;
  late String storeLogo;
  late String coverImage;

  final ImagePicker _picker = ImagePicker();
  pickStoreLogo() async {
    try {
      final pickedStoreLogo = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileLogo = pickedStoreLogo;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  pickCoverImage() async {
    try {
      final pickedCoverImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      setState(() {
        imageFileCover = pickedCoverImage;
      });
    } catch (e) {
      setState(() {
        _pickedImageError = e;
      });
      print(_pickedImageError);
    }
  }

  Future uploadStoreLogo() async {
    if (imageFileLogo != null) {
      try {
        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref("supp-images/${widget.data["email"]}.jpg");

        //uploading file
        await ref.putFile(File(imageFileLogo!.path));
        //get url for image
        storeLogo = await ref.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      storeLogo = widget.data["storeLogo"];
    }
  }

  Future uploadCoverImage() async {
    if (imageFileCover != null) {
      try {
        firebase_storage.Reference ref2 = firebase_storage
            .FirebaseStorage.instance
            .ref("supp-images/${widget.data["email"]}.jpg-cover");

        //uploading file
        await ref2.putFile(File(imageFileLogo!.path));
        //get url for image
        coverImage = await ref2.getDownloadURL();
      } catch (e) {
        print(e);
      }
    } else {
      //the same cover image inside app
      coverImage = widget.data["storeLogo"];
    }
  }

  editStoreDate() async {
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection("suppliers")
          .doc(FirebaseAuth.instance.currentUser!.uid);
      transaction.update(documentReference, {
        "storename": storeName,
        "phone": phone,
        "storelogo": storeLogo,
        "coverimage": coverImage,
      });
    }).whenComplete(() => Navigator.pop(context));
  }

  saveChanges() async {
    if (formKey.currentState!.validate()) {
      //continue
      formKey.currentState!.save();
      await uploadStoreLogo().whenComplete(() async =>
          await uploadCoverImage().whenComplete(() => editStoreDate()));
    } else {
      MyMessageHandler.showSnackBar(
          scaffoldKey, "please fill all fields first");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const AppBarTitle(title: "Edit Store"),
          leading: const AppBarBackButton(),
        ),
        body: Form(
          key: formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Store Logo",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(widget.data["storeLogo"].toString()),
                      ),
                      Column(
                        children: [
                          yellowButtonCstm(
                              label: "change",
                              onPressed: () {
                                pickStoreLogo();
                              },
                              width: 0.25,
                              colore: Colors.yellow),
                          const SizedBox(
                            height: 10,
                          ),
                          imageFileLogo == null
                              ? const SizedBox()
                              : yellowButtonCstm(
                                  label: "Reset",
                                  onPressed: () {
                                    setState(() {
                                      //clear picked image
                                      imageFileLogo = null;
                                    });
                                  },
                                  width: 0.25,
                                  colore: Colors.yellow),
                        ],
                      ),
                      imageFileLogo == null
                          ? const SizedBox()
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                File(imageFileLogo!.path),
                              ),
                            ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Cover Image",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey.shade900,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            NetworkImage(widget.data["coverimage"].toString()),
                      ),
                      Column(
                        children: [
                          yellowButtonCstm(
                              label: "change",
                              onPressed: () {
                                pickCoverImage();
                              },
                              width: 0.25,
                              colore: Colors.yellow),
                          const SizedBox(
                            height: 10,
                          ),
                          imageFileCover == null
                              ? const SizedBox()
                              : yellowButtonCstm(
                                  label: "Reset",
                                  onPressed: () {
                                    setState(() {
                                      //clear picked image
                                      imageFileCover = null;
                                    });
                                  },
                                  width: 0.25,
                                  colore: Colors.yellow),
                        ],
                      ),
                      imageFileCover == null
                          ? const SizedBox()
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(
                                File(imageFileCover!.path),
                              ),
                            ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Divider(
                      color: Colors.yellow,
                      thickness: 2.5,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your store name";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    storeName = value!;
                  },
                  initialValue: widget.data["storeName"],
                  decoration: textFormDecoration.copyWith(
                      labelText: "Store name", hintText: "Enter store name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone no.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    phone = value!;
                  },
                  initialValue: widget.data["phone"],
                  decoration: textFormDecoration.copyWith(
                      labelText: "Phone", hintText: "Enter phone no."),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: Row(
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
                        label: "Save Changes",
                        onPressed: () {
                          saveChanges();
                        },
                        width: 0.5,
                        colore: Colors.green)
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
