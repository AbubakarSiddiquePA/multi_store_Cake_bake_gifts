import 'package:bake_store/galleries/bake_gallery.dart';
import 'package:bake_store/galleries/cake_gallery.dart';
import 'package:bake_store/galleries/cards.dart';
import 'package:bake_store/galleries/flowers.dart';
import 'package:bake_store/galleries/gitts_gallery.dart';
import 'package:bake_store/galleries/hampers.dart';
import 'package:bake_store/galleries/save_the_date.dart';
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
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade100.withOpacity(0.5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                // RepeatedTab(
                //   label: 'Hampers',
                // ),
                // RepeatedTab(
                //   label: 'Save the date',
                // ),
                RepeatedTab(
                  label: 'Flowers',
                ),
                // RepeatedTab(
                //   label: 'Cards',
                // ),
              ]),
        ),
        body: const TabBarView(
          children: [
            CakeGalleryScreen(),
            BakeGalleryScreen(),
            GiftGalleryScreen(),
            // HampersGallery(),
            // SaveTheDateGallery(),
            FlowersGallery(),
            // CardsGallery(),
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
