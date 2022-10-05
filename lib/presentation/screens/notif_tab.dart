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
        Expanded(
          child: SizedBox(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemBuilder: ((context, index) {
                return ListTile(
                  leading: Image.asset('assets/images/profile.png'),
                  title: TextBold(
                      text: 'Lance Olana', fontSize: 16, color: Colors.grey),
                  subtitle: TextRegular(
                      text: 'Added a Status', fontSize: 12, color: Colors.grey),
                  trailing: TextRegular(
                      text: '28/03/2022', fontSize: 12, color: Colors.grey),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
