// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: Stack(
          children: [
            Container(
              height: 230,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.white70],
                ),
              ),
            ),
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  expandedHeight: 140,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      return FlexibleSpaceBar(
                        title: AnimatedOpacity(
                          opacity: constraints.biggest.height <= 120 ? 1 : 0,
                          duration: const Duration(milliseconds: 200),
                          child: const Text(
                            "Account",
                            style: TextStyle(color: Colors.black, fontSize: 25),
                          ),
                        ),
                        background: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black87, Colors.white70],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15, left: 30),
                            child: Row(
                              children: [
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      "images/profile/guest_profile.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    "Guest".toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onPressed: () {},
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
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
                              onPressed: () {},
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
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
                              onPressed: () {},
                              child: SizedBox(
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.2,
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
                          SizedBox(
                            height: 150,
                            child: Image(
                                image: AssetImage("images/logo/app_logo1.png")),
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
                              child: const Column(
                                children: [
                                  RepeatedListTile(
                                    title: "Email",
                                    subTitle: "example@gmail.com",
                                    icon: Icons.email,
                                  ),
                                  GreyDivider(),
                                  RepeatedListTile(
                                    title: "Phone Number",
                                    subTitle: "+91 9991786313",
                                    icon: Icons.phone,
                                  ),
                                  GreyDivider(),
                                  RepeatedListTile(
                                    title: "Adress",
                                    subTitle: "13th street calicut 654258",
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
                                  const ListTile(
                                    title: Text("LogOut"),
                                    subtitle: Text(" "),
                                    leading: Icon(Icons.logout),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
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
