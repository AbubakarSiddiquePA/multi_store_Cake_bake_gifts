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
              const Text(
                "Store Logo",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue,
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
                      SizedBox(
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
              Padding(
                padding: EdgeInsets.all(16),
                child: Divider(
                  color: Colors.yellow,
                  thickness: 2.5,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
