// import 'package:flutter/material.dart';

import 'package:bake_store/customer_screens/address_book.dart';
import 'package:bake_store/customer_screens/custmr_orders.dart';
import 'package:bake_store/customer_screens/wishlist.dart';
import 'package:bake_store/main_screens/cart.dart';
import 'package:bake_store/providers/auth_repo.dart';
import 'package:bake_store/widgets/appbar_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../customer_screens/add_address.dart';
import '../widgets/alert_dialg.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;
  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseAuth.instance.currentUser!.isAnonymous
          ? anonymous.doc(widget.documentId).get()
          : customers.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          //from the firestore document below line is syntax to be passed for each
          // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black87, Colors.white70],
                      ),
                    ),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: true,
                        centerTitle: true,
                        elevation: 0,
                        backgroundColor: Colors.white,
                        expandedHeight: 140,
                        flexibleSpace: LayoutBuilder(
                          builder: (context, constraints) {
                            return FlexibleSpaceBar(
                              title: AnimatedOpacity(
                                opacity:
                                    constraints.biggest.height <= 120 ? 1 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: const Text(
                                  "Account",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25),
                                ),
                              ),
                              background: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.black87, Colors.white70],
                                  ),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 15, left: 30),
                                  child: Row(
                                    children: [
                                      data["profileimage"] == ""
                                          ? const CircleAvatar(
                                              radius: 50,
                                              backgroundImage: AssetImage(
                                                  "images/profile/guest_profile.png"),
                                            )
                                          : CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                  data["profileimage"])),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 30),
                                        child: Text(
                                          data["name"] == ""
                                              ? "guest".toUpperCase()
                                              : data["name"].toUpperCase(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CartScreen(
                                                      back: AppBarBackButton()),
                                            ));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            "Cart",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const WishlistScreen(),
                                            ));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            "Wishlist",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const CustomerOrders(),
                                            ));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            "Orders",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 150,
                                    child: Image(
                                        image: AssetImage(
                                            "images/logo/app_logo1.png")),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: "  Account Info  "),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: "Email",
                                            subTitle: data["email"] == ""
                                                ? "example@gmail.com"
                                                : data["email"],
                                            icon: Icons.email,
                                          ),
                                          const GreyDivider(),
                                          RepeatedListTile(
                                            title: "Phone Number",
                                            subTitle: data["phone"] == ""
                                                ? "eg:+91 6660001122"
                                                : data["phone"],
                                            icon: Icons.phone,
                                          ),
                                          const GreyDivider(),
                                          RepeatedListTile(
                                            onPressed: FirebaseAuth.instance
                                                    .currentUser!.isAnonymous
                                                ? null
                                                : () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const AddressBook(),
                                                        ));
                                                  },
                                            title: "Address",
                                            subTitle: userAdress(data),
                                            /*data["address"] == ""
                                                ? "13th street ,hennur cross ,banglore 142"
                                                : data["address"],*/
                                            icon: Icons.location_pin,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: "  Account Settings  "),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: "Edit Profile",
                                            subTitle: "",
                                            icon: Icons.edit,
                                            onPressed: () {},
                                          ),
                                          const GreyDivider(),
                                          const RepeatedListTile(
                                            title: "Change Password",
                                            subTitle: " ",
                                            icon: Icons.lock,
                                          ),
                                          const GreyDivider(),
                                          RepeatedListTile(
                                            title: "LogOut",
                                            icon: Icons.logout,
                                            onPressed: () async {
                                              MyAlertDialog.showMyDialogue(
                                                  context: context,
                                                  title: "LogOut",
                                                  content:
                                                      "Are you sure you want to log out?",
                                                  tabNo: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  tabYes: () async {
                                                    // Perform the log out operation
                                                    await AuthRepo.logOut();
                                                    await Future.delayed(
                                                            const Duration(
                                                                microseconds:
                                                                    100))
                                                        .whenComplete(() {
                                                      Navigator.pop(context);
                                                      Navigator
                                                          .pushReplacementNamed(
                                                              context,
                                                              "/welcome_screen");
                                                    });
                                                  });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Container(
                          height: 1000, // Replace with the desired height
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Additional Content',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );
  }
}

String userAdress(dynamic data) {
  if (FirebaseAuth.instance.currentUser!.isAnonymous == true) {
    return "example:48th street , Mumbai, India ";
  } else if (FirebaseAuth.instance.currentUser!.isAnonymous == false &&
      data["address"] == "") {
    return "set your address";
  }
  return data["address"];
}

class GreyDivider extends StatelessWidget {
  const GreyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.grey.shade400,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;

  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile(
      {super.key,
      required this.title,
      this.subTitle = " ",
      required this.icon,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const ProfileHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                color: Colors.grey, fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
