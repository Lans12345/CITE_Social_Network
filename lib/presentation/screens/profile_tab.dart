import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

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
                        child: const CircleAvatar(
                          minRadius: 60,
                          maxRadius: 60,
                          backgroundImage:
                              AssetImage('assets/images/profile.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextBold(
                          text: 'Lance Olana',
                          fontSize: 18,
                          color: Colors.grey),
                      TextRegular(
                          text: 'Web System', fontSize: 14, color: Colors.grey),
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
                                text: 'Classic',
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
                                text: '20', fontSize: 14, color: Colors.grey),
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
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemBuilder: ((context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/profile.png',
                              height: 60,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextRegular(
                                        text: 'Lance Olana',
                                        fontSize: 18,
                                        color: Colors.grey),
                                    const SizedBox(
                                      width: 60,
                                    ),
                                    TextBold(
                                        text: '28/03/2022',
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    ListTile(
                                                      trailing: const Icon(
                                                          Icons.delete),
                                                      onTap: () {},
                                                      leading: TextRegular(
                                                          text: 'Delete Post',
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                    const Divider(),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                      icon:
                                          const Icon(Icons.more_vert_outlined),
                                    ),
                                  ],
                                ),
                                TextBold(
                                    text: '20:53:11',
                                    fontSize: 12,
                                    color: Colors.grey),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 20, top: 10, bottom: 10),
                        child: ExpandableText(
                          'Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum Lopsum Ipsum',
                          style: TextStyle(
                            fontFamily: 'QRegular',
                          ),
                          expandText: 'show more',
                          collapseText: 'show less',
                          maxLines: 5,
                          linkColor: Colors.blue,
                        ),
                      ),
                      Image.asset('assets/images/sample_image.jpg'),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
