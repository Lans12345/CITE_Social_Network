import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/text_widget.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final box = GetStorage();

  @override
  void initState() {
    getData();

    super.initState();
  }

  late String name = '';
  late String profilePicture = '';
  late String subscription = '';
  late int points = 0;
  late String type = '';

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
          name = data['name'];

          profilePicture = data['profilePicture'];
          subscription = data['subscription'];
          points = data['points'];
          type = data['type'];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              trailing: const Icon(Icons.upload),
                              onTap: () {},
                              leading: TextRegular(
                                  text: 'Upload Photo',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            const Divider(),
                            ListTile(
                              trailing: const Icon(Icons.image),
                              onTap: () {},
                              leading: TextRegular(
                                  text: 'View Cover Photo',
                                  fontSize: 16,
                                  color: Colors.black),
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                color: Colors.black,
                height: 150,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 20, bottom: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        trailing: const Icon(Icons.upload),
                                        onTap: () {},
                                        leading: TextRegular(
                                            text: 'Upload Photo',
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      const Divider(),
                                      ListTile(
                                        trailing: const Icon(Icons.image),
                                        onTap: () {},
                                        leading: TextRegular(
                                            text: 'View Profile Picture',
                                            fontSize: 16,
                                            color: Colors.black),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: CircleAvatar(
                          minRadius: 60,
                          maxRadius: 60,
                          backgroundImage: NetworkImage(profilePicture),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(text: name, fontSize: 18, color: Colors.grey),
                      TextRegular(text: type, fontSize: 14, color: Colors.grey),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30, left: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star),
                            const SizedBox(
                              width: 5,
                            ),
                            TextBold(
                                text: subscription,
                                fontSize: 14,
                                color: Colors.grey),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(Icons.confirmation_num_rounded),
                            const SizedBox(
                              width: 25,
                            ),
                            TextBold(
                                text: "$points",
                                fontSize: 14,
                                color: Colors.grey),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Posts')
                .where('email', isEqualTo: box.read('email'))
                .orderBy('date')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              return Expanded(
                child: SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data?.size ?? 0,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            const Divider(),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Image.network(
                                    data.docs[index]['profilePicutre'],
                                    height: 60,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          TextRegular(
                                              text: data.docs[index]['name'],
                                              fontSize: 18,
                                              color: Colors.grey),
                                          const SizedBox(
                                            width: 60,
                                          ),
                                          TextBold(
                                              text: data.docs[index]['date'],
                                              fontSize: 12,
                                              color: Colors.grey),
                                          IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    return SizedBox(
                                                      height: 100,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListTile(
                                                            trailing:
                                                                const Icon(Icons
                                                                    .delete),
                                                            onTap: () {},
                                                            leading: TextRegular(
                                                                text:
                                                                    'Delete Post',
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          const Divider(),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: const Icon(
                                                Icons.more_vert_outlined),
                                          ),
                                        ],
                                      ),
                                      TextBold(
                                          text: data.docs[index]['time'],
                                          fontSize: 12,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 20, top: 10, bottom: 10),
                              child: ExpandableText(
                                data.docs[index]['caption'],
                                style: const TextStyle(
                                  fontFamily: 'QRegular',
                                ),
                                expandText: 'show more',
                                collapseText: 'show less',
                                maxLines: 5,
                                linkColor: Colors.blue,
                              ),
                            ),
                            Image.network(data.docs[index]['imageURL']),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              );
            }),
      ],
    );
  }
}
