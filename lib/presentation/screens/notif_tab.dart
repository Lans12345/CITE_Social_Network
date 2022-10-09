import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

class NotifTab extends StatelessWidget {
  const NotifTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20),
          child:
              TextBold(text: 'Notifications', fontSize: 18, color: Colors.grey),
        ),
        const Divider(),
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
                  child: ListView.separated(
                    itemCount: snapshot.data?.size ?? 0,
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemBuilder: ((context, index) {
                      return ListTile(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return SingleChildScrollView(
                                  child: AlertDialog(
                                    content: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10,
                                              right: 20,
                                              top: 10,
                                              bottom: 10),
                                          child: ExpandableText(
                                            data.docs[index]['caption'],
                                            style: const TextStyle(
                                              fontFamily: 'QRegular',
                                            ),
                                            expandText: 'show more',
                                            collapseText: 'show less',
                                            maxLines: 3,
                                            linkColor: Colors.blue,
                                          ),
                                        ),
                                        Image.network(
                                            data.docs[index]['imageURL']),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: TextBold(
                                            text: 'Close',
                                            fontSize: 14,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          minRadius: 30,
                          maxRadius: 30,
                          backgroundImage:
                              NetworkImage(data.docs[index]['profilePicture']),
                        ),
                        title: TextBold(
                            text: data.docs[index]['name'],
                            fontSize: 16,
                            color: Colors.grey),
                        subtitle: TextRegular(
                            text: 'Added a Status',
                            fontSize: 12,
                            color: Colors.grey),
                        trailing: TextRegular(
                            text: data.docs[index]['date'],
                            fontSize: 12,
                            color: Colors.grey),
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
