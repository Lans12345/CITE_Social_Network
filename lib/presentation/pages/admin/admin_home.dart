import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/auth/login_page.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          automaticallyImplyLeading: false,
          title:
              TextBold(text: 'Admin Panel', fontSize: 18, color: Colors.black),
          actions: [
            IconButton(
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
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                    fontFamily: 'QRegular',
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            FlatButton(
                              onPressed: () async {
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
              icon: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Icon(
                  Icons.logout,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
              child: TextRegular(
                  text: 'Points Purchases', fontSize: 14, color: Colors.black),
            ),
            Tab(
              child: TextRegular(
                  text: 'Premium Purchases', fontSize: 14, color: Colors.black),
            ),
          ]),
        ),
        body: TabBarView(children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Points').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return ListView.separated(
                  itemCount: snapshot.data?.size ?? 0,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(data.docs[index]['profilePicture']),
                      ),
                      title: TextBold(
                          text: data.docs[index]['name'],
                          fontSize: 18,
                          color: Colors.black),
                      trailing: SizedBox(
                        height: 100,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () async {
                                late int currentPoints;

                                late String id = '';
                                var collection = FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('email',
                                        isEqualTo: data.docs[index]['email']);

                                var querySnapshot = await collection.get();
                                if (mounted) {
                                  setState(() {
                                    for (var queryDocumentSnapshot
                                        in querySnapshot.docs) {
                                      Map<String, dynamic> data =
                                          queryDocumentSnapshot.data();
                                      currentPoints = data['points'];
                                      id = data['id'];
                                    }
                                  });
                                }

                                print(currentPoints.toString() +
                                    " Points" +
                                    "id" +
                                    data.docs[index].id);
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(id)
                                    .update({
                                  'points': currentPoints + 100,
                                });

                                FirebaseFirestore.instance
                                    .collection('Points')
                                    .doc(data.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.check_box_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Points')
                                    .doc(data.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Premium').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.black,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return ListView.separated(
                  itemCount: snapshot.data?.size ?? 0,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: ((context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        minRadius: 25,
                        maxRadius: 25,
                        backgroundColor: Colors.white,
                        backgroundImage:
                            NetworkImage(data.docs[index]['profilePicture']),
                      ),
                      title: TextBold(
                          text: data.docs[index]['name'],
                          fontSize: 18,
                          color: Colors.black),
                      trailing: SizedBox(
                        height: 100,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () async {
                                late int currentPoints;

                                late String id = '';
                                var collection = FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('email',
                                        isEqualTo: data.docs[index]['email']);

                                var querySnapshot = await collection.get();
                                if (mounted) {
                                  setState(() {
                                    for (var queryDocumentSnapshot
                                        in querySnapshot.docs) {
                                      Map<String, dynamic> data =
                                          queryDocumentSnapshot.data();
                                      currentPoints = data['points'];
                                      id = data['id'];
                                    }
                                  });
                                }

                                print(currentPoints.toString() +
                                    " Points" +
                                    "id" +
                                    data.docs[index].id);
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(id)
                                    .update({
                                  'points': 0,
                                  'subscription': 'Premium',
                                });

                                FirebaseFirestore.instance
                                    .collection('Premium')
                                    .doc(data.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.check_box_outlined,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('Premium')
                                    .doc(data.docs[index].id)
                                    .delete();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }),
        ]),
      ),
    );
  }
}
