import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Posts')
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
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      minRadius: 30,
                                      maxRadius: 30,
                                      backgroundImage: NetworkImage(
                                          data.docs[index]['profilePicture']),
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
                                              width: 100,
                                            ),
                                            TextBold(
                                                text: data.docs[index]['date'],
                                                fontSize: 12,
                                                color: Colors.grey),
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
                      })),
                ),
              );
            }),
      ],
    );
  }
}
