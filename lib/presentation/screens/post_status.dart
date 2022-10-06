import 'package:flutter/material.dart';
import 'package:monetization_system/presentation/widgets/text_widget.dart';

class PostStatus extends StatefulWidget {
  const PostStatus({Key? key}) : super(key: key);

  @override
  State<PostStatus> createState() => _PostStatusState();
}

class _PostStatusState extends State<PostStatus> {
  late String status = '';

  var hasStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: MaterialButton(
              child:
                  TextRegular(text: 'Post', fontSize: 12, color: Colors.white),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              onPressed: hasStatus != true ? null : () {},
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
                child: ListTile(
              leading: const CircleAvatar(
                minRadius: 35,
                maxRadius: 35,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextFormField(
                  onChanged: (_input) {
                    setState(() {
                      hasStatus = true;
                    });

                    status = _input;
                  },
                  decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: InputBorder.none,
                      hintText: 'Write a status...'),
                  maxLines: 20,
                ),
              ),
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 30),
            child: Row(
              children: [
                TextBold(
                    text: "${status.length}/480",
                    fontSize: 18,
                    color: Colors.blue),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.image,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
