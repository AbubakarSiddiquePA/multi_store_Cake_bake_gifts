import 'package:bake_store/widgets/fake_search.dart';
import 'package:flutter/material.dart';

List<ItemData> items = [
  ItemData(label: "Cake"),
  ItemData(label: "Bake"),
  ItemData(label: "Gifts"),
  ItemData(label: "Bake"),
  ItemData(label: "Bake"),
  ItemData(label: "Bake"),
  ItemData(label: "Bake"),
  ItemData(label: "Bake"),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const FakeSearch(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: sideNavigator(size)),
          Positioned(bottom: 0, right: 0, child: categoryView(size))
        ],
      ),
    );
  }

  Widget sideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      //takes 20% of any device width
      width: MediaQuery.of(context).size.width * 0.2,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              for (var element in items) {
                element.isSelected = false;
              }
              setState(() {
                items[index].isSelected = true;
              });
            },
            child: Container(
              color:
                  items[index].isSelected == true ? Colors.white : Colors.grey,
              height: 100,
              child: Center(
                child: Text(items[index].label),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget categoryView(Size size) {
    return Container(
      height: size.height * 0.8,
      //takes 80% of any device width

      width: size.width * 0.8,
      color: Colors.white,
    );
  }
}

class ItemData {
  String label;
  bool isSelected;
  ItemData({required this.label, this.isSelected = false});
}
