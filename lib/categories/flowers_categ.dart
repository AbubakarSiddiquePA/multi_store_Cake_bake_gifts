import 'package:bake_store/utilities/categ_list.dart';
import 'package:flutter/material.dart';

import '../widgets/catgry_widgets.dart';

class FlowersCategory extends StatelessWidget {
  const FlowersCategory({super.key});

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
                  const CategoryHeaderLabel(headerLabel: "FLOWERS"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.60,
                    child: GridView.count(
                        mainAxisSpacing: 70,
                        crossAxisSpacing: 15,
                        crossAxisCount: 3,
                        children: List.generate(
                          cake.length - 1,
                          (index) {
                            return SubCategModel(
                              mainCategName: "Flowers",
                              subCategName: cake[index + 1],
                              assetName: "images/cake/cake$index.jpg",
                              subCategLabel: cake[index + 1],
                            );
                          },
                        )),
                  )
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(maincategName: "Flowers"),
          )
        ],
      ),
    );
  }
}
