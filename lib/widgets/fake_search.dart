import 'package:flutter/material.dart';

import '../minor_screens/search.dart';

class FakeSearch extends StatelessWidget {
  const FakeSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SearchScreen(),
            ));
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.4),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey.shade400,
                  ),
                ),
                Text(
                  "What are you looking for?",
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(6),
              height: 32,
              width: 75,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                "search",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
