import 'package:bake_store/main_screens/visit_store.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:flutter/material.dart';

List store = [
  "Visit Store 1",
  "Visit Store 2",
  "Visit Store 3",
  "Visit Store 4"
];

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTitle(title: "Stores"),
      ),
      body: GridView.builder(
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 150,
                width: 120,
                child: Image.asset("images/store/store (2).gif"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VisitStore(),
                      ));
                },
                child: Text(
                  store[index],
                  style: TextStyle(fontSize: 19),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
