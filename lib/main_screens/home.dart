import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
              isScrollable: true,
              indicatorColor: Colors.black,
              tabs: [
                RepeatedTab(
                  label: 'Cake',
                ),
                RepeatedTab(
                  label: 'Bake',
                ),
                RepeatedTab(
                  label: 'Gift',
                ),
              ]),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: Text("Cake Screen"),
            ),
            Center(
              child: Text("Bake Screen"),
            ),
            Center(
              child: Text("Gifts Screen"),
            ),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;
  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade800),
      ),
    );
  }
}
