import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monetization_system/presentation/auth/login_page.dart';
import 'package:monetization_system/presentation/pages/payment_page.dart';
import 'package:monetization_system/presentation/pages/payment_page_premium.dart';
import 'package:monetization_system/presentation/screens/home_tab.dart';
import 'package:monetization_system/presentation/screens/notif_tab.dart';
import 'package:monetization_system/presentation/screens/post_status.dart';
import 'package:monetization_system/presentation/screens/profile_tab.dart';
import 'package:monetization_system/presentation/widgets/search_bar_widget.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selectedIndex = 0;

  final box = GetStorage();

  @override
  void initState() {
    getData();

    super.initState();
  }

  late String profilePicture = '';
  late String subscription = '';

  late String query = '';
  getData() async {
    // Use provider
    var collection = FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: box.read('email'));

    var querySnapshot = await collection.get();
    if (mounted) {
      setState(() {
        for (var queryDocumentSnapshot in querySnapshot.docs) {
          Map<String, dynamic> data = queryDocumentSnapshot.data();

          profilePicture = data['profilePicture'];
          subscription = data['subscription'];
        }
      });
    }
  }

  late String searchResult = '';

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: (() {
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));
      }),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextBold(
              text: 'CITE Social Network', fontSize: 18, color: Colors.grey),
          elevation: 0.5,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              maxRadius: 30,
              minRadius: 30,
              backgroundImage: NetworkImage(profilePicture),
            ),
          ),
          actions: [
            selectedIndex == 3
                ? IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text(
                                  'Logout Confirmation',
                                  style: TextStyle(
                                      fontFamily: 'QBold',
                                      fontWeight: FontWeight.bold),
                                ),
                                content: const Text(
                                  'Are you sure you want to Logout?',
                                  style: TextStyle(fontFamily: 'QRegular'),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  FlatButton(
                                    onPressed: () async {
                                      await FirebaseAuth.instance.signOut();
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                                          fontFamily: 'QRegular',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ));
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const SizedBox(),
            selectedIndex == 3
                ? PopupMenuButton(
                    iconSize: 25,
                    icon: const Icon(Icons.more_vert_outlined,
                        color: Colors.grey),
                    itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () async {
                              if (subscription != "Premium") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PaymentPage()));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const PaymentPage()));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: const Text(
                                            'No need to buy points. You are already in Premium Subscription',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: const Text(
                                            'No need to buy points. You are already in Premium Subscription',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              }
                            },
                            child: TextBold(
                                text: 'Purchase Points',
                                fontSize: 14,
                                color: Colors.black),
                            value: 1,
                          ),
                          PopupMenuItem(
                            onTap: () async {
                              if (subscription != "Premium") {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentPagePremium()));
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const PaymentPagePremium()));
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: const Text(
                                            'You are already in Premium Subscription',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          content: const Text(
                                            'You are already in Premium Subscription',
                                            style: TextStyle(
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              child: const Text(
                                                'Close',
                                                style: TextStyle(
                                                    fontFamily: 'QRegular',
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ));
                              }
                            },
                            child: TextBold(
                                text: 'Go Premium',
                                fontSize: 14,
                                color: Colors.black),
                            value: 2,
                          ),
                        ])
                : const SizedBox(),
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: const [
            HomeTab(),
            SearchBarWidget(),
            NotifTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: FloatingNavbar(
            borderRadius: 10,
            fontSize: 8,
            backgroundColor: Colors.blue,
            selectedItemColor: Colors.black,
            onTap: (int val) {
              setState(() {
                selectedIndex = val;
              });
            },
            currentIndex: selectedIndex,
            items: [
              FloatingNavbarItem(icon: Icons.home, title: 'Home'),
              FloatingNavbarItem(icon: Icons.search, title: 'Search'),
              FloatingNavbarItem(
                  icon: Icons.notifications_rounded, title: 'Notifications'),
              FloatingNavbarItem(icon: Icons.person, title: 'Profile'),
            ],
          ),
        ),
        floatingActionButton: selectedIndex == 1
            ? const SizedBox()
            : selectedIndex == 2
                ? const SizedBox()
                : FloatingActionButton(
                    backgroundColor: Colors.blue,
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const PostStatus(),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
