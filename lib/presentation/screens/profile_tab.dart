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
            Container(
              color: Colors.black,
              height: 150,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 20, bottom: 10),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        minRadius: 60,
                        maxRadius: 60,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
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
                                      width: 100,
                                    ),
                                    TextBold(
                                        text: '28/03/2022',
                                        fontSize: 12,
                                        color: Colors.grey),
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
