import 'package:flutter/material.dart';

import '../minor_screens/sub_categ_products.dart';

class SliderBar extends StatelessWidget {
  final String maincategName;
  const SliderBar({super.key, required this.maincategName});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.79,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50)),
        child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "<<",
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  maincategName.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.brown,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                maincategName == "Cake"
                    ? const Text(" ")
                    : const Text(
                        ">>",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            )),
      ),
    );
  }
}

class SubCategModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  const SubCategModel(
      {super.key,
      required this.assetName,
      required this.mainCategName,
      required this.subCategName,
      required this.subCategLabel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubCategoryProducts(
                  maincategoryName: mainCategName,
                  subcategoryName: subCategName),
            ));
      },
      child: Column(children: [
        SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(assetName),
            )),
        Text(subCategLabel),
      ]),
    );
  }
}

class CategoryHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const CategoryHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
            letterSpacing: 10),
      ),
    );
  }
}
