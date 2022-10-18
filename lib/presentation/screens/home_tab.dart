import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:monetization_system/data/services/cloud_functions/add_comment.dart';

import '../widgets/text_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final box = GetStorage();

  @override
  void initState() {
    getData();

    super.initState();
  }

  var dt = DateTime.now();

  late String name = '';
  late String profilePicture = '';

  late String id = '';

  late String comment = '';
  late String email = '';

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

          id = data['id'];
          email = data['email'];
        }
      });
    }
  }

  var isClicked = false;
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
                                            SizedBox(
                                              width: 100,
                                              child: TextRegular(
                                                  text: data.docs[index]
                                                      ['name'],
                                                  fontSize: 18,
                                                  color: Colors.grey),
                                            ),
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
                              data.docs[index]['imageURL'] != ""
                                  ? Image.network(data.docs[index]['imageURL'])
                                  : const SizedBox(),
                              ListTile(
                                leading: SizedBox(
                                  width: 100,
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: () async {
                                          if (isClicked == true) {
                                          } else {
                                            late int likes = 0;

                                            var collection = FirebaseFirestore
                                                .instance
                                                .collection('Posts')
                                                .where('id',
                                                    isEqualTo:
                                                        data.docs[index].id);

                                            var querySnapshot =
                                                await collection.get();
                                            if (mounted) {
                                              setState(() {
                                                for (var queryDocumentSnapshot
                                                    in querySnapshot.docs) {
                                                  Map<String, dynamic> data =
                                                      queryDocumentSnapshot
                                                          .data();
                                                  likes = data['likes'];
                                                }
                                              });
                                            }

                                            setState(() {
                                              isClicked = true;
                                            });
                                            FirebaseFirestore.instance
                                                .collection('Posts')
                                                .doc(data.docs[index].id)
                                                .update({
                                              'likes': likes + 1,
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.thumb_up_alt_rounded,
                                            color: isClicked
                                                ? Colors.blue
                                                : Colors.grey),
                                      ),
                                      TextRegular(
                                          text: data.docs[index]['likes']
                                              .toString(),
                                          fontSize: 18,
                                          color: Colors.grey),
                                    ],
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SingleChildScrollView(
                                            reverse: true,
                                            child: AlertDialog(
                                              title: SizedBox(
                                                height: 500,
                                                child: StreamBuilder<
                                                        QuerySnapshot>(
                                                    stream: FirebaseFirestore
                                                        .instance
                                                        .collection('Comments')
                                                        .where('commentId',
                                                            isEqualTo:
                                                                data.docs[index]
                                                                    ['id'])
                                                        .snapshots(),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                QuerySnapshot>
                                                            snapshot) {
                                                      if (snapshot.hasError) {
                                                        print(snapshot.error);
                                                        return const Center(
                                                            child:
                                                                Text('Error'));
                                                      }
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting) {
                                                        print('waiting');
                                                        return const Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 50),
                                                          child: Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                            color: Colors.black,
                                                          )),
                                                        );
                                                      }

                                                      final data =
                                                          snapshot.requireData;
                                                      return ListView.separated(
                                                          itemCount: snapshot
                                                                  .data?.size ??
                                                              0,
                                                          separatorBuilder:
                                                              (context, index) {
                                                            return const Divider();
                                                          },
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                              subtitle:
                                                                  TextRegular(
                                                                text: data.docs[
                                                                        index]
                                                                    ['comment'],
                                                                fontSize: 14,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                              trailing: TextRegular(
                                                                  text: data.docs[
                                                                          index]
                                                                      ['time'],
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                              title: TextBold(
                                                                  text: data.docs[
                                                                          index]
                                                                      ['name'],
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .grey),
                                                              leading:
                                                                  CircleAvatar(
                                                                maxRadius: 20,
                                                                minRadius: 20,
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                        data.docs[index]
                                                                            [
                                                                            'profilePicture']),
                                                              ),
                                                            );
                                                          });
                                                    }),
                                              ),
                                              content: TextFormField(
                                                textCapitalization:
                                                    TextCapitalization.words,
                                                onChanged: (_input) {
                                                  comment = _input;
                                                },
                                                decoration: InputDecoration(
                                                  hintText: 'Add comment',
                                                  suffixIcon: IconButton(
                                                    onPressed: () {
                                                      addComment(
                                                          name,
                                                          email,
                                                          profilePicture,
                                                          data.docs[index].id,
                                                          dt.hour.toString() +
                                                              ':' +
                                                              dt.minute
                                                                  .toString(),
                                                          comment);
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                      Icons.send,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: TextRegular(
                                      text: 'Comments',
                                      fontSize: 15,
                                      color: Colors.grey),
                                ),
                              ),
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
