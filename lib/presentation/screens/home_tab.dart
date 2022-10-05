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
    return ListView.builder(itemBuilder: ((context, index) {
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
                          text: '20:53:11', fontSize: 12, color: Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 20, top: 10, bottom: 10),
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
    }));
  }
}
