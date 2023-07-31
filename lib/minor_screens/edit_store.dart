import 'dart:io';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:bake_store/widgets/yellow_btn.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditStore extends StatefulWidget {
  final dynamic data;
  const EditStore({super.key, required this.data});

  @override
  State<EditStore> createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  XFile? imageFileLogo;
  XFile? imageFileCover;
  dynamic _pickedImageError;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Edit Store"),
        leading: const AppBarBackButton(),
      ),
      body: Column(
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
                        NetworkImage(widget.data["storelogo"].toString()),
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
              initialValue: widget.data["storeName"],
              decoration: textFormDecoration.copyWith(
                  labelText: "Store name", hintText: "Enter store name"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: widget.data["phone"],
              decoration: textFormDecoration.copyWith(
                  labelText: "Phone", hintText: "Enter phone no."),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
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
                      Navigator.pop(context);
                    },
                    width: 0.5,
                    colore: Colors.green)
              ],
            ),
          )
        ],
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
