import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/auth/login_page.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextBold(
            text: 'CITE Social Network', fontSize: 18, color: Colors.grey),
        elevation: 0.5,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/profile.png',
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
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()));
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
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.grey,
                  ),
                )
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
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PostStatus()));
          }),
    );
  }
}
