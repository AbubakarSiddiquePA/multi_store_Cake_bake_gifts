import 'package:bake_store/minor_screens/sub_categ_products.dart';
import 'package:bake_store/utilities/categ_list.dart';
import 'package:flutter/material.dart';

// List<String> imagestry = [
//   "images/cake/cake1.JPG",
//   "images/cake/cake2.jpg",
//   "images/cake/cake3.jpg",
//   "images/cake/cake4.jpg"
// ];

class CakeCategory extends StatelessWidget {
  const CakeCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryHeaderLabel(headerLabel: "CAKE"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView.count(
                        mainAxisSpacing: 70,
                        crossAxisSpacing: 15,
                        crossAxisCount: 3,
                        children: List.generate(
                          cake.length,
                          (index) {
                            return SubCategModel(
                              mainCategName: "Cake",
                              subCategName: cake[index],
                              assetName: "images/cake/cake$index.jpg",
                              subCategLabel: cake[index],
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
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
                          "Cake".toUpperCase(),
                          style: const TextStyle(
                            color: Colors.brown,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
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
            ),
          )
        ],
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
